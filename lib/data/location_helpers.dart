import 'package:google_maps_flutter/google_maps_flutter.dart';

const GOOGLE_API_KEY = "AIzaSyDGxOdw59_btxe7mwA1_1O2HGRzxm3nE1M";

class LocationHelper {
  static String generateLocationPreview(LatLng location) {
    return "http://maps.googleapis.com/maps/api/staticmap?center=${location.latitude},${location.longitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C${location.latitude},${location.longitude}&key=$GOOGLE_API_KEY";
  }
}
