// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'messages_table.dart';

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
      int? referencedMessageId,
      required DateTime createdAt}) {
    return _ChatMessage(
      id: id,
      chatId: chatId,
      userId: userId,
      message: message,
      referencedMessageId: referencedMessageId,
      createdAt: createdAt,
    );
  }

  ChatMessage fromJson(Map<String, Object> json) {
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
  final int? referencedMessageId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ChatMessage(id: $id, chatId: $chatId, userId: $userId, message: $message, referencedMessageId: $referencedMessageId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChatMessage &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.chatId, chatId) ||
                const DeepCollectionEquality().equals(other.chatId, chatId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.referencedMessageId, referencedMessageId) ||
                const DeepCollectionEquality()
                    .equals(other.referencedMessageId, referencedMessageId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(chatId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(referencedMessageId) ^
      const DeepCollectionEquality().hash(createdAt);

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
      int? referencedMessageId,
      required DateTime createdAt}) = _$_ChatMessage;
  const _ChatMessage._() : super._();

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$_ChatMessage.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  int get chatId => throw _privateConstructorUsedError;
  @override
  int get userId => throw _privateConstructorUsedError;
  @override
  String get message => throw _privateConstructorUsedError;
  @override
  int? get referencedMessageId => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChatMessageCopyWith<_ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessageEvent _$ChatMessageEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String?) {
    case 'sent':
      return ChatMessageSentEvent.fromJson(json);
    case 'deleted':
      return ChatMessageSeletedEvent.fromJson(json);
    case 'updated':
      return ChatMessageUpdatedInEvent.fromJson(json);

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

  ChatMessageSeletedEvent deleted({required int id}) {
    return ChatMessageSeletedEvent(
      id: id,
    );
  }

  ChatMessageUpdatedInEvent updated({required ChatMessage message}) {
    return ChatMessageUpdatedInEvent(
      message: message,
    );
  }

  ChatMessageEvent fromJson(Map<String, Object> json) {
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
    required TResult Function(int id) deleted,
    required TResult Function(ChatMessage message) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int id)? deleted,
    TResult Function(ChatMessage message)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int id)? deleted,
    TResult Function(ChatMessage message)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageSeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedInEvent value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageSeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedInEvent value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageSeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedInEvent value)? updated,
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
  const _$ChatMessageSentEvent({required this.message}) : super._();

  factory _$ChatMessageSentEvent.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageSentEventFromJson(json);

  @override
  final ChatMessage message;

  @override
  String toString() {
    return 'ChatMessageEvent.sent(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChatMessageSentEvent &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ChatMessageSentEventCopyWith<ChatMessageSentEvent> get copyWith =>
      _$ChatMessageSentEventCopyWithImpl<ChatMessageSentEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatMessage message) sent,
    required TResult Function(int id) deleted,
    required TResult Function(ChatMessage message) updated,
  }) {
    return sent(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int id)? deleted,
    TResult Function(ChatMessage message)? updated,
  }) {
    return sent?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int id)? deleted,
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
    required TResult Function(ChatMessageSeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedInEvent value) updated,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageSeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedInEvent value)? updated,
  }) {
    return sent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageSeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedInEvent value)? updated,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageSentEventToJson(this)..['runtimeType'] = 'sent';
  }
}

abstract class ChatMessageSentEvent extends ChatMessageEvent {
  const factory ChatMessageSentEvent({required ChatMessage message}) =
      _$ChatMessageSentEvent;
  const ChatMessageSentEvent._() : super._();

  factory ChatMessageSentEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageSentEvent.fromJson;

