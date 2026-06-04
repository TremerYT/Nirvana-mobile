import 'package:flutter/cupertino.dart';
import 'package:pinput/pinput.dart';

import '../../../core/theme/app_pinput_theme.dart';

class CustomOTP extends StatelessWidget {
  final int length;
  final Function(String) onCompleted;

  const CustomOTP({super.key, required this.onCompleted, required this.length});

  @override
  Widget build(BuildContext context) {

    return Pinput(
      defaultPinTheme: AppPinputTheme.defaultTheme,
      focusedPinTheme: AppPinputTheme.focusedTheme,
      submittedPinTheme: AppPinputTheme.submittedTheme,
      errorPinTheme: AppPinputTheme.errorTheme,
      onCompleted: onCompleted,
    );
  }
}
