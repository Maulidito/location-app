import 'package:flutter/material.dart';
import 'package:location_app/models/place.dart';
import 'package:location_app/providers/provider_place.dart';

class DeleteSystem {
  AlertDialog confirmDeleteDialog(
      AllPlaces provider, BuildContext context, Place dataPlace) {
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

  Future<bool?> showDeleteDialog(
      BuildContext context, AllPlaces provider, Place dataPlace) async {
    final result = await showDialog(
        context: context,
        builder: (context) =>
            confirmDeleteDialog(provider, context, dataPlace));
    if (result == false) {
      return false;
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
    return true;
  }
}
