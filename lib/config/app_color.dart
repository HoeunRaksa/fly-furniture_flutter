import 'package:flutter/material.dart';

class AppColors {
  // Furniture-inspired Greys (Softer, more natural tones)
  static const greyLight = Color(0xFF9CA3AF); // Light ash grey
  static const greyMedium = Color(0xFF4B5563); // Medium charcoal
  static const greyDark = Color(0xFF1F2937); // Deep espresso

  // Furniture Wood Tones
  static const woodWalnut = Color(0xFF8B7355); // Walnut brown
  static const woodOak = Color(0xFF5D4E37); // Oak brown
  static const offWhite = Color(0xFFFAF9F6); // Off-white/Linen

  // Furniture Gradient Colors (Wood & Fabric tones)
  static const woodLight = Color(0xFFA68A64); // Light maple
  static const woodDark = Color(0xFF6B5744); // Dark walnut

  static const woodSoft = Color(0xFF8B7D6B); // Light oak
  static const woodDeep = Color(0xFF4A4238); // Dark mahogany

  // Glass Morphism Support (Softer for furniture UI)
  static const glassLight = Color(0x0DFAF9F6);
  static const glassDark = Color(0x1A1F2937);

  // Shadow Colors (Natural furniture shadows)
  static const shadowBrown = Color(0x1A5D4E37);
  static const shadowWarm = Color(0x1A8B7355);
  static const shadowBlack = Color(0x12000000);

  // Gradient Helpers
  static LinearGradient greenGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [woodLight, woodWalnut, woodDark],
  );

  static LinearGradient blueGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [woodSoft, woodOak, woodDeep],
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
