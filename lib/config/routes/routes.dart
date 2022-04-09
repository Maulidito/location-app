import 'package:flutter/material.dart';
import 'package:location_app/screens/setting_screen/setting_screen.dart';
import 'package:location_app/screens/splash_screen/splash_screen.dart';

import '../../screens/add_address_screen/add_address_screen.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/item_address_screen/item_address_screen.dart';

class Routes {
  final String initApp = SplashScreen.routeName;

  Map<String, Widget Function(BuildContext)> get routes {
    return {
      HomeScreen.routeName: (context) => HomeScreen(),
      ItemAddressScreen.routeName: (context) => ItemAddressScreen(),
      AddAddressScreen.routeName: (context) => AddAddressScreen(),
      SettingScreen.routename: (context) => SettingScreen(),
      SplashScreen.routeName: (context) => SplashScreen()
    };
  }
}
