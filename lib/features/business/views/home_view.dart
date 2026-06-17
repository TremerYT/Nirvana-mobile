import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/features/business/controller/business_controller.dart';

class HomeView extends GetView<BusinessController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      body: SafeArea(child: Padding(padding: EdgeInsets.all(24))),
    );
  }
}
