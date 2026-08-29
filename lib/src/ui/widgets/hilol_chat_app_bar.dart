/*

  Created by: Bakhromjon Polat
  Created on: Nov 26 2025 11:30:13

*/

import 'package:hilol_chat_flutter/src/constants/hilol_chat_icons.dart';
import 'package:flutter/material.dart';
import 'package:hilol_chat_flutter/src/utils/logger.dart';
import 'package:svg_flutter/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HilolChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HilolChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Column(
        children: [
          Text(
            'Hilol Support',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          // Text(
          //   Strings.time_online.tr(),
          //   style: TextStyle(
          //     fontSize: 10,
          //     fontWeight: FontWeight.w500,
          //     color: Theme.of(context).primaryColor,
          //   ),
          // ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () async {
            try {
              await launchUrlString(
                'tel:+998712175999',
                mode: LaunchMode.externalApplication,
              );
            } catch (e) {
              Log.e(e, fileName: 'hilol_chat_app_bar');
            }
          },
          icon: SvgPicture.asset(
            HilolChatIcons.call,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color ?? Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
