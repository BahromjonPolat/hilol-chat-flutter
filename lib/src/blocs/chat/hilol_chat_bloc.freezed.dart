// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hilol_chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HilolChatEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HilolChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatEvent()';
}


}

/// @nodoc
class $HilolChatEventCopyWith<$Res>  {
$HilolChatEventCopyWith(HilolChatEvent _, $Res Function(HilolChatEvent) __);
}


/// Adds pattern-matching-related methods to [HilolChatEvent].
extension HilolChatEventPatterns on HilolChatEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initialize value)?  initialize,TResult Function( _GetMessages value)?  getMessages,TResult Function( _Register value)?  register,TResult Function( _SendMessage value)?  sendMessage,TResult Function( _SendImage value)?  sendImage,TResult Function( _AddMessage value)?  addMessage,TResult Function( _OnRegistered value)?  onRegistered,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _GetMessages() when getMessages != null:
return getMessages(_that);case _Register() when register != null:
return register(_that);case _SendMessage() when sendMessage != null:
return sendMessage(_that);case _SendImage() when sendImage != null:
return sendImage(_that);case _AddMessage() when addMessage != null:
return addMessage(_that);case _OnRegistered() when onRegistered != null:
return onRegistered(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initialize value)  initialize,required TResult Function( _GetMessages value)  getMessages,required TResult Function( _Register value)  register,required TResult Function( _SendMessage value)  sendMessage,required TResult Function( _SendImage value)  sendImage,required TResult Function( _AddMessage value)  addMessage,required TResult Function( _OnRegistered value)  onRegistered,}){
final _that = this;
switch (_that) {
case _Initialize():
return initialize(_that);case _GetMessages():
return getMessages(_that);case _Register():
return register(_that);case _SendMessage():
return sendMessage(_that);case _SendImage():
return sendImage(_that);case _AddMessage():
return addMessage(_that);case _OnRegistered():
return onRegistered(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initialize value)?  initialize,TResult? Function( _GetMessages value)?  getMessages,TResult? Function( _Register value)?  register,TResult? Function( _SendMessage value)?  sendMessage,TResult? Function( _SendImage value)?  sendImage,TResult? Function( _AddMessage value)?  addMessage,TResult? Function( _OnRegistered value)?  onRegistered,}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _GetMessages() when getMessages != null:
return getMessages(_that);case _Register() when register != null:
return register(_that);case _SendMessage() when sendMessage != null:
return sendMessage(_that);case _SendImage() when sendImage != null:
return sendImage(_that);case _AddMessage() when addMessage != null:
return addMessage(_that);case _OnRegistered() when onRegistered != null:
return onRegistered(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( HilolChatConfig config,  HilolChatRegisterModel? userData,  void Function()? onSuccess)?  initialize,TResult Function( int page)?  getMessages,TResult Function( HilolChatRegisterModel data,  void Function()? onSuccess,  void Function(String error)? onError)?  register,TResult Function( String message,  String? endpoint)?  sendMessage,TResult Function( String imagePath,  String? endpoint)?  sendImage,TResult Function( ChatMessage message)?  addMessage,TResult Function()?  onRegistered,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that.config,_that.userData,_that.onSuccess);case _GetMessages() when getMessages != null:
return getMessages(_that.page);case _Register() when register != null:
return register(_that.data,_that.onSuccess,_that.onError);case _SendMessage() when sendMessage != null:
return sendMessage(_that.message,_that.endpoint);case _SendImage() when sendImage != null:
return sendImage(_that.imagePath,_that.endpoint);case _AddMessage() when addMessage != null:
return addMessage(_that.message);case _OnRegistered() when onRegistered != null:
return onRegistered();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( HilolChatConfig config,  HilolChatRegisterModel? userData,  void Function()? onSuccess)  initialize,required TResult Function( int page)  getMessages,required TResult Function( HilolChatRegisterModel data,  void Function()? onSuccess,  void Function(String error)? onError)  register,required TResult Function( String message,  String? endpoint)  sendMessage,required TResult Function( String imagePath,  String? endpoint)  sendImage,required TResult Function( ChatMessage message)  addMessage,required TResult Function()  onRegistered,}) {final _that = this;
switch (_that) {
case _Initialize():
return initialize(_that.config,_that.userData,_that.onSuccess);case _GetMessages():
return getMessages(_that.page);case _Register():
return register(_that.data,_that.onSuccess,_that.onError);case _SendMessage():
return sendMessage(_that.message,_that.endpoint);case _SendImage():
return sendImage(_that.imagePath,_that.endpoint);case _AddMessage():
return addMessage(_that.message);case _OnRegistered():
return onRegistered();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( HilolChatConfig config,  HilolChatRegisterModel? userData,  void Function()? onSuccess)?  initialize,TResult? Function( int page)?  getMessages,TResult? Function( HilolChatRegisterModel data,  void Function()? onSuccess,  void Function(String error)? onError)?  register,TResult? Function( String message,  String? endpoint)?  sendMessage,TResult? Function( String imagePath,  String? endpoint)?  sendImage,TResult? Function( ChatMessage message)?  addMessage,TResult? Function()?  onRegistered,}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that.config,_that.userData,_that.onSuccess);case _GetMessages() when getMessages != null:
return getMessages(_that.page);case _Register() when register != null:
return register(_that.data,_that.onSuccess,_that.onError);case _SendMessage() when sendMessage != null:
return sendMessage(_that.message,_that.endpoint);case _SendImage() when sendImage != null:
return sendImage(_that.imagePath,_that.endpoint);case _AddMessage() when addMessage != null:
return addMessage(_that.message);case _OnRegistered() when onRegistered != null:
return onRegistered();case _:
  return null;

}
}

}

