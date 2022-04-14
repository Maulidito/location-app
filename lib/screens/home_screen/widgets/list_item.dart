import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location_app/models/place.dart';
import 'package:location_app/providers/provider_place.dart';
import 'package:provider/provider.dart';
import 'delete_system.dart';
import '../../item_address_screen/item_address_screen.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.dataPlace,
  }) : super(key: key);

  final Place dataPlace;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllPlaces>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          splashColor: Colors.red,
          onTap: () => Navigator.of(context)
              .pushNamed(ItemAddressScreen.routeName, arguments: dataPlace.id),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: CircleAvatar(backgroundImage: FileImage(dataPlace.image)),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
              child: Text(
                dataPlace.title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            subtitle: Text("Lorem Ipsum And index dont know ${dataPlace}",
                style: TextStyle(color: Colors.white)),
            trailing: IconButton(
                icon: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.secondary),
                onPressed: () => DeleteSystem()
                    .showDeleteDialog(context, provider, dataPlace)),
            onTap: () => Navigator.of(context).pushNamed(
                ItemAddressScreen.routeName,
                arguments: dataPlace.id),
          ),
        ),
      ),
    );
  }
}
