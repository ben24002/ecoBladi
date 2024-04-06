import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import Google Maps Flutter package

class DisplayMap extends StatelessWidget {
  const DisplayMap({super.key});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.7749, -122.4194), // Set initial position to San Francisco
        zoom: 12, // Adjust the zoom level as needed
      ),
      onMapCreated: (GoogleMapController controller) {
        // You can use the controller here if needed
      },
    );
  }
}
