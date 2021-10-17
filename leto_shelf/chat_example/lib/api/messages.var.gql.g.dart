// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GgetMessagesVars> _$ggetMessagesVarsSerializer =
    new _$GgetMessagesVarsSerializer();
Serializer<GsendMessageVars> _$gsendMessageVarsSerializer =
    new _$GsendMessageVarsSerializer();
Serializer<GonMessageSentVars> _$gonMessageSentVarsSerializer =
    new _$GonMessageSentVarsSerializer();
Serializer<GFullMessageVars> _$gFullMessageVarsSerializer =
    new _$GFullMessageVarsSerializer();

class _$GgetMessagesVarsSerializer
    implements StructuredSerializer<GgetMessagesVars> {
  @override
  final Iterable<Type> types = const [GgetMessagesVars, _$GgetMessagesVars];
  @override
  final String wireName = 'GgetMessagesVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GgetMessagesVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GgetMessagesVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetMessagesVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GsendMessageVarsSerializer
    implements StructuredSerializer<GsendMessageVars> {
  @override
  final Iterable<Type> types = const [GsendMessageVars, _$GsendMessageVars];
  @override
  final String wireName = 'GsendMessageVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsendMessageVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.referencedMessageId;
    if (value != null) {
      result
        ..add('referencedMessageId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GsendMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsendMessageVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'referencedMessageId':
          result.referencedMessageId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GonMessageSentVarsSerializer
    implements StructuredSerializer<GonMessageSentVars> {
  @override
  final Iterable<Type> types = const [GonMessageSentVars, _$GonMessageSentVars];
  @override
  final String wireName = 'GonMessageSentVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GonMessageSentVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GonMessageSentVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GonMessageSentVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GFullMessageVarsSerializer
    implements StructuredSerializer<GFullMessageVars> {
  @override
  final Iterable<Type> types = const [GFullMessageVars, _$GFullMessageVars];
  @override
  final String wireName = 'GFullMessageVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFullMessageVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GFullMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GFullMessageVarsBuilder().build();
  }
}

class _$GgetMessagesVars extends GgetMessagesVars {
  @override
  final int chatId;

  factory _$GgetMessagesVars(
          [void Function(GgetMessagesVarsBuilder)? updates]) =>
      (new GgetMessagesVarsBuilder()..update(updates)).build();

  _$GgetMessagesVars._({required this.chatId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(chatId, 'GgetMessagesVars', 'chatId');
  }

  @override
  GgetMessagesVars rebuild(void Function(GgetMessagesVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetMessagesVarsBuilder toBuilder() =>
      new GgetMessagesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetMessagesVars && chatId == other.chatId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, chatId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetMessagesVars')
          ..add('chatId', chatId))
        .toString();
  }
}

class GgetMessagesVarsBuilder
    implements Builder<GgetMessagesVars, GgetMessagesVarsBuilder> {
  _$GgetMessagesVars? _$v;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  GgetMessagesVarsBuilder();

  GgetMessagesVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chatId = $v.chatId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetMessagesVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetMessagesVars;
  }

  @override
  void update(void Function(GgetMessagesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetMessagesVars build() {
    final _$result = _$v ??
        new _$GgetMessagesVars._(
            chatId: BuiltValueNullFieldError.checkNotNull(
                chatId, 'GgetMessagesVars', 'chatId'));
    replace(_$result);
    return _$result;
  }
}

class _$GsendMessageVars extends GsendMessageVars {
  @override
  final int chatId;
  @override
  final String message;
  @override
  final int? referencedMessageId;

  factory _$GsendMessageVars(
          [void Function(GsendMessageVarsBuilder)? updates]) =>
      (new GsendMessageVarsBuilder()..update(updates)).build();

  _$GsendMessageVars._(
      {required this.chatId, required this.message, this.referencedMessageId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(chatId, 'GsendMessageVars', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GsendMessageVars', 'message');
  }

  @override
  GsendMessageVars rebuild(void Function(GsendMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsendMessageVarsBuilder toBuilder() =>
      new GsendMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsendMessageVars &&
        chatId == other.chatId &&
        message == other.message &&
        referencedMessageId == other.referencedMessageId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, chatId.hashCode), message.hashCode),
        referencedMessageId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsendMessageVars')
          ..add('chatId', chatId)
          ..add('message', message)
          ..add('referencedMessageId', referencedMessageId))
        .toString();
  }
}

class GsendMessageVarsBuilder
    implements Builder<GsendMessageVars, GsendMessageVarsBuilder> {
  _$GsendMessageVars? _$v;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  int? _referencedMessageId;
  int? get referencedMessageId => _$this._referencedMessageId;
  set referencedMessageId(int? referencedMessageId) =>
      _$this._referencedMessageId = referencedMessageId;

  GsendMessageVarsBuilder();

  GsendMessageVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chatId = $v.chatId;
      _message = $v.message;
      _referencedMessageId = $v.referencedMessageId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsendMessageVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsendMessageVars;
  }

  @override
  void update(void Function(GsendMessageVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsendMessageVars build() {
    final _$result = _$v ??
        new _$GsendMessageVars._(
            chatId: BuiltValueNullFieldError.checkNotNull(
                chatId, 'GsendMessageVars', 'chatId'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, 'GsendMessageVars', 'message'),
            referencedMessageId: referencedMessageId);
    replace(_$result);
    return _$result;
  }
}

class _$GonMessageSentVars extends GonMessageSentVars {
  @override
  final int chatId;

  factory _$GonMessageSentVars(
          [void Function(GonMessageSentVarsBuilder)? updates]) =>
      (new GonMessageSentVarsBuilder()..update(updates)).build();

  _$GonMessageSentVars._({required this.chatId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GonMessageSentVars', 'chatId');
  }

  @override
  GonMessageSentVars rebuild(
          void Function(GonMessageSentVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GonMessageSentVarsBuilder toBuilder() =>
      new GonMessageSentVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GonMessageSentVars && chatId == other.chatId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, chatId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GonMessageSentVars')
          ..add('chatId', chatId))
        .toString();
  }
}

class GonMessageSentVarsBuilder
    implements Builder<GonMessageSentVars, GonMessageSentVarsBuilder> {
  _$GonMessageSentVars? _$v;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  GonMessageSentVarsBuilder();

  GonMessageSentVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chatId = $v.chatId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GonMessageSentVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GonMessageSentVars;
  }

  @override
  void update(void Function(GonMessageSentVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GonMessageSentVars build() {
    final _$result = _$v ??
        new _$GonMessageSentVars._(
            chatId: BuiltValueNullFieldError.checkNotNull(
                chatId, 'GonMessageSentVars', 'chatId'));
    replace(_$result);
    return _$result;
  }
}

class _$GFullMessageVars extends GFullMessageVars {
  factory _$GFullMessageVars(
          [void Function(GFullMessageVarsBuilder)? updates]) =>
      (new GFullMessageVarsBuilder()..update(updates)).build();

  _$GFullMessageVars._() : super._();

  @override
  GFullMessageVars rebuild(void Function(GFullMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFullMessageVarsBuilder toBuilder() =>
      new GFullMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFullMessageVars;
  }

  @override
  int get hashCode {
    return 1065985539;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GFullMessageVars').toString();
  }
}

class GFullMessageVarsBuilder
    implements Builder<GFullMessageVars, GFullMessageVarsBuilder> {
  _$GFullMessageVars? _$v;

  GFullMessageVarsBuilder();

  @override
  void replace(GFullMessageVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFullMessageVars;
  }

  @override
  void update(void Function(GFullMessageVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GFullMessageVars build() {
    final _$result = _$v ?? new _$GFullMessageVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
