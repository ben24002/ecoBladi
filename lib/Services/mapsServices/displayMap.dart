// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../firestore_service.dart';

class DisplayMap extends StatefulWidget {
  static const String route = '/latlng_to_screen_point';

  const DisplayMap({super.key});

  @override
  State<DisplayMap> createState() => DisplayMapState();
}

class DisplayMapState extends State<DisplayMap> {
  static const double pointSize = 65;

  LatLng? _currentLocation = LatLng(0, 0);
  final MapController mapController = MapController();
  final FirestoreService fire = FirestoreService();

  LatLng? tappedCoords;
  Point<double>? tappedPoint;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tap/click to set coordinate')),
      );
      await _getCurrentLocation();
    });

    Timer.periodic(Duration(seconds: 1), (timer) async {
      //_currentLocation =LatLng(_currentLocation!.latitude, _currentLocation!.longitude);
      print('object');
      await test();
      //var v = await _getCurrentLocation();
    });
  }

  test() async {
    Position position = await Geolocator.getCurrentPosition();
    print(position.toString());
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      //Position position = await Geolocator.getCurrentPosition();
      print(DateTime.now());
      //print(position.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Scaffold(
        appBar: AppBar(
          // Set the title to include the current location
          title: Text(_currentLocation != null
              ? 'Your current location is (${_currentLocation!.latitude.toStringAsFixed(6)}, ${_currentLocation!.longitude.toStringAsFixed(6)})'
              : 'Lat/Lng to Screen Point'), // Use a default title if location is not yet available
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                // Set the initial center to Tlemcen, Algeria
                //initialCenter:const LatLng(34.88061848393576, 1.3183836245749083),
                center: _currentLocation,

                initialZoom: 13, // Adjust zoom level as desired
                interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.doubleTapZoom,
                ),
                onTap: (tapPosition, latLng) {
                  // Handle tap on the map
                  fire.setPointPosition(latLng);
                  final point =
                      mapController.camera.latLngToScreenPoint(latLng);
                  setState(() {
                    tappedCoords = latLng;
                    tappedPoint = Point<double>(point.x, point.y);
                  });
                },
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    Marker(
                      width: pointSize,
                      height: pointSize,
                      point: _currentLocation!,
                      child: const Icon(
                        Icons.fire_truck,
                        size: 30,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                if (tappedCoords != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: pointSize,
                        height: pointSize,
                        point: tappedCoords!,
                        child: const Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (tappedPoint != null)
              Positioned(
                left: tappedPoint!.x - pointSize / 2,
                top: tappedPoint!.y - pointSize / 2,
                child: const IgnorePointer(
                  child: Icon(
                    Icons.center_focus_strong_outlined,
                    color: Colors.black,
                    size: pointSize,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future _getCurrentLocation() async {
    // Request location permission if needed
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      // _markers.add(
      // Marker(
      //   markerId: MarkerId('current_location'),
      //   position: _currentLocation!,
      //   // ),
      // );
    });

    //Move the camera to the current location
    mapController.move(_currentLocation!, 15.0);
    return _currentLocation;

    // if (mapController != null) {
    //   mapController!.animateCamera(
    //     CameraUpdate.newLatLngZoom(_currentLocation!, 15),
    //   );
    // }
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      urlTemplate:
          'https://mt1.google.com/vt/lyrs=m@189097413&hl=en&x={x}&y={y}&z={z}&key=YOUR_API_KEY',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      tileProvider: CancellableNetworkTileProvider(),
    );

/*
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';


import '../firestore_service.dart';

class DisplayMap extends StatefulWidget {
  static const String route = '/latlng_to_screen_point';

  const DisplayMap({super.key});

  @override
  State<DisplayMap> createState() => DisplayMapState();
}

class DisplayMapState extends State<DisplayMap> {
  static const double pointSize = 65;

  final mapController = MapController();
  final fire = FirestoreService();

  LatLng? tappedCoords;

  Point<double>? tappedPoint;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance
        .addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tap/click to set coordinate')),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Scaffold(
        appBar: AppBar(title: const Text('Lat/Lng 🡒 Screen Point')),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: const LatLng(51.5, -0.09),
                initialZoom: 11,
                interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.doubleTapZoom,
                ),
                onTap: (_, latLng) {
                  fire.setPointPosition(latLng);
                  final point = mapController.camera
                      .latLngToScreenPoint(tappedCoords = latLng);
                  setState(() => tappedPoint = Point(point.x, point.y));
                },
              ),
              children: [
                openStreetMapTileLayer,
                if (tappedCoords != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: pointSize,
                        height: pointSize,
                        point: tappedCoords!,
                        child: const Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
              ],
            ),
            if (tappedPoint != null)
              Positioned(
                left: tappedPoint!.x - 60 / 2,
                top: tappedPoint!.y - 60 / 2,
                child: const IgnorePointer(
                  child: Icon(
                    Icons.center_focus_strong_outlined,
                    color: Colors.black,
                    size: 60,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      // Use the recommended flutter_map_cancellable_tile_provider package to
      // support the cancellation of loading tiles.
      tileProvider: CancellableNetworkTileProvider(),
    );
*/
