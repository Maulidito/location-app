import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_app/data/db_place/db_place.dart';
import 'package:location_app/models/place.dart';

class AllPlaces with ChangeNotifier {
  final List<Place> _dataPlace = [];
  final db = DBPlace();

  List<Place> get items {
    return [..._dataPlace];
  }

  set setItems(List<Place> data) {
    _dataPlace.insertAll(0, data);
  }

  void addPlace(String title, File image, LatLng location) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: location,
        image: image);
    _dataPlace.add(newPlace);

    db.insert("user_places", {
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
    setItems = fromJsontoPlace(dataList);
    notifyListeners();
  }
}
