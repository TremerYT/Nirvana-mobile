import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/core/theme/app_colors.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/utils/utils.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';
import 'package:nirvana_mobile/features/profile/controller/profile_controller.dart';

class HomeView extends StatelessWidget {
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
                text: greeting(user?.firstName ?? ''),
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                ),
              );
            }),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge(
              label: const Text('3'),
              child: Icon(
                Icons.notifications_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge(
              label: const Text('3'),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child: Padding(padding: EdgeInsets.all(24))),
    );
  }
}
