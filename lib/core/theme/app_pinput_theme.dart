// app_pinput_theme.dart
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'app_colors.dart';
import 'app_textstyle.dart';

class AppPinputTheme {
  static PinTheme base(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PinTheme(
      width: 56,
      height: 56,
      textStyle: AppTextStyles.titleLarge.copyWith(
        fontSize: 20,
        color: isDark ? AppColors.textPrimary : AppColors.textPrimaryLight,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceLight : AppColors.surfaceMidLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.border : AppColors.borderLight,
          width: 0.8,
        ),
      ),
    );
  }

  static PinTheme focused(BuildContext context) => base(context).copyDecorationWith(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.surfaceMid
        : AppColors.surfaceWhite,
    border: Border.all(color: AppColors.primary, width: 1.5),
    borderRadius: BorderRadius.circular(12),
  );

  static PinTheme submitted(BuildContext context) => base(context).copyDecorationWith(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.surfaceMid
        : AppColors.surfaceWhite,
    border: Border.all(color: AppColors.primaryDark, width: 1),
    borderRadius: BorderRadius.circular(12),
  );

  static PinTheme error(BuildContext context) => base(context).copyDecorationWith(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.surfaceLight
        : AppColors.surfaceMidLight,
    border: Border.all(color: AppColors.error, width: 1.5),
    borderRadius: BorderRadius.circular(12),
  );
}