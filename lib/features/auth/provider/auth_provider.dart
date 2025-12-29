import 'package:flutter/material.dart';
import 'package:fly/features/auth/service/authService.dart';

import '../../../model/user_auth.dart';


class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<void> register(String name, String email, String password) async {
    _user = await _authService.register(name, email, password);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _user = await _authService.login(email, password);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
