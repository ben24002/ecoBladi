import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart' as permission;

class DisplayMap extends StatefulWidget {
  static const String route = '/live_location';

  const DisplayMap({Key? key}) : super(key: key);

  @override
  _DisplayMapState createState() => _DisplayMapState();
}

class _DisplayMapState extends State<DisplayMap> {
  LocationData? _currentLocation;
  late final MapController _mapController;

  bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
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
        interval: 1,
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

      //-----------------------------------------------

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

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng = _currentLocation != null
        ? LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)
        : const LatLng(34.8791468, -1.3134872);

    final markers = <Marker>[
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
    ];

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
                        'Error occurred while acquiring location. Error message: $_serviceError',
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
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(markers: markers),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
