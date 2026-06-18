import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nirvana_mobile/routes/app_routes.dart';

import '../data/onboarding_data.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();
  final compositions = <int, LottieComposition>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _preloadLottie();
  }

  void _preloadLottie() async {
    for (int i = 0; i < onBoardingData.length; i++) {
      final bytes = await rootBundle.load(onBoardingData[i].lottie);
      compositions[i] = await LottieComposition.fromByteData(bytes);
    }
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finish();
    }
  }

  void skip() {
    finish();
  }

  void finish() {
    Get.offAllNamed(AppRoutes.authenticationOptions);
  }
}
