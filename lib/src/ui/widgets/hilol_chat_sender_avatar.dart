/*

  Created by: Bakhromjon Polat
  Created on: Nov 26 2025 12:20:58

*/

import 'package:hilol_chat_flutter/src/constants/hilol_chat_images.dart';
import 'package:flutter/material.dart';

class HilolChatSenderAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isOnline;
  const HilolChatSenderAvatar({
    super.key,
    required this.imageUrl,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green),
            image: const DecorationImage(
              image: AssetImage(HilolChatImages.support),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (isOnline) ...{
          const Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(backgroundColor: Colors.green, radius: 5),
          ),
        },
      ],
    );
  }
}
