/*

  Created by: Bakhromjon Polat
  Created on: Nov 29 2025

*/

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fcrm_chat_sdk/fcrm_chat_sdk.dart';
import 'package:hilol_chat_flutter/hilol_chat_flutter.dart';

/// Abstract repository for chat operations
/// Follows Single Responsibility Principle and Interface Segregation Principle
abstract class ChatRepository {
  /// Initialize chat with configuration
  /// Returns [ChatInitResult] on success or [Failure] on error
  Future<Either<Failure, ChatInitResult>> initialize({
    required HilolChatConfig config,
  });

  /// Register user with chat service
  /// Returns [RegisterResult] on success or [Failure] on error
  Future<Either<Failure, RegisterResult>> register({
    required Map<String, dynamic> userData,
  });

  /// Get paginated chat messages
  /// Returns [MessagesResult] on success or [Failure] on error
  Future<Either<Failure, MessagesResult>> getMessages({int page = 1});

  /// Send text message to chat
  /// Returns [MessageSendResult] on success or [Failure] on error
  Future<Either<Failure, MessageSendResult>> sendMessage({
    required String message,
    String? endpoint,
  });

  /// Send image message to chat
  /// Returns [ImageSendResult] on success or [Failure] on error
  Future<Either<Failure, ImageSendResult>> sendImage({
    required File imageFile,
    required String imagePath,
    required String fileName,
    String? endpoint,
    Function(int, int)? onProgress,
  });

  /// Edit an existing message
  /// Returns [bool] on success or [Failure] on error
  Future<Either<Failure, bool>> editMessage({
    required int messageId,
    required String content,
  });

  /// Check if user is registered
  /// Returns [bool] on success or [Failure] on error
  Future<Either<Failure, bool>> isRegistered();

  /// Get message stream
  /// Returns stream of [ChatMessage]
  Stream<ChatMessage>? get messageStream;

  /// Dispose resources
  Future<void> dispose();
}
