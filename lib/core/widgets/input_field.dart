import 'package:flutter/material.dart';

import '../../config/app_color.dart';

class InputField extends StatelessWidget {
  final String? label;
  final bool obscureText;
  final TextEditingController? controller;
  const InputField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade600,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 1, color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 1, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.secondaryGreen
          ),
        ),
      ),
    );
  }
}
