import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Place {
  final String id;
  final String title;
  final LatLng? location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});

  factory Place.fromJson(Map<String, Object?> data) {
    return Place(
        id: data['id'].toString(),
        title: data['title'].toString(),
        location: LatLng(double.parse(data["lat"] as String),
            double.parse(data["long"] as String)),
        image: File(data["image"].toString()));
  }
}
