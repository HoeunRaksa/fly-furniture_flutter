import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:fly/config/app_config.dart';
import '../../../model/user_auth.dart';

class AuthService {
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/login"),
      body: {'email': email, 'password': password},
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return User.fromApiResponse(data);
    } else {
      throw Exception(data['message'] ?? 'Login failed');
    }
  }

  Future<User?> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/register"),
      body: {'name': name, 'email': email, 'password': password},
    );

    print('Register status: ${response.statusCode}');
    print('Register body: ${response.body}');

    Map<String, dynamic>? data;
    try {
      data = jsonDecode(response.body);
    } catch (_) {
      // HTML returned, assume OTP sent
      print("Non-JSON response, assume OTP sent");
      return User(
        id: '',
        name: name,
        email: email,
        role: 'user',
        isVerified: false,
        token: null,
      );
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User(
        id: '',
        name: name,
        email: email,
        role: 'user',
        isVerified: false,
        token: null,
      );
    } else {
      throw Exception(data?['message'] ?? 'Failed to register');
    }
  }

  Future<User> verifyOtp(String email, String otp) async {
    try {
      debugPrint('Verifying OTP for email: $email, OTP: $otp');

      final response = await http.post(
        Uri.parse("${AppConfig.baseUrl}/verify-otp"),
        body: {'email': email, 'otp': otp},
      );

      debugPrint('Verify OTP status: ${response.statusCode}');
      debugPrint('Verify OTP body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Your User.fromApiResponse already handles this structure
        return User.fromApiResponse(data);
      } else {
        // Try to parse error message
        try {
          final data = jsonDecode(response.body);
          throw Exception(data['message'] ?? 'OTP verification failed');
        } catch (e) {
          // If JSON parse fails, use status code message
          if (response.statusCode == 400) {
            throw Exception('Invalid OTP code');
          } else if (response.statusCode == 401) {
            throw Exception('OTP expired or invalid');
          } else if (response.statusCode == 404) {
            throw Exception('Email not found');
          } else {
            throw Exception('Server error: ${response.statusCode}');
          }
        }
      }
    } catch (e) {
      debugPrint('Error in verifyOtp: $e');
      rethrow;
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      debugPrint('Resending OTP to: $email');

      final response = await http.post(
        Uri.parse("${AppConfig.baseUrl}/resend-otp"),
        body: {'email': email},
      );

      debugPrint('Resend OTP status: ${response.statusCode}');
      debugPrint('Resend OTP body: ${response.body}');

      if (response.statusCode == 200) {
        return;
      } else {
        try {
          final data = jsonDecode(response.body);
          throw Exception(data['message'] ?? 'Failed to resend OTP');
        } catch (e) {
          throw Exception('Failed to resend OTP');
        }
      }
    } catch (e) {
      debugPrint('Error in resendOtp: $e');
      rethrow;
    }
  }

  Future<void> logout(String token) async {
    try {
      await http.post(
        Uri.parse("${AppConfig.baseUrl}/logout"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      debugPrint('Logout request failed: $e');
      // Don't throw - local logout should still work
    }
  }
}