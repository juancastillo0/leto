// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  int get id => throw _privateConstructorUsedError;
  int get chatId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  @GraphQLField(omit: true)
  String? get metadataJson => throw _privateConstructorUsedError;
  int? get referencedMessageId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {int id,
      int chatId,
      int userId,
      String message,
      MessageType type,
      String? fileUrl,
      @GraphQLField(omit: true) String? metadataJson,
      int? referencedMessageId,
      DateTime createdAt});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? userId = null,
    Object? message = null,
    Object? type = null,
    Object? fileUrl = freezed,
    Object? metadataJson = freezed,
    Object? referencedMessageId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataJson: freezed == metadataJson
          ? _value.metadataJson
          : metadataJson // ignore: cast_nullable_to_non_nullable
              as String?,
      referencedMessageId: freezed == referencedMessageId
          ? _value.referencedMessageId
          : referencedMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatMessageCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$_ChatMessageCopyWith(
          _$_ChatMessage value, $Res Function(_$_ChatMessage) then) =
      __$$_ChatMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int chatId,
      int userId,
      String message,
      MessageType type,
      String? fileUrl,
      @GraphQLField(omit: true) String? metadataJson,
      int? referencedMessageId,
      DateTime createdAt});
}

/// @nodoc
class __$$_ChatMessageCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$_ChatMessage>
    implements _$$_ChatMessageCopyWith<$Res> {
  __$$_ChatMessageCopyWithImpl(
      _$_ChatMessage _value, $Res Function(_$_ChatMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? userId = null,
    Object? message = null,
    Object? type = null,
    Object? fileUrl = freezed,
    Object? metadataJson = freezed,
    Object? referencedMessageId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$_ChatMessage(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataJson: freezed == metadataJson
          ? _value.metadataJson
          : metadataJson // ignore: cast_nullable_to_non_nullable
              as String?,
      referencedMessageId: freezed == referencedMessageId
          ? _value.referencedMessageId
          : referencedMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatMessage extends _ChatMessage {
  const _$_ChatMessage(
      {required this.id,
      required this.chatId,
      required this.userId,
      required this.message,
      required this.type,
      this.fileUrl,
      @GraphQLField(omit: true) this.metadataJson,
      this.referencedMessageId,
      required this.createdAt})
      : super._();

  factory _$_ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$$_ChatMessageFromJson(json);

  @override
  final int id;
  @override
  final int chatId;
  @override
  final int userId;
  @override
  final String message;
  @override
  final MessageType type;
  @override
  final String? fileUrl;
  @override
  @GraphQLField(omit: true)
  final String? metadataJson;
  @override
  final int? referencedMessageId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ChatMessage(id: $id, chatId: $chatId, userId: $userId, message: $message, type: $type, fileUrl: $fileUrl, metadataJson: $metadataJson, referencedMessageId: $referencedMessageId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.metadataJson, metadataJson) ||
                other.metadataJson == metadataJson) &&
            (identical(other.referencedMessageId, referencedMessageId) ||
                other.referencedMessageId == referencedMessageId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, chatId, userId, message,
      type, fileUrl, metadataJson, referencedMessageId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageCopyWith<_$_ChatMessage> get copyWith =>
      __$$_ChatMessageCopyWithImpl<_$_ChatMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageToJson(
      this,
    );
  }
}

abstract class _ChatMessage extends ChatMessage {
  const factory _ChatMessage(
      {required final int id,
      required final int chatId,
      required final int userId,
      required final String message,
      required final MessageType type,
      final String? fileUrl,
      @GraphQLField(omit: true) final String? metadataJson,
      final int? referencedMessageId,
      required final DateTime createdAt}) = _$_ChatMessage;
  const _ChatMessage._() : super._();

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$_ChatMessage.fromJson;

  @override
  int get id;
  @override
  int get chatId;
  @override
  int get userId;
  @override
  String get message;
  @override
  MessageType get type;
  @override
  String? get fileUrl;
  @override
  @GraphQLField(omit: true)
  String? get metadataJson;
  @override
  int? get referencedMessageId;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_ChatMessageCopyWith<_$_ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessageEvent _$ChatMessageEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'sent':
      return ChatMessageSentEvent.fromJson(json);
    case 'deleted':
      return ChatMessageDeletedEvent.fromJson(json);
    case 'updated':
      return ChatMessageUpdatedEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ChatMessageEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ChatMessageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatMessage message) sent,
    required TResult Function(int chatId, int messageId) deleted,
    required TResult Function(ChatMessage message) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatMessage message)? sent,
    TResult? Function(int chatId, int messageId)? deleted,
    TResult? Function(ChatMessage message)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int chatId, int messageId)? deleted,
    TResult Function(ChatMessage message)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageDeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedEvent value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatMessageSentEvent value)? sent,
    TResult? Function(ChatMessageDeletedEvent value)? deleted,
    TResult? Function(ChatMessageUpdatedEvent value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageEventCopyWith<$Res> {
  factory $ChatMessageEventCopyWith(
          ChatMessageEvent value, $Res Function(ChatMessageEvent) then) =
      _$ChatMessageEventCopyWithImpl<$Res, ChatMessageEvent>;
}

/// @nodoc
class _$ChatMessageEventCopyWithImpl<$Res, $Val extends ChatMessageEvent>
    implements $ChatMessageEventCopyWith<$Res> {
  _$ChatMessageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatMessageSentEventCopyWith<$Res> {
  factory _$$ChatMessageSentEventCopyWith(_$ChatMessageSentEvent value,
          $Res Function(_$ChatMessageSentEvent) then) =
      __$$ChatMessageSentEventCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatMessage message});

  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$ChatMessageSentEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res, _$ChatMessageSentEvent>
    implements _$$ChatMessageSentEventCopyWith<$Res> {
  __$$ChatMessageSentEventCopyWithImpl(_$ChatMessageSentEvent _value,
      $Res Function(_$ChatMessageSentEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ChatMessageSentEvent(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatMessage,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res> get message {
    return $ChatMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageSentEvent extends ChatMessageSentEvent {
  const _$ChatMessageSentEvent({required this.message, final String? $type})
      : $type = $type ?? 'sent',
        super._();

  factory _$ChatMessageSentEvent.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageSentEventFromJson(json);

  @override
  final ChatMessage message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChatMessageEvent.sent(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageSentEvent &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageSentEventCopyWith<_$ChatMessageSentEvent> get copyWith =>
      __$$ChatMessageSentEventCopyWithImpl<_$ChatMessageSentEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatMessage message) sent,
    required TResult Function(int chatId, int messageId) deleted,
    required TResult Function(ChatMessage message) updated,
  }) {
    return sent(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatMessage message)? sent,
    TResult? Function(int chatId, int messageId)? deleted,
    TResult? Function(ChatMessage message)? updated,
  }) {
    return sent?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int chatId, int messageId)? deleted,
    TResult Function(ChatMessage message)? updated,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageDeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedEvent value) updated,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatMessageSentEvent value)? sent,
    TResult? Function(ChatMessageDeletedEvent value)? deleted,
    TResult? Function(ChatMessageUpdatedEvent value)? updated,
  }) {
    return sent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageSentEventToJson(
      this,
    );
  }
}

