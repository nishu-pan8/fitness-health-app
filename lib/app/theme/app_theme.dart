import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    primaryColor: Colors.white,
    cardColor: const Color(0xFFF0F0F0),
    focusColor: Colors.black,
  );

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff181818)),
    primaryColor: const Color(0xff181818),
    cardColor: const Color(0xff323232),
    focusColor: Colors.white,
  );
}
