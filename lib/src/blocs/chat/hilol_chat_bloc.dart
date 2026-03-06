/*

  Created by: Bakhromjon Polat
  Created on: Nov 26 2025 15:00:39

*/

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';
import 'package:hilol_chat_flutter/src/ui/widgets/hilol_chat_notification_banner.dart';
import 'package:fcrm_chat_sdk/fcrm_chat_sdk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:hilol_chat_flutter/src/extensions/message_x.dart';
import 'package:hilol_chat_flutter/src/models/image_meta.dart';
import 'package:hilol_chat_flutter/src/models/upload_task.dart';
import 'package:hilol_chat_flutter/src/utils/image_utils.dart';

part 'hilol_chat_event.dart';
part 'hilol_chat_state.dart';
part 'hilol_chat_bloc.freezed.dart';

class HilolChatBloc extends Bloc<HilolChatEvent, HilolChatState> {
  final ChatRepository chatRepository;
  StreamSubscription<ChatMessage>? _messageSubscription;
  bool _isProcessingQueue = false;

  GlobalKey<NavigatorState>? _navigatorKey;
  void Function()? _onNotificationTap;
  OverlayEntry? _notificationEntry;

  HilolChatBloc()
    : chatRepository = ChatRepositoryImpl(),
      super(const HilolChatState.initial()) {
    on<HilolChatEvent>((event, emit) async {
      await event.when(
        initialize: (config, userData, onSuccess) async {
          _navigatorKey = config.navigatorKey;
          _onNotificationTap = config.onNotificationTap;
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
                if (message.isEdited) {
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

              // add(HilolChatEvent.register(data: userData));
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
              if (onSuccess == null) {
                add(const HilolChatEvent.getMessages());
              }
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
          await _enqueueImage(
            imagePath,
            endpoint ?? state.defaultEndpoint,
            emit,
          );
        },
        sendImages: (imagePaths, endpoint) async {
          for (final imagePath in imagePaths) {
            await _enqueueImage(
              imagePath,
              endpoint ?? state.defaultEndpoint,
              emit,
            );
          }
        },
        updateUploadProgress: (filePath, progress) {
          final task = state.uploadTasks[filePath];
          if (task == null) return;
          final updatedTasks = Map<String, UploadTask>.from(state.uploadTasks);
          updatedTasks[filePath] = task.copyWith(progress: progress);
          emit(state.copyWith(uploadTasks: updatedTasks));
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
              : [...state.messages.map((e) => e.copyWith(isRead: true))];

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
          } else {
            final existingIndex = messages.indexWhere(
              (m) => m.id == message.id,
            );

            if (existingIndex != -1) {
              messages[existingIndex] = message;
            } else {
              messages.add(message);
            }
          }
          emit(state.copyWith(messages: messages));

          if (!message.isUserMessage && !state.isChatPageVisible) {
            _showNotification(message);
          }
        },
        setChatVisible: (visible) {
          emit(state.copyWith(isChatPageVisible: visible));
          if (visible) {
            _dismissNotification();
          }
        },
      );
    });
  }

  Future<void> _enqueueImage(
    String imagePath,
    String? endpoint,
    Emitter<HilolChatState> emit,
  ) async {
    final fileName = imagePath.split(Platform.pathSeparator).last;
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

    final uploadTask = UploadTask(filePath: imagePath);
    final messages = [...state.messages, chatMessage];
    final uploadTasks = Map<String, UploadTask>.from(state.uploadTasks)
      ..[imagePath] = uploadTask;

    emit(state.copyWith(messages: messages, uploadTasks: uploadTasks));

    if (!_isProcessingQueue) {
      await _processQueue(endpoint, emit);
    }
  }

  Future<void> _processQueue(
    String? endpoint,
    Emitter<HilolChatState> emit,
  ) async {
    _isProcessingQueue = true;

    while (true) {
      final waitingEntry = state.uploadTasks.entries
          .where((e) => e.value.status == UploadStatus.waiting)
          .firstOrNull;
      if (waitingEntry == null) break;

      final filePath = waitingEntry.key;
      final updatedTasks = Map<String, UploadTask>.from(state.uploadTasks);
      updatedTasks[filePath] = waitingEntry.value.copyWith(
        status: UploadStatus.uploading,
      );
      emit(state.copyWith(uploadTasks: updatedTasks));

      final fileName = filePath.split(Platform.pathSeparator).last;
      final imageFile = File(filePath);

      DateTime lastEmit = DateTime.now();

      final result = await chatRepository.sendImage(
        imageFile: imageFile,
        imagePath: filePath,
        fileName: fileName,
        endpoint: endpoint,
        onProgress: (sent, total) {
          final now = DateTime.now();
          if (now.difference(lastEmit).inMilliseconds < 100 && sent < total) {
            return;
          }
          lastEmit = now;
          add(
            HilolChatEvent.updateUploadProgress(
              filePath,
              total > 0 ? sent / total : 0.0,
            ),
          );
        },
      );

      result.fold(
        (failure) {
          final tasks = Map<String, UploadTask>.from(state.uploadTasks);
          tasks[filePath] = tasks[filePath]!.copyWith(
            status: UploadStatus.failed,
          );
          emit(
            state.copyWith(uploadTasks: tasks, errorMessage: failure.message),
          );
        },
        (_) {
          final tasks = Map<String, UploadTask>.from(state.uploadTasks);
          tasks.remove(filePath);
          emit(state.copyWith(uploadTasks: tasks, errorMessage: null));
        },
      );
    }

    _isProcessingQueue = false;
  }

  void _showNotification(ChatMessage message) {
    final overlay = _navigatorKey?.currentState?.overlay;
    if (overlay == null) return;

    _dismissNotification();

    late OverlayEntry entry;

    void dismiss() {
      if (_notificationEntry == entry) {
        entry.remove();
        _notificationEntry = null;
      }
    }

    entry = OverlayEntry(
      builder: (context) => HilolChatNotificationBanner(
        message: message,
        onTap: _onNotificationTap,
        onDismiss: dismiss,
      ),
    );

    _notificationEntry = entry;
    overlay.insert(entry);
  }

  void _dismissNotification() {
    _notificationEntry?.remove();
    _notificationEntry = null;
  }

  @override
  Future<void> close() async {
    _messageSubscription?.cancel();
    _dismissNotification();
    await chatRepository.dispose();
    return super.close();
  }
}
