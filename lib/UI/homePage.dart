// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Locals

import '../Components/ProfilCards.dart';
import '../Components/options.dart';
import '../Constants/AppColors.dart';
import '../Services/mapsServices/displayMap.dart';
import '../Components/ui.dart';
import 'ProfilMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProfileCardsData> cardsDataList = [
    ProfileCardsData(
      title: 'Mes Fonctionnalités :',
      profileCardList: [
        ProfileCardData(
          icon: Icons.account_circle_outlined,
          label: 'horaires de ramassage',
          onTap: () {
            print(
                '-------------------------------------------\nhoraires de ramassage\n------------------------------------------------');
          },
        ),
        ProfileCardData(
          icon: Icons.password,
          label: 'guide de tri',
          onTap: () {
            print(
                '-------------------------------------------\nguide de tri\n------------------------------------------------');
          },
        ),
        ProfileCardData(
          icon: Icons.location_on,
          label: 'localisation',
          onTap: () {
            print(
                '-------------------------------------------\nlocalisation\n------------------------------------------------');
          },
        ),
        ProfileCardData(
          icon: Icons.location_on_outlined,
          label: 'localisation des points de poubelles',
          onTap: () {
            print(
                '-------------------------------------------\nlocalisation\n------------------------------------------------');
          },
        ),
      ],
    ),
  ];

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
      appBar: AppBar(
        backgroundColor: AppColors.first,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Open the drawer from the left
              },
              splashRadius:
                  25.0, // Customize the splash radius for a smoother effect
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0), // Adjust padding as needed
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(60, 0, 0, 0),
          child: Text(
            'EcoBladi',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.black,
              fontSize: 35,
              letterSpacing: 0,
            ),
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      drawer: Drawer(
        backgroundColor:
            AppColors.expended, // Match the background color to AppBar
        child: ListView(
          children: [
            const Divider(),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilMenu()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            // Add more ListTile widgets as needed
          ],
        ),
      ),
      bottomNavigationBar: const UIbottom(),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //map
            const DisplayMap(),
            ProfileCards(
              cardsDataList: cardsDataList,
            ),
            const SizedBox(
              height: 58,
            ),
          ],
        ),
      ),
    );
  }
}
