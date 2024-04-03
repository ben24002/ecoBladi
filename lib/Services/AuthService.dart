// ignore_for_file: file_names, non_constant_identifier_names, avoid_types_as_parameter_names, must_be_immutable
import 'package:flutter/material.dart';

//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//logs pages
import '../UI/AllUsers.dart';
import '../logs/LoginOrRegisterPage.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return const HomePage();
          }
          //user not logged in
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
  //sign user out methode
  signOutUser(){
    FirebaseAuth.instance.signOut();
  }

  authorizeAccess(BuildContext context) {
  if (currentUser != null) {
    FirebaseFirestore.instance
        .collection('/Users')
        .where('ID', isEqualTo: currentUser!.uid)
        .get()
        .then((QuerySnapshot docs) {
      if (docs.docs.isNotEmpty) {
        Map<String, dynamic>? userData = docs.docs[0].data() as Map<String, dynamic>?; // Explicit cast to Map<String, dynamic>?
        if (userData != null && userData['role'] == 'admin') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ));
        }
      }
    });
  }
}

}
