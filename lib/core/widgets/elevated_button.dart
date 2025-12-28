import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';

class EButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  const EButton({
    super.key,
    required this.name,
    required this.onPressed,
    this.backgroundColor = AppColors.secondaryGreen,
    this.textColor = Colors.white,
    this.borderRadius = 13,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      padding: EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(borderRadius),
            side: BorderSide(width: 1, color: Colors.white.withOpacity(0.3)),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 15),
          maxLines: 1,
          softWrap: false,
        ),
      ),
    );
  }
}
