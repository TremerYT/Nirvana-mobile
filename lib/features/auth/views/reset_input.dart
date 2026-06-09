import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_textstyle.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_background.dart';
import '../widgets/custom_form.dart';

class ResetInputView extends GetView<AuthController> {
  const ResetInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final type = Get.arguments as String;

    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new, size: 23),
              ),
              CustomText(
                text: type == "phone"
                    ? "Enter your phone number"
                    : "Enter your email address",
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: type == "phone"
                    ? "We'll send a verification code to your phone"
                    : "We'll send a verification code to your email",
              ),
              const SizedBox(height: 20),
              if (type == "phone")
                CustomForm(
                  formKey: controller.resetFormKey,
                  fields: controller.resetFieldsPhone,
                )
              else
                CustomForm(
                  formKey: controller.resetFormKey,
                  fields: controller.resetFieldsEmail,
                ),
              const SizedBox(height: 20),
              Obx(
                    () => CustomButton(
                  text: "Send Code",
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.requestOtp,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}