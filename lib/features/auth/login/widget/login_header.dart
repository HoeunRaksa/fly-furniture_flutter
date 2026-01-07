import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget implements PreferredSizeWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
            CupertinoColors.black.withValues(alpha: 0.9),
            CupertinoColors.black.withValues(alpha: 0.6),
            CupertinoColors.black.withValues(alpha: 0.0),
          ]
              : [
            CupertinoColors.systemBackground.withValues(alpha: 0.9),
            CupertinoColors.systemBackground.withValues(alpha: 0.6),
            CupertinoColors.systemBackground.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  CupertinoColors.label.resolveFrom(context),
                  CupertinoColors.label
                      .resolveFrom(context)
                      .withValues(alpha: 0.85),
                ],
              ).createShader(bounds),
              child: Text(
                "Welcome back",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                  height: 1.1,
                  color: CupertinoColors.label.resolveFrom(context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Welcome Back! Please Enter Your Details",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.1,
                height: 1.4,
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
