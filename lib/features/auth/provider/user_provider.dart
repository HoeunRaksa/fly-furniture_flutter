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
  String? _lastFetchedToken; // ✅ Track which token we fetched for

  User? get user => _user;
  bool get loading => _loading;

  UserProvider({
    required this.userService,
    required this.authProvider,
  });

  Future<void> fetchUser({bool force = false}) async {
    final token = authProvider.token;

    if (token == null || token.isEmpty) {
      debugPrint('⚠️ No token available, skipping fetchUser');
      return;
    }

    // ✅ Check if token changed (different user logged in)
    final tokenChanged = _lastFetchedToken != null && _lastFetchedToken != token;

    if (tokenChanged) {
      debugPrint('🔄 Token changed - clearing old user data');
      clear();
    }

    // Skip if already fetched for this token (unless forced)
    if (_fetched && !force && _lastFetchedToken == token) {
      debugPrint('ℹ️ User already fetched for this token');
      return;
    }

    try {
      _loading = true;
      notifyListeners();

      debugPrint('📥 Fetching user with token: ${token.substring(0, 20)}...');
      _user = await userService.getUser(token);
      _fetched = true;
      _lastFetchedToken = token; // ✅ Remember which token this user belongs to

      debugPrint('✅ User fetched: ${_user?.email}');
    } catch (e) {
      debugPrint('❌ Error fetching user: $e');
      // Clear on error
      _user = null;
      _fetched = false;
      _lastFetchedToken = null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ✅ Clear method now also clears the token tracker
  void clear() {
    debugPrint('🗑️ Clearing UserProvider data');
    debugPrint('   Previous user: ${_user?.email}');

    _user = null;
    _fetched = false;
    _lastFetchedToken = null;

    notifyListeners();

    debugPrint('   Current user: ${_user?.email} (should be null)');
  }

  Future<void> updateProfile({String? name, String? email}) async {
    final token = authProvider.token;
    if (token == null) return;

    try {
      _user = await userService.updateProfile(token, name: name, email: email);
      notifyListeners();
      debugPrint('✅ Profile updated: ${_user?.email}');
    } catch (e) {
      debugPrint('❌ Error updating profile: $e');
      rethrow;
    }
  }

  Future<void> uploadProfileImage(File image) async {
    final token = authProvider.token;
    if (token == null) return;

    try {
      _user = await userService.uploadProfileImage(token, image);
      notifyListeners();
      debugPrint('✅ Profile image uploaded');
    } catch (e) {
      debugPrint('❌ Error uploading image: $e');
      rethrow;
    }
  }

  // ✅ Helper to check if current user matches auth
  bool get isUserSynced {
    if (authProvider.user == null) return _user == null;
    return _user?.email == authProvider.user?.email;
  }
}