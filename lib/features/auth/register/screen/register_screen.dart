import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/auth/register/widget/register_header.dart';
import '../widget/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: const RegisterHeader(),
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
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned.fill(
                  child: const Padding(
                    padding: EdgeInsets.only(top: 0, right: 20, left: 20),
                    child: RegisterBody(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
