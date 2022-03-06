import 'package:flutter/material.dart';

import '../../screens/add_address_screen/add_address_screen.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/item_address_screen/item_address_screen.dart';

class Routes {
   static String get home => HomeScreen.routeName;

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      HomeScreen.routeName: (context) => HomeScreen(),
      ItemAddressScreen.routeName: (context) => ItemAddressScreen(),
      AddAddressScreen.routeName: (context) => AddAddressScreen()
    };
  }
}
