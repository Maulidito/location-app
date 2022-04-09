import 'package:flutter/material.dart';

class ThemeConfiguration {
  ThemeData themeLight() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF003566),
      brightness: Brightness.light,
    ).copyWith());
  }

  ThemeData themeDark() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF003566), brightness: Brightness.dark)
            .copyWith());
  }
}
