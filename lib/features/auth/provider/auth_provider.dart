import 'package:flutter/material.dart';
import '../service/authService.dart';
import '../../../model/user_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => _token != null;

  Future<void> login(String email, String password) async {
    final result = await _authService.login(email, password);
    _user = result;
    _token = result.token;
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    final result = await _authService.register(name, email, password);
    _user = result;
    _token = result.token;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
