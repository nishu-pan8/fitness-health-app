import 'dart:async';
import 'package:boozin_fitness/app/modules/home/controllers/home_controller.dart';
import 'package:boozin_fitness/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<HomeController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Get.offNamed(AppPages.HOME);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (Get.isDarkMode)
                ? Image.asset("assets/gif/fitness_dark.gif")
                : Image.asset("assets/gif/fitness_light.gif"),
          ],
        ),
      ),
    );
  }
}
