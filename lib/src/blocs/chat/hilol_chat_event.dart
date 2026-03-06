part of 'hilol_chat_bloc.dart';

@freezed
sealed class HilolChatEvent with _$HilolChatEvent {
  const factory HilolChatEvent.initialize({
    required HilolChatConfig config,
    HilolChatRegisterModel? userData,
    void Function()? onSuccess,
  }) = _Initialize;

  const factory HilolChatEvent.getMessages({@Default(1) int page}) =
      _GetMessages;

  const factory HilolChatEvent.register({
    required HilolChatRegisterModel data,
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) = _Register;

  const factory HilolChatEvent.setupUserData({
    required HilolChatRegisterModel data,
  }) = _SetupUserData;

  const factory HilolChatEvent.sendMessage(String message, {String? endpoint}) =
      _SendMessage;

  const factory HilolChatEvent.sendImage(String imagePath, {String? endpoint}) =
      _SendImage;

  const factory HilolChatEvent.sendImages(List<String> imagePaths, {String? endpoint}) =
      _SendImages;

  const factory HilolChatEvent.updateUploadProgress(String filePath, double progress) =
      _UpdateUploadProgress;

  const factory HilolChatEvent.addMessage(ChatMessage message) = _AddMessage;

  const factory HilolChatEvent.onRegistered() = _OnRegistered;

  const factory HilolChatEvent.startEditing(ChatMessage message) =
      _StartEditing;

  const factory HilolChatEvent.cancelEditing() = _CancelEditing;

  const factory HilolChatEvent.editMessage({
    required int messageId,
    required String content,
  }) = _EditMessage;

  const factory HilolChatEvent.setChatVisible(bool visible) = _SetChatVisible;
}
