// ignore_for_file: must_be_immutable, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../UI/AllUsers.dart';
import '../logs/LoginOrRegisterPage.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  User? currentUser = FirebaseAuth.instance.currentUser;
  static FirebaseFirestore bd =FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AllUsers();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }

  // Sign user out method
  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  // Authorize access method
  void authorizeAccess(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {bd
          .collection('/Utilisateurs')
          .where('ID', isEqualTo: currentUser.uid)
          .get()
          .then((QuerySnapshot docs) {
        if (docs.docs.isNotEmpty) {
          Map<String, dynamic>? userData =
              docs.docs[0].data() as Map<String, dynamic>?; // Explicit cast to Map<String, dynamic>?
          if (userData != null && userData['role'] == 'admin') {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AllUsers(),
            ));
          }
        }
      }).catchError((error) {
        print("Error authorizing access: $error");
        // Handle the error here, e.g., display a message to the user
      });
    }
  }
}