/// @nodoc


class _Initialize with DiagnosticableTreeMixin implements HilolChatEvent {
  const _Initialize({required this.config, this.userData, this.onSuccess});
  

 final  HilolChatConfig config;
 final  HilolChatRegisterModel? userData;
 final  void Function()? onSuccess;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitializeCopyWith<_Initialize> get copyWith => __$InitializeCopyWithImpl<_Initialize>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatEvent.initialize'))
    ..add(DiagnosticsProperty('config', config))..add(DiagnosticsProperty('userData', userData))..add(DiagnosticsProperty('onSuccess', onSuccess));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initialize&&(identical(other.config, config) || other.config == config)&&(identical(other.userData, userData) || other.userData == userData)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,config,userData,onSuccess);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatEvent.initialize(config: $config, userData: $userData, onSuccess: $onSuccess)';
}


}

/// @nodoc
abstract mixin class _$InitializeCopyWith<$Res> implements $HilolChatEventCopyWith<$Res> {
  factory _$InitializeCopyWith(_Initialize value, $Res Function(_Initialize) _then) = __$InitializeCopyWithImpl;
@useResult
$Res call({
 HilolChatConfig config, HilolChatRegisterModel? userData, void Function()? onSuccess
});




}
/// @nodoc
class __$InitializeCopyWithImpl<$Res>
    implements _$InitializeCopyWith<$Res> {
  __$InitializeCopyWithImpl(this._self, this._then);

  final _Initialize _self;
  final $Res Function(_Initialize) _then;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,Object? userData = freezed,Object? onSuccess = freezed,}) {
  return _then(_Initialize(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as HilolChatConfig,userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as HilolChatRegisterModel?,onSuccess: freezed == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function()?,
  ));
}


}

/// @nodoc


class _GetMessages with DiagnosticableTreeMixin implements HilolChatEvent {
  const _GetMessages({this.page = 1});
  

@JsonKey() final  int page;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetMessagesCopyWith<_GetMessages> get copyWith => __$GetMessagesCopyWithImpl<_GetMessages>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatEvent.getMessages'))
    ..add(DiagnosticsProperty('page', page));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetMessages&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatEvent.getMessages(page: $page)';
}


}

