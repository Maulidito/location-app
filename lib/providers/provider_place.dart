import 'dart:io';

import 'package:flutter/material.dart';
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

  void addPlace(
    String title,
    File image,
  ) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: image);
    _dataPlace.add(newPlace);
    db.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path
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

    setItems = fromJsontoPlace(dataList);
    debugPrint(items[0].title);
    debugPrint(items.length.toString());

    notifyListeners();
  }
}
