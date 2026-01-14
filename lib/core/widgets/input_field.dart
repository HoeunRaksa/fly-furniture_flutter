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
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.woodLight, width: 1),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
