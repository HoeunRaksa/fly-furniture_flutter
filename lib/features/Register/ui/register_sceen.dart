import 'package:flutter/material.dart';
import 'package:fly/features/Register/widget/register_header.dart';
import '../../../config/app_config.dart';
import '../../../core/colors/app_color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      extendBodyBehindAppBar: true,
      appBar: RegisterHeader(),
      body: Stack(
        children: [
        ],
      ),
    );
  }
}
