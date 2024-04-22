// ignore_for_file: file_names, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Components/MyButtons.dart';
import 'package:education/Constants/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//locals
//import '../Constants/AppColors.dart';
//import '../Services/AuthService.dart';
import '../Components/MyTextfields.dart';
import '../Components/ui.dart';
import '../Services/firestore_service.dart';

class AllUsers extends StatelessWidget {
  AllUsers({super.key});

  final currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static FirestoreService get instance => Get.find();

  //text editing controller
  final fullNameController = TextEditingController();
  final adressController = TextEditingController();
  //methods
  update(context) {
    _db
        .collection('/Utilisateurs')
        .where('ID', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot docs) {
      if (docs.docs.isNotEmpty) {
        Map<String, dynamic>? userData = docs.docs[0].data()
            as Map<String, dynamic>?; // Explicit cast to Map<String, dynamic>?
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

  Future<void> createRoom(collection, docid, data) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(docid)
        .set(data);
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const UIbottom(),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          //appbar
          const UIappBar(hintTxt: 'Profile'),
          const SizedBox(
            height: 200,
          ),
          //full name
          MyTextfields(
            controller: fullNameController,
            hintText: 'FullName',
            obscureText: false,
          ),
          const SizedBox(
            height: 25,
          ),
          //adress
          MyTextfields(
            controller: adressController,
            hintText: 'Adress',
            obscureText: false,
          ),
          const SizedBox(
            height: 20,
          ),
          //update button
          MyButtons(
              onTap: () {
                var data = [];
                update(context);
                print("object");
              },
              text: 'UPDATE'),
          const SizedBox(
            height: 179,
          ),
        ],
      ),
    );
  }
}
