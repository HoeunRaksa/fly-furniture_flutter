import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[50],
    colorScheme: const ColorScheme.light(
      primary: AppColors.secondaryGreen,
      secondary: AppColors.secondaryGreen,
      background: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.gray800,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: AppColors.gray800,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.gray700,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.gray800,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        color: AppColors.gray700,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.secondaryGreen,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: AppColors.gray500,
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.gray800,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.secondaryGreen,
      secondary: AppColors.secondaryGreen,
      background: AppColors.gray800,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.gray800,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.gray700,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.secondaryGreen,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.gray700,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: AppColors.white,
      ),
    ),
  );
}
