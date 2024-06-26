// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class DisplayMap extends StatefulWidget {
  static const String route = '/live_location';
  const DisplayMap({Key? key}) : super(key: key);

  @override
  _DisplayMapState createState() => _DisplayMapState();
}

class _DisplayMapState extends State<DisplayMap> {
  LocationData? _currentLocation;
  final MapController _mapController = MapController();

  bool _liveUpdate = false;
  bool isWorking = false;

  final Location _locationService = Location();
  final Distance distance = const Distance();

  String? _serviceError;

  List<LatLng> stops = [
    const LatLng(34.8971364, -1.3484785), // Stop 1
    const LatLng(34.894685, -1.352196), // Stop 2
    const LatLng(34.893864, -1.355490), // Stop 3
  ];

  List<LatLng> routePoints = [];
  List<LatLng> userPath = [];
  List<Marker> stopMarkers = [];

  int currentStopIndex = 0;

  @override
  void initState() {
    super.initState();
    initLocationService();
    // Initialize markers for stops
    createStopMarkers();
    // Fetch the initial route
    fetchRoute(currentStopIndex).then((points) {
      setState(() {
        routePoints = points;
      });
    });
  }

  void createStopMarkers() {
    stopMarkers = stops.map((stop) {
      return Marker(
        point: stop,
        child: const Icon(
          Icons.circle, // Use an icon for the stop (can change to other icons)
          color: Colors.black, // Customize the color as desired
          size: 10, // Adjust size as needed
        ),
      );
    }).toList();
  }

  Future<List<LatLng>> fetchRoute(int startStopIndex) async {
    if (startStopIndex < 0 || startStopIndex >= stops.length) {
      // Handle invalid startStopIndex
      return [];
    }

    Dio dio = Dio();

    LatLng start;
    if (startStopIndex == 0 && _currentLocation != null) {
      start = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      start = stops[startStopIndex - 1];
    }

    LatLng end = stops[startStopIndex];

    // Replace 'YOUR_ROUTING_API_ENDPOINT' with the actual endpoint
    try {
      Response response = await dio.get(
        'https://dart.dev',
        queryParameters: {
          'start': '${start.latitude},${start.longitude}',
          'end': '${end.latitude},${end.longitude}',
          // Add any additional query parameters required by your API
        },
      );

      return parseRouteResponse(response);
    } catch (e) {
      // Handle API error
      print('Error fetching route: $e');
      return [];
    }
  }

  List<LatLng> parseRouteResponse(Response response) {
    // Implement your parsing logic here
    // Example parsing of response data
    // For instance, if the API response contains a list of points:
    List<LatLng> points = [];
    // Add code to parse response data and populate the list of points
    return points;
  }

  // Initialize location service and handle permissions
  void initLocationService() async {
    try {
      // Change location settings
      await _locationService.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 1000,
      );

      // Check if location services are enabled
      bool serviceEnabled = await _locationService.serviceEnabled();
      if (!serviceEnabled) {
        bool requestServiceResult = await _locationService.requestService();
        if (!requestServiceResult) {
          setState(() {
            _serviceError = 'Failed to request location services.';
          });
          return;
        }
      }

      // Request location permissions
      var status = await permission.Permission.location.request();
      if (status != permission.PermissionStatus.granted) {
        setState(() {
          _serviceError = 'Location permission denied.';
        });
        return;
      }

      // Get the current location
      _currentLocation = await _locationService.getLocation();

      // Start listening for location changes
      _locationService.onLocationChanged.listen((LocationData locationData) {
        setState(() {
          _currentLocation = locationData;

          // Update the current location on the map
          if (isWorking && _currentLocation != null) {
            LatLng currentLatLng = LatLng(
              _currentLocation!.latitude!,
              _currentLocation!.longitude!,
            );

            // Move the map to the new location
            _mapController.move(currentLatLng, 18.0);

            // Record the user's path
            userPath.add(currentLatLng);

            // Check if the user reached the current stop
            if (currentStopIndex < stops.length) {
              LatLng currentStop = stops[currentStopIndex];
              double distanceToCurrentStop = distance.as(
                LengthUnit.Meter,
                currentLatLng,
                currentStop,
              );

              // Check if the user is near the current stop
              if (distanceToCurrentStop < 50.0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Stop reached!')),
                );

                // Move to the next stop
                currentStopIndex++;
                fetchRoute(currentStopIndex).then((points) {
                  setState(() {
                    routePoints = points;
                  });
                });
              }
            }
          }
        });
      });
    } catch (e) {
      setState(() {
        _serviceError = 'Error initializing location service: $e';
      });
      debugPrint('Error initializing location service: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize current location
    LatLng currentLatLng = _currentLocation != null
        ? LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)
        : const LatLng(34.8791468, -1.3134872);

    // Define markers for the map
    final markers = <Marker>[
      // Marker for the current location
      Marker(
        width: 80,
        height: 80,
        point: currentLatLng,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
      ),
      // Add stop markers
      ...stopMarkers,
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: _serviceError == null
                  ? Text(
                      'Current location: (${currentLatLng.latitude}, ${currentLatLng.longitude}).',
                    )
                  : Text(
                      'Error acquiring location. \nError message: $_serviceError',
                    ),
            ),
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: currentLatLng,
                  zoom: 14,
                  interactiveFlags: InteractiveFlag.all,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: markers),
                  // PolylineLayer for displaying the route
                  if (routePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints,
                          strokeWidth: 4.0,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  // PolylineLayer for displaying the user's path
                  if (isWorking && userPath.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: userPath,
                          strokeWidth: 4.0,
                          color: Colors.red,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isWorking = !isWorking;
                final message = isWorking
                    ? 'On work mode enabled'
                    : 'On work mode disabled';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              });
            },
            child: const Text('On Work'),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              if (currentStopIndex < stops.length) {
                setState(() {
                  currentStopIndex++;
                  fetchRoute(currentStopIndex).then((points) {
                    setState(() {
                      routePoints = points;
                    });
                  });
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Stop reached!')),
                );
              }
            },
            child: const Text('Stop Reached'),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _liveUpdate = !_liveUpdate;
                final message = _liveUpdate
                    ? 'Live update enabled'
                    : 'Live update disabled';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              });
            },
            child: Icon(
              _liveUpdate ? Icons.location_on : Icons.location_off,
            ),
          ),
        ],
      ),
    );
  }
}
