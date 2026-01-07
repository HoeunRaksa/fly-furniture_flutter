import 'package:flutter/material.dart';

class AppColors {
  // Greys
  static const lowGrey = Color(0xFF6B7280);
  static const mediumGrey = Color(0xFF374151);
  static const strongGrey = Color(0xFF1F2937);
  static const secondaryGreen = Color(0xFF0E8C7A);
  static const secondaryBlue = Color(0xFF1E88E5);
  static const white = Color(0xFFFFFFFF);

  // iOS 26 Gradient Colors
  static const greenLight = Color(0xFF10A68D);
  static const greenDark = Color(0xFF0B7565);

  static const blueLight = Color(0xFF42A5F5);
  static const blueDark = Color(0xFF1976D2);

  // Glass Morphism Support
  static const glassFillLight = Color(0x0DFFFFFF);
  static const glassFillDark = Color(0x1A000000);

  // Shadow Colors
  static const shadowBlue = Color(0x1A1E88E5);
  static const shadowGreen = Color(0x1A0E8C7A);
  static const shadowBlack = Color(0x0F000000);

  // Gradient Helpers
  static LinearGradient greenGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [greenLight, secondaryGreen, greenDark],
  );

  static LinearGradient blueGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blueLight, secondaryBlue, blueDark],
  );

  static LinearGradient glassGradientLight = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xF2FFFFFF),
      Color(0xE6FFFFFF),
    ],
  );

  static LinearGradient glassGradientDark = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x80374151),
      Color(0x66374151),
    ],
  );
}