import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisplayMap extends StatefulWidget {
  // ignore: use_super_parameters
  const DisplayMap({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DisplayMapState createState() => _DisplayMapState();
}

class _DisplayMapState extends State<DisplayMap> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(36.7372, 3.0867), // Algiers coordinates
        zoom: 12,
      ),
      onMapCreated: _onMapCreated,
      markers: _createMarkers(),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  Set<Marker> _createMarkers() {
    return <Marker>[
      Marker(
        markerId: MarkerId('algiers_marker'),
        position: LatLng(36.7372, 3.0867), // Algiers coordinates
        infoWindow: InfoWindow(
          title: 'Algiers',
          snippet: 'Capital of Algeria',
        ),
      ),
    ].toSet();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
