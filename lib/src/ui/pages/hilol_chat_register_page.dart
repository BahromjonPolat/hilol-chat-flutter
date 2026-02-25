/*

  Created by: Bakhromjon Polat
  Created on: Dec 02 2025 18:34:51

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';
import 'package:hilol_chat_flutter/src/blocs/register/hilol_chat_register_bloc.dart';
import 'package:hilol_chat_flutter/src/extensions/context_x.dart';
import 'package:hilol_chat_flutter/src/extensions/string_x.dart';
import 'package:hilol_chat_flutter/src/inputs/email_or_phone_input.dart';
import 'package:hilol_chat_flutter/src/inputs/name_input.dart';
import 'package:hilol_chat_flutter/src/languages/strings.dart';
import 'package:hilol_chat_flutter/src/repositories/chat_repository.dart';
import 'package:hilol_chat_flutter/src/ui/widgets/hilol_chat_elevated_button.dart';
import 'package:hilol_chat_flutter/src/ui/widgets/hilol_chat_input_field.dart';

class HilolChatRegisterPage extends StatelessWidget {
  final ChatRepository chatRepository;
  const HilolChatRegisterPage({super.key, required this.chatRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HilolChatRegisterBloc(repository: chatRepository),
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: const HilolChatRegisterCard(),
      ),
    );
  }
}

class HilolChatRegisterCard extends StatelessWidget {
  const HilolChatRegisterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HilolChatRegisterBloc, HilolChatRegisterState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              Text(
                Strings.register_greeting.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                Strings.register_instruction.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              HilolChatInputField(
                textCapitalization: TextCapitalization.words,
                title: Strings.register_name_label.tr(),
                isRequired: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                autofillHints: const [
                  AutofillHints.name,
                  AutofillHints.familyName,
                ],
                hintText: Strings.register_name_placeholder.tr(),
                onChanged: (value) {
                  context.read<HilolChatRegisterBloc>().add(
                    HilolChatRegisterEvent.nameChanged(value),
                  );
                },
                errorText: state.name.displayError != null
                    ? _getNameErrorText(state.name.displayError!)
                    : null,
              ),
              const SizedBox(height: 16),
              HilolChatInputField(
                title: Strings.register_email_or_phone_label.tr(),
                isRequired: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [
                  AutofillHints.email,
                  AutofillHints.telephoneNumber,
                ],

                hintText: Strings.register_email_or_phone_placeholder.tr(),
                onChanged: (value) {
                  context.read<HilolChatRegisterBloc>().add(
                    HilolChatRegisterEvent.emailOrPhoneChanged(value),
                  );
                },
                errorText: state.emailOrPhone.displayError != null
                    ? _getEmailOrPhoneErrorText(
                        state.emailOrPhone.displayError!,
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              HilolChatElevatedButton(
                isEnabled: state.isValid,
                isLoading: state.status.isInProgress,
                onPressed: () {
                  context.read<HilolChatRegisterBloc>().add(
                    HilolChatRegisterEvent.submit(
                      onSuccess: () {
                        context.read<HilolChatBloc>().add(
                          const HilolChatEvent.onRegistered(),
                        );
                        context.pop();
                      },
                      onError: (errorMessage) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(errorMessage)));
                      },
                    ),
                  );
                },
                text: Strings.register_start_button.tr(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getNameErrorText(NameInputError error) {
    switch (error) {
      case NameInputError.empty:
        return Strings.register_name_required.tr();
      case NameInputError.tooShort:
        return Strings.register_name_too_short.tr();
    }
  }

  String _getEmailOrPhoneErrorText(EmailOrPhoneInputError error) {
    switch (error) {
      case EmailOrPhoneInputError.empty:
        return Strings.register_email_or_phone_required.tr();
      case EmailOrPhoneInputError.invalid:
        return Strings.register_email_or_phone_invalid.tr();
    }
  }
}