abstract class ChatMessageSentEvent extends ChatMessageEvent {
  const factory ChatMessageSentEvent({required final ChatMessage message}) =
      _$ChatMessageSentEvent;
  const ChatMessageSentEvent._() : super._();

  factory ChatMessageSentEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageSentEvent.fromJson;

  ChatMessage get message;
  @JsonKey(ignore: true)
  _$$ChatMessageSentEventCopyWith<_$ChatMessageSentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatMessageDeletedEventCopyWith<$Res> {
  factory _$$ChatMessageDeletedEventCopyWith(_$ChatMessageDeletedEvent value,
          $Res Function(_$ChatMessageDeletedEvent) then) =
      __$$ChatMessageDeletedEventCopyWithImpl<$Res>;
  @useResult
  $Res call({int chatId, int messageId});
}

/// @nodoc
class __$$ChatMessageDeletedEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res, _$ChatMessageDeletedEvent>
    implements _$$ChatMessageDeletedEventCopyWith<$Res> {
  __$$ChatMessageDeletedEventCopyWithImpl(_$ChatMessageDeletedEvent _value,
      $Res Function(_$ChatMessageDeletedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? messageId = null,
  }) {
    return _then(_$ChatMessageDeletedEvent(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageDeletedEvent extends ChatMessageDeletedEvent {
  const _$ChatMessageDeletedEvent(
      {required this.chatId, required this.messageId, final String? $type})
      : $type = $type ?? 'deleted',
        super._();

  factory _$ChatMessageDeletedEvent.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageDeletedEventFromJson(json);

  @override
  final int chatId;
  @override
  final int messageId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChatMessageEvent.deleted(chatId: $chatId, messageId: $messageId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageDeletedEvent &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chatId, messageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageDeletedEventCopyWith<_$ChatMessageDeletedEvent> get copyWith =>
      __$$ChatMessageDeletedEventCopyWithImpl<_$ChatMessageDeletedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatMessage message) sent,
    required TResult Function(int chatId, int messageId) deleted,
    required TResult Function(ChatMessage message) updated,
  }) {
    return deleted(chatId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatMessage message)? sent,
    TResult? Function(int chatId, int messageId)? deleted,
    TResult? Function(ChatMessage message)? updated,
  }) {
    return deleted?.call(chatId, messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int chatId, int messageId)? deleted,
    TResult Function(ChatMessage message)? updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(chatId, messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageDeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedEvent value) updated,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatMessageSentEvent value)? sent,
    TResult? Function(ChatMessageDeletedEvent value)? deleted,
    TResult? Function(ChatMessageUpdatedEvent value)? updated,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageDeletedEventToJson(
      this,
    );
  }
}

abstract class ChatMessageDeletedEvent extends ChatMessageEvent {
  const factory ChatMessageDeletedEvent(
      {required final int chatId,
      required final int messageId}) = _$ChatMessageDeletedEvent;
  const ChatMessageDeletedEvent._() : super._();

