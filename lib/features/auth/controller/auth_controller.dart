import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nirvana_mobile/features/auth/data/form_data.dart';

class AuthController extends GetxController {
  final loginFormKey = GlobalKey<FormBuilderState>();
  final registerFormKey = GlobalKey<FormBuilderState>();

  final composition = Rxn<LottieComposition>();
  final compositionPath = "assets/lottie/login.json";

  final loginFormFields = loginFields;
  final registerFormFields = registerFields;

  var rememberMe = false.obs;
  var otp = ''.obs;
  var seconds = 60.obs;
  var isLoading = false.obs;
  var isVerified = false.obs;

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

  void register() {
    if (registerFormKey.currentState?.saveAndValidate() ?? false) {
      final data = registerFormKey.currentState!.value;
      final phoneNumber = data["phoneNumber"];
      startTimer();
      Get.toNamed("/verification", arguments: phoneNumber);
    }
  }

  void verify() async{
    isLoading.value = true;
    Future.delayed(Duration(seconds: 7));
    isLoading.value = false;
    isVerified.value = true;
  }

  void setOtp (String code) {
    otp.value = code;
  }

  void startTimer () {
    Future.doWhile( () async {
      await Future.delayed(Duration(seconds: 1));
      if (seconds.value > 0) {
        seconds.value --;
        return true;
      }
      return false;
    });
  }
}
