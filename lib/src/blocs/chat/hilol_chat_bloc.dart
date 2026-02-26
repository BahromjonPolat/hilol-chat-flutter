/*

  Created by: Bakhromjon Polat
  Created on: Nov 26 2025 15:00:39

*/

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';
import 'package:fcrm_chat_sdk/fcrm_chat_sdk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:hilol_chat_flutter/src/extensions/message_x.dart';
import 'package:hilol_chat_flutter/src/models/image_meta.dart';
import 'package:hilol_chat_flutter/src/utils/image_utils.dart';
import 'package:hilol_chat_flutter/src/utils/logger.dart';

part 'hilol_chat_event.dart';
part 'hilol_chat_state.dart';
part 'hilol_chat_bloc.freezed.dart';

class HilolChatBloc extends Bloc<HilolChatEvent, HilolChatState> {
  final ChatRepository chatRepository;
  StreamSubscription<ChatMessage>? _messageSubscription;

  HilolChatBloc()
    : chatRepository = ChatRepositoryImpl(),
      super(const HilolChatState.initial()) {
    on<HilolChatEvent>((event, emit) async {
      await event.when(
        initialize: (config, userData, onSuccess) async {
          emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
          final result = await chatRepository.initialize(config: config);

          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  status: FormzSubmissionStatus.failure,
                  errorMessage: failure.message,
                ),
              );
            },
            (chatInitResult) async {
              _messageSubscription = chatRepository.messageStream?.listen((
                message,
              ) {
                if (message.isUpdated) {
                  return;
                }
                add(HilolChatEvent.addMessage(message));
              });

              emit(
                state.copyWith(
                  defaultEndpoint: config.defaultEndpoint,
                  status: FormzSubmissionStatus.success,
                  isRegistered: chatInitResult.isRegistered,
                  defaultUserData: userData,
                  errorMessage: null,
                ),
              );

              onSuccess?.call();

              if (chatInitResult.isRegistered) {
                add(const HilolChatEvent.getMessages());
                return;
              }

              if (userData == null) {
                return;
              }
              add(HilolChatEvent.register(data: userData));
            },
          );
        },
        setupUserData: (data) {
          if (state.isRegistered) {
            return;
          }
          emit(state.copyWith(defaultUserData: data));
        },
        register: (data, onSuccess, onError) async {
          if (state.status.isInProgress) {
            return;
          }

          emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

          final result = await chatRepository.register(userData: data.toJson());

          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  status: FormzSubmissionStatus.failure,
                  errorMessage: failure.message,
                ),
              );
              onError?.call(failure.message);
            },
            (registerResult) {
              emit(
                state.copyWith(
                  status: FormzSubmissionStatus.success,
                  isRegistered: true,
                  errorMessage: null,
                ),
              );
              onSuccess?.call();
              add(const HilolChatEvent.getMessages());
            },
          );
        },
        getMessages: (page) async {
          if (state.status.isInProgress) {
            return;
          }

          emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

          final result = await chatRepository.getMessages(page: page);

          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  status: FormzSubmissionStatus.failure,
                  errorMessage: failure.message,
                ),
              );
            },
            (messagesResult) {
              final messages = [...messagesResult.messages, ...state.messages];
              emit(
                state.copyWith(
                  messages: messages,
                  status: FormzSubmissionStatus.success,
                  hasMoreMessages: messagesResult.hasMore,
                  currentPage: messagesResult.page,
                  errorMessage: null,
                ),
              );
            },
          );
        },
        sendMessage: (message, endpoint) async {
          final chatMessage = ChatMessage(
            id: 0,
            chatId: 0,
            content: message,
            type: MessageType.user,
            createdAt: DateTime.now(),
          );
          final messages = [...state.messages, chatMessage];
          emit(state.copyWith(messages: messages));

          final result = await chatRepository.sendMessage(
            message: message,
            endpoint: endpoint ?? state.defaultEndpoint,
          );
          result.fold(
            (failure) {
              emit(state.copyWith(errorMessage: failure.message));
            },
            (sendResult) {
              // Message will be updated via the message stream
              emit(state.copyWith(errorMessage: null));
            },
          );
        },
        sendImage: (imagePath, endpoint) async {
          final fileName = imagePath.split(Platform.pathSeparator).last;
          final imageFile = File(imagePath);

          final image = await getImageDimensions(imagePath);
          final chatMessage = ChatMessage(
            id: 0,
            chatId: 0,
            content: imagePath,
            type: MessageType.user,
            createdAt: DateTime.now(),
            metadata: ImageMeta(
              isImage: true,
              originalName: fileName,
              filePath: imagePath,
              size: 0,
              width: image.width,
              height: image.height,
            ).toJson(),
          );
          final messages = [...state.messages, chatMessage];
          emit(state.copyWith(messages: messages));

          final result = await chatRepository.sendImage(
            imageFile: imageFile,
            imagePath: imagePath,
            fileName: fileName,
            endpoint: endpoint ?? state.defaultEndpoint,
            onProgress: (sent, total) {
              Log.d(sent / total * 100, fileName: 'hilol_chat_bloc');
            },
          );

          result.fold(
            (failure) {
              emit(state.copyWith(errorMessage: failure.message));
            },
            (imageSendResult) {
              // Message will be updated via the message stream
              emit(state.copyWith(errorMessage: null));
            },
          );
        },
        onRegistered: () async {
          emit(state.copyWith(isRegistered: true, errorMessage: null));
          add(const HilolChatEvent.getMessages());
        },
        startEditing: (message) {
          emit(state.copyWith(editingMessage: message));
        },
        cancelEditing: () {
          emit(state.copyWith(editingMessage: null));
        },
        editMessage: (messageId, content) async {
          final result = await chatRepository.editMessage(
            messageId: messageId,
            content: content,
          );
          result.fold(
            (failure) {
              emit(state.copyWith(errorMessage: failure.message));
            },
            (_) {
              final messages = state.messages.map((m) {
                return m.id == messageId ? m.copyWith(content: content) : m;
              }).toList();
              emit(
                state.copyWith(
                  messages: messages,
                  editingMessage: null,
                  errorMessage: null,
                ),
              );
            },
          );
        },
        addMessage: (message) {
          final messages = message.isUserMessage
              ? [...state.messages]
              : [
                  ...state.messages.map((e) => e.copyWith(isRead: true)),
                  message,
                ];

          if (message.isUserMessage) {
            final index = messages.indexWhere(
              (m) => m.isImage && message.isImage
                  ? (m.imageMeta.originalName == message.imageMeta.originalName)
                  : (m.content == message.content && !m.isSent),
            );

            if (index != -1) {
              messages[index] = message.isImage
                  ? message.copyWith(
                      metadata: messages[index].imageMeta.toJson(),
                    )
                  : message;
            } else {
              messages.add(message);
            }
          }
          emit(state.copyWith(messages: messages));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _messageSubscription?.cancel();
    await chatRepository.dispose();
    return super.close();
  }
}
