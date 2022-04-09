import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_app/data/db_place/db_place.dart';
import 'package:location_app/models/place.dart';

class AllPlaces with ChangeNotifier {
  final List<Place> _dataPlace = [];
  final db = DBPlace();
  Place? backupDeletedItem;

  List<Place> get items {
    debugPrint("CHECK DATA PLACE COUNT ${_dataPlace}");
    return [..._dataPlace];
  }

  set setItems(List<Place> data) {
    _dataPlace.addAll(data);
  }

  Future<void> addPlace(String title, File image, LatLng location) async {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: location,
        image: image);
    _dataPlace.add(newPlace);

    await db.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "lat": newPlace.location != null
          ? newPlace.location!.latitude.toString()
          : "0.000",
      "long": newPlace.location != null
          ? newPlace.location!.longitude.toString()
          : "0.000",
    });

    notifyListeners();
  }

  List<Place> fromJsontoPlace(List<Map<String, Object?>> data) {
    return data.map((e) => Place.fromJson(e)).toList();
  }

  Place getOneItem(String id) {
    return _dataPlace.firstWhere((element) => element.id == id);
  }

  Future<void> fecthPlaces() async {
    final dataList = await db.getData('user_places');
    if (dataList.isEmpty) {
      return;
    }
    debugPrint("CHECK FECTH PLACES ${_dataPlace.length}");

    setItems = fromJsontoPlace(dataList);
    notifyListeners();
  }

  Future<void> deletePlace(String id) async {
    try {
      backupDeletedItem = items.firstWhere((element) => element.id == id);
      _dataPlace.removeWhere((element) => element.id == id);
      await db.delete("user_places", id);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> restorePlace() async {
    try {
      if (backupDeletedItem != null) {
        await addPlace(backupDeletedItem!.title, backupDeletedItem!.image,
            backupDeletedItem!.location!);
        backupDeletedItem = null;
      }
    } catch (e) {
      throw e;
    } finally {
      notifyListeners();
    }
  }
}
