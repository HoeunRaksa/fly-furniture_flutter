import 'dart:async';
import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../../../model/user_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  String? _token;
  bool _otpPending = false; // ✅ Track OTP pending state

  bool _isResendEnabled = true;
  int _resendSeconds = 60;

  User? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => _token != null;
  bool get otpPending => _otpPending;
  bool get isResendEnabled => _isResendEnabled;
  int get resendSeconds => _resendSeconds;

  // ---------------- LOGIN ----------------
  Future<void> login(String email, String password) async {
    final result = await _authService.login(email, password);
    _user = result;
    _token = result.token;
    _otpPending = false; // ✅ Clear OTP pending after login
    notifyListeners();
  }

  // ---------------- REGISTER ----------------
  Future<void> register(String name, String email, String password) async {
    try {
      final result = await _authService.register(name, email, password);

      // OTP not verified yet
      _token = null;
      _otpPending = true; // ⚠️ OTP is pending

      // Store user info for OTP screen
      _user = User(
        id: result?.id ?? '',
        name: result?.name ?? name,
        email: result?.email ?? email,
        role: result?.role ?? 'user',
        isVerified: false,
        token: null,
      );

      notifyListeners();
      debugPrint("Register success, OTP pending for: $email");

    } catch (e) {
      debugPrint("Register failed: $e");
      rethrow;
    }
  }

  // ---------------- VERIFY OTP ----------------
  Future<void> verifyOtp(String email, String otp) async {
    final result = await _authService.verifyOtp(email, otp);
    _user = result;
    _token = result.token;
    _otpPending = false; // ✅ OTP verified
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
    try {
      await _authService.resendOtp(email);
      startResendTimer();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // ---------------- LOGOUT ----------------
  void logout() {
    _user = null;
    _token = null;
    _otpPending = false;
    notifyListeners();
  }
}
