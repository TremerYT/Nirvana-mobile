import 'package:get/get.dart';
import 'package:nirvana_mobile/features/auth/bindings/auth_binding.dart';
import 'package:nirvana_mobile/features/auth/views/login_view.dart';
import 'package:nirvana_mobile/features/auth/views/register_view.dart';
import 'package:nirvana_mobile/features/auth/views/reset_password.dart';
import 'package:nirvana_mobile/features/auth/views/verification_view.dart';
import 'package:nirvana_mobile/features/business/binding/business_binding.dart';
import 'package:nirvana_mobile/features/onboarding/binding/onboarding_binding.dart';
import 'package:nirvana_mobile/routes/app_routes.dart';

import '../features/auth/views/reset_input.dart';
import '../features/auth/views/verification_options.dart';
import '../features/business/views/home_view.dart';
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
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.verificationOptions,
      page: () => VerificationOptions(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.resetInput,
      page: () => ResetInputView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: BusinessBinding(),
    ),
  ];
}
