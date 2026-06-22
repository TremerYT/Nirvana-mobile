import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/utils/utils.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/business/controller/business_controller.dart';
import 'package:nirvana_mobile/features/profile/controller/profile_controller.dart';

class HomeView extends GetView<BusinessController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 80,
        title: Row(
          children: [
            const SizedBox(width: 8),
            ClipOval(
              child: Image.asset(
                'assets/images/profile.jpeg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Obx(() {
              final user = profileController.currentUser.value;
              return CustomText(
                text: greeting(user?.firstName ?? 'User'),
                style: AppTextStyles.body.copyWith(
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
              );
            }),
          ],
        ),
        actions: [
          IconButton(
            icon: const Badge(
              label: Text('3'),
              child: Icon(Icons.notifications_outlined, size: 28),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Badge(
              label: Text('0'),
              child: Icon(Icons.shopping_cart_outlined, size: 28),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(child: Padding(padding: EdgeInsets.all(24))),
    );
  }
}
