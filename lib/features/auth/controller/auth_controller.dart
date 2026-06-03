import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nirvana_mobile/features/auth/data/form_data.dart';

class AuthController extends GetxController {
  final loginFormKey = GlobalKey<FormBuilderState>();
  final composition = Rxn<LottieComposition>();
  final compositionPath = "assets/lottie/login.json";
  final loginFormFields = loginFields;

  var rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    _preLoadLottie();
  }

  void _preLoadLottie() async {
    final bytes = await rootBundle.load(compositionPath);
    composition.value = await LottieComposition.fromByteData(bytes);
  }

  void login() {
    if (loginFormKey.currentState?.saveAndValidate() ?? false) {
      Get.offAllNamed("/home");
    }
  }
}
