import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:location_app/constant/constants.dart';
import 'package:location_app/providers/provider_list_style.dart';
import 'package:location_app/screens/setting_screen/widgets/caraousel_list_style.dart';
import 'package:provider/provider.dart';

import 'example_list_style.dart';

class ViewingStyleExample extends StatelessWidget {
  ViewingStyleExample({Key? key, required this.constraints}) : super(key: key);
  final BoxConstraints constraints;
  final List<String> exampleData = List.generate(10, (index) => "Example");
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        height: constraints.maxHeight * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Colors.white],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Provider.of<ProviderListStyle>(context).isList()
            ? ExampleListStyle(exampleData: exampleData)
            : CaraouselListStyle(exampleData: exampleData),
      ),
    );
  }
}
