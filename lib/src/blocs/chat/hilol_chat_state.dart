part of 'hilol_chat_bloc.dart';

@freezed
sealed class HilolChatState with _$HilolChatState {
  const factory HilolChatState.initial({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default([]) List<ChatMessage> messages,
    String? defaultEndpoint,
    @Default(false) bool isRegistered,
    @Default(false) bool hasMoreMessages,
    @Default(1) int currentPage,
    String? errorMessage,
    HilolChatRegisterModel? defaultUserData,
  }) = _Initial;
}
