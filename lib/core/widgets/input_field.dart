import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/app_color.dart';

class InputField extends StatelessWidget {
  final String? label;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;

  const InputField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: isDark
              ? [
            CupertinoColors.systemGrey6.darkColor.withOpacity(0.4),
            CupertinoColors.systemGrey6.darkColor.withOpacity(0.3),
          ]
              : [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.9),
          ],
        ),
        border: Border.all(
          color: CupertinoColors.separator.resolveFrom(context).withOpacity(0.2),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
          color: CupertinoColors.label.resolveFrom(context),
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: prefixIcon,
          )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 44,
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
            color: CupertinoColors.secondaryLabel.resolveFrom(context),
          ),
          floatingLabelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color: AppColors.secondaryGreen,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 1.5,
              color: AppColors.secondaryGreen,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 1.5,
              color: CupertinoColors.systemRed,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 1.5,
              color: CupertinoColors.systemRed,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}