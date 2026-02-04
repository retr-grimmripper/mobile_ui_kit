import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF5DB075);
  static const Color secondary = Color(0xFF4B9460);
  static const Color textMain = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color inputBackground = Color(0xFFF6F6F6);
  static const Color border = Color(0xFFE8E8E8);
}

class AppText {
  static TextStyle header1 = GoogleFonts.inter(
    fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.textMain,
  );
  static TextStyle header2 = GoogleFonts.inter(
    fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textMain,
  );
  static TextStyle body = GoogleFonts.inter(
    fontSize: 16, color: AppColors.textSecondary,
  );
  static TextStyle link = GoogleFonts.inter(
    fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary,
  );
}