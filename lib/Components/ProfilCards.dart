// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProfileCardData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  ProfileCardData({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class ProfileCardsData {
  final String title;
  final List<ProfileCardData> profileCardList;

  ProfileCardsData({
    required this.title,
    required this.profileCardList,
  });
}

class ProfileCards extends StatelessWidget {
  final List<ProfileCardsData> cardsDataList;

  const ProfileCards({super.key, required this.cardsDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cardsDataList.map((profileCardsData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                profileCardsData.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...profileCardsData.profileCardList.map((cardData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: cardData.onTap,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA9CF46),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x3416202A),
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            cardData.icon,
                            size: 24,
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                    Colors.black,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              cardData.label,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                    Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      }).toList(),
    );
  }
}
