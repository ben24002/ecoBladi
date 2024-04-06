import 'package:flutter/material.dart';

//locals
import '../Constants/AppColors.dart';
import '../UI/AllUsers.dart';
import '../UI/homePage.dart';
import '../UI/notifPage.dart';
import '../UI/searchPage.dart';

//appBar
class UIappBar extends StatelessWidget {
  final String hintTxt;
  const UIappBar({
    super.key,
    required this.hintTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 435,
          height: 104,
          decoration: ShapeDecoration(
            color: AppColors.cnst,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            hintTxt,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

//appBottom
class UIbottom extends StatelessWidget {
  const UIbottom({
    super.key,
  });
  //methodes
  void onTap1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
  void onTap2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }
  void onTap3(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationPage()),
    );
  }
  void onTap4(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllUsers()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Take the full width of the parent
      decoration: BoxDecoration(
        color: AppColors.cnst,
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20)), // Add rounded corners to the top
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8), // Add padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              onTap1;
            },
            icon: const Icon(Icons.home),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              onTap2;
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              onTap3;
            },
            icon: const Icon(Icons.notifications),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              onTap4;
            },
            icon: const Icon(Icons.person),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
