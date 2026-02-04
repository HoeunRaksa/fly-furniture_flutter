import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.furnitureBlue,
      scaffoldBackgroundColor: AppColors.primary,
      dividerColor: AppColors.divider,
      // Ensure status bar icons are dark on light theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: AppColors.headerLine),
        titleTextStyle: TextStyle(
          color: AppColors.headerLine,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.furnitureBlue,
        secondary: AppColors.furnitureBlue,
        surface: AppColors.primary,
        onSurface: AppColors.headerLine,
        surfaceContainerHighest: AppColors.secondary,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.headerLine,
          fontSize: 32,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.5,
        ),
        headlineMedium: TextStyle(
          color: AppColors.headerLine,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: AppColors.headerLine,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: AppColors.headerLine,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: AppColors.bodyLine,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.furnitureBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.furnitureBlue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintStyle: const TextStyle(color: AppColors.bodyLine, fontWeight: FontWeight.w400),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.furnitureBlue,
      scaffoldBackgroundColor: const Color(0xFF101112),
      dividerColor: const Color(0xFF2C2D2E),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.furnitureBlue,
        secondary: AppColors.furnitureBlue,
        surface: Color(0xFF1F2021),
        onSurface: Colors.white,
      ),
    );
  }
}
