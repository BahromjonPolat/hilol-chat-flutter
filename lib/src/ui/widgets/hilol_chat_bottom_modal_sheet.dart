/*

  Created by: Bakhromjon Polat
  Created on: Nov 26 2025 14:36:55

*/

import 'package:hilol_chat_flutter/src/extensions/context_x.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class HilolChatBottomModalSheetContent extends StatelessWidget {
  final List<BottomModalSheetItem> items;
  const HilolChatBottomModalSheetContent({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.paddingOf(context).bottom + 8,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 74,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: context.isDark ? Colors.white : Colors.black,
            ),
          ),
          ...items.map(
            (e) => ListTile(
              title: Text(e.title),
              trailing: SvgPicture.asset(
                e.icon,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color ?? Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                e.onTap();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showHilolChatBottomModalSheet({
  required BuildContext context,
  required List<BottomModalSheetItem> items,
}) async {
  return showModalBottomSheet(
    useRootNavigator: true,
    useSafeArea: true,
    context: context,
    builder: (context) => HilolChatBottomModalSheetContent(items: items),
  );
}

class BottomModalSheetItem {
  final String title;
  final String icon;
  final VoidCallback onTap;
  const BottomModalSheetItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
