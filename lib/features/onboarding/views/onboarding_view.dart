import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nirvana_mobile/core/theme/app_textstyle.dart';
import 'package:nirvana_mobile/core/widgets/custom_text.dart';

import '../../../core/widgets/custom_button.dart';
import '../controller/onboarding_controller.dart';
import '../data/onboarding_data.dart';

class OnBoardingView extends GetView<OnboardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: controller.finish,
                child: CustomText(text: "Skip", style: AppTextStyles.body),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: onBoardingData.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                itemBuilder: (context, index) {
                  final item = onBoardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          final composition = controller.compositions[index];
                          if (composition == null) {
                            return const SizedBox(height: 250);
                          }
                          return Lottie(
                            composition: composition,
                            height: 250,
                            fit: BoxFit.contain,
                          );
                        }),
                        const SizedBox(height: 20),
                        CustomText(
                          text: item.title,
                          style: AppTextStyles.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        CustomText(
                          text: item.description,
                          style: AppTextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingData.length,
                      (index) => Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: controller.currentPage.value == index ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Obx(() {
                    final isLast =
                        controller.currentPage.value ==
                        onBoardingData.length - 1;
                    return CustomButton(
                      text: isLast ? "Get Started" : "Next",
                      onPressed: controller.nextPage,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
