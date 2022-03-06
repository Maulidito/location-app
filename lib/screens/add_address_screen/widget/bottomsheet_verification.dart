import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/widgets/frame_image.dart';

class BottomSheetVerification extends StatelessWidget {
  final String title;
  final File image;
  final LatLng location;
  final Duration backDuration = const Duration(seconds: 3);

  DateTime? currentBackPressed;

  BottomSheetVerification({
    Key? key,
    required this.title,
    required this.image,
    required this.location,
  }) : super(key: key);

  bool _checkOnWillPop(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPressed != null &&
        now.difference(currentBackPressed!).inSeconds <=
            backDuration.inSeconds) {
      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Press Back Again to Cancel"),
      duration: backDuration,
      behavior: SnackBarBehavior.floating,
    ));

    currentBackPressed = now;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future<bool>(() => _checkOnWillPop(context)),
      child: Container(
        width: double.infinity,
        height: double.infinity / 2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(),
            Row(children: [
              FrameImage(child: Image.file(image,fit: BoxFit.cover,), )
            ]),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("pop"),
            ),
          ],
        ),
      ),
    );
  }
}
