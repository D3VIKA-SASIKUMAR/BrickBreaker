import 'package:flutter/material.dart';

final lightGameColorScheme = ColorScheme(
  brightness: Brightness.light,

  primary: LightGameColors.primary,
  onPrimary: LightGameColors.onPrimary,

  secondary: LightGameColors.secondary,
  onSecondary: LightGameColors.onSecondary,

  tertiary: LightGameColors.accent,
  onTertiary: Colors.black,

  error: LightGameColors.danger,
  onError: Colors.white,

  surface: Colors.white,
  onSurface: LightGameColors.textPrimary,

  outline: LightGameColors.brickOrange,
  shadow: Colors.black,

  inversePrimary: LightGameColors.primary,
  inverseSurface: LightGameColors.background,
  onInverseSurface: Colors.white,
);

final darkGameColorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: DarkGameColors.primary,
  onPrimary: Colors.black,

  secondary: DarkGameColors.secondary,
  onSecondary: Colors.black,

  tertiary: DarkGameColors.accent,
  onTertiary: Colors.black,

  error: DarkGameColors.danger,
  onError: Colors.white,

  surface: DarkGameColors.surface,
  onSurface: Colors.white,

  outline: DarkGameColors.brickYellow,
  shadow: Colors.black,

  inversePrimary: DarkGameColors.primary,
  inverseSurface: DarkGameColors.background,
  onInverseSurface: Colors.white,
);

class LightGameColors {
  static const Color background = Color(0xFFF4F6FF);

  static const Color primary = Color(0xFF3A86FF); // Blue paddle
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFFFF006E); // Neon pink bricks
  static const Color onSecondary = Color(0xFFFFFFFF);

  static const Color accent = Color(0xFFFFBE0B); // Yellow highlights

  static const Color danger = Color(0xFFD90429); // Game over

  static const Color textPrimary = Color(0xFF1A1A1A);

  // 🧱 Brick Variants
  static const Color brickRed = Color(0xFFFF4C4C);
  static const Color brickOrange = Color(0xFFFF9F1C);
  static const Color brickYellow = Color(0xFFFFE66D);
  static const Color brickGreen = Color(0xFF2EC4B6);
  static const Color brickBlue = Color(0xFF3A86FF);
  static const Color brickPurple = Color(0xFF8338EC);
}

class DarkGameColors {
  static const Color background = Color(0xFF0A0F1E);
  static const Color surface = Color(0xFF141B2D);

  static const Color primary = Color(0xFF00E5FF); // Neon cyan paddle
  static const Color secondary = Color(0xFFFF2E63); // Neon pink bricks
  static const Color accent = Color(0xFFFFD700); // Gold score

  static const Color danger = Color(0xFFFF1744);

  // 🧱 Brick Variants
  static const Color brickRed = Color(0xFFFF4C4C);
  static const Color brickOrange = Color(0xFFFF9F1C);
  static const Color brickYellow = Color(0xFFFFEA00);
  static const Color brickGreen = Color(0xFF00FF94);
  static const Color brickBlue = Color(0xFF2979FF);
  static const Color brickPurple = Color(0xFFAA00FF);
}
