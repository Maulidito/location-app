import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressViewModel {
  final _textControll = TextEditingController();

  LatLng? _location;
  File? _pickedImage;

  set setImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  set setLocation(LatLng loc) {
    _location = loc;
  }

  LatLng? get getLocation {
    return _location;
  }

  String? get getTitle {
    return _textControll.text;
  }

  File? get getImage {
    return _pickedImage;
  }

  TextEditingController get titleTextControll {
    return _textControll;
  }

  bool checkNull() {
    if (_textControll.text.isEmpty ||
        _pickedImage == null ||
        _location == null) {
      return true;
    }
    debugPrint(
        "${_textControll.text} , ${_pickedImage?.path.toString()} , ${_location.toString()}");

    return false;
  }
}
