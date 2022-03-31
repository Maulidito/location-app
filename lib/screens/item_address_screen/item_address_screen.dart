import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/models/place.dart';

import 'package:location_app/providers/provider_place.dart';
import 'package:location_app/screens/item_address_screen/widgets/bottom_tabbar.dart';
import 'package:location_app/screens/item_address_screen/widgets/item_image_screen.dart';
import 'package:location_app/screens/item_address_screen/widgets/item_location_screen.dart';

import 'package:provider/provider.dart';

class ItemAddressScreen extends StatefulWidget {
  const ItemAddressScreen({Key? key}) : super(key: key);
  static const routeName = "/item-address";

  @override
  State<ItemAddressScreen> createState() => _ItemAddressScreenState();
}

class _ItemAddressScreenState extends State<ItemAddressScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final data = Provider.of<AllPlaces>(context, listen: false).getOneItem(id);
    debugPrint("${data.location} location data ");
    debugPrint("Building ${ItemAddressScreen.routeName}... with item id ${id}");
    return Scaffold(
        appBar: tabController.index == 0
            ? AppBar(title: Text("${data.title}"))
            : null,
        body: Stack(children: [
          TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                item_image_screen(data: data),
                item_location_screen(
                  latLng: data.location ?? LatLng(5.000, 20.000),
                )
              ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Bottom_tabbar(tabController: tabController),
            ),
          ),
        ]));
  }
}
