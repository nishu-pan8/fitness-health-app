import 'package:boozin_fitness/app/modules/home/controllers/home_controller.dart';
import 'package:boozin_fitness/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.put(HomeController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      title: "boozin_fitness".tr,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
