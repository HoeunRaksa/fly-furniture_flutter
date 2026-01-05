import 'package:flutter/material.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:fly/features/auth/provider/user_provider.dart';
import 'package:fly/features/profile/widget/profile_body.dart';
import 'package:fly/features/profile/widget/profile_header.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.isSetHeader = false});
  final bool isSetHeader;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = context.read<UserProvider>();
      try {
        await userProvider.fetchUser();
      } catch (e) {
        debugPrint("Error fetching user: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final authProvider = context.watch<AuthProvider>();
    final user = userProvider.user;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: widget.isSetHeader ? const ProfileHeader(isSet: true) : null,
      body: SafeArea(
        top: !widget.isSetHeader,
        child: Padding(
          padding: EdgeInsets.only(top: widget.isSetHeader ? 0 : 60),
          child: Builder(
            builder: (context) {
              if (userProvider.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (user == null) {
                return const Center(child: Text("Fail to load user!"));
              } else {
                return ProfileBody(
                  user: user,
                  logout: () {
                    authProvider.logout();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
