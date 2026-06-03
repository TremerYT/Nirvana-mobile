import 'package:get/instance_manager.dart';
import 'package:nirvana_mobile/features/onboarding/controller/onboarding_controller.dart';

class OnboardingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
  }
}