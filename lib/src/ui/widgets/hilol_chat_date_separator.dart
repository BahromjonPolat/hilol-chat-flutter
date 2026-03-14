/*

  Created by: Bakhromjon Polat
  Created on: Dec 01 2025 10:47:40

*/

import 'package:flutter/material.dart';
import 'package:hilol_chat_flutter/src/constants/hilol_chat_colors.dart';
import 'package:hilol_chat_flutter/src/utils/date_utils.dart';

class HilolChatDateSeparator extends StatelessWidget {
  final DateTime dateTime;
  const HilolChatDateSeparator({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: Text(
        AppDateUtils.formatDate(dateTime, format: 'ddMM'),
        style: const TextStyle(fontSize: 12, color: HilolChatColors.grey),
      ),
    );
  }
}
