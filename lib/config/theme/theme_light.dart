import 'package:flutter/material.dart';

class ThemeConfiguration {
  final Color themeofApp = const Color(0xFF003566);
  ThemeData themeLight() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
      seedColor: themeofApp,
      secondary: Color(0xFFFFBA49),
      brightness: Brightness.light,
    ).copyWith());
  }

  ThemeData themeDark() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
                seedColor: themeofApp, brightness: Brightness.dark)
            .copyWith());
  }
}
