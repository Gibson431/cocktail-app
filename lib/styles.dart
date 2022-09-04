//https://github.com/funwithflutter/flutter_ui_tips/blob/master/tip_003_popup_card/lib/styles.dart

import 'package:flutter/material.dart';

// import 'package:flutter/painting.dart';

// abstract class AppColors {
//   static const Color barTextColor = Color(0xffffffff);
//   static const Color barTextColorDark = Color(0xffffffff);

//   static const Color primaryColor = Color(0xFFef8354);
//   static const Color primaryColorDark = Color(0xFFef8354);

//   static const Color backgroundColorLight = Color(0xFFEEEEEE);
//   static const Color backgroundFadedColor = Color(0xFF191B1C);
//   static const Color backgroundColorDark = Color(0xFF333333);
// }

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFFEEEEEE),
      primary: const Color(0xFFef8354),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color.fromARGB(221, 185, 101, 65),
      secondary: const Color(0xFFFFFF00),
    ),
    scaffoldBackgroundColor: const Color(0xFFEEEEEE));

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFFEEEEEE),
    primary: const Color(0xFFef8354),
    onPrimary: const Color(0xFFFFFFFF),
    primaryContainer: const Color.fromARGB(221, 185, 101, 65),
    surface: const Color(0xFFef8354),
    secondary: const Color(0xFFFFFF00),
  ),
  scaffoldBackgroundColor: const Color(0xFF333333),
);
