import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.bodyLine,
      secondary: AppColors.headerLine,
      background: AppColors.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.headerLine,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        height: 1.2,
        color: AppColors.headerLine,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.2,
        color: AppColors.bodyLine,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        height: 1.2,
        color: AppColors.bodyLine,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.5,
        color: AppColors.bodyLine,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.5,
        color: AppColors.bodyLine,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.4,
        color: AppColors.bodyLine,
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.headerLine,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.headerLine,
      secondary: AppColors.headerLine,
      background: AppColors.headerLine,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.primary,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        height: 1.2,
        color: AppColors.primary,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.2,
        color: AppColors.bodyLine,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        height: 1.2,
        color: AppColors.headerLine,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.5,
        color: AppColors.headerLine,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.5,
        color: AppColors.bodyLine,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.4,
        color: AppColors.primary,
      ),
    ),
  );
}
