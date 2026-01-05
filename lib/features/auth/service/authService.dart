import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fly/config/app_config.dart';
import '../../../model/user_auth.dart';

class AuthService {
  /// Login user
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/login"),
      body: {'email': email, 'password': password},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Merge token into user
      return User.fromApiResponse(data);
    } else {
      throw Exception(data['message'] ?? 'Login failed');
    }
  }

  /// Register user
  Future<User> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/register"),
      body: {'name': name, 'email': email, 'password': password},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return User.fromApiResponse(data);
    } else if (response.statusCode == 422) {
      throw Exception(data['message'] ?? 'Validation failed');
    } else {
      throw Exception(data['message'] ?? 'Failed to register');
    }
  }
}
