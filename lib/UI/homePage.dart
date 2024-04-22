// ignore_for_file: file_names

import 'package:flutter/material.dart';

// Locals
import '../Components/options.dart';
import '../Constants/AppColors.dart';
import '../Services/mapsServices/displayMap.dart';
import '../Components/ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Methods

  void consultHoraire() {
    // Implement the home method
  }

  void consultGuide() {
    // Implement the home method
  }

  void consultLocalisation() {
    // Implement the home method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const UIbottom(),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const UIappBar(hintTxt: "HomePage"),
          const SizedBox(
            height: 100,
          ),
          //map
          const DisplayMap(),
          OptionsDisplay(
            options: [
              OptionItem(
                icon: Icons.content_paste_search_outlined,
                onTap: () {
                  consultHoraire();
                },
                hintText: 'Consultation des horaires de ramassage',
              ),
              OptionItem(
                icon: Icons.search,
                onTap: () {
                  consultGuide();
                },
                hintText: 'Consulter Guide tri',
              ),
              OptionItem(
                icon: Icons.notifications,
                onTap: () {
                  consultLocalisation();
                },
                hintText: 'Consulter Localisation',
              ),
            ],
          ),
          const SizedBox(
            height: 58,
          ),
        ],
      ),
    );
  }
}
