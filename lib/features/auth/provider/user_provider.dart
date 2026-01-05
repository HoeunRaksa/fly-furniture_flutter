import 'dart:io';
import 'package:flutter/material.dart';

import '../../../model/user_auth.dart';
import '../service/user_service.dart';
import 'auth_provider.dart';


class UserProvider extends ChangeNotifier {
  final UserService userService;
  final AuthProvider authProvider;

  User? _user;
  bool _fetched = false;
  bool _loading = false;

  User? get user => _user;
  bool get loading => _loading;

  UserProvider({
    required this.userService,
    required this.authProvider,
  });

  Future<void> fetchUser() async {
    if (_fetched) return;

    final token = authProvider.token;
    if (token == null || token.isEmpty) return;

    try {
      _loading = true;
      notifyListeners();

      _user = await userService.getUser(token);
      _fetched = true;
    } catch (e) {
      debugPrint('Error fetching user: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clear() {
    _user = null;
    _fetched = false;
    notifyListeners();
  }

  Future<void> updateProfile({String? name, String? email}) async {
    final token = authProvider.token;
    if (token == null) return;

    _user = await userService.updateProfile(token, name: name, email: email);
    notifyListeners();
  }

  Future<void> uploadProfileImage(File image) async {
    final token = authProvider.token;
    if (token == null) return;

    _user = await userService.uploadProfileImage(token, image);
    notifyListeners();
  }
}
