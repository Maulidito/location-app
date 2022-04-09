import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location_app/models/place.dart';
import 'package:location_app/providers/provider_place.dart';
import 'package:provider/provider.dart';

import '../../item_address_screen/item_address_screen.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.dataPlace,
  }) : super(key: key);

  final Place dataPlace;

  AlertDialog confirmDeleteDialog(AllPlaces provider, BuildContext context) {
    return AlertDialog(
        content: Text("Delete the ${dataPlace.title}"),
        actions: [
          TextButton(
              onPressed: () async {
                await provider.deletePlace(dataPlace.id);
                return Navigator.of(context).pop(true);
              },
              child: Text("Yes")),
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("No"))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllPlaces>(context, listen: false);
    return ListTile(
      leading: CircleAvatar(backgroundImage: FileImage(dataPlace.image)),
      title: Text(dataPlace.title),
      subtitle: Text("Lorem Ipsum And index dont know ${dataPlace}"),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          final result = await showDialog(
              context: context,
              builder: (context) => confirmDeleteDialog(provider, context));
          if (result == false) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Undo The Action"),
            action: SnackBarAction(
              label: "UNDO",
              textColor: Colors.white,
              onPressed: () async {
                debugPrint("CHECK DATA ${dataPlace.id}");
                await provider.restorePlace();
              },
            ),
          ));
        },
      ),
      onTap: () => Navigator.of(context)
          .pushNamed(ItemAddressScreen.routeName, arguments: dataPlace.id),
    );
  }
}
