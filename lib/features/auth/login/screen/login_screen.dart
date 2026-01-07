import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/login_body.dart';
import '../widget/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: const LoginHeader(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
              CupertinoColors.black.withValues(alpha: 0.95),
              CupertinoColors.black.withValues(alpha: 0.98),
              CupertinoColors.black,
            ]
                : [
              CupertinoColors.systemBackground.withValues(alpha: 0.95),
              CupertinoColors.systemGrey6.withValues(alpha: 0.5),
              CupertinoColors.systemBackground,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 50,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 480,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: LoginBody(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
