import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6366F1);
  static const Color secondaryColor = Color(0xFF8B5CF6);
  static const Color backgroundColor = Color(0xFF0F172A);
  static const Color cardColor = Color(0xFF1E293B);
  static const Color accentColor = Color(0xFF10B981);
  static const Color textBodyColor = Color(0xFF94A3B8);
  static const Color textHeadingColor = Colors.white;

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    textTheme: GoogleFonts.outfitTextTheme().copyWith(
      bodyLarge: GoogleFonts.outfit(color: textHeadingColor, fontSize: 16),
      bodyMedium: GoogleFonts.outfit(color: textBodyColor, fontSize: 14),
      headlineLarge: GoogleFonts.outfit(color: textHeadingColor, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    colorScheme: const ColorScheme.dark(primary: primaryColor, secondary: secondaryColor, surface: cardColor),
  );
}
