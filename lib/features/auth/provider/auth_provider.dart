import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../service/auth_service.dart';
import '../../../model/user_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  String? _token;

  bool _otpPending = false;
  bool _isResendEnabled = true;
  int _resendSeconds = 60;

  // ✅ important: avoid router redirect before session load finishes
  bool _sessionLoaded = false;

  User? get user => _user;
  String? get token => _token;

  // ✅ logged in if token exists (cookie style)
  bool get isLoggedIn => _token != null;

  bool get otpPending => _otpPending;
  bool get isResendEnabled => _isResendEnabled;
  int get resendSeconds => _resendSeconds;
  bool get sessionLoaded => _sessionLoaded;

  // ✅ secure storage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _tokenKey = "auth_token";

  Future<void> _saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> _readToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> _clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // ✅ call once at app start
  Future<void> loadSession() async {
    try {
      final saved = await _readToken();

      if (saved != null && saved.isNotEmpty) {
        _token = saved;
        notifyListeners();

        // try fetch user using token
        await fetchUser();
      }
    } finally {
      _sessionLoaded = true;
      notifyListeners();
    }
  }

  // ---------------- LOGIN ----------------
  Future<void> login(String email, String password) async {
    _user = null;
    _token = null;
    _otpPending = false;
    notifyListeners();

    final result = await _authService.login(email, password);

    _user = result;
    _token = result.token;

    if (_token != null) {
      await _saveToken(_token!);
    }

    notifyListeners();
  }

  // ---------------- REGISTER ----------------
  Future<void> register(
      String name,
      String email,
      String password, {
        File? profileImage,
      }) async {
    final result = await _authService.register(
      name,
      email,
      password,
      profileImage: profileImage,
    );

    _token = null;
    _otpPending = true;

    _user = User(
      id: result?.id ?? '',
      name: result?.name ?? name,
      email: result?.email ?? email,
      role: result?.role ?? 'user',
      profileImage: result?.profileImage,
      profileImageUrl: result?.profileImageUrl,
      isVerified: false,
      token: null,
    );

    notifyListeners();
  }

  // ---------------- VERIFY OTP ----------------
  Future<void> verifyOtp(String email, String otp) async {
    final result = await _authService.verifyOtp(email, otp);

    _user = result;
    _token = result.token;
    _otpPending = false;

    if (_token != null) {
      await _saveToken(_token!);
    }

    notifyListeners();
  }

  // ---------------- RESEND OTP ----------------
  void startResendTimer() {
    _isResendEnabled = false;
    _resendSeconds = 60;
    notifyListeners();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _resendSeconds--;
      notifyListeners();

      if (_resendSeconds <= 0) {
        timer.cancel();
        _isResendEnabled = true;
        notifyListeners();
      }
    });
  }

  Future<void> resendOtp(String email) async {
    await _authService.resendOtp(email);
    startResendTimer();
  }

  // ---------------- GET CURRENT USER ----------------
  Future<void> fetchUser() async {
    if (_token == null) return;

    try {
      final result = await _authService.getUser(_token!);
      _user = result;
      notifyListeners();
    } catch (e) {
      // invalid token -> logout fully
      if (e.toString().contains('401') ||
          e.toString().contains('Unauthenticated')) {
        await logout();
      }
      rethrow;
    }
  }

  // ---------------- UPDATE PROFILE ----------------
  Future<void> updateProfile({
    String? name,
    String? email,
    String? password,
    File? profileImage,
  }) async {
    if (_token == null) throw Exception('Not authenticated');

    final result = await _authService.updateProfile(
      token: _token!,
      name: name,
      email: email,
      password: password,
      profileImage: profileImage,
    );

    _user = result;
    notifyListeners();
  }

  // ---------------- DELETE PROFILE IMAGE ----------------
  Future<void> deleteProfileImage() async {
    if (_token == null) throw Exception('Not authenticated');

    await _authService.deleteProfileImage(_token!);

    if (_user != null) {
      _user = _user!.copyWith(profileImage: null, profileImageUrl: null);
    }

    notifyListeners();
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout() async {
    final currentToken = _token;

    _user = null;
    _token = null;
    _otpPending = false;
    _isResendEnabled = true;
    _resendSeconds = 60;

    await _clearToken();
    notifyListeners();

    if (currentToken != null) {
      try {
        await _authService.logout(currentToken);
      } catch (_) {}
    }
  }
}
