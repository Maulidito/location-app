import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/widgets/frame_image.dart';

class ItemLocationScreen extends StatefulWidget {
  final LatLng latLng;
  const ItemLocationScreen({
    Key? key,
    required this.latLng,
  }) : super(key: key);

  @override
  State<ItemLocationScreen> createState() => _ItemLocationScreenState();
}

class _ItemLocationScreenState extends State<ItemLocationScreen> {
  double zoomValue = 10;
  final double minZoomValue = 4.0;
  final double maxZoomValue = 18.0;
  final Completer<GoogleMapController> _controllerGooggleMap = Completer();

  zoomMapController(int value) async {
    GoogleMapController _googlemapController =
        await _controllerGooggleMap.future;
    setState(() {
      zoomValue += value;

      if (zoomValue < minZoomValue) {
        zoomValue = minZoomValue;
      }
      if (zoomValue > maxZoomValue) {
        zoomValue = maxZoomValue;
      }

      _googlemapController.animateCamera(CameraUpdate.zoomTo(zoomValue));
    });
    debugPrint("zoom map value = $zoomValue");
  }

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
                RotatedBox(
                    quarterTurns: 1,
                    child: InkWell(
                      onTap: () => zoomMapController(-1),
                      child: IconZoomMap(
                        iconData: Icons.remove,
                      ),
                    )),
                Slider.adaptive(
                    activeColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    inactiveColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    thumbColor: Theme.of(context).colorScheme.primary,
                    max: 18,
                    min: 4,
                    value: zoomValue,
                    onChanged: (val) async {
                      GoogleMapController controller =
                          await _controllerGooggleMap.future;
                      setState(() {
                        zoomValue = val;
                        controller
                            .animateCamera(CameraUpdate.zoomTo(zoomValue));
                      });
                    }),
                InkWell(
                  onTap: () => zoomMapController(1),
                  child: IconZoomMap(
                    iconData: Icons.add,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}

class IconZoomMap extends StatelessWidget {
  const IconZoomMap({
    Key? key,
    required this.iconData,
  }) : super(key: key);
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(iconData),
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), shape: BoxShape.circle),
    );
  }
}
