import 'package:flutter/material.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final String text;

  const CustomDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.dividerLight, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.dividerLight, thickness: 1)),
      ],
    );
  }
}
