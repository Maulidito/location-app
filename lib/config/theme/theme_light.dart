import 'package:flutter/material.dart';

class ThemeLight {
   static ThemeData get theme {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF003566),
      brightness: Brightness.light,
    ).copyWith());
  }
}
