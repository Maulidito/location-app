import 'dart:io';

import 'package:location/location.dart';

class Place {
  final String id;
  final String title;
  final LocationData? location;
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
        location: null,
        image: File(data["image"].toString()));
  }
}
