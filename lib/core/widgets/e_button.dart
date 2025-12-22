import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';

class EButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  const EButton({
    super.key,
    required this.name,
    required this.onPressed,
    this.backgroundColor = AppColors.secondaryBlue,
    this.textColor = Colors.white,
    this.borderRadius = 15,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(borderRadius),
          side: BorderSide(width: 1, color: Colors.white.withOpacity(0.3)),
        ),
      ),
      child: Text(name, style: TextStyle(color: Colors.white, fontSize: 15)),
    );
  }
}
