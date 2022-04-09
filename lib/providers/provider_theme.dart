import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location_app/config/theme/theme_light.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderTheme with ChangeNotifier {
  static const THEME_STATUS = "THEMESTATUS";
  final ThemeConfiguration themeConfiguration = ThemeConfiguration();
  bool? themeMode; //true = light, false = dark

  Future<void> changeTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_STATUS, value);
    themeMode = value;
    debugPrint("THEME MODE $themeMode");
    notifyListeners();
  }

  Future<void> getThemeFromPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getBool(THEME_STATUS);
    themeMode = status ?? true;
    debugPrint("CHECK PROVIDER THEME GET THEME FROM PREFERENCE");
    notifyListeners();
    return;
  }
}
