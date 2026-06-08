import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_background.dart';

import '../../../core/widgets/custom_button.dart';
import '../widgets/custom_form.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back, size: 29),
                ),
                const SizedBox(height: 30),
                CustomText(
                  text: "Forgot Your Password",
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: "Enter your email address to reset your password",
                ),
                const SizedBox(height: 20),
                CustomForm(
                  formKey: controller.forgortPasswordFormKey,
                  fields: controller.forgotPasswordFormFields,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CustomButton(
                    text: "Reset Password",
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.forgotPassword,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
