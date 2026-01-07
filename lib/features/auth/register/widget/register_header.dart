import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterHeader extends StatelessWidget implements PreferredSizeWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 20),
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
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double horizontalPadding =
            constraints.maxWidth < 600 ? 20 : 0;

            return Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                  ),
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: isDark
                                  ? [
                                CupertinoColors
                                    .systemGrey6.darkColor
                                    .withValues(alpha: 0.6),
                                CupertinoColors
                                    .systemGrey6.darkColor
                                    .withValues(alpha: 0.4),
                              ]
                                  : [
                                Colors.white
                                    .withValues(alpha: 0.95),
                                Colors.white
                                    .withValues(alpha: 0.85),
                              ],
                            ),
                            border: Border.all(
                              color: CupertinoColors.separator
                                  .resolveFrom(context)
                                  .withValues(alpha: 0.2),
                              width: 0.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CupertinoColors.black.withValues(
                                  alpha: isDark ? 0.3 : 0.08,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              context.pop();
                            },
                            child: Icon(
                              CupertinoIcons.arrow_left,
                              size: 20,
                              color: CupertinoColors.label.resolveFrom(context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
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
                            "Create Account",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.8,
                              height: 1.1,
                              color:
                              CupertinoColors.label.resolveFrom(context),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Let's start our journey together",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                            height: 1.4,
                            color: CupertinoColors.secondaryLabel
                                .resolveFrom(context),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
