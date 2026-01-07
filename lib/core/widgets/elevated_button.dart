import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';

class EleButton extends StatelessWidget {
  final String? name;           // optional now
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final bool isCircular;        // optional circular
  final double? width;
  final double? height;
  final bool isLoading;         // optional loading spinner
  final Widget? child;          // optional custom widget

  const EleButton({
    super.key,
    this.name,
    required this.onPressed,
    this.backgroundColor = AppColors.secondaryGreen,
    this.textColor = Colors.white,
    this.borderRadius = 13,
    this.isCircular = false,
    this.width,
    this.height,
    this.isLoading = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidth = width ?? (isCircular ? 60.0 : 400.0);
    final buttonHeight = height ?? (isCircular ? 60.0 : 50.0);

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: isCircular
              ? const CircleBorder() // circular if requested
              : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(width: 1, color: Colors.white.withOpacity(0.3)),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? SizedBox(
          width: isCircular ? 22 : 16,
          height: isCircular ? 22 : 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: textColor,
          ),
        )
            : child ?? Text(
          name ?? '',
          style: TextStyle(color: textColor, fontSize: 15),
          maxLines: 1,
          softWrap: false,
        ),
      ),
    );
  }
}
