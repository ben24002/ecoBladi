// ignore_for_file: file_names

import 'package:flutter/material.dart';

//locals
import '../Components/amenageurCarts.dart';
import '../Components/MyTextfields.dart';
import '../Components/ui.dart';
import '../Constants/AppColors.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  //controllers
  final navigationController = TextEditingController();
  //variables

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
                print('IconButton pressed ...');
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
      bottomNavigationBar: const UIbottom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
