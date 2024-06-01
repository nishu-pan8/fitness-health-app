import 'package:boozin_fitness/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<HomeController>();
  }
}
