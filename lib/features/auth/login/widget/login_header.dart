import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';

class LoginHeader extends StatelessWidget implements PreferredSizeWidget {
  const LoginHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Welcome back",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 40
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 7,),
          Text(
            " Welcome Back! Please Enter Your Details",
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
