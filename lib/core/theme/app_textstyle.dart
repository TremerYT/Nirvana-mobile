import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 35,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle titleLarge = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static TextStyle productTitle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle price = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static TextStyle priceLarge = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static TextStyle body = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  static TextStyle navLabel = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}