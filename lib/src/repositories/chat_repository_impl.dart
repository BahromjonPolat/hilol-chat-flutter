/*

  Created by: Bakhromjon Polat
  Created on: Nov 29 2025

*/

import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fcrm_chat_sdk/fcrm_chat_sdk.dart';
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';
import 'package:hilol_chat_flutter/src/utils/image_utils.dart';
import 'package:hilol_chat_flutter/src/models/image_meta.dart';
import 'package:hilol_chat_flutter/src/utils/logger.dart';

/// Implementation of ChatRepository
/// Follows Dependency Inversion Principle - depends on abstractions
class ChatRepositoryImpl implements ChatRepository {
  FcrmChat? _chat;
  String? _defaultEndpoint;

  @override
  Future<Either<Failure, ChatInitResult>> initialize({
    required HilolChatConfig config,
  }) async {
    try {
      final chat = FcrmChat(
        config: ChatConfig(
          enableLogging: false,
          baseUrl: config.baseUrl,
          companyToken: config.companyToken,
          appKey: config.appKey,
          appSecret: config.appSecret,
          socketUrl: config.socketUrl,
        ),
      );

      await chat.initialize();

      final isRegistered = await chat.isRegistered();

      _chat = chat;
      _defaultEndpoint = config.defaultEndpoint;

      return Right(ChatInitResult(chat: chat, isRegistered: isRegistered));
    } on SocketException catch (e) {
      return Left(NetworkFailure(message: 'Network error: ${e.message}'));
    } catch (e) {
      return Left(
        UnknownFailure(message: 'Failed to initialize chat: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, RegisterResult>> register({
    required Map<String, dynamic> userData,
  }) async {
    try {
      if (_chat == null) {
        return const Left(ChatNotInitializedFailure());
      }

      final isRegistered = await _chat!.isRegistered();
      if (isRegistered) {
        return const Left(UserAlreadyRegisteredFailure());
      }

      await _chat!.register(userData: userData);

      return Right(RegisterResult(success: true, registeredAt: DateTime.now()));
    } on SocketException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error during registration: ${e.message}',
        ),
      );
    } catch (e, st) {
      Log.e(e, fileName: 'chat_repository_impl');
      Log.e(st, fileName: 'chat_repository_impl');
      return Left(
        ServerFailure(message: 'Failed to register user: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, MessagesResult>> getMessages({int page = 1}) async {
    try {
      if (_chat == null) {
        return const Left(ChatNotInitializedFailure());
      }

      final result = await _chat!.getMessages(page: page);

      return Right(
        MessagesResult(
          messages: result.messages,
          hasMore: result.hasMore,
          page: page,
        ),
      );
    } on SocketException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching messages: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get messages: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, MessageSendResult>> sendMessage({
    required String message,
    String? endpoint,
  }) async {
    try {
      if (_chat == null) {
        return const Left(ChatNotInitializedFailure());
      }

      final chatMessage = ChatMessage(
        id: 0,
        chatId: 0,
        content: message,
        type: MessageType.user,
        createdAt: DateTime.now(),
      );

      await _chat!.sendMessage(message, endpoint: endpoint ?? _defaultEndpoint);

      return Right(
        MessageSendResult(message: chatMessage, sentAt: DateTime.now()),
      );
    } on SocketException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while sending message: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to send message: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, ImageSendResult>> sendImage({
    required File imageFile,
    required String imagePath,
    required String fileName,
    String? endpoint,
    Function(int, int)? onProgress,
  }) async {
    try {
      if (_chat == null) {
        return const Left(ChatNotInitializedFailure());
      }

      // Get image dimensions
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

      await _chat?.sendImage(
        imageFile,
        endpoint: endpoint ?? _defaultEndpoint,
        onSendProgress: onProgress,
        cancelToken: null,
      );

      return Right(
        ImageSendResult(
          message: chatMessage,
          sentAt: DateTime.now(),
          imageUrl: imagePath,
        ),
      );
    } on FileSystemException catch (e) {
      return Left(
        ImageProcessingFailure(message: 'File system error: ${e.message}'),
      );
    } on SocketException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while sending image: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        ImageProcessingFailure(
          message: 'Failed to send image: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> editMessage({
    required int messageId,
    required String content,
  }) async {
    try {
      if (_chat == null) {
        return const Left(ChatNotInitializedFailure());
      }
      await _chat!.editMessage(messageId: messageId, content: content);
      return const Right(true);
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to edit message: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isRegistered() async {
    try {
      if (_chat == null) {
        return const Left(ChatNotInitializedFailure());
      }

      final isRegistered = await _chat!.isRegistered();
      return Right(isRegistered);
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to check registration status: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Stream<ChatMessage>? get messageStream => _chat?.onMessage;

  @override
  Future<void> dispose() async {
    _chat = null;
    _defaultEndpoint = null;
  }
}
