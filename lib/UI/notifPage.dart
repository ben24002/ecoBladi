// ignore_for_file: file_names

import 'package:flutter/material.dart';

//locals
import '../Components/ui.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  //variables

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: UIbottom(),
      body: Column(
        children: [
          UIappBar(hintTxt: 'Notification'),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 600,
          ),
        ],
      ),
    );
  }
}
