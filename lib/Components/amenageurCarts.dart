// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RatingCart extends StatelessWidget {
  final String imagePath;
  final String text;
  final int percentage;

  const RatingCart({
    super.key,
    required this.imagePath,
    required this.text,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Stars
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < percentage ~/ 20
                            ? Icons.star
                            : Icons.star_border,
                        color: index < percentage ~/ 20
                            ? Colors.yellow
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
