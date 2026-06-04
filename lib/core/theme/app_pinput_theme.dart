// core/theme/app_pinput_theme.dart
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'app_colors.dart';
import 'app_textstyle.dart';

class AppPinputTheme {
  static PinTheme get _base => PinTheme(
    width: 56,
    height: 56,
    textStyle: AppTextStyles.titleLarge.copyWith(
      fontSize: 20,
      color: AppColors.textPrimary,
    ),
    decoration: BoxDecoration(
      color: AppColors.surfaceLight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.border, width: 0.8),
    ),
  );

  static PinTheme get defaultTheme => _base;

  static PinTheme get focusedTheme => _base.copyDecorationWith(
    color: AppColors.surfaceMid,
    border: Border.all(color: AppColors.primary, width: 1.5),
    borderRadius: BorderRadius.circular(12),
  );

  static PinTheme get submittedTheme => _base.copyDecorationWith(
    color: AppColors.surfaceMid,
    border: Border.all(color: AppColors.primaryDark, width: 1),
    borderRadius: BorderRadius.circular(12),
  );

  static PinTheme get errorTheme => _base.copyDecorationWith(
    color: AppColors.surfaceLight,
    border: Border.all(color: AppColors.error, width: 1.5),
    borderRadius: BorderRadius.circular(12),
  );
}