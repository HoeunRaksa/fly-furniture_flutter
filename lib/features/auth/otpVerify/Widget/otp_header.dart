import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_color.dart';

class OtpHeader extends StatelessWidget implements PreferredSizeWidget {
  final String email;

  const OtpHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                alignment: Alignment.center,
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
                  icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Verification",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 55),
          Center(
            child: Column(
              children: [
                Text(
                  "Enter the 6-digit code sent to",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    color: AppColors.strongGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 7),
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 17,
                    color: AppColors.secondaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(300);
}