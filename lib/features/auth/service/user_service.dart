import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../config/app_config.dart';
import '../../../model/user_auth.dart';


class UserService {
  Future<User> getUser(String token) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch user');
    }
  }

  Future<User> updateProfile(String token, {String? name, String? email}) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/user'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['user']);
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<User> uploadProfileImage(String token, File image) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConfig.baseUrl}/user/profile'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['user']);
    } else {
      throw Exception('Failed to upload image');
    }
  }
}
