import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_background.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_form.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_textstyle.dart';
import '../../../core/widgets/custom_button.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

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
                CustomText(
                  text: "Getting Started",
                  style: AppTextStyles.displayLarge,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text:
                      "Seems like you are new here. Lets set up your profile below",
                ),
                const SizedBox(height: 30),
                CustomForm(
                  formKey: controller.registerFormKey,
                  fields: controller.registerFormFields,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 13,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 6),
                    CustomText(
                      text:
                          'Your phone number will be used for delivery updates.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CustomButton(
                    text: "Register",
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.register,
                    isLoading: controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: SignInButton(
                    Buttons.google,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(50),
                    ),
                    onPressed: () {},
                    text: 'Sign up with Google',
                    textStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textStyle: TextStyle(color: AppColors.textPrimaryLight),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: SignInButton(
                    Buttons.appleDark,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(50),
                    ),
                    onPressed: () {},
                    text: 'Sign up with Apple',
                    textStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textStyle: TextStyle(color: AppColors.textPrimary),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "Already have an account?"),
                    TextButton(
                      onPressed: () => Get.toNamed('/login'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: CustomText(
                        text: 'login',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
