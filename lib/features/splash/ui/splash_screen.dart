import 'package:flutter/material.dart';
import 'package:fly/features/splash/widget/splash_body.dart';
import 'package:fly/features/splash/widget/splash_bottom.dart';
import 'dart:async';
import 'package:fly/features/splash/widget/splash_header.dart';
import '../../../core/colors/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      appBar: SplashHeader(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SplashBody(), SizedBox(height: 60), SplashBottom()],
            ),
          ),
        ],
      ),
    );
  }
}
