import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../widgets/custom_background.dart';

class ResetPasswordView extends GetView<AuthController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(24)),
        ),
      ),
    );
  }
}
