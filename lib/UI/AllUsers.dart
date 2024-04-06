// ignore_for_file: file_names, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'package:education/Components/MyButtons.dart';
import 'package:education/Constants/AppColors.dart';
import 'package:flutter/material.dart';

//locals
//import '../Constants/AppColors.dart';
//import '../Services/AuthService.dart';
import '../Components/MyTextfields.dart';
import '../Components/ui.dart';

class AllUsers extends StatelessWidget {
  AllUsers({super.key});

  //text editing controller
  final fullNameController = TextEditingController();
  final adressController = TextEditingController();
  //methods
  update() {}

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          MyButtons(onTap: update(), text: 'UPDATE'),
          const SizedBox(
            height: 179,
          ),
          //appBottom
          const UIbottom(
          )
        ],
      ),
    );
  }
}
