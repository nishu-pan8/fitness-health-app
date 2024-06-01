import 'package:boozin_fitness/app/modules/home/controllers/home_controller.dart';
import 'package:boozin_fitness/utils/data_card.dart';
import 'package:boozin_fitness/app/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Hi!'.tr,
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.w700, fontFamily: "Nunito"),
        ),
      ),
      body: Center(
        child: Obx(() {
          switch (controller.isAuthorized.value) {
            case false:
              return ElevatedButton(
                onPressed: () async => await controller.authorize(),
                child: Text(
                  'authorize'.tr,
                  style: TextStyle(
                      fontFamily: "Nunito", color: Get.theme.focusColor),
                ),
              );
            case true:
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () => openBottomSheet(BottomSheetType.steps),
                    child: DataCard(
                      goal: controller.stepsGoal.value,
                      icon: "footsteps",
                      title: "steps".tr,
                      value: controller.nofSteps.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => openBottomSheet(BottomSheetType.calories),
                    child: DataCard(
                      goal: controller.caloriesGoal.value,
                      icon: "kcal",
                      title: "calories_burned".tr,
                      value: controller.calories.value,
                    ),
                  ),
                ],
              );

            default:
              return Text('error_fetching_data'.tr);
          }
        }),
      ),
    );
  }
}
