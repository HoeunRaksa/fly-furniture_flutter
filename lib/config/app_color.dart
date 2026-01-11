import 'package:flutter/material.dart';

class AppColors {
  // Furniture-inspired Greys (Softer, more natural tones)
  static const lowGrey = Color(0xFF9CA3AF); // Light ash grey
  static const mediumGrey = Color(0xFF4B5563); // Medium charcoal
  static const strongGrey = Color(0xFF1F2937); // Deep espresso

  // Furniture Wood Tones
  static const secondaryGreen = Color(0xFF8B7355); // Walnut brown
  static const secondaryBlue = Color(0xFF5D4E37); // Oak brown
  static const white = Color(0xFFFAF9F6); // Off-white/Linen

  // Furniture Gradient Colors (Wood & Fabric tones)
  static const greenLight = Color(0xFFA68A64); // Light maple
  static const greenDark = Color(0xFF6B5744); // Dark walnut

  static const blueLight = Color(0xFF8B7D6B); // Light oak
  static const blueDark = Color(0xFF4A4238); // Dark mahogany

  // Glass Morphism Support (Softer for furniture UI)
  static const glassFillLight = Color(0x0DFAF9F6);
  static const glassFillDark = Color(0x1A1F2937);

  // Shadow Colors (Natural furniture shadows)
  static const shadowBlue = Color(0x1A5D4E37);
  static const shadowGreen = Color(0x1A8B7355);
  static const shadowBlack = Color(0x12000000);

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
    colors: [Color(0xF2FAF9F6), Color(0xE6F5F3F0)],
  );

  static LinearGradient glassGradientDark = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x804B5563), Color(0x66374151)],
  );
}
