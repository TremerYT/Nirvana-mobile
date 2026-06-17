import 'package:flutter/cupertino.dart';
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
  final resetFormKey = GlobalKey<FormBuilderState>();
  final resetPasswordFormKey = GlobalKey<FormBuilderState>();

  final composition = Rxn<LottieComposition>();
  final compositionPath = "assets/lottie/login.json";

  final loginFormFields = loginFields;
  final registerFormFields = registerFields;
  final resetPasswordFormFields = resetPasswordFields;
  final resetFieldsPhone = resetPhoneFields;
  final resetFieldsEmail = resetEmailFields;

  var rememberMe = false.obs;
  var otp = ''.obs;
  var seconds = 60.obs;
  var isLoading = false.obs;
  var isVerified = false.obs;
  var reset = false.obs;
  var resetInput = "".obs;

  final phoneNumber = ''.obs;
  final email = "".obs;

  Future<void> register() async {
    if (!(registerFormKey.currentState?.saveAndValidate() ?? false)) return;

    isLoading.value = true;
    try {
      final data = registerFormKey.currentState!.value;
      final payload = {
        "fullName": data["fullName"],
        "email": data["email"],
        "phoneNumber": data["phoneNumber"],
        "password": data["password"],
        "purpose": "REGISTER",
      };

      await _authService.register(payload);
      startTimer();

      Get.offNamed(
        AppRoutes.verification,
        arguments: {"purpose": "REGISTRATION", "phone": data["phoneNumber"]},
      );
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: e.toString().replaceFirst('Exception: ', ''),
        backgroundColor: AppColors.error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    if (!(loginFormKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }
    isLoading.value = true;
    try {
      final data = loginFormKey.currentState!.value;
      final response = await _authService.login(data);
      final accessToken = response.data["accessToken"];
      final refreshToken = response.data["refreshToken"];

      if (accessToken == null || refreshToken == null) {
        throw Exception("Invalid response from server");
      }

      await SecureStorage.setAccessToken(accessToken);
      await SecureStorage.setRefreshToken(refreshToken);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString().replaceFirst('Exception: ', ''),
        backgroundColor: AppColors.error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      //
    } finally {
      await SecureStorage.clearAll();
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.login);
    }
  }

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
      final args = Get.arguments as Map<String, dynamic>;
      final payload = {
        "otp": otp.value,
        "purpose": args["purpose"],
        if (args["phone"] != null)
          "phoneNumber": args["phone"]
        else
          "email": args["email"],
      };

      final response = await _authService.verifyOtp(payload);
      Fluttertoast.showToast(
        msg: "Verification successful",
        backgroundColor: AppColors.success,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
      );
      if (args["purpose"] == "VERIFICATION") {
        final resetToken = response.data["resetToken"];
        Get.offAllNamed(
          AppRoutes.resetPassword,
          arguments: {"resetToken": resetToken},
        );
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString().replaceFirst('Exception: ', ''),
        backgroundColor: AppColors.error,
        gravity: ToastGravity.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestOtp(String type) async {
    if (!(resetFormKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }
    isLoading.value = true;
    try {
      final data = resetFormKey.currentState!.value;
      final payload = {
        "purpose": "VERIFICATION",
        if (type == "phone")
          "phoneNumber": data["phoneNumber"]
        else
          "email": data["email"],
      };
      await _authService.requestOtp(payload);
      startTimer();
      Fluttertoast.showToast(
        msg: "OTP sent. Please verify your email or phone number",
        backgroundColor: AppColors.success,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
      );
      Get.toNamed("/verification", arguments: payload);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString().replaceFirst('Exception: ', ''),
        backgroundColor: AppColors.error,
        gravity: ToastGravity.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    if (!(resetPasswordFormKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }
    isLoading.value = true;
    try {
      final data = resetPasswordFormKey.currentState!.value;
      final args = Get.arguments as Map<String, dynamic>;
      final payload = {
        "resetToken": args["resetToken"],
        "newPassword": data["password"],
      };
      await _authService.resetPassword(payload);
      Fluttertoast.showToast(
        msg: "Password reset Successfully",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: AppColors.success,
        gravity: ToastGravity.TOP,
      );
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString().replaceFirst('Exception: ', ''),
        backgroundColor: AppColors.error,
        gravity: ToastGravity.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setOtp(String code) {
    otp.value = code;
  }

  void startTimer() {
    seconds.value = 60;
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
