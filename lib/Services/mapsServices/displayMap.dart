// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

class DisplayMap extends StatefulWidget {
  static const String route = '/latlng_to_screen_point';

  const DisplayMap({super.key});

  @override
  State<DisplayMap> createState() => DisplayMapState();
}

class DisplayMapState extends State<DisplayMap> {
  static const double pointSize = 65;

  final mapController = MapController();

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
