import 'package:get/get.dart';
import 'package:nirvana_mobile/features/auth/bindings/auth_binding.dart';
import 'package:nirvana_mobile/features/auth/views/login_view.dart';
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
  ];
}
