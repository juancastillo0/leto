// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'messages_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatMessageEventTearOff {
  const _$ChatMessageEventTearOff();

  ChatMessageSentEvent sent(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
          value) {
    return ChatMessageSentEvent(
      value,
    );
  }

  ChatMessageDeletedEvent deleted(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
          value) {
    return ChatMessageDeletedEvent(
      value,
    );
  }

  ChatMessageUpdatedEvent updated(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
          value) {
    return ChatMessageUpdatedEvent(
      value,
    );
  }
}

/// @nodoc
const $ChatMessageEvent = _$ChatMessageEventTearOff();

/// @nodoc
mixin _$ChatMessageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)
        sent,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)
        deleted,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)
        updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessageSentEvent value)? sent,
    TResult Function(ChatMessageDeletedEvent value)? deleted,
    TResult Function(ChatMessageUpdatedEvent value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
  $Res call(
      {GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
          value});
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
    Object? value = freezed,
  }) {
    return _then(ChatMessageSentEvent(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent,
    ));
  }
}

/// @nodoc

class _$ChatMessageSentEvent implements ChatMessageSentEvent {
  const _$ChatMessageSentEvent(this.value);

  @override
  final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
      value;

  @override
  String toString() {
    return 'ChatMessageEvent.sent(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChatMessageSentEvent &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $ChatMessageSentEventCopyWith<ChatMessageSentEvent> get copyWith =>
      _$ChatMessageSentEventCopyWithImpl<ChatMessageSentEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)
        sent,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)
        deleted,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)
        updated,
  }) {
    return sent(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(value);
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
}

abstract class ChatMessageSentEvent implements ChatMessageEvent {
  const factory ChatMessageSentEvent(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
          value) = _$ChatMessageSentEvent;

  GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
      get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageSentEventCopyWith<ChatMessageSentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageDeletedEventCopyWith<$Res> {
  factory $ChatMessageDeletedEventCopyWith(ChatMessageDeletedEvent value,
          $Res Function(ChatMessageDeletedEvent) then) =
      _$ChatMessageDeletedEventCopyWithImpl<$Res>;
  $Res call(
      {GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
          value});
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
    Object? value = freezed,
  }) {
    return _then(ChatMessageDeletedEvent(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent,
    ));
  }
}

/// @nodoc

class _$ChatMessageDeletedEvent implements ChatMessageDeletedEvent {
  const _$ChatMessageDeletedEvent(this.value);

  @override
  final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
      value;

  @override
  String toString() {
    return 'ChatMessageEvent.deleted(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChatMessageDeletedEvent &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $ChatMessageDeletedEventCopyWith<ChatMessageDeletedEvent> get copyWith =>
      _$ChatMessageDeletedEventCopyWithImpl<ChatMessageDeletedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)
        sent,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)
        deleted,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)
        updated,
  }) {
    return deleted(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(value);
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
}

abstract class ChatMessageDeletedEvent implements ChatMessageEvent {
  const factory ChatMessageDeletedEvent(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
          value) = _$ChatMessageDeletedEvent;

  GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
      get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageDeletedEventCopyWith<ChatMessageDeletedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageUpdatedEventCopyWith<$Res> {
  factory $ChatMessageUpdatedEventCopyWith(ChatMessageUpdatedEvent value,
          $Res Function(ChatMessageUpdatedEvent) then) =
      _$ChatMessageUpdatedEventCopyWithImpl<$Res>;
  $Res call(
      {GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
          value});
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
    Object? value = freezed,
  }) {
    return _then(ChatMessageUpdatedEvent(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent,
    ));
  }
}

/// @nodoc

class _$ChatMessageUpdatedEvent implements ChatMessageUpdatedEvent {
  const _$ChatMessageUpdatedEvent(this.value);

  @override
  final GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
      value;

  @override
  String toString() {
    return 'ChatMessageEvent.updated(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChatMessageUpdatedEvent &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $ChatMessageUpdatedEventCopyWith<ChatMessageUpdatedEvent> get copyWith =>
      _$ChatMessageUpdatedEventCopyWithImpl<ChatMessageUpdatedEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)
        sent,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)
        deleted,
    required TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)
        updated,
  }) {
    return updated(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageSentEvent
                value)?
        sent,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageDeletedEvent
                value)?
        deleted,
    TResult Function(
            GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
                value)?
        updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(value);
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
}

abstract class ChatMessageUpdatedEvent implements ChatMessageEvent {
  const factory ChatMessageUpdatedEvent(
      GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
          value) = _$ChatMessageUpdatedEvent;

  GonEventData_onEvent_data__asChatMessageDBEventData_value__asChatMessageUpdatedEvent
      get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageUpdatedEventCopyWith<ChatMessageUpdatedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
