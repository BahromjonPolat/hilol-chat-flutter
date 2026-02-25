/*

  Created by: Bakhromjon Polat
  Created on: Nov 26 2025 13:13:24

*/

import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';
import 'package:hilol_chat_flutter/src/constants/hilol_chat_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hilol_chat_flutter/src/extensions/context_x.dart';
import 'package:hilol_chat_flutter/src/extensions/string_x.dart';
import 'package:hilol_chat_flutter/src/languages/strings.dart';
import 'package:svg_flutter/svg_flutter.dart';

import 'hilol_chat_file_picker_button.dart';

class HilolChatMessageInput extends StatefulWidget {
  final TextEditingController controller;
  const HilolChatMessageInput({super.key, required this.controller});

  @override
  State<HilolChatMessageInput> createState() => _HilolChatMessageInputState();
}

class _HilolChatMessageInputState extends State<HilolChatMessageInput> {
  bool showButton = false;

  void listener() {
    final message = widget.controller.text.trim();
    final isShow = message.isNotEmpty;
    if (isShow == showButton) {
      return;
    }
    setState(() => showButton = isShow);
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        10,
        16,
        MediaQuery.paddingOf(context).bottom + 10,
      ),
      child: Row(
        crossAxisAlignment: .end,
        spacing: 8,
        children: [
          const HilolChatFilePickerButton(),
          Expanded(
            child: Stack(
              children: [
                TextFormField(
                  controller: widget.controller,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  cursorHeight: 18,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: showButton ? const SizedBox() : null,
                    contentPadding: const EdgeInsets.all(12),
                    fillColor: Theme.of(context).cardColor,
                    filled: true,
                    hintText: Strings.chat_type_message.tr(),
                    constraints: const BoxConstraints(
                      maxHeight: 150,
                      minHeight: 42,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: .none,
                    ),
                  ),
                ),

                if (showButton) ...{
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SendButton(
                      onPressed: () {
                        final message = widget.controller.text.trim();
                        if (message.isEmpty) return;

                        final bloc = context.read<HilolChatBloc>();

                        if (!bloc.state.isRegistered) {
                          final defaultUserData = bloc.state.defaultUserData;
                          if (defaultUserData != null) {
                            bloc.add(
                              HilolChatEvent.register(
                                data: defaultUserData,
                                onSuccess: () {
                                  bloc.add(HilolChatEvent.sendMessage(message));
                                },
                              ),
                            );
                            widget.controller.clear();
                          } else {
                            context.push(
                              HilolChatRegisterPage(
                                chatRepository: bloc.chatRepository,
                              ),
                            );
                          }
                          return;
                        }

                        bloc.add(HilolChatEvent.sendMessage(message));
                        widget.controller.clear();
                      },
                    ),
                  ),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }
}

class SendButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SendButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        HilolChatIcons.send,
        colorFilter: ColorFilter.mode(
          Theme.of(context).primaryColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
