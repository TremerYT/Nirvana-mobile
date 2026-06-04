import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_background.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_otp.dart';

import '../../../core/widgets/custom_button.dart';

class VerificationView extends GetView<AuthController> {
  const VerificationView({super.key});

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
                text: "Enter the verification code",
                style: AppTextStyles.displayLarge,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "We have sent an OTP code to "),
                    TextSpan(
                      text: "${Get.arguments ?? 'your phone number'}",
                      style: TextStyle(color: AppColors.primary),
                    ),
                    const TextSpan(text: " \nEnter the OTP below to verify"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    CustomText(text: "Didn't reveive the verification code?"),
                    const SizedBox(height: 10),
                    Obx(
                      () => Center(
                        child: GestureDetector(
                          onTap: controller.seconds.value > 0 ? null : () {},
                          child: CustomText(
                            text: controller.seconds.value > 0
                                ? "You can resend code in ${controller.seconds.value}s"
                                : "Resend Code",
                            style: AppTextStyles.body.copyWith(
                              color: controller.seconds.value > 0
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),
              Obx(
                () => CustomButton(
                  text: controller.isVerified.value
                      ? "Proceed to Login"
                      : "Verify",
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.isVerified.value
                      ? () => Get.toNamed('/login')
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
