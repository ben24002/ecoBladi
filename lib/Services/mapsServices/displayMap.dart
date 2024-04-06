// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Constants/AppColors.dart';

class DisplayMap extends StatelessWidget {
  const DisplayMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 400,
      height: 400,
      color: AppColors.first,
      child: const Text(
        "map",
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
