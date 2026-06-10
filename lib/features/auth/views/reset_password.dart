import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_form.dart';

import '../../../core/widgets/custom_button.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_background.dart';

class ResetPasswordView extends GetView<AuthController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                CustomText(
                  text: "Reset Password",
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text:
                      "Your password must be different from the previous used passwords",
                ),
                const SizedBox(height: 20),
                CustomForm(
                  formKey: controller.resetPasswordFormKey,
                  fields: controller.resetPasswordFormFields,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CustomButton(
                    text: "Reset Password",
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.resetPassword,
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