/// @nodoc
abstract mixin class _$GetMessagesCopyWith<$Res> implements $HilolChatEventCopyWith<$Res> {
  factory _$GetMessagesCopyWith(_GetMessages value, $Res Function(_GetMessages) _then) = __$GetMessagesCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class __$GetMessagesCopyWithImpl<$Res>
    implements _$GetMessagesCopyWith<$Res> {
  __$GetMessagesCopyWithImpl(this._self, this._then);

  final _GetMessages _self;
  final $Res Function(_GetMessages) _then;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(_GetMessages(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Register with DiagnosticableTreeMixin implements HilolChatEvent {
  const _Register({required this.data, this.onSuccess, this.onError});
  

 final  HilolChatRegisterModel data;
 final  void Function()? onSuccess;
 final  void Function(String error)? onError;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterCopyWith<_Register> get copyWith => __$RegisterCopyWithImpl<_Register>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatEvent.register'))
    ..add(DiagnosticsProperty('data', data))..add(DiagnosticsProperty('onSuccess', onSuccess))..add(DiagnosticsProperty('onError', onError));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Register&&(identical(other.data, data) || other.data == data)&&(identical(other.onSuccess, onSuccess) || other.onSuccess == onSuccess)&&(identical(other.onError, onError) || other.onError == onError));
}


@override
int get hashCode => Object.hash(runtimeType,data,onSuccess,onError);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatEvent.register(data: $data, onSuccess: $onSuccess, onError: $onError)';
}


}

/// @nodoc
abstract mixin class _$RegisterCopyWith<$Res> implements $HilolChatEventCopyWith<$Res> {
  factory _$RegisterCopyWith(_Register value, $Res Function(_Register) _then) = __$RegisterCopyWithImpl;
@useResult
$Res call({
 HilolChatRegisterModel data, void Function()? onSuccess, void Function(String error)? onError
});




}
/// @nodoc
class __$RegisterCopyWithImpl<$Res>
    implements _$RegisterCopyWith<$Res> {
  __$RegisterCopyWithImpl(this._self, this._then);

  final _Register _self;
  final $Res Function(_Register) _then;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? onSuccess = freezed,Object? onError = freezed,}) {
  return _then(_Register(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HilolChatRegisterModel,onSuccess: freezed == onSuccess ? _self.onSuccess : onSuccess // ignore: cast_nullable_to_non_nullable
as void Function()?,onError: freezed == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as void Function(String error)?,
  ));
}


}

/// @nodoc


class _SendMessage with DiagnosticableTreeMixin implements HilolChatEvent {
  const _SendMessage(this.message, {this.endpoint});
  

 final  String message;
 final  String? endpoint;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendMessageCopyWith<_SendMessage> get copyWith => __$SendMessageCopyWithImpl<_SendMessage>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatEvent.sendMessage'))
    ..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('endpoint', endpoint));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendMessage&&(identical(other.message, message) || other.message == message)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint));
}


@override
int get hashCode => Object.hash(runtimeType,message,endpoint);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatEvent.sendMessage(message: $message, endpoint: $endpoint)';
}


}

/// @nodoc
abstract mixin class _$SendMessageCopyWith<$Res> implements $HilolChatEventCopyWith<$Res> {
  factory _$SendMessageCopyWith(_SendMessage value, $Res Function(_SendMessage) _then) = __$SendMessageCopyWithImpl;
@useResult
$Res call({
 String message, String? endpoint
});




}
/// @nodoc
class __$SendMessageCopyWithImpl<$Res>
    implements _$SendMessageCopyWith<$Res> {
  __$SendMessageCopyWithImpl(this._self, this._then);

  final _SendMessage _self;
  final $Res Function(_SendMessage) _then;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? endpoint = freezed,}) {
  return _then(_SendMessage(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,endpoint: freezed == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SendImage with DiagnosticableTreeMixin implements HilolChatEvent {
  const _SendImage(this.imagePath, {this.endpoint});
  

 final  String imagePath;
 final  String? endpoint;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendImageCopyWith<_SendImage> get copyWith => __$SendImageCopyWithImpl<_SendImage>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatEvent.sendImage'))
    ..add(DiagnosticsProperty('imagePath', imagePath))..add(DiagnosticsProperty('endpoint', endpoint));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendImage&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,endpoint);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatEvent.sendImage(imagePath: $imagePath, endpoint: $endpoint)';
}


}

/// @nodoc
abstract mixin class _$SendImageCopyWith<$Res> implements $HilolChatEventCopyWith<$Res> {
  factory _$SendImageCopyWith(_SendImage value, $Res Function(_SendImage) _then) = __$SendImageCopyWithImpl;
@useResult
$Res call({
 String imagePath, String? endpoint
});




}
/// @nodoc
class __$SendImageCopyWithImpl<$Res>
    implements _$SendImageCopyWith<$Res> {
  __$SendImageCopyWithImpl(this._self, this._then);

  final _SendImage _self;
  final $Res Function(_SendImage) _then;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? imagePath = null,Object? endpoint = freezed,}) {
  return _then(_SendImage(
null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,endpoint: freezed == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _AddMessage with DiagnosticableTreeMixin implements HilolChatEvent {
  const _AddMessage(this.message);
  

 final  ChatMessage message;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddMessageCopyWith<_AddMessage> get copyWith => __$AddMessageCopyWithImpl<_AddMessage>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatEvent.addMessage'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddMessage&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatEvent.addMessage(message: $message)';
}


}

/// @nodoc
abstract mixin class _$AddMessageCopyWith<$Res> implements $HilolChatEventCopyWith<$Res> {
  factory _$AddMessageCopyWith(_AddMessage value, $Res Function(_AddMessage) _then) = __$AddMessageCopyWithImpl;
@useResult
$Res call({
 ChatMessage message
});




}
/// @nodoc
class __$AddMessageCopyWithImpl<$Res>
    implements _$AddMessageCopyWith<$Res> {
  __$AddMessageCopyWithImpl(this._self, this._then);

  final _AddMessage _self;
  final $Res Function(_AddMessage) _then;

/// Create a copy of HilolChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_AddMessage(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatMessage,
  ));
}


}

