// ignore_for_file: file_names

import 'package:flutter/material.dart';

//locals
import '../Components/amenageurCarts.dart';
import '../Components/MyTextfields.dart';
import '../Components/ui.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  //controllers
  final navigationController = TextEditingController();
  //variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const UIbottom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UIappBar(hintTxt: 'navigate'),
            const SizedBox(
              height: 25,
            ),
            MyTextfields(
              controller: navigationController,
              hintText: "search",
              obscureText: false,
            ),
            const SizedBox(
              height: 25,
            ),
            const RatingCart(
              imagePath: "lib/images/LOGO.png",
              text: "text",
              percentage: 80,
            ),
            const SizedBox(
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}
