import 'package:boozin_fitness/app/modules/home/bindings/home_binding.dart';
import 'package:boozin_fitness/app/modules/home/screens/home_screen.dart';
import 'package:boozin_fitness/app/modules/home/screens/splash_screen.dart';

import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