  ChatMessage get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageSentEventCopyWith<ChatMessageSentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageSeletedEventCopyWith<$Res> {
  factory $ChatMessageSeletedEventCopyWith(ChatMessageSeletedEvent value,
          $Res Function(ChatMessageSeletedEvent) then) =
      _$ChatMessageSeletedEventCopyWithImpl<$Res>;
  $Res call({int id});
}

/// @nodoc
class _$ChatMessageSeletedEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res>
    implements $ChatMessageSeletedEventCopyWith<$Res> {
  _$ChatMessageSeletedEventCopyWithImpl(ChatMessageSeletedEvent _value,
      $Res Function(ChatMessageSeletedEvent) _then)
      : super(_value, (v) => _then(v as ChatMessageSeletedEvent));

  @override
  ChatMessageSeletedEvent get _value => super._value as ChatMessageSeletedEvent;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(ChatMessageSeletedEvent(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageSeletedEvent extends ChatMessageSeletedEvent {
  const _$ChatMessageSeletedEvent({required this.id}) : super._();

  factory _$ChatMessageSeletedEvent.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageSeletedEventFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'ChatMessageEvent.deleted(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChatMessageSeletedEvent &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  $ChatMessageSeletedEventCopyWith<ChatMessageSeletedEvent> get copyWith =>
      _$ChatMessageSeletedEventCopyWithImpl<ChatMessageSeletedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatMessage message) sent,
    required TResult Function(int id) deleted,
    required TResult Function(ChatMessage message) updated,
  }) {
    return deleted(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int id)? deleted,
    TResult Function(ChatMessage message)? updated,
  }) {
    return deleted?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int id)? deleted,
    TResult Function(ChatMessage message)? updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessageSentEvent value) sent,
    required TResult Function(ChatMessageSeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedInEvent value) updated,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageSeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedInEvent value)? updated,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageSeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedInEvent value)? updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageSeletedEventToJson(this)..['runtimeType'] = 'deleted';
  }
}

abstract class ChatMessageSeletedEvent extends ChatMessageEvent {
  const factory ChatMessageSeletedEvent({required int id}) =
      _$ChatMessageSeletedEvent;
  const ChatMessageSeletedEvent._() : super._();

  factory ChatMessageSeletedEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageSeletedEvent.fromJson;

  int get id => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageSeletedEventCopyWith<ChatMessageSeletedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageUpdatedInEventCopyWith<$Res> {
  factory $ChatMessageUpdatedInEventCopyWith(ChatMessageUpdatedInEvent value,
          $Res Function(ChatMessageUpdatedInEvent) then) =
      _$ChatMessageUpdatedInEventCopyWithImpl<$Res>;
  $Res call({ChatMessage message});

  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$ChatMessageUpdatedInEventCopyWithImpl<$Res>
    extends _$ChatMessageEventCopyWithImpl<$Res>
    implements $ChatMessageUpdatedInEventCopyWith<$Res> {
  _$ChatMessageUpdatedInEventCopyWithImpl(ChatMessageUpdatedInEvent _value,
      $Res Function(ChatMessageUpdatedInEvent) _then)
      : super(_value, (v) => _then(v as ChatMessageUpdatedInEvent));

  @override
  ChatMessageUpdatedInEvent get _value =>
      super._value as ChatMessageUpdatedInEvent;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ChatMessageUpdatedInEvent(
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
class _$ChatMessageUpdatedInEvent extends ChatMessageUpdatedInEvent {
  const _$ChatMessageUpdatedInEvent({required this.message}) : super._();

  factory _$ChatMessageUpdatedInEvent.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageUpdatedInEventFromJson(json);

  @override
  final ChatMessage message;

  @override
  String toString() {
    return 'ChatMessageEvent.updated(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChatMessageUpdatedInEvent &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ChatMessageUpdatedInEventCopyWith<ChatMessageUpdatedInEvent> get copyWith =>
      _$ChatMessageUpdatedInEventCopyWithImpl<ChatMessageUpdatedInEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatMessage message) sent,
    required TResult Function(int id) deleted,
    required TResult Function(ChatMessage message) updated,
  }) {
    return updated(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int id)? deleted,
    TResult Function(ChatMessage message)? updated,
  }) {
    return updated?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatMessage message)? sent,
    TResult Function(int id)? deleted,
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
    required TResult Function(ChatMessageSeletedEvent value) deleted,
    required TResult Function(ChatMessageUpdatedInEvent value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageSeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedInEvent value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageSeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedInEvent value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageUpdatedInEventToJson(this)
      ..['runtimeType'] = 'updated';
  }
}

abstract class ChatMessageUpdatedInEvent extends ChatMessageEvent {
  const factory ChatMessageUpdatedInEvent({required ChatMessage message}) =
      _$ChatMessageUpdatedInEvent;
  const ChatMessageUpdatedInEvent._() : super._();

  factory ChatMessageUpdatedInEvent.fromJson(Map<String, dynamic> json) =
      _$ChatMessageUpdatedInEvent.fromJson;

  ChatMessage get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageUpdatedInEventCopyWith<ChatMessageUpdatedInEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
