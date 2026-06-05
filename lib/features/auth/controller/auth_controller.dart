import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/features/auth/data/form_data.dart';

import '../../../core/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final _authService = AuthService();

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

  String? pendingPhone;

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

  Future<void> register() async {
    if (!(registerFormKey.currentState?.saveAndValidate() ?? false)) return;

    isLoading.value = true;
    try {
      final data = registerFormKey.currentState!.value;
      final phoneNumber = data["phoneNumber"] as String;

      await _authService.register(data);

      startTimer();
      Get.offNamed(AppRoutes.verification, arguments: phoneNumber);
      Future.delayed(Duration(milliseconds: 300), () {
        Get.snackbar(
          "Registration Successful",
          "Please verify your phone number.",
          backgroundColor: AppColors.success,
          snackPosition: SnackPosition.TOP,
        );
      });
    } catch (e) {
      Get.snackbar(
        "Registration Failed",
        e.toString().replaceFirst("Exception: ", ""),
        snackPosition: SnackPosition.TOP,
      );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verify() async {
    if (otp.value.length < 6) {
      Get.snackbar(
        "Invalid Code",
        "Please enter the full 6-digit code.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error
      );
    }

    isLoading.value = true;
    try {
      await _authService.verifyOtp(pendingPhone ?? '', otp.value);

      isVerified.value = true;
    } catch (e) {
      Get.snackbar(
        "Verification Failed",
        e.toString().replaceFirst("Exception: ", ""),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setOtp(String code) {
    otp.value = code;
  }

  void startTimer() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (seconds.value > 0) {
        seconds.value--;
        return true;
      }
      return false;
    });
  }
}
