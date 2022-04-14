import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:location_app/constant/constants.dart';
import 'package:location_app/models/place.dart';
import 'package:location_app/providers/provider_list_style.dart';
import 'package:location_app/providers/provider_place.dart';
import 'package:location_app/screens/add_address_screen/add_address_screen.dart';

import 'package:location_app/screens/item_address_screen/item_address_screen.dart';
import 'package:location_app/screens/setting_screen/setting_screen.dart';
import 'package:provider/provider.dart';

import 'widgets/carousel_item.dart';
import 'widgets/list_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  void fecthData() async {
    debugPrint("INIT APP HOMESCREEN");
    await Provider.of<AllPlaces>(context, listen: false).fecthPlaces();

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fecthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building ${HomeScreen.routeName}...");
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AddAddressScreen.routeName),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          enableFeedback: true,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text(
            "Home",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SettingScreen.routename);
                },
                icon: Icon(Icons.settings))
          ],
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator.adaptive(
                    backgroundColor: Theme.of(context).colorScheme.primary),
              )
            : Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.25, 0.8],
                  colors: [
                    Colors.white,
                    Theme.of(context).colorScheme.primary.withOpacity(0.4)
                  ],
                )),
                child: ContainerListPlace()));
  }
}

class ContainerListPlace extends StatelessWidget {
  const ContainerListPlace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AllPlaces>(builder: (ctx, dataPlace, widget) {
      if (dataPlace.items.isEmpty) {
        return const Center(
          child: Text("You dont have any places, add one"),
        );
      }
      if (Provider.of<ProviderListStyle>(context).listMode == LISTMODE) {
        return ListView.builder(
          itemCount: dataPlace.items.length,
          itemBuilder: (ctx, i) {
            debugPrint("CHECK REBUILDING CONSUMER ${dataPlace.items.length}");
            return ListItem(
              dataPlace: dataPlace.items[i],
            );
          },
        );
      }

      return Center(
        child: CarouselSlider.builder(
            itemCount: dataPlace.items.length,
            itemBuilder: (context, itemIndex, pageViewIndex) {
              final data = dataPlace.items[itemIndex];
              return CarouselItem(data: data);
            },
            options: CarouselOptions(
              height: 400,
              disableCenter: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              enlargeCenterPage: true,
            )),
      );
    });
  }
}
