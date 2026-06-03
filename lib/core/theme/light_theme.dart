import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_textstyle.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.backgroundLight,

  colorScheme: const ColorScheme.light(
    surface: AppColors.surfaceWhite,
    primary: AppColors.primary,
    onPrimary: AppColors.accentText,
    secondary: AppColors.surfaceMidLight,
    onSecondary: AppColors.textPrimaryLight,
    onSurface: AppColors.textPrimaryLight,
    outline: AppColors.borderLight,
    error: AppColors.error,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundLight,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.5,
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceWhite,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondaryLight,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.accentText,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      textStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.borderLight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primary,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceWhite,
    hintStyle: GoogleFonts.poppins(
      color: AppColors.textSecondaryLight,
      fontSize: 14,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borderLight, width: 0.8),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 1.5),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.primary;
      return AppColors.surfaceWhite;
    }),
    checkColor: WidgetStatePropertyAll(AppColors.accentText),
    side: const BorderSide(color: AppColors.borderLight, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    overlayColor: WidgetStatePropertyAll(AppColors.primary.withOpacity(0.08)),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surfaceWhite,
    selectedColor: AppColors.primary,
    labelStyle: GoogleFonts.poppins(
      fontSize: 13,
      color: AppColors.textSecondaryLight,
    ),
    secondaryLabelStyle: GoogleFonts.poppins(
      fontSize: 13,
      color: AppColors.accentText,
    ),
    shape: const StadiumBorder(),
    side: const BorderSide(color: AppColors.borderLight, width: 0.8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  ),

  cardTheme: CardThemeData(
    color: AppColors.surfaceWhite,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppColors.borderLight, width: 0.8),
    ),
    margin: EdgeInsets.zero,
  ),

  dividerTheme: const DividerThemeData(
    color: AppColors.dividerLight,
    thickness: 0.8,
    space: 0,
  ),

  iconTheme: const IconThemeData(color: AppColors.textPrimaryLight, size: 22),

  textTheme:
      TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        titleLarge: AppTextStyles.titleLarge,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
        labelSmall: AppTextStyles.navLabel,
      ).apply(
        bodyColor: AppColors.textPrimaryLight,
        displayColor: AppColors.textPrimaryLight,
      ),

  fontFamily: GoogleFonts.poppins().fontFamily,
  useMaterial3: true,
);
