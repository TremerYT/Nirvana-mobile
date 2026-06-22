import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_background.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_otp.dart';

import '../../../core/widgets/custom_button.dart';

class VerificationView extends GetView<AuthController> {
  const VerificationView({super.key});
  void _handleResendOtp() {
    final args = Get.arguments as Map<String, dynamic>?;
    final type = args?.containsKey("phoneNumber") ?? false ? "phone" : "email";
    controller.requestOtp(type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Emporia",
                style: GoogleFonts.pacifico(
                  textStyle: AppTextStyles.titleLarge,
                  fontSize: 35,
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                text: "Enter the verification code",
                style: AppTextStyles.displayLarge,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    const TextSpan(text: "We have sent an OTP code to your "),
                    TextSpan(
                      text:
                          (Get.arguments as Map<String, dynamic>?)?.containsKey(
                                "phoneNumber",
                              ) ??
                              false
                          ? "phone number"
                          : "email",
                    ),
                    TextSpan(
                      text:
                          " ${(Get.arguments as Map<String, dynamic>?)?['phoneNumber'] ?? (Get.arguments as Map<String, dynamic>?)?['email'] ?? 'your contact'}",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    CustomOTP(onCompleted: controller.setOtp, length: 4),
                    const SizedBox(height: 20),
                    CustomText(text: "Didn't receive the verification code?"),
                    const SizedBox(height: 8),
                    Obx(
                      () => Center(
                        child: GestureDetector(
                          onTap: controller.seconds.value > 0
                              ? null
                              : () {
                                  final args =
                                      Get.arguments as Map<String, dynamic>?;
                                  final type =
                                      (args?["phone"] != null ||
                                          args?["phoneNumber"] != null)
                                      ? "phone"
                                      : "email";
                                  controller.requestOtp(type);
                                },
                          child: CustomText(
                            text: controller.seconds.value > 0
                                ? "Resend in ${controller.seconds.value}s"
                                : "Resend Code",
                            style: AppTextStyles.body.copyWith(
                              color: controller.seconds.value > 0
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.6)
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Obx(
                () => CustomButton(
                  text: "Verify",
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.verify,
                  isLoading: controller.isLoading.value,
                  icon: Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
