// ignore_for_file: file_names, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';

//locals
import '../Services/AuthService.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: AuthPage().signOutUser(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "YOU LOGGED IN! as:" + AuthPage().currentUser!.email!,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
