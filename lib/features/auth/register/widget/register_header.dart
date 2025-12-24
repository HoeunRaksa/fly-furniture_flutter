import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';
import 'package:go_router/go_router.dart';

class RegisterHeader extends StatelessWidget implements PreferredSizeWidget {
  const RegisterHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(shape: BoxShape.circle,
                color: Colors.white
            ),
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
            ),
          ),
          SizedBox(height: 30,),
          Text(
            "Create Account",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 40
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 7,),
          Text(
            "Let's start our journey together",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 17,
                color: AppColors.gray700.withAlpha(225)
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(220);
}
