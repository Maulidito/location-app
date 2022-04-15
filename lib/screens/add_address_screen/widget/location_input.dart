import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key, required this.saveLocation}) : super(key: key);
  final Function saveLocation;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LatLng? _currentLocation;
  bool _selectMapMode = false;

  bool _refreshMap = false;
  GoogleMapController? initController;

  void refresh() {
    setState(() {
      _refreshMap = !_refreshMap;
    });
  }

  void setLocationMapMode(
      {LatLng? locLatLang, LocationData? loc, required bool mapMode}) {
    setState(() {
      if (loc != null) {
        _currentLocation = LatLng(loc.latitude!, loc.longitude!);
      }
      if (locLatLang != null) {
        _currentLocation = locLatLang;
      }
      _refreshMap = false;
      _selectMapMode = mapMode;
    });
  }

  Future<PermissionStatus> _permissionCheck() async {
    final permissionInit = await Location().hasPermission();

    if (permissionInit == PermissionStatus.denied) {
      return await Location().requestPermission();
    }
    return permissionInit;
  }

  Future<void> _getCurrentUserLocation() async {
    if (await _permissionCheck() == PermissionStatus.denied) {
      return;
    }
    try {
      final getCurrentLocation = await Location().getLocation();
      setLocationMapMode(loc: getCurrentLocation, mapMode: false);
      if (initController != null && _currentLocation != null) {
        await initController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: _currentLocation!, zoom: 15)));
      }
      widget.saveLocation(_currentLocation);
      debugPrint(
          "${_currentLocation!.latitude} ${_currentLocation!.longitude}");
      return;
    } catch (e) {
      debugPrint("Get Current User Error ${e.toString()}");
    }
  }

  void _getTapLocation(LatLng tapLocation) {
    if (tapLocation != null) {
      setState(() {
        _currentLocation = tapLocation;
      });
      widget.saveLocation(_currentLocation);
    }
    return;
  }

  Future<void> _getDefaultLocation(LocationInput func) async {
    if (await _permissionCheck() == PermissionStatus.denied) {
      return;
    }
    setLocationMapMode(locLatLang: LatLng(0.0, 0.0), mapMode: true);

    if (initController != null && _currentLocation != null) {
      initController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(0.0, 0.0), zoom: 1)));
    }

    func.saveLocation(_currentLocation);
    debugPrint("Map Mode $_selectMapMode");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("current location $_currentLocation");
    return Column(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Card(
              color: Colors.grey[150],
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: _selectMapMode
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  )),
              child: _refreshMap == true
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 150, vertical: 250 / 3),
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : _currentLocation == null
                      ? Center(
                          widthFactor: double.infinity,
                          heightFactor: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("No Location"),
                              Icon(
                                Icons.not_listed_location_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            ],
                          ))
                      : Stack(
                          children: [
                            GoogleMap(
                                markers: [
                                  Marker(
                                    markerId: MarkerId("selectionLocation"),
                                    position:
                                        _currentLocation ?? LatLng(0.0, 0.0),
                                  )
                                ].toSet(),
                                zoomControlsEnabled: false,
                                buildingsEnabled: true,
                                zoomGesturesEnabled: true,
                                myLocationEnabled: !_selectMapMode,
                                scrollGesturesEnabled: true,
                                gestureRecognizers: Set()
                                  ..add(Factory<EagerGestureRecognizer>(
                                      () => EagerGestureRecognizer())),
                                tiltGesturesEnabled: true,
                                rotateGesturesEnabled: true,
                                compassEnabled: false,
                                onLongPress: _getTapLocation,
                                onMapCreated: (goggleMapController) {
                                  debugPrint("BUILDING MAP...");

                                  initController = goggleMapController;
                                },
                                initialCameraPosition: CameraPosition(
                                    zoom: _selectMapMode ? 0 : 15,
                                    target:
                                        _currentLocation ?? LatLng(0.0, 0.0))),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15))),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  _selectMapMode
                                      ? "Tap Map to Select"
                                      : "This is Your Location",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        )),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: Icon(Icons.my_location),
                label: Text("Current Location")),
            VerticalDivider(
              indent: 5,
              width: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
            TextButton.icon(
                onPressed: () => _getDefaultLocation(widget),
                icon: Icon(Icons.map),
                label: Text("Select On Map")),
          ]),
        )
      ],
    );
  }
}
