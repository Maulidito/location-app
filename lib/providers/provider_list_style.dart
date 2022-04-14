import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:location_app/constant/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderListStyle with ChangeNotifier {
  String? listMode;

  Future<void> changeMode(String value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(LISTSTYLEPREF, value);
    listMode = value;
    notifyListeners();
  }

  Future<void> getListStylePreference() async {
    final pref = await SharedPreferences.getInstance();
    final value = pref.getString(LISTSTYLEPREF);
    listMode = value ?? LISTMODE;
    notifyListeners();
  }

  bool isList() {
    return listMode == LISTMODE;
  }
}
