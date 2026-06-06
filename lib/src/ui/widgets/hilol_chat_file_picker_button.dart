/*

  Created by: Bakhromjon Polat
  Created on: Nov 26 2025 13:55:09

*/

import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';
import 'package:hilol_chat_flutter/src/constants/hilol_chat_icons.dart';
import 'package:hilol_chat_flutter/src/extensions/context_x.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg.dart';

class HilolChatFilePickerButton extends StatelessWidget {
  const HilolChatFilePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final bloc = context.read<HilolChatBloc>();

        if (!bloc.state.isRegistered) {
          final defaultUserData = bloc.state.defaultUserData;
          if (defaultUserData != null) {
            bloc.add(
              HilolChatEvent.register(
                data: defaultUserData,
                onSuccess: () {
                  _pickAndSendImage(context);
                },
              ),
            );
          } else {
            context.push(
              HilolChatRegisterPage(chatRepository: bloc.chatRepository),
            );
          }
          return;
        }

        _pickAndSendImage(context);
        // showHilolChatBottomModalSheet(
        //   context: context,
        //   items: [
        //     BottomModalSheetItem(
        //       title: 'File',
        //       icon: HilolChatIcons.file,
        //       onTap: () => _pickFile(isFile: true, onPicked: (value) {}),
        //     ),
        //     BottomModalSheetItem(
        //       title: 'Gallery',
        //       icon: HilolChatIcons.gallery,
        //       onTap: () => _pickFile(
        //         isFile: false,
        //         onPicked: (value) {
        //           final imagePath = value.first.path;
        //           context.read<HilolChatBloc>().add(
        //             HilolChatEvent.sendImage(imagePath),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // );
      },
      child: Container(
        height: 48,
        width: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: SvgPicture.asset(
          HilolChatIcons.gallery,
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  void _pickAndSendImage(BuildContext context) {
    _pickFile(
      isFile: false,
      onPicked: (value) {
        final imagePath = value.first.path;
        context.read<HilolChatBloc>().add(
              HilolChatEvent.sendImage(imagePath),
            );
      },
    );
  }

  Future<void> _pickFile({
    required bool isFile,
    required ValueChanged<List<XFile>> onPicked,
  }) async {
    final files = <XFile>[];
    if (isFile) {
      final picker = FilePicker.platform;
      final result = await picker.pickFiles();
      files.addAll(result?.xFiles ?? []);
    } else {
      final picker = ImagePicker();
      final result = await picker.pickImage(source: ImageSource.gallery);
      if (result != null) {
        files.add(result);
      }
    }

    if (files.isEmpty) {
      return;
    }
    onPicked(files);
  }
}