  factory ChatMessageDeletedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageDeletedEvent.fromJson;

  int get chatId;
  int get messageId;
  @JsonKey(ignore: true)
  _$$ChatMessageDeletedEventCopyWith<_$ChatMessageDeletedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatMessageUpdatedEventCopyWith<$Res> {
  factory _$$ChatMessageUpdatedEventCopyWith(_$ChatMessageUpdatedEvent value,
          $Res Function(_$ChatMessageUpdatedEvent) then) =
      __$$ChatMessageUpdatedEventCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatMessage message});

  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$ChatMessageUpdatedEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res, _$ChatMessageUpdatedEvent>
    implements _$$ChatMessageUpdatedEventCopyWith<$Res> {
  __$$ChatMessageUpdatedEventCopyWithImpl(_$ChatMessageUpdatedEvent _value,
      $Res Function(_$ChatMessageUpdatedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ChatMessageUpdatedEvent(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatMessage,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res> get message {
    return $ChatMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageUpdatedEvent extends ChatMessageUpdatedEvent {
  const _$ChatMessageUpdatedEvent({required this.message, final String? $type})
      : $type = $type ?? 'updated',
        super._();

  factory _$ChatMessageUpdatedEvent.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageUpdatedEventFromJson(json);

  @override
  final ChatMessage message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChatMessageEvent.updated(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageUpdatedEvent &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageUpdatedEventCopyWith<_$ChatMessageUpdatedEvent> get copyWith =>
      __$$ChatMessageUpdatedEventCopyWithImpl<_$ChatMessageUpdatedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatMessage message) sent,
    required TResult Function(int chatId, int messageId) deleted,
    required TResult Function(ChatMessage message) updated,
  }) {
    return updated(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatMessage message)? sent,
    TResult? Function(int chatId, int messageId)? deleted,
    TResult? Function(ChatMessage message)? updated,
  }) {
    return updated?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int chatId, int messageId)? deleted,
    TResult Function(ChatMessage message)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageDeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedEvent value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatMessageSentEvent value)? sent,
    TResult? Function(ChatMessageDeletedEvent value)? deleted,
    TResult? Function(ChatMessageUpdatedEvent value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageUpdatedEventToJson(
      this,
    );
  }
}

abstract class ChatMessageUpdatedEvent extends ChatMessageEvent {
  const factory ChatMessageUpdatedEvent({required final ChatMessage message}) =
      _$ChatMessageUpdatedEvent;
  const ChatMessageUpdatedEvent._() : super._();

  factory ChatMessageUpdatedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageUpdatedEvent.fromJson;

  ChatMessage get message;
  @JsonKey(ignore: true)
  _$$ChatMessageUpdatedEventCopyWith<_$ChatMessageUpdatedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
