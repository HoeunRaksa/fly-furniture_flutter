import 'dart:async';
import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../../../model/user_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  String? _token;
  bool _otpPending = false;
  bool _isResendEnabled = true;
  int _resendSeconds = 60;

  User? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => _token != null && _user != null;
  bool get otpPending => _otpPending;
  bool get isResendEnabled => _isResendEnabled;
  int get resendSeconds => _resendSeconds;

  // ---------------- LOGIN ----------------
  Future<void> login(String email, String password) async {
    // IMPORTANT: Clear everything first
    _user = null;
    _token = null;
    _otpPending = false;
    notifyListeners(); // Force UI update

    final result = await _authService.login(email, password);

    _user = result;
    _token = result.token;

    notifyListeners();
    debugPrint('✅ Login successful: ${result.email}');
    debugPrint('✅ Current user in provider: ${_user?.email}');
  }

  // ---------------- REGISTER ----------------
  Future<void> register(String name, String email, String password) async {
    try {
      final result = await _authService.register(name, email, password);

      // OTP not verified yet - don't save token
      _token = null;
      _otpPending = true;

      // Store temporary user info for OTP screen
      _user = User(
        id: result?.id ?? '',
        name: result?.name ?? name,
        email: result?.email ?? email,
        role: result?.role ?? 'user',
        isVerified: false,
        token: null,
      );

      notifyListeners();
      debugPrint("✅ Register success, OTP pending for: $email");
    } catch (e) {
      debugPrint("❌ Register failed: $e");
      rethrow;
    }
  }

  // ---------------- VERIFY OTP ----------------
  Future<void> verifyOtp(String email, String otp) async {
    final result = await _authService.verifyOtp(email, otp);

    _user = result;
    _token = result.token;
    _otpPending = false;

    notifyListeners();
    debugPrint('✅ OTP verified: ${result.email}');
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
  Future<void> logout() async {
    debugPrint('🚪 Logging out: ${_user?.email}');

    final currentToken = _token;
    final currentEmail = _user?.email;

    // CRITICAL: Clear memory state COMPLETELY
    _user = null;
    _token = null;
    _otpPending = false;
    _isResendEnabled = true;
    _resendSeconds = 60;

    // Force immediate UI update
    notifyListeners();

    debugPrint('✅ User cleared from AuthProvider');
    debugPrint('   Previous: $currentEmail');
    debugPrint('   Current: ${_user?.email} (should be null)');
    debugPrint('   Token cleared: ${_token == null}');

    // Call backend logout
    if (currentToken != null) {
      try {
        await _authService.logout(currentToken);
        debugPrint('✅ Backend logout successful');
      } catch (e) {
        debugPrint('⚠️ Backend logout failed: $e');
      }
    }

    debugPrint('✅ Logout complete');
  }

  // ---------------- DEBUG HELPER ----------------
  void printCurrentState() {
    debugPrint('========== AUTH STATE ==========');
    debugPrint('User: ${_user?.email}');
    debugPrint('Token: ${_token?.substring(0, 20)}...');
    debugPrint('Logged in: $isLoggedIn');
    debugPrint('================================');
  }
}