/// @nodoc


class _OnRegistered with DiagnosticableTreeMixin implements HilolChatEvent {
  const _OnRegistered();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatEvent.onRegistered'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnRegistered);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatEvent.onRegistered()';
}


}




/// @nodoc
mixin _$HilolChatState implements DiagnosticableTreeMixin {

 FormzSubmissionStatus get status; List<ChatMessage> get messages; String? get defaultEndpoint; bool get isRegistered; bool get hasMoreMessages; int get currentPage; String? get errorMessage; HilolChatRegisterModel? get defaultUserData;
/// Create a copy of HilolChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HilolChatStateCopyWith<HilolChatState> get copyWith => _$HilolChatStateCopyWithImpl<HilolChatState>(this as HilolChatState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('messages', messages))..add(DiagnosticsProperty('defaultEndpoint', defaultEndpoint))..add(DiagnosticsProperty('isRegistered', isRegistered))..add(DiagnosticsProperty('hasMoreMessages', hasMoreMessages))..add(DiagnosticsProperty('currentPage', currentPage))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('defaultUserData', defaultUserData));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HilolChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.defaultEndpoint, defaultEndpoint) || other.defaultEndpoint == defaultEndpoint)&&(identical(other.isRegistered, isRegistered) || other.isRegistered == isRegistered)&&(identical(other.hasMoreMessages, hasMoreMessages) || other.hasMoreMessages == hasMoreMessages)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.defaultUserData, defaultUserData) || other.defaultUserData == defaultUserData));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(messages),defaultEndpoint,isRegistered,hasMoreMessages,currentPage,errorMessage,defaultUserData);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatState(status: $status, messages: $messages, defaultEndpoint: $defaultEndpoint, isRegistered: $isRegistered, hasMoreMessages: $hasMoreMessages, currentPage: $currentPage, errorMessage: $errorMessage, defaultUserData: $defaultUserData)';
}


}

/// @nodoc
abstract mixin class $HilolChatStateCopyWith<$Res>  {
  factory $HilolChatStateCopyWith(HilolChatState value, $Res Function(HilolChatState) _then) = _$HilolChatStateCopyWithImpl;
@useResult
$Res call({
 FormzSubmissionStatus status, List<ChatMessage> messages, String? defaultEndpoint, bool isRegistered, bool hasMoreMessages, int currentPage, String? errorMessage, HilolChatRegisterModel? defaultUserData
});




}
/// @nodoc
class _$HilolChatStateCopyWithImpl<$Res>
    implements $HilolChatStateCopyWith<$Res> {
  _$HilolChatStateCopyWithImpl(this._self, this._then);

  final HilolChatState _self;
  final $Res Function(HilolChatState) _then;

/// Create a copy of HilolChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? messages = null,Object? defaultEndpoint = freezed,Object? isRegistered = null,Object? hasMoreMessages = null,Object? currentPage = null,Object? errorMessage = freezed,Object? defaultUserData = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,defaultEndpoint: freezed == defaultEndpoint ? _self.defaultEndpoint : defaultEndpoint // ignore: cast_nullable_to_non_nullable
as String?,isRegistered: null == isRegistered ? _self.isRegistered : isRegistered // ignore: cast_nullable_to_non_nullable
as bool,hasMoreMessages: null == hasMoreMessages ? _self.hasMoreMessages : hasMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,defaultUserData: freezed == defaultUserData ? _self.defaultUserData : defaultUserData // ignore: cast_nullable_to_non_nullable
as HilolChatRegisterModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [HilolChatState].
extension HilolChatStatePatterns on HilolChatState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( FormzSubmissionStatus status,  List<ChatMessage> messages,  String? defaultEndpoint,  bool isRegistered,  bool hasMoreMessages,  int currentPage,  String? errorMessage,  HilolChatRegisterModel? defaultUserData)?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.status,_that.messages,_that.defaultEndpoint,_that.isRegistered,_that.hasMoreMessages,_that.currentPage,_that.errorMessage,_that.defaultUserData);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( FormzSubmissionStatus status,  List<ChatMessage> messages,  String? defaultEndpoint,  bool isRegistered,  bool hasMoreMessages,  int currentPage,  String? errorMessage,  HilolChatRegisterModel? defaultUserData)  initial,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.status,_that.messages,_that.defaultEndpoint,_that.isRegistered,_that.hasMoreMessages,_that.currentPage,_that.errorMessage,_that.defaultUserData);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( FormzSubmissionStatus status,  List<ChatMessage> messages,  String? defaultEndpoint,  bool isRegistered,  bool hasMoreMessages,  int currentPage,  String? errorMessage,  HilolChatRegisterModel? defaultUserData)?  initial,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.status,_that.messages,_that.defaultEndpoint,_that.isRegistered,_that.hasMoreMessages,_that.currentPage,_that.errorMessage,_that.defaultUserData);case _:
  return null;

}
}

}

