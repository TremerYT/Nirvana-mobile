import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_button.dart';
import 'package:nirvana_mobile/core/widgets/custom_divider.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_background.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_form.dart';
import 'package:nirvana_mobile/routes/app_routes.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomBackground(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
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
                  const SizedBox(height: 15),
                  CustomText(
                    text: "Hi, Welcome Back 👋",
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomText(text: "Sign in to your account"),
                  const SizedBox(height: 50),
                  CustomForm(
                    formKey: controller.loginFormKey,
                    fields: controller.loginFormFields,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          Get.toNamed(AppRoutes.verificationOptions),
                      child: const CustomText(text: "Forgot Password?"),
                    ),
                  ),
                  Obx(
                    () => CustomButton(
                      text: "Login",
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,
                      isLoading: controller.isLoading.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomDivider(text: "Or Sign in with"),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: SignInButton(
                      Buttons.google,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: () {},
                      text: 'Sign in with Google',
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryLight,
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: () {},
                      text: 'Sign in with Apple',
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(text: "Don't have an account?"),
                      TextButton(
                        onPressed: () => Get.offNamed(AppRoutes.register),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: CustomText(
                          text: 'Sign up',
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
      ),
    );
  }
}
