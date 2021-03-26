import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scrum_app/app/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: appThemeData,
      defaultTransition: Transition.fadeIn,
    ),
  );
}
