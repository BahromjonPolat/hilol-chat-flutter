/*

  Created by: Bakhromjon Polat
  Created on: Nov 29 2025

  Mock repository for testing purposes

*/

import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fcrm_chat_sdk/fcrm_chat_sdk.dart';
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';

/// Mock implementation of ChatRepository for testing
/// This is useful for unit testing without actual network calls
sealed class MockChatRepository implements ChatRepository {
  bool _shouldFail = false;
  bool _isInitialized = false;
  bool _isUserRegistered = false;
  final List<ChatMessage> _mockMessages = [];
  final _messageController = StreamController<ChatMessage>.broadcast();

  /// Set whether the repository should simulate failures
  void setShouldFail(bool shouldFail) {
    _shouldFail = shouldFail;
  }

  /// Add a mock message to the list
  void addMockMessage(ChatMessage message) {
    _mockMessages.add(message);
    _messageController.add(message);
  }

  @override
  Future<Either<Failure, ChatInitResult>> initialize({
    required HilolChatConfig config,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (_shouldFail) {
      return const Left(NetworkFailure(message: 'Mock: Network error'));
    }

    _isInitialized = true;

    // Create a mock FcrmChat instance (this would need to be mocked properly in real tests)
    return Right(
      ChatInitResult(
        chat: FcrmChat(
          config: ChatConfig(
            baseUrl: config.baseUrl,
            companyToken: config.companyToken,
            appKey: config.appKey,
            appSecret: config.appSecret,
            socketUrl: config.socketUrl,
          ),
        ),
        isRegistered: _isUserRegistered,
      ),
    );
  }

  @override
  Future<Either<Failure, RegisterResult>> register({
    required Map<String, dynamic> userData,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (!_isInitialized) {
      return const Left(ChatNotInitializedFailure());
    }

    if (_shouldFail) {
      return const Left(ServerFailure(message: 'Mock: Registration failed'));
    }

    if (_isUserRegistered) {
      return const Left(UserAlreadyRegisteredFailure());
    }

    _isUserRegistered = true;

    return Right(RegisterResult(success: true, registeredAt: DateTime.now()));
  }

  @override
  Future<Either<Failure, MessagesResult>> getMessages({int page = 1}) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (!_isInitialized) {
      return const Left(ChatNotInitializedFailure());
    }

    if (_shouldFail) {
      return const Left(
        NetworkFailure(message: 'Mock: Failed to get messages'),
      );
    }

    return Right(
      MessagesResult(messages: _mockMessages, hasMore: false, page: page),
    );
  }

  @override
  Future<Either<Failure, MessageSendResult>> sendMessage({
    required String message,
    String? endpoint,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (!_isInitialized) {
      return const Left(ChatNotInitializedFailure());
    }

    if (_shouldFail) {
      return const Left(
        NetworkFailure(message: 'Mock: Failed to send message'),
      );
    }

    final chatMessage = ChatMessage(
      id: _mockMessages.length + 1,
      chatId: 1,
      content: message,
      type: MessageType.user,
      createdAt: DateTime.now(),
    );

    _mockMessages.add(chatMessage);
    _messageController.add(chatMessage);

    return Right(
      MessageSendResult(message: chatMessage, sentAt: DateTime.now()),
    );
  }

  @override
  Future<Either<Failure, ImageSendResult>> sendImage({
    required File imageFile,
    required String imagePath,
    required String fileName,
    String? endpoint,
    Function(int, int)? onProgress,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (!_isInitialized) {
      return const Left(ChatNotInitializedFailure());
    }

    if (_shouldFail) {
      return const Left(
        ImageProcessingFailure(message: 'Mock: Failed to send image'),
      );
    }

    final chatMessage = ChatMessage(
      id: _mockMessages.length + 1,
      chatId: 1,
      content: imagePath,
      type: MessageType.user,
      createdAt: DateTime.now(),
    );

    _mockMessages.add(chatMessage);
    _messageController.add(chatMessage);

    return Right(
      ImageSendResult(
        message: chatMessage,
        sentAt: DateTime.now(),
        imageUrl: imagePath,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> isRegistered() async {
    await Future.delayed(const Duration(milliseconds: 50));

    if (!_isInitialized) {
      return const Left(ChatNotInitializedFailure());
    }

    return Right(_isUserRegistered);
  }

  @override
  Stream<ChatMessage>? get messageStream => _messageController.stream;

  @override
  Future<void> dispose() async {
    await _messageController.close();
    _mockMessages.clear();
    _isInitialized = false;
    _isUserRegistered = false;
  }

  /// Clear all mock data
  void clear() {
    _mockMessages.clear();
    _isUserRegistered = false;
  }
}
