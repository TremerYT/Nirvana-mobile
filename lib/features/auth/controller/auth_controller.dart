import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nirvana_mobile/core/storage/secure_storage.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/features/auth/data/form_data.dart';

import '../../../core/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final _authService = AuthService();

  final loginFormKey = GlobalKey<FormBuilderState>();
  final registerFormKey = GlobalKey<FormBuilderState>();
  final forgortPasswordFormKey = GlobalKey<FormBuilderState>();

  final composition = Rxn<LottieComposition>();
  final compositionPath = "assets/lottie/login.json";

  final loginFormFields = loginFields;
  final registerFormFields = registerFields;
  final forgotPasswordFormFields = forgotPasswordFields;

  var rememberMe = false.obs;
  var otp = ''.obs;
  var seconds = 60.obs;
  var isLoading = false.obs;
  var isVerified = false.obs;

  final phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _preLoadLottie();
  }

  void _preLoadLottie() async {
    final bytes = await rootBundle.load(compositionPath);
    composition.value = await LottieComposition.fromByteData(bytes);
  }

  Future<void> register() async {
    if (!(registerFormKey.currentState?.saveAndValidate() ?? false)) return;

    isLoading.value = true;
    try {
      final data = registerFormKey.currentState!.value;
      phoneNumber.value = data["phoneNumber"];

      await _authService.register(data);

      startTimer();
      Get.offNamed(
        AppRoutes.verification,
        arguments: data["phoneNumber"] as String,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to Register",
        backgroundColor: AppColors.error,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> login() async{
  //   if (!(loginFormKey.currentState?.saveAndValidate() ?? false)) {
  //     return;
  //   }
  //   isLoading.value = true;
  //   try {
  //     final data =loginFormKey.currentState!.value;
  //     final _tokens = await _authService.login(data);
  //
  //   }
  //   catch(e) {
  //
  //   }
  //
  // }

  Future<void> verify() async {
    if (otp.value.length < 6) {
      Fluttertoast.showToast(
        msg: "Please enter a valid Otp code",
        backgroundColor: AppColors.error,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
      );

      return;
    }

    isLoading.value = true;
    try {
      await _authService.verifyOtp({
        "phoneNumber": phoneNumber.value,
        "verificationCode": otp.value,
      });

      isVerified.value = true;
      Get.offAllNamed("/login");
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error verifying your number",
        backgroundColor: AppColors.error,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (!(forgortPasswordFormKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }
    isLoading.value = true;
    try {
      final data = forgortPasswordFormKey.currentState!.value;
      await _authService.forgotPassword(data);
      Get.toNamed("/verification");
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try again.",
        backgroundColor: AppColors.error,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
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
