import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fly/config/app_config.dart';
import '../model/user_auth.dart';

class AuthService {
  /// Register a user
  Future<User> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/register"),
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return User.fromJson(data['user']);
    } else if (response.statusCode == 422) {
      // Laravel validation error
      throw Exception(data['message'] ?? 'Validation failed');
    } else {
      throw Exception(data['message'] ?? 'Failed to register');
    }
  }

  /// Login a user
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/login"),
      body: {
        'email': email,
        'password': password,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Optionally, check if the user is verified
      final user = User.fromJson(data['user']);
      final token = data['token'] ?? '';
      if (token.isEmpty) {
        throw Exception('Token not returned by server');
      }
      return User(
        id: user.id,
        name: user.name,
        email: user.email,
        token: token,
        isVerified: user.isVerified,
      );
    } else if (response.statusCode == 401) {
      throw Exception('Invalid username or password!');
    } else {
      throw Exception(data['message'] ?? 'Failed to login');
    }
  }

  /// Optional: send OTP (if implemented in backend)
  Future<void> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/send-otp"),
      body: {'email': email},
    );

    if (response.statusCode != 200) {
      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Failed to send OTP');
    }
  }

  /// Optional: verify OTP
  Future<User> verifyOtp(String email, String otp) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/verify-otp"),
      body: {'email': email, 'otp': otp},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(data['user']);
    } else {
      throw Exception(data['message'] ?? 'Invalid OTP');
    }
  }
}
