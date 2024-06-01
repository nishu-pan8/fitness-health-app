import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health/health.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    authorize();
    _loadGoalsFromStorage();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  List<HealthDataPoint> _energy = [];
  final RxBool _authorized = false.obs;
  final RxInt _nofSteps = 0.obs;
  final RxInt _calories = 0.obs;
  final RxInt _stepsGoal = 2500.obs;
  final RxInt _caloriesGoal = 2000.obs;
  final RxInt _tempStepsGoal = 2500.obs;
  final RxInt _tempCaloriesGoal = 2000.obs;

  // getters
  List<HealthDataPoint> get energy => _energy;
  RxBool get isAuthorized => _authorized;
  RxInt get nofSteps => _nofSteps;
  RxInt get calories => _calories;
  RxInt get stepsGoal => _stepsGoal;
  RxInt get caloriesGoal => _caloriesGoal;
  RxInt get tempStepsGoal => _tempStepsGoal;
  RxInt get tempCaloriesGoal => _tempCaloriesGoal;

  late TextEditingController textEditingController;

  static final types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  final permissions = types.map((e) => HealthDataAccess.READ).toList();

  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  final storage = GetStorage();

  void _loadGoalsFromStorage() {
    if (storage.hasData('stepsGoal')) {
      _stepsGoal.value = storage.read('stepsGoal');
    }
    if (storage.hasData('caloriesGoal')) {
      _caloriesGoal.value = storage.read('caloriesGoal');
    }
  }

  Future<void> authorize() async {
    if (storage.hasData('auth')) {
      _authorized.value = await storage.read('auth');
      if (_authorized.value) {
        await fetchStepData();
        await fetchEnergyData();
        return;
      }
    }
    bool hasPermissions =
        await health.hasPermissions(types, permissions: permissions) ?? false;

    if (!hasPermissions || !_authorized.value) {
      try {
        _authorized.value =
            await health.requestAuthorization(types, permissions: permissions);
        storage.write("auth", _authorized.value);
      } catch (error) {
        storage.write("auth", false);
        Get.snackbar("error".tr, "error_in_auth".tr);
      }
    }
    if (_authorized.value) {
      await fetchStepData();
      await fetchEnergyData();
    }
  }

  Future fetchStepData() async {
    int? steps;

    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    try {
      steps = await health.getTotalStepsInInterval(midnight, now);
    } catch (error) {
      Get.snackbar("error".tr, "error_in_step".tr);
    }

    _nofSteps.value = (steps == null) ? 0 : steps;
  }

  Future fetchEnergyData() async {
    List<HealthDataPoint> energy = [];

    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    try {
      energy = await health.getHealthDataFromTypes(
          midnight, now, [HealthDataType.ACTIVE_ENERGY_BURNED]);
    } catch (error) {
      Get.snackbar("error".tr, "error_in_energy".tr);
    }

    _energy = (energy.isEmpty) ? [] : energy;
    for (var i in _energy) {
      _calories.value += double.parse(i.value.toString()).round();
    }
  }

  updateCaloriesGoal(int value) {
    _caloriesGoal.value = value;
  }

  updateStepsGoal(int value) {
    _stepsGoal.value = value;
  }

  updateTempCaloriesGoal(int value) {
    textEditingController.text = value.toString();
    _tempCaloriesGoal.value = value;
  }

  updateTempStepsGoal(int value) {
    textEditingController.text = value.toString();

    _tempStepsGoal.value = value;
  }
}
