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
    this.label,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: AppColors.glassDark.withAlpha(10),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: AppColors.shadowWarm, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.shadowWarm, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.woodLight, width: 1),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
