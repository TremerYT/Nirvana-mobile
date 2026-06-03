import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/routes/app_pages.dart';
import 'package:nirvana_mobile/routes/app_routes.dart';

import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Nirvana",
      initialRoute: AppRoutes.onBoarding,
      getPages: AppPages.routes,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}