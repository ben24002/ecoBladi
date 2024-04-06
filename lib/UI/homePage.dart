
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Constants/AppColors.dart';
import '../Components/options.dart';
import '../Components/ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const UIappBar(hintTxt: "HomePage"),
          const SizedBox(height: 100),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194), // Initial map center coordinates (San Francisco)
                zoom: 12, // Initial zoom level
              ),
              onMapCreated: (GoogleMapController controller) {
                // You can use the controller to interact with the map
              },
            ),
          ),
          OptionsDisplay(
            options: [
              OptionItem(
                icon: Icons.content_paste_search_outlined,
                onTap: () {
                  // Implement the consultHoraire method
                },
                hintText: 'Consultation des horaires de ramassage',
              ),
              OptionItem(
                icon: Icons.search,
                onTap: () {
                  // Implement the consultGuide method
                },
                hintText: 'Consulter Guide tri',
              ),
              OptionItem(
                icon: Icons.notifications,
                onTap: () {
                  // Implement the consultLocalisation method
                },
                hintText: 'Consulter Localisation',
              ),
            ],
          ),
          const SizedBox(height: 58),
          // AppBottom
          UIbottom(
            onTap1: () {
              // Implement the home method
            },
            onTap2: () {
              // Implement the search method
            },
            onTap3: () {
              // Implement the notification method
            },
            onTap4: () {
              // Implement the personalH method
            },
          ),
        ],
      ),
    );
  }
}
