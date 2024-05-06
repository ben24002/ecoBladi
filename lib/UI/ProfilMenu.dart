// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../Components/ProfilCards.dart';
import '../Components/ui.dart';
import '../Constants/AppColors.dart';
import '../logs/LoginOrRegisterPage.dart';

import 'homePage.dart';

class ProfilMenu extends StatefulWidget {
  const ProfilMenu({super.key});

  @override
  State<ProfilMenu> createState() => _ProfilMenuState();
}

class _ProfilMenuState extends State<ProfilMenu> {
  List<ProfileCardsData> cardsDataList = [
    ProfileCardsData(
      title: 'Account',
      profileCardList: [
        ProfileCardData(
          icon: Icons.account_circle_outlined,
          label: 'Edit Profile',
          onTap: () {
            print('Edit Profile tapped');
          },
        ),
        ProfileCardData(
          icon: Icons.password,
          label: 'Change Password',
          onTap: () {
            print('Change Password tapped');
          },
        ),
        ProfileCardData(
          icon: Icons.notifications_none,
          label: 'Notification Setting',
          onTap: () {
            print('Notification Setting tapped');
          },
        ),
      ],
    ),
    ProfileCardsData(
      title: 'General',
      profileCardList: [
        ProfileCardData(
          icon: Icons.privacy_tip_outlined,
          label: 'Terms Of Service',
          onTap: () {
            print('Terms Of Service tapped');
          },
        ),
        ProfileCardData(
          icon: Icons.help,
          label: 'Help',
          onTap: () {
            print('Help tapped');
          },
        ),
        ProfileCardData(
          icon: Icons.info,
          label: 'About Us',
          onTap: () {
            print('About Us tapped');
          },
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: AppColors.first,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            UIbottom.onTap1(context);
          },
          splashRadius:
              25.0, // Customize the splash radius for a smoother effect
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0), // Adjust padding as needed
        ),
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(60, 0, 0, 0),
          child: Text(
            'EcoBladi',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Outfit',
                  color: Colors.black,
                  fontSize: 35,
                  letterSpacing: 0,
                ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
            child: IconButton(
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
        ],
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
              title: const Text('Option 1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Option 2'),
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
            const SizedBox(
              height: 20,
            ),
            ProfileCards(
              cardsDataList: cardsDataList,
            ),
            const SizedBox(
              height: 20,
            ),
            //log out button
            GestureDetector(
              onTap: () async {
                // Implement the logout functionality
                try {
                  // Sign out the user from Firebase Authentication
                  await FirebaseAuth.instance.signOut();
                  print("User signed out successfully.");

                  // After signing out, you can navigate the user to the login or home screen
                  // After signing out, navigate the user to the LoginPage
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LoginOrRegisterPage()),
                  );
                  // OR
                  // Navigator.of(context).pushReplacementNamed('/home'); // Adjust the route accordingly
                } catch (e) {
                  // Handle any errors that might occur during the sign-out process
                  print("Failed to sign out: $e");
                }
              },
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    // Define the border
                    color: const Color(0xFFA9CF46),
                    width: 2.0, // Border width (adjust as needed)
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
