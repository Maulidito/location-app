import 'package:flutter/material.dart';
import 'package:location_app/config/routes/routes.dart';
import 'package:location_app/config/theme/theme_light.dart';
import 'package:location_app/providers/provider_place.dart';



import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllPlaces()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeLight.theme,
        initialRoute: Routes.home,
        routes: Routes.routes,
      ),
    );
  }
}
