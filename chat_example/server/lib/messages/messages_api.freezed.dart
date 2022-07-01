// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'messages_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
class _$ChatMessageTearOff {
  const _$ChatMessageTearOff();

  _ChatMessage call(
      {required int id,
      required int chatId,
      required int userId,
      required String message,
      required MessageType type,
      String? fileUrl,
      @GraphQLField(omit: true) String? metadataJson,
      int? referencedMessageId,
      required DateTime createdAt}) {
    return _ChatMessage(
      id: id,
      chatId: chatId,
      userId: userId,
      message: message,
      type: type,
      fileUrl: fileUrl,
      metadataJson: metadataJson,
      referencedMessageId: referencedMessageId,
      createdAt: createdAt,
    );
  }

  ChatMessage fromJson(Map<String, Object?> json) {
    return ChatMessage.fromJson(json);
  }
}

/// @nodoc
const $ChatMessage = _$ChatMessageTearOff();

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
      _$ChatMessageCopyWithImpl<$Res>;
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
class _$ChatMessageCopyWithImpl<$Res> implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  final ChatMessage _value;
  // ignore: unused_field
  final $Res Function(ChatMessage) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? chatId = freezed,
    Object? userId = freezed,
    Object? message = freezed,
    Object? type = freezed,
    Object? fileUrl = freezed,
    Object? metadataJson = freezed,
    Object? referencedMessageId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      fileUrl: fileUrl == freezed
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataJson: metadataJson == freezed
          ? _value.metadataJson
          : metadataJson // ignore: cast_nullable_to_non_nullable
              as String?,
      referencedMessageId: referencedMessageId == freezed
          ? _value.referencedMessageId
          : referencedMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$ChatMessageCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(
          _ChatMessage value, $Res Function(_ChatMessage) then) =
      __$ChatMessageCopyWithImpl<$Res>;
  @override
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
class __$ChatMessageCopyWithImpl<$Res> extends _$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(
      _ChatMessage _value, $Res Function(_ChatMessage) _then)
      : super(_value, (v) => _then(v as _ChatMessage));

  @override
  _ChatMessage get _value => super._value as _ChatMessage;

  @override
  $Res call({
    Object? id = freezed,
    Object? chatId = freezed,
    Object? userId = freezed,
    Object? message = freezed,
    Object? type = freezed,
    Object? fileUrl = freezed,
    Object? metadataJson = freezed,
    Object? referencedMessageId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_ChatMessage(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      fileUrl: fileUrl == freezed
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadataJson: metadataJson == freezed
          ? _value.metadataJson
          : metadataJson // ignore: cast_nullable_to_non_nullable
              as String?,
      referencedMessageId: referencedMessageId == freezed
          ? _value.referencedMessageId
          : referencedMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
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
            other is _ChatMessage &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.chatId, chatId) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.fileUrl, fileUrl) &&
            const DeepCollectionEquality()
                .equals(other.metadataJson, metadataJson) &&
            const DeepCollectionEquality()
                .equals(other.referencedMessageId, referencedMessageId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(chatId),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(fileUrl),
      const DeepCollectionEquality().hash(metadataJson),
      const DeepCollectionEquality().hash(referencedMessageId),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$ChatMessageCopyWith<_ChatMessage> get copyWith =>
      __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageToJson(this);
  }
}

abstract class _ChatMessage extends ChatMessage {
  const factory _ChatMessage(
      {required int id,
      required int chatId,
      required int userId,
      required String message,
      required MessageType type,
      String? fileUrl,
      @GraphQLField(omit: true) String? metadataJson,
      int? referencedMessageId,
      required DateTime createdAt}) = _$_ChatMessage;
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
  _$ChatMessageCopyWith<_ChatMessage> get copyWith =>
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
class _$ChatMessageEventTearOff {
  const _$ChatMessageEventTearOff();

  ChatMessageSentEvent sent({required ChatMessage message}) {
    return ChatMessageSentEvent(
      message: message,
    );
  }

  ChatMessageDeletedEvent deleted(
      {required int chatId, required int messageId}) {
    return ChatMessageDeletedEvent(
      chatId: chatId,
      messageId: messageId,
    );
  }

  ChatMessageUpdatedEvent updated({required ChatMessage message}) {
    return ChatMessageUpdatedEvent(
      message: message,
    );
  }

  ChatMessageEvent fromJson(Map<String, Object?> json) {
    return ChatMessageEvent.fromJson(json);
  }
}

/// @nodoc
const $ChatMessageEvent = _$ChatMessageEventTearOff();

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
    TResult Function(ChatMessage message)? sent,
    TResult Function(int chatId, int messageId)? deleted,
    TResult Function(ChatMessage message)? updated,
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
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
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
      _$ChatMessageEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatMessageEventCopyWithImpl<$Res>
    implements $ChatMessageEventCopyWith<$Res> {
  _$ChatMessageEventCopyWithImpl(this._value, this._then);

  final ChatMessageEvent _value;
  // ignore: unused_field
  final $Res Function(ChatMessageEvent) _then;
}

/// @nodoc
abstract class $ChatMessageSentEventCopyWith<$Res> {
  factory $ChatMessageSentEventCopyWith(ChatMessageSentEvent value,
          $Res Function(ChatMessageSentEvent) then) =
      _$ChatMessageSentEventCopyWithImpl<$Res>;
  $Res call({ChatMessage message});

  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$ChatMessageSentEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res>
    implements $ChatMessageSentEventCopyWith<$Res> {
  _$ChatMessageSentEventCopyWithImpl(
      ChatMessageSentEvent _value, $Res Function(ChatMessageSentEvent) _then)
      : super(_value, (v) => _then(v as ChatMessageSentEvent));

  @override
  ChatMessageSentEvent get _value => super._value as ChatMessageSentEvent;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ChatMessageSentEvent(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatMessage,
    ));
  }

