import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/widgets/frame_image.dart';

class item_location_screen extends StatefulWidget {
  final LatLng latLng;
  const item_location_screen({
    Key? key,
    required this.latLng,
  }) : super(key: key);

  @override
  State<item_location_screen> createState() => _item_location_screenState();
}

class _item_location_screenState extends State<item_location_screen> {
  double zoomValue = 5;
  final Completer<GoogleMapController> _controllerGooggleMap = Completer();
  @override
  Widget build(BuildContext context) {
    debugPrint("item Location Screen generating...");
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        GoogleMap(
          onMapCreated: (googlemapController) {
            _controllerGooggleMap.complete(googlemapController);
          },
          initialCameraPosition:
              CameraPosition(target: widget.latLng, zoom: zoomValue),
          markers: [
            Marker(markerId: MarkerId("target"), position: widget.latLng)
          ].toSet(),
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: RotatedBox(
            quarterTurns: 3,
            child: Container(
              width: 250,
              height: 70,
              child: Row(children: [
                RotatedBox(quarterTurns: 1, child: Icon(Icons.remove)),
                Slider.adaptive(
                    activeColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    inactiveColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    thumbColor: Theme.of(context).colorScheme.primary,
                    max: 16,
                    min: 0,
                    value: zoomValue,
                    onChanged: (val) async {
                      GoogleMapController controller =
                          await _controllerGooggleMap.future;

                      controller.animateCamera(CameraUpdate.zoomTo(zoomValue));
                      setState(() {
                        zoomValue = val;
                      });
                    }),
                Icon(Icons.add),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
