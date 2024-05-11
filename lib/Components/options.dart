import 'package:flutter/material.dart';

//locals
import '../Constants/AppColors.dart';

class OptionItem {
  final IconData icon;
  final VoidCallback onTap;
  final String hintText;

  OptionItem({
    required this.icon,
    required this.onTap,
    required this.hintText,
  });
}

class OptionsDisplay extends StatelessWidget {
  final List<OptionItem> options;
  final double itemWidth;
  final double itemHeight;

  const OptionsDisplay({
    super.key,
    required this.options,
    this.itemWidth = 64,
    this.itemHeight = 70,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: (options.length / 3).ceil(), // Calculate number of rows
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Align items vertically
              children: options
                  .sublist(index * 3,
                      (index + 1) * 3) // Get three items for each row
                  .map((item) {
                return Expanded(
                  child: SizedBox(
                    width: itemWidth,
                    height: itemHeight,
                    child: InkWell(
                      onTap: item.onTap,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cnst,
                            ),
                            child: Center(
                              child: Icon(item.icon),
                            ),
                          ),
                          const SizedBox(
                              height:
                                  20), // Add some spacing between icon and text
                          Text(
                            item.hintText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
