//firebase
// ignore_for_file: avoid_print, body_might_complete_normally_catch_error, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:education/Constants/AppColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

//locals
//import '../Constants/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static FirestoreService get instance => Get.find();

  // Initialize Firestore
  FirestoreService() {
    initializeFirestore();
  }

  Future<void> initializeFirestore() async {
    await Firebase.initializeApp();
  }


  Future<void> createRoom(collection, docid, data) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(docid.text)
        .set(data);

    //add users
/*
  createUser(UsersModel user) async {
    await _db
        .collection('Utilisateurs')
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
              "success",
              "you're account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.first,
            ))
        .catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "something went wrong. try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errbg,
        colorText: AppColors.errtxt,
      );
    });
  }*/

    Future<bool> addUser(String name, String familyName, String address,
        String email, String password,
        {String? role}) async {
      try {
        // Determine role
        // Set role to 'admin' if explicitly provided, otherwise set it to 'user'
        String userRole = role == 'admin' ? 'admin' : 'user';

        // Add a document to the "users" collection
        await _db
            // Name of the collection (similar to a table)
            .collection('users')
            .add({
          'name': name,
          'familyName': familyName,
          'address': address,
          'email': email,
          'password': password,
          // Set the role field
          'role': userRole,
          // Add more fields as needed
        });
        print("Document added successfully!");
        return true; // Return true if successful
      } catch (error) {
        print("Failed to add document: $error");
        return false; // Return false if there's an error
      }
    }

    // Get all users from Firestore
    Stream<List<DocumentSnapshot>> getUsers() {
      return _db.collection('Utilisateurs').snapshots().map((snapshot) {
        return snapshot.docs;
      });
    }

    // Get all users from Firestore
    Stream<List<DocumentSnapshot>> getEboueurs() {
      return _db.collection('Eboueurs').snapshots().map((snapshot) {
        return snapshot.docs;
      });
    }

    // Get all users from Firestore
    Stream<List<DocumentSnapshot>> getAmenageurs() {
      return _db.collection('Amenageurs').snapshots().map((snapshot) {
        return snapshot.docs;
      });
    }

    // Other Firestore operations (e.g., update, delete, etc.) can be added here
  }
}
