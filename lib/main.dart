import 'package:flutter/material.dart';
import 'package:location_app/config/routes/routes.dart';
import 'package:location_app/config/theme/theme_light.dart';
import 'package:location_app/providers/provider_place.dart';
import 'package:location_app/providers/provider_theme.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllPlaces()),
        ChangeNotifierProvider(create: (context) => ProviderTheme())
      ],
      child: LoadApp(),
    );
  }
}

class LoadApp extends StatelessWidget {
  const LoadApp({
    Key? key,
  }) : super(key: key);

  final bool themeModeStartUp = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderTheme>(
      builder: (context, provider, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: provider.themeConfiguration.themeLight(),
        initialRoute: Routes().initApp,
        routes: Routes().routes,
        darkTheme: provider.themeConfiguration.themeDark(),
        themeMode: provider.themeMode ?? themeModeStartUp
            ? ThemeMode.light
            : ThemeMode.dark,
      ),
    );
  }
}
