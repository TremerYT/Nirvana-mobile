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
        toastLength: Toast.LENGTH_SHORT,
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
        msg: "Error trying to login",
        backgroundColor: AppColors.error,
      );
    } finally {
      isLoading.value = false;
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

      if (args["purpose"] == "VERIFICATION") {
        final resetToken = response.data["resetToken"];
        Get.offAllNamed(
          "/reset-password",
          arguments: {"resetToken": resetToken},
        );
      } else {
        Get.offAllNamed("/login");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error verifying your code",
        backgroundColor: AppColors.error,
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
          "phone": data["phoneNumber"]
        else
          "email": data["email"],
      };
      await _authService.requestOtp(payload);
      startTimer();
      Get.toNamed("/verification", arguments: payload);
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed");
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
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to set new password");
    } finally {
      isLoading.value = false;
    }
  }

  void setOtp(String code) {
    otp.value = code;
  }

  void startTimer() {
    Future.doWhile(() async {
      seconds.value = 60;
      await Future.delayed(Duration(seconds: 1));
      if (seconds.value > 0) {
        seconds.value--;
        return true;
      }
      return false;
    });
  }
}
