import 'package:google_maps_flutter/google_maps_flutter.dart';

const GOOGLE_API_KEY = "AIzaSyB1Mgg5sm57-nFK0U5qcl8OJxAOwx8zVQ8";

class LocationHelper {
  static String generateLocationPreview(LatLng location) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=${location.latitude},${location.longitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C${location.latitude},${location.longitude}&key=$GOOGLE_API_KEY";
  }
}
