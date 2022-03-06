import 'package:flutter/material.dart';

import 'package:location_app/providers/provider_place.dart';

import 'package:provider/provider.dart';

class ItemAddressScreen extends StatelessWidget {
  const ItemAddressScreen({Key? key}) : super(key: key);
  static const routeName = "/item-address";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final data = Provider.of<AllPlaces>(context).getOneItem(id);

    debugPrint("Building $routeName... with item id ${id}");
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        data != null ? Image.file(data.image) : Text("Not Found"),
      ],
    )));
  }
}
