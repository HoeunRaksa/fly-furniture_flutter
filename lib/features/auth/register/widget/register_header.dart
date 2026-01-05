import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';
import 'package:go_router/go_router.dart';

class RegisterHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double horizontalPadding =
          constraints.maxWidth < 600 ? 20 : 0;

          return Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  height: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Create Account",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "Let's start our journey together",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          fontSize: 17,
                          color:
                          AppColors.gray700.withAlpha(225),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(220);
}
