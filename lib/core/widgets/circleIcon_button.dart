
import 'package:flutter/material.dart';

import '../../config/app_color.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final double sizeX;
  final double sizedY;
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconSize = 20,
    this.sizedY = 30,
    this.sizeX =30,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.lowGrey
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: sizedY,
          width: sizeX,
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor
          ),
        ),
      ),
    );
  }
}