/// @nodoc


class _Initial with DiagnosticableTreeMixin implements HilolChatState {
  const _Initial({this.status = FormzSubmissionStatus.initial, final  List<ChatMessage> messages = const [], this.defaultEndpoint, this.isRegistered = false, this.hasMoreMessages = false, this.currentPage = 1, this.errorMessage, this.defaultUserData}): _messages = messages;
  

@override@JsonKey() final  FormzSubmissionStatus status;
 final  List<ChatMessage> _messages;
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  String? defaultEndpoint;
@override@JsonKey() final  bool isRegistered;
@override@JsonKey() final  bool hasMoreMessages;
@override@JsonKey() final  int currentPage;
@override final  String? errorMessage;
@override final  HilolChatRegisterModel? defaultUserData;

/// Create a copy of HilolChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HilolChatState.initial'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('messages', messages))..add(DiagnosticsProperty('defaultEndpoint', defaultEndpoint))..add(DiagnosticsProperty('isRegistered', isRegistered))..add(DiagnosticsProperty('hasMoreMessages', hasMoreMessages))..add(DiagnosticsProperty('currentPage', currentPage))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('defaultUserData', defaultUserData));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.defaultEndpoint, defaultEndpoint) || other.defaultEndpoint == defaultEndpoint)&&(identical(other.isRegistered, isRegistered) || other.isRegistered == isRegistered)&&(identical(other.hasMoreMessages, hasMoreMessages) || other.hasMoreMessages == hasMoreMessages)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.defaultUserData, defaultUserData) || other.defaultUserData == defaultUserData));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_messages),defaultEndpoint,isRegistered,hasMoreMessages,currentPage,errorMessage,defaultUserData);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HilolChatState.initial(status: $status, messages: $messages, defaultEndpoint: $defaultEndpoint, isRegistered: $isRegistered, hasMoreMessages: $hasMoreMessages, currentPage: $currentPage, errorMessage: $errorMessage, defaultUserData: $defaultUserData)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $HilolChatStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 FormzSubmissionStatus status, List<ChatMessage> messages, String? defaultEndpoint, bool isRegistered, bool hasMoreMessages, int currentPage, String? errorMessage, HilolChatRegisterModel? defaultUserData
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of HilolChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? messages = null,Object? defaultEndpoint = freezed,Object? isRegistered = null,Object? hasMoreMessages = null,Object? currentPage = null,Object? errorMessage = freezed,Object? defaultUserData = freezed,}) {
  return _then(_Initial(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormzSubmissionStatus,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,defaultEndpoint: freezed == defaultEndpoint ? _self.defaultEndpoint : defaultEndpoint // ignore: cast_nullable_to_non_nullable
as String?,isRegistered: null == isRegistered ? _self.isRegistered : isRegistered // ignore: cast_nullable_to_non_nullable
as bool,hasMoreMessages: null == hasMoreMessages ? _self.hasMoreMessages : hasMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,defaultUserData: freezed == defaultUserData ? _self.defaultUserData : defaultUserData // ignore: cast_nullable_to_non_nullable
as HilolChatRegisterModel?,
  ));
}


}

// dart format on
