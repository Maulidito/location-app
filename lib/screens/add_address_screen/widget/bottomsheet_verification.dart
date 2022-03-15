import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/data/location_helpers.dart';
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
      child: Column(
        children: [
          Expanded(
              child: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                color: Theme.of(context).colorScheme.primary),
            width: double.infinity,
            child: const Text(
              "Verification",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          )),
          Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              height: double.infinity / 2,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VerificationItem(
                        title: "Title",
                        dataItem: title,
                        isTextType: true,
                        height: 100),
                    VerificationItem(
                      title: "Image",
                      dataItem: image.path.toString(),
                      isTextType: false,
                    ),
                    VerificationItem(
                      title: "Location",
                      isTextType: false,
                      Location: location,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, fixedSize: Size(250, 50)),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Confirm"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationItem extends StatelessWidget {
  const VerificationItem(
      {Key? key,
      required this.title,
      this.dataItem,
      required this.isTextType,
      this.height,
      this.Location})
      : super(key: key);
  final String title;
  final String? dataItem;
  final bool isTextType;
  final LatLng? Location;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height != null ? height : 300,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: Center(child: Text(title))),
              VerticalDivider(
                indent: 1,
                endIndent: 5,
                color: Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                  flex: 2,
                  child: isTextType
                      ? Text(
                          dataItem ?? "Not Found",
                          maxLines: 2,
                          textScaleFactor: 0.9,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        )
                      : FrameImage(
                          child: Location != null
                              ? GoogleMap(
                                  scrollGesturesEnabled: false,
                                  compassEnabled: false,
                                  zoomGesturesEnabled: false,
                                  zoomControlsEnabled: false,
                                  rotateGesturesEnabled: false,
                                  myLocationButtonEnabled: false,
                                  tiltGesturesEnabled: false,
                                  myLocationEnabled: false,
                                  markers: [
                                    Marker(
                                        markerId: MarkerId("locationChoosen"),
                                        position: Location!)
                                  ].toSet(),
                                  initialCameraPosition: CameraPosition(
                                      target: Location!, zoom: 10))
                              : dataItem != null
                                  ? Image.file(
                                      File(dataItem!),
                                      fit: BoxFit.cover,
                                    )
                                  : Text("Error"),
                        ))
            ],
          ),
        ),
        Divider(
          indent: 50,
          endIndent: 50,
        ),
      ],
    );
  }
}
