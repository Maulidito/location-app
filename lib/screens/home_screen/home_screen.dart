import 'package:flutter/material.dart';
import 'package:location_app/providers/provider_place.dart';
import 'package:location_app/screens/add_address_screen/add_address_screen.dart';

import 'package:location_app/screens/item_address_screen/item_address_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllPlaces>(context, listen: false);

    debugPrint("Building $routeName...");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddAddressScreen.routeName),
        backgroundColor: Theme.of(context).colorScheme.primary,
        enableFeedback: true,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: FutureBuilder(
          future: provider.fecthPlaces(),
          builder: (cstx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                    backgroundColor: Theme.of(context).colorScheme.primary),
              );
            }
            if (snapShot.hasError) {
              return Center(
                child: Text("Something Went Wrong"),
              );
            }

            return Consumer<AllPlaces>(
              
              builder: (ctx, dataPlace, widget) => dataPlace.items.length == 0
                  ? Center(
                      child: Text("You dont have any places, add one"),
                    )
                  : ListView.builder(
                      itemCount: dataPlace.items.length,
                      itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(dataPlace.items[i].image)),
                            title: Text(dataPlace.items[i].title),
                            subtitle: Text(
                                "Lorem Ipsum And I dont know ${dataPlace.items.length}"),
                            onTap: () => Navigator.of(context).pushNamed(
                                ItemAddressScreen.routeName,
                                arguments: dataPlace.items[i].id),
                          )),
            );
          }),
    );
  }
}
