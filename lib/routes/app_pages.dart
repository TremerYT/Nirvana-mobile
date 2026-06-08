import 'package:get/get.dart';
import 'package:nirvana_mobile/features/auth/bindings/auth_binding.dart';
import 'package:nirvana_mobile/features/auth/views/forgot_password.dart';
import 'package:nirvana_mobile/features/auth/views/login_view.dart';
import 'package:nirvana_mobile/features/auth/views/register_view.dart';
import 'package:nirvana_mobile/features/auth/views/reset_password.dart';
import 'package:nirvana_mobile/features/auth/views/verification_view.dart';
import 'package:nirvana_mobile/features/onboarding/binding/OnBoardingBinding.dart';
import 'package:nirvana_mobile/routes/app_routes.dart';

import '../features/onboarding/views/onboarding_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.onBoarding,
      page: () => OnBoardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.verification,
      page: () => VerificationView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordView(),
      binding: AuthBinding(),
    ),
  ];
}
