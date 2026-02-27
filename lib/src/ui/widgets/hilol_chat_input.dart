/*

  Created by: Bakhromjon Polat
  Created on: Nov 26 2025 13:13:24

*/

import 'package:fcrm_chat_sdk/fcrm_chat_sdk.dart';
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
    return BlocConsumer<HilolChatBloc, HilolChatState>(
      listenWhen: (prev, curr) => prev.editingMessage != curr.editingMessage,
      listener: (context, state) {
        if (state.editingMessage != null) {
          widget.controller.text = state.editingMessage!.content;
          widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: state.editingMessage!.content.length),
          );
        } else {
          widget.controller.clear();
        }
      },
      buildWhen: (prev, curr) => prev.editingMessage != curr.editingMessage,
      builder: (context, state) {
        final isEditing = state.editingMessage != null;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isEditing)
              _EditingBanner(
                message: state.editingMessage!,
                onCancel: () {
                  context.read<HilolChatBloc>().add(
                    const HilolChatEvent.cancelEditing(),
                  );
                },
              ),
            Container(
              padding: EdgeInsets.fromLTRB(
                16,
                10,
                16,
                MediaQuery.paddingOf(context).bottom + 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 8,
                children: [
                  if (!isEditing) const HilolChatFilePickerButton(),
                  Expanded(
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: widget.controller,
                          textInputAction: TextInputAction.newline,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                          cursorHeight: 18,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
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
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        if (showButton)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SendButton(
                              onPressed: () {
                                final content = widget.controller.text.trim();
                                if (content.isEmpty) return;

                                final bloc = context.read<HilolChatBloc>();

                                if (bloc.state.editingMessage != null) {
                                  bloc.add(
                                    HilolChatEvent.editMessage(
                                      messageId: bloc.state.editingMessage!.id,
                                      content: content,
                                    ),
                                  );
                                  widget.controller.clear();
                                  return;
                                }

                                if (!bloc.state.isRegistered) {
                                  final defaultUserData =
                                      bloc.state.defaultUserData;
                                  if (defaultUserData != null) {
                                    bloc.add(
                                      HilolChatEvent.register(
                                        data: defaultUserData,
                                        onSuccess: () {
                                          bloc.add(
                                            HilolChatEvent.sendMessage(content),
                                          );
                                        },
                                      ),
                                    );
                                    widget.controller.clear();
                                    return;
                                  } else {
                                    context.push(
                                      HilolChatRegisterPage(
                                        chatRepository: bloc.chatRepository,
                                      ),
                                    );
                                  }
                                  return;
                                }

                                bloc.add(HilolChatEvent.sendMessage(content));
                                widget.controller.clear();
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }
}

class _EditingBanner extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback onCancel;

  const _EditingBanner({required this.message, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
          left: BorderSide(color: Theme.of(context).primaryColor, width: 3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Strings.general_edit.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onCancel,
            icon: const Icon(Icons.close, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
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
