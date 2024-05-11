//flutter
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//firebase
import 'firebase_options.dart';

//import 'package:education/firestore_service.dart';
import 'UI/searchPage.dart';
import '../Services/AuthService.dart';
import 'UI/homePage.dart';
import 'logs/LoginOrRegisterPage.dart';
import 'logs/RegisterPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}//sheetbottom
