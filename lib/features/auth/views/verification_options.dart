import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_background.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_card.dart';
import 'package:nirvana_mobile/routes/app_routes.dart';

class VerificationOptions extends GetView<AuthController> {
  const VerificationOptions({super.key});

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
                text: "Verification options",
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 10),
              CustomText(text: "Choose your prefered mode of verification"),
              const SizedBox(height: 20),
              CustomCard(
                pefixIcon: Icons.phone_android,
                text: "Send verification code to phone",
                onTap: () => Get.toNamed(AppRoutes.resetInput, arguments: "phone"),
              ),
              const SizedBox(height: 10),
              CustomCard(
                pefixIcon: Icons.email,
                text: "Send verification code to email",
                onTap: () => Get.toNamed(AppRoutes.resetInput, arguments: "email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