  @override
  $ChatMessageCopyWith<$Res> get message {
    return $ChatMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageSentEvent extends ChatMessageSentEvent {
  const _$ChatMessageSentEvent({required this.message, String? $type})
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
            other is ChatMessageSentEvent &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $ChatMessageSentEventCopyWith<ChatMessageSentEvent> get copyWith =>
      _$ChatMessageSentEventCopyWithImpl<ChatMessageSentEvent>(
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
    TResult Function(ChatMessage message)? sent,
    TResult Function(int chatId, int messageId)? deleted,
    TResult Function(ChatMessage message)? updated,
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
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
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
    return _$$ChatMessageSentEventToJson(this);
  }
}

abstract class ChatMessageSentEvent extends ChatMessageEvent {
  const factory ChatMessageSentEvent({required ChatMessage message}) =
      _$ChatMessageSentEvent;
  const ChatMessageSentEvent._() : super._();

  factory ChatMessageSentEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageSentEvent.fromJson;

  ChatMessage get message;
  @JsonKey(ignore: true)
  $ChatMessageSentEventCopyWith<ChatMessageSentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageDeletedEventCopyWith<$Res> {
  factory $ChatMessageDeletedEventCopyWith(ChatMessageDeletedEvent value,
          $Res Function(ChatMessageDeletedEvent) then) =
      _$ChatMessageDeletedEventCopyWithImpl<$Res>;
  $Res call({int chatId, int messageId});
}

/// @nodoc
class _$ChatMessageDeletedEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res>
    implements $ChatMessageDeletedEventCopyWith<$Res> {
  _$ChatMessageDeletedEventCopyWithImpl(ChatMessageDeletedEvent _value,
      $Res Function(ChatMessageDeletedEvent) _then)
      : super(_value, (v) => _then(v as ChatMessageDeletedEvent));

  @override
  ChatMessageDeletedEvent get _value => super._value as ChatMessageDeletedEvent;

  @override
  $Res call({
    Object? chatId = freezed,
    Object? messageId = freezed,
  }) {
    return _then(ChatMessageDeletedEvent(
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      messageId: messageId == freezed
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
      {required this.chatId, required this.messageId, String? $type})
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
            other is ChatMessageDeletedEvent &&
            const DeepCollectionEquality().equals(other.chatId, chatId) &&
            const DeepCollectionEquality().equals(other.messageId, messageId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chatId),
      const DeepCollectionEquality().hash(messageId));

  @JsonKey(ignore: true)
  @override
  $ChatMessageDeletedEventCopyWith<ChatMessageDeletedEvent> get copyWith =>
      _$ChatMessageDeletedEventCopyWithImpl<ChatMessageDeletedEvent>(
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
    TResult Function(ChatMessage message)? sent,
    TResult Function(int chatId, int messageId)? deleted,
    TResult Function(ChatMessage message)? updated,
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
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
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
    return _$$ChatMessageDeletedEventToJson(this);
  }
}

abstract class ChatMessageDeletedEvent extends ChatMessageEvent {
  const factory ChatMessageDeletedEvent(
      {required int chatId,
      required int messageId}) = _$ChatMessageDeletedEvent;
  const ChatMessageDeletedEvent._() : super._();

  factory ChatMessageDeletedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageDeletedEvent.fromJson;

  int get chatId;
  int get messageId;
  @JsonKey(ignore: true)
  $ChatMessageDeletedEventCopyWith<ChatMessageDeletedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageUpdatedEventCopyWith<$Res> {
  factory $ChatMessageUpdatedEventCopyWith(ChatMessageUpdatedEvent value,
          $Res Function(ChatMessageUpdatedEvent) then) =
      _$ChatMessageUpdatedEventCopyWithImpl<$Res>;
  $Res call({ChatMessage message});

  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$ChatMessageUpdatedEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res>
    implements $ChatMessageUpdatedEventCopyWith<$Res> {
  _$ChatMessageUpdatedEventCopyWithImpl(ChatMessageUpdatedEvent _value,
      $Res Function(ChatMessageUpdatedEvent) _then)
      : super(_value, (v) => _then(v as ChatMessageUpdatedEvent));

  @override
  ChatMessageUpdatedEvent get _value => super._value as ChatMessageUpdatedEvent;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ChatMessageUpdatedEvent(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatMessage,
    ));
  }

  @override
  $ChatMessageCopyWith<$Res> get message {
    return $ChatMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageUpdatedEvent extends ChatMessageUpdatedEvent {
  const _$ChatMessageUpdatedEvent({required this.message, String? $type})
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
            other is ChatMessageUpdatedEvent &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $ChatMessageUpdatedEventCopyWith<ChatMessageUpdatedEvent> get copyWith =>
      _$ChatMessageUpdatedEventCopyWithImpl<ChatMessageUpdatedEvent>(
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
    TResult Function(ChatMessage message)? sent,
    TResult Function(int chatId, int messageId)? deleted,
    TResult Function(ChatMessage message)? updated,
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
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
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
    return _$$ChatMessageUpdatedEventToJson(this);
  }
}

abstract class ChatMessageUpdatedEvent extends ChatMessageEvent {
  const factory ChatMessageUpdatedEvent({required ChatMessage message}) =
      _$ChatMessageUpdatedEvent;
  const ChatMessageUpdatedEvent._() : super._();

  factory ChatMessageUpdatedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageUpdatedEvent.fromJson;

  ChatMessage get message;
  @JsonKey(ignore: true)
  $ChatMessageUpdatedEventCopyWith<ChatMessageUpdatedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
