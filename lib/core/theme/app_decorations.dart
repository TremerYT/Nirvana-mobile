import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppDecorations {
  static BoxDecoration card({double radius = 12}) => BoxDecoration(
    color: AppColors.surfaceWhite,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.border, width: 0.8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration productImage({double radius = 10}) => BoxDecoration(
    color: AppColors.surfaceLight,
    borderRadius: BorderRadius.circular(radius),
  );

  // Bottom CTA bar
  static final BoxDecoration bottomBar = BoxDecoration(
    color: AppColors.surfaceWhite,
    border: const Border(top: BorderSide(color: AppColors.border, width: 0.8)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(12),
        blurRadius: 12,
        offset: const Offset(0, -4),
      ),
    ],
  );

  // Pill chip (category filter)
  static BoxDecoration chip({bool selected = false}) => BoxDecoration(
    color: selected ? AppColors.accent : AppColors.surfaceWhite,
    borderRadius: BorderRadius.circular(100),
    border: Border.all(
      color: selected ? AppColors.accent : AppColors.border,
      width: 1,
    ),
  );
}
