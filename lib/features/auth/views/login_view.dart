import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_button.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_background.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_form.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Lottie(
                    composition: controller.composition.value,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                CustomText(
                  text: "Login to continue using the app",
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: 10),
                CustomForm(
                  formKey: controller.loginFormKey,
                  fields: controller.loginFormFields,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) =>
                                controller.rememberMe.value = value ?? false,
                          ),
                          CustomText(text: "Remember me"),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: CustomText(text: "Forgot Password?"),
                    ),
                  ],
                ),
                CustomButton(text: "Login", onPressed: () {}),
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
                    text: 'Sign in with Google',
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
                    text: 'Sign in with Google',
                    textStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textStyle: TextStyle(color: AppColors.textPrimary),
                      letterSpacing: 0.3,
                    ),
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
