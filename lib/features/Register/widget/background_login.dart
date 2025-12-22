import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../config/app_color.dart';

class BackgroundLogin extends StatelessWidget {
  const BackgroundLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          height: 570,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(color: AppColors.green400,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          ),
        ),
        Positioned(
          top: -50,
          left: -100,
          height: 500,
          width: 460,
          child: Transform.rotate(
            angle: 60,
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(color: AppColors.secondaryBlue),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: -20, // negative is fine if Stack allows overflow
          height: 220,
          width: 250,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.light.withOpacity(0.2), // softer glow
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
