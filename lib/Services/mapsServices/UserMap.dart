// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print, use_build_context_synchronously, deprecated_member_use

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart' as permission;

import '../firestore_service.dart';
import '../firestore_service.dart' as fire;

class DisplayMap extends StatefulWidget {
  static const String route = '/live_location';

  const DisplayMap({Key? key}) : super(key: key);

  @override
  _DisplayMapState createState() => _DisplayMapState();
}

class _DisplayMapState extends State<DisplayMap> {
  var fr = FirestoreService();
  LocationData? _currentLocation;
  late final MapController _mapController;

  bool _liveUpdate = false;
  bool seeWorkers = false;

  String? _serviceError;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  List<LatLng> stops = [
    const LatLng(34.8971364, -1.3484785), // Stop 1
    const LatLng(34.894685, -1.352196), // Stop 2
    const LatLng(34.893864, -1.355490), // Stop 3
  ];

  LatLng? getStopAtIndex(List<LatLng> stops, int index) {
    if (index >= 0 && index < stops.length) {
      return stops[index];
    } else {
      return null; // Return null if index is out of bounds
    }
  }

  // Request location permissions
  Future<void> requestLocationPermissions() async {
    // Access the PermissionStatus from the permission package using the prefix 'permission'
    var status = await permission.Permission.location.request();
    if (status != permission.PermissionStatus.granted) {
      // Handle permission denied case here
      // E.g., show an alert to the user
      print(
          "-------------------------------------------\nLocation permission denied1\n------------------------------------------------");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permission denied'),
      ));
    }
  }

  // Check permissions and access location
  void checkPermissionsAndAccessLocation() async {
    // Request permissions
    var status = await _locationService.requestPermission();
    if (status == location.PermissionStatus.granted) {
      // Permission granted, access location services here
    } else {
      // Permission denied, handle the scenario
      print(
          "-------------------------------------------\nLocation permission denied2\n------------------------------------------------");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permission denied'),
      ));
    }
  }

  // Initialize location service
  void initLocationService() async {
    try {
      await _locationService.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 5,
      );

      bool serviceEnabled = await _locationService.serviceEnabled();

      if (!serviceEnabled) {
        bool serviceRequestResult = await _locationService.requestService();
        if (!serviceRequestResult) {
          setState(() {
            print(
                "-------------------------------------------\nLocation service request failed1.\n------------------------------------------------");
            _serviceError = 'Location service request failed.';
          });
          return;
        }
      }

      // Request location permission
      var status = await permission.Permission.location.request();
      if (status != permission.PermissionStatus.granted) {
        setState(() {
          print(
              "-------------------------------------------\nLocation permission denied3\n------------------------------------------------");
          _serviceError = 'Location permission denied.';
        });
        return;
      }

      // Access current location and listen for location changes
      _currentLocation = await _locationService.getLocation();
      _locationService.onLocationChanged.listen((LocationData locationData) {
        if (mounted) {
          setState(() {
            _currentLocation = locationData;
            if (_liveUpdate && _currentLocation != null) {
              LatLng currentLatLng;
              currentLatLng = LatLng(
                  _currentLocation!.latitude!, _currentLocation!.longitude!);
              fr.setPointPosition(currentLatLng);
              _mapController.move(
                LatLng(
                    _currentLocation!.latitude!, _currentLocation!.longitude!),
                14.0, // Set the desired zoom level
              );
            }
          });
        }
      });
    } catch (e) {
      setState(() {
        print(
            "-------------------------------------------\nError initializing location service:$e\n------------------------------------------------");
        _serviceError = 'Error initializing location service: $e';
      });
      debugPrint('Error: $e');
    }
  }

  Future<List<LatLng>> fetchRoute(List<LatLng> stops) async {
    List<LatLng> routePoints = [];

    // Parcourez chaque paire d'arrêts pour obtenir l'itinéraire entre eux
    for (int i = 0; i < stops.length - 1; i++) {
      LatLng start = stops[i];
      LatLng end = stops[i + 1];

      // Utilisez un service open source pour obtenir l'itinéraire entre `start` et `end`
      List<LatLng> segmentPoints = await fetchSegmentPoints(start, end);

      // Ajoutez les points de l'itinéraire au tableau `routePoints`
      routePoints.addAll(segmentPoints);
    }

    return routePoints;
  }

  // Cette fonction est un exemple, à compléter selon vos besoins et le service utilisé.
  Future<List<LatLng>> fetchSegmentPoints(LatLng start, LatLng end) async {
    // Remplacez par votre propre logique de récupération d'itinéraires
    return [];
  }

//end from GPT------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //init localisation to TLM or current localisation
    LatLng currentLatLng = _currentLocation != null
        ? LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)
        : const LatLng(34.8791468, -1.3134872);

    List<Marker> markers = [
      const Marker(
        width: 80,
        height: 80,
        point: LatLng(34.8791468, -1.3134872), //currentLatLng,
        child: Icon(
          Icons.location_on,
          color: Colors.yellow,
          size: 40,
        ),
      ),
    ];
    void fetchData() {if (mounted) {
      FirestoreService.getDriversLocation().then(
        (driverPositions) {
          markers.addAll(
            driverPositions.map(
              (position) => Marker(
                width: 80,
                height: 80,
                point: LatLng(position[0], position[1]),
                child: const Icon(
                  Icons.no_crash_rounded,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ),
          );
        },
      ).catchError(
        (error) {
          print('------------------------------------------------------\n\n');
          print('Error fetching driver positions: $error');
        },
      );
    }
    }

    fetchData();

    return SizedBox(
      height: 400,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: _serviceError == null
                    ? Text(
                        'This is a map that is showing (${currentLatLng.latitude}, ${currentLatLng.longitude}).',
                      )
                    : Text(
                        'Error occurred while acquiring location. \nError message: $_serviceError',
                      ),
              ),
              Flexible(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: currentLatLng,
                    zoom: 14, // Set your desired zoom level
                    interactiveFlags: InteractiveFlag.all,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      //from GPT--------------------------------------------------------------------------------------
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(markers: markers),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _liveUpdate = !_liveUpdate;

                  if (_liveUpdate) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Live update enabled'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Live update disabled'),
                    ));
                  }
                });
              },
              child: Icon(
                _liveUpdate ? Icons.location_on : Icons.location_off,
              ),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  seeWorkers = !seeWorkers;
                  final message = seeWorkers
                      ? 'see Workers mode enabled'
                      : 'see Workers mode disabled';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                });
              },
              child: const Text(
                'see\n workers',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
