import 'package:flutter/material.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.surface,
            ],
            stops: const [0.0, 0.6],
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}
