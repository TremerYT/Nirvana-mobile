import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_button.dart';
import 'package:nirvana_mobile/core/widgets/custom_divider.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/widgets/custom_background.dart';
import 'package:nirvana_mobile/routes/app_routes.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AuthenticationOptions extends GetView<AuthController> {
  const AuthenticationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
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
              Align(
                alignment: Alignment.center,
                child: Lottie.asset(
                  'assets/lottie/login.json',
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              CustomText(
                text: "Let's Explore Emporia",
                style: AppTextStyles.titleLarge.copyWith(fontSize: 36),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: SignInButton(
                  Buttons.google,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
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
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  onPressed: () {},
                  text: 'Sign in with Apple',
                  textStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    textStyle: TextStyle(color: AppColors.textPrimary),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomDivider(text: "Or Sign in with "),
              const SizedBox(height: 20),
              CustomButton(
                text: "Sign in with email",
                onPressed: () => Get.offAllNamed(AppRoutes.login),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Don't have an account?"),
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
    );
  }
}
