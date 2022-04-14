import 'package:flutter/material.dart';
import 'package:location_app/providers/provider_list_style.dart';
import 'package:location_app/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getUserPreference() async {
    debugPrint("GET DATA USER PREFERENCE");
    await Provider.of<ProviderTheme>(context, listen: false)
        .getThemeFromPreference();
    await Provider.of<ProviderListStyle>(context, listen: false)
        .getListStylePreference();
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("CHECK FUTURE BUILDER IS DONE");
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
