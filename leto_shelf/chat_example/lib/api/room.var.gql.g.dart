// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GcreateRoomVars> _$gcreateRoomVarsSerializer =
    new _$GcreateRoomVarsSerializer();
Serializer<GdeleteRoomVars> _$gdeleteRoomVarsSerializer =
    new _$GdeleteRoomVarsSerializer();
Serializer<GgetRoomsVars> _$ggetRoomsVarsSerializer =
    new _$GgetRoomsVarsSerializer();
Serializer<GsearchUserVars> _$gsearchUserVarsSerializer =
    new _$GsearchUserVarsSerializer();
Serializer<GaddChatRoomUserVars> _$gaddChatRoomUserVarsSerializer =
    new _$GaddChatRoomUserVarsSerializer();
Serializer<GdeleteChatRoomUserVars> _$gdeleteChatRoomUserVarsSerializer =
    new _$GdeleteChatRoomUserVarsSerializer();
Serializer<GUserChatVars> _$gUserChatVarsSerializer =
    new _$GUserChatVarsSerializer();
Serializer<GFullChatRoomVars> _$gFullChatRoomVarsSerializer =
    new _$GFullChatRoomVarsSerializer();
Serializer<GBaseChatRoomVars> _$gBaseChatRoomVarsSerializer =
    new _$GBaseChatRoomVarsSerializer();

class _$GcreateRoomVarsSerializer
    implements StructuredSerializer<GcreateRoomVars> {
  @override
  final Iterable<Type> types = const [GcreateRoomVars, _$GcreateRoomVars];
  @override
  final String wireName = 'GcreateRoomVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GcreateRoomVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GcreateRoomVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GcreateRoomVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GdeleteRoomVarsSerializer
    implements StructuredSerializer<GdeleteRoomVars> {
  @override
  final Iterable<Type> types = const [GdeleteRoomVars, _$GdeleteRoomVars];
  @override
  final String wireName = 'GdeleteRoomVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GdeleteRoomVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GdeleteRoomVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GdeleteRoomVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsVarsSerializer implements StructuredSerializer<GgetRoomsVars> {
  @override
  final Iterable<Type> types = const [GgetRoomsVars, _$GgetRoomsVars];
  @override
  final String wireName = 'GgetRoomsVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GgetRoomsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GgetRoomsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GgetRoomsVarsBuilder().build();
  }
}

class _$GsearchUserVarsSerializer
    implements StructuredSerializer<GsearchUserVars> {
  @override
  final Iterable<Type> types = const [GsearchUserVars, _$GsearchUserVars];
  @override
  final String wireName = 'GsearchUserVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsearchUserVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GsearchUserVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsearchUserVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GaddChatRoomUserVarsSerializer
    implements StructuredSerializer<GaddChatRoomUserVars> {
  @override
  final Iterable<Type> types = const [
    GaddChatRoomUserVars,
    _$GaddChatRoomUserVars
  ];
  @override
  final String wireName = 'GaddChatRoomUserVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GaddChatRoomUserVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.role;
    if (value != null) {
      result
        ..add('role')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GChatRoomUserRole)));
    }
    return result;
  }

  @override
  GaddChatRoomUserVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GaddChatRoomUserVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'role':
          result.role = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GChatRoomUserRole))
              as _i2.GChatRoomUserRole?;
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GdeleteChatRoomUserVarsSerializer
    implements StructuredSerializer<GdeleteChatRoomUserVars> {
  @override
  final Iterable<Type> types = const [
    GdeleteChatRoomUserVars,
    _$GdeleteChatRoomUserVars
  ];
  @override
  final String wireName = 'GdeleteChatRoomUserVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GdeleteChatRoomUserVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GdeleteChatRoomUserVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GdeleteChatRoomUserVarsBuilder();

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
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GUserChatVarsSerializer implements StructuredSerializer<GUserChatVars> {
  @override
  final Iterable<Type> types = const [GUserChatVars, _$GUserChatVars];
  @override
  final String wireName = 'GUserChatVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUserChatVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GUserChatVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GUserChatVarsBuilder().build();
  }
}

class _$GFullChatRoomVarsSerializer
    implements StructuredSerializer<GFullChatRoomVars> {
  @override
  final Iterable<Type> types = const [GFullChatRoomVars, _$GFullChatRoomVars];
  @override
  final String wireName = 'GFullChatRoomVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFullChatRoomVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GFullChatRoomVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GFullChatRoomVarsBuilder().build();
  }
}

class _$GBaseChatRoomVarsSerializer
    implements StructuredSerializer<GBaseChatRoomVars> {
  @override
  final Iterable<Type> types = const [GBaseChatRoomVars, _$GBaseChatRoomVars];
  @override
  final String wireName = 'GBaseChatRoomVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GBaseChatRoomVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GBaseChatRoomVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GBaseChatRoomVarsBuilder().build();
  }
}

class _$GcreateRoomVars extends GcreateRoomVars {
  @override
  final String name;

  factory _$GcreateRoomVars([void Function(GcreateRoomVarsBuilder)? updates]) =>
      (new GcreateRoomVarsBuilder()..update(updates)).build();

  _$GcreateRoomVars._({required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'GcreateRoomVars', 'name');
  }

  @override
  GcreateRoomVars rebuild(void Function(GcreateRoomVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GcreateRoomVarsBuilder toBuilder() =>
      new GcreateRoomVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GcreateRoomVars && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(0, name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GcreateRoomVars')..add('name', name))
        .toString();
  }
}

class GcreateRoomVarsBuilder
    implements Builder<GcreateRoomVars, GcreateRoomVarsBuilder> {
  _$GcreateRoomVars? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GcreateRoomVarsBuilder();

  GcreateRoomVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GcreateRoomVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GcreateRoomVars;
  }

  @override
  void update(void Function(GcreateRoomVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GcreateRoomVars build() {
    final _$result = _$v ??
        new _$GcreateRoomVars._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'GcreateRoomVars', 'name'));
    replace(_$result);
    return _$result;
  }
}

class _$GdeleteRoomVars extends GdeleteRoomVars {
  @override
  final int id;

  factory _$GdeleteRoomVars([void Function(GdeleteRoomVarsBuilder)? updates]) =>
      (new GdeleteRoomVarsBuilder()..update(updates)).build();

  _$GdeleteRoomVars._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'GdeleteRoomVars', 'id');
  }

  @override
  GdeleteRoomVars rebuild(void Function(GdeleteRoomVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GdeleteRoomVarsBuilder toBuilder() =>
      new GdeleteRoomVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GdeleteRoomVars && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GdeleteRoomVars')..add('id', id))
        .toString();
  }
}

class GdeleteRoomVarsBuilder
    implements Builder<GdeleteRoomVars, GdeleteRoomVarsBuilder> {
  _$GdeleteRoomVars? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GdeleteRoomVarsBuilder();

  GdeleteRoomVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GdeleteRoomVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GdeleteRoomVars;
  }

  @override
  void update(void Function(GdeleteRoomVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GdeleteRoomVars build() {
    final _$result = _$v ??
        new _$GdeleteRoomVars._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GdeleteRoomVars', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsVars extends GgetRoomsVars {
  factory _$GgetRoomsVars([void Function(GgetRoomsVarsBuilder)? updates]) =>
      (new GgetRoomsVarsBuilder()..update(updates)).build();

  _$GgetRoomsVars._() : super._();

  @override
  GgetRoomsVars rebuild(void Function(GgetRoomsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsVarsBuilder toBuilder() => new GgetRoomsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetRoomsVars;
  }

  @override
  int get hashCode {
    return 481284813;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GgetRoomsVars').toString();
  }
}

class GgetRoomsVarsBuilder
    implements Builder<GgetRoomsVars, GgetRoomsVarsBuilder> {
  _$GgetRoomsVars? _$v;

  GgetRoomsVarsBuilder();

  @override
  void replace(GgetRoomsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsVars;
  }

  @override
  void update(void Function(GgetRoomsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsVars build() {
    final _$result = _$v ?? new _$GgetRoomsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GsearchUserVars extends GsearchUserVars {
  @override
  final String name;

  factory _$GsearchUserVars([void Function(GsearchUserVarsBuilder)? updates]) =>
      (new GsearchUserVarsBuilder()..update(updates)).build();

  _$GsearchUserVars._({required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'GsearchUserVars', 'name');
  }

  @override
  GsearchUserVars rebuild(void Function(GsearchUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsearchUserVarsBuilder toBuilder() =>
      new GsearchUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsearchUserVars && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(0, name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsearchUserVars')..add('name', name))
        .toString();
  }
}

class GsearchUserVarsBuilder
    implements Builder<GsearchUserVars, GsearchUserVarsBuilder> {
  _$GsearchUserVars? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GsearchUserVarsBuilder();

  GsearchUserVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsearchUserVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsearchUserVars;
  }

  @override
  void update(void Function(GsearchUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsearchUserVars build() {
    final _$result = _$v ??
        new _$GsearchUserVars._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'GsearchUserVars', 'name'));
    replace(_$result);
    return _$result;
  }
}

class _$GaddChatRoomUserVars extends GaddChatRoomUserVars {
  @override
  final _i2.GChatRoomUserRole? role;
  @override
  final int chatId;
  @override
  final int userId;

  factory _$GaddChatRoomUserVars(
          [void Function(GaddChatRoomUserVarsBuilder)? updates]) =>
      (new GaddChatRoomUserVarsBuilder()..update(updates)).build();

  _$GaddChatRoomUserVars._(
      {this.role, required this.chatId, required this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GaddChatRoomUserVars', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GaddChatRoomUserVars', 'userId');
  }

  @override
  GaddChatRoomUserVars rebuild(
          void Function(GaddChatRoomUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GaddChatRoomUserVarsBuilder toBuilder() =>
      new GaddChatRoomUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GaddChatRoomUserVars &&
        role == other.role &&
        chatId == other.chatId &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, role.hashCode), chatId.hashCode), userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GaddChatRoomUserVars')
          ..add('role', role)
          ..add('chatId', chatId)
          ..add('userId', userId))
        .toString();
  }
}

class GaddChatRoomUserVarsBuilder
    implements Builder<GaddChatRoomUserVars, GaddChatRoomUserVarsBuilder> {
  _$GaddChatRoomUserVars? _$v;

  _i2.GChatRoomUserRole? _role;
  _i2.GChatRoomUserRole? get role => _$this._role;
  set role(_i2.GChatRoomUserRole? role) => _$this._role = role;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  GaddChatRoomUserVarsBuilder();

  GaddChatRoomUserVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _chatId = $v.chatId;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GaddChatRoomUserVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GaddChatRoomUserVars;
  }

  @override
  void update(void Function(GaddChatRoomUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GaddChatRoomUserVars build() {
    final _$result = _$v ??
        new _$GaddChatRoomUserVars._(
            role: role,
            chatId: BuiltValueNullFieldError.checkNotNull(
                chatId, 'GaddChatRoomUserVars', 'chatId'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, 'GaddChatRoomUserVars', 'userId'));
    replace(_$result);
    return _$result;
  }
}

class _$GdeleteChatRoomUserVars extends GdeleteChatRoomUserVars {
  @override
  final int chatId;
  @override
  final int userId;

  factory _$GdeleteChatRoomUserVars(
          [void Function(GdeleteChatRoomUserVarsBuilder)? updates]) =>
      (new GdeleteChatRoomUserVarsBuilder()..update(updates)).build();

  _$GdeleteChatRoomUserVars._({required this.chatId, required this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GdeleteChatRoomUserVars', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GdeleteChatRoomUserVars', 'userId');
  }

  @override
  GdeleteChatRoomUserVars rebuild(
          void Function(GdeleteChatRoomUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GdeleteChatRoomUserVarsBuilder toBuilder() =>
      new GdeleteChatRoomUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GdeleteChatRoomUserVars &&
        chatId == other.chatId &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, chatId.hashCode), userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GdeleteChatRoomUserVars')
          ..add('chatId', chatId)
          ..add('userId', userId))
        .toString();
  }
}

class GdeleteChatRoomUserVarsBuilder
    implements
        Builder<GdeleteChatRoomUserVars, GdeleteChatRoomUserVarsBuilder> {
  _$GdeleteChatRoomUserVars? _$v;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  GdeleteChatRoomUserVarsBuilder();

  GdeleteChatRoomUserVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chatId = $v.chatId;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GdeleteChatRoomUserVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GdeleteChatRoomUserVars;
  }

  @override
  void update(void Function(GdeleteChatRoomUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GdeleteChatRoomUserVars build() {
    final _$result = _$v ??
        new _$GdeleteChatRoomUserVars._(
            chatId: BuiltValueNullFieldError.checkNotNull(
                chatId, 'GdeleteChatRoomUserVars', 'chatId'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, 'GdeleteChatRoomUserVars', 'userId'));
    replace(_$result);
    return _$result;
  }
}

class _$GUserChatVars extends GUserChatVars {
  factory _$GUserChatVars([void Function(GUserChatVarsBuilder)? updates]) =>
      (new GUserChatVarsBuilder()..update(updates)).build();

  _$GUserChatVars._() : super._();

  @override
  GUserChatVars rebuild(void Function(GUserChatVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserChatVarsBuilder toBuilder() => new GUserChatVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserChatVars;
  }

  @override
  int get hashCode {
    return 805641949;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GUserChatVars').toString();
  }
}

class GUserChatVarsBuilder
    implements Builder<GUserChatVars, GUserChatVarsBuilder> {
  _$GUserChatVars? _$v;

  GUserChatVarsBuilder();

  @override
  void replace(GUserChatVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUserChatVars;
  }

  @override
  void update(void Function(GUserChatVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GUserChatVars build() {
    final _$result = _$v ?? new _$GUserChatVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GFullChatRoomVars extends GFullChatRoomVars {
  factory _$GFullChatRoomVars(
          [void Function(GFullChatRoomVarsBuilder)? updates]) =>
      (new GFullChatRoomVarsBuilder()..update(updates)).build();

  _$GFullChatRoomVars._() : super._();

  @override
  GFullChatRoomVars rebuild(void Function(GFullChatRoomVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFullChatRoomVarsBuilder toBuilder() =>
      new GFullChatRoomVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFullChatRoomVars;
  }

  @override
  int get hashCode {
    return 454365807;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GFullChatRoomVars').toString();
  }
}

class GFullChatRoomVarsBuilder
    implements Builder<GFullChatRoomVars, GFullChatRoomVarsBuilder> {
  _$GFullChatRoomVars? _$v;

  GFullChatRoomVarsBuilder();

  @override
  void replace(GFullChatRoomVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFullChatRoomVars;
  }

  @override
  void update(void Function(GFullChatRoomVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GFullChatRoomVars build() {
    final _$result = _$v ?? new _$GFullChatRoomVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GBaseChatRoomVars extends GBaseChatRoomVars {
  factory _$GBaseChatRoomVars(
          [void Function(GBaseChatRoomVarsBuilder)? updates]) =>
      (new GBaseChatRoomVarsBuilder()..update(updates)).build();

  _$GBaseChatRoomVars._() : super._();

  @override
  GBaseChatRoomVars rebuild(void Function(GBaseChatRoomVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBaseChatRoomVarsBuilder toBuilder() =>
      new GBaseChatRoomVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBaseChatRoomVars;
  }

  @override
  int get hashCode {
    return 1071874162;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('GBaseChatRoomVars').toString();
  }
}

class GBaseChatRoomVarsBuilder
    implements Builder<GBaseChatRoomVars, GBaseChatRoomVarsBuilder> {
  _$GBaseChatRoomVars? _$v;

  GBaseChatRoomVarsBuilder();

  @override
  void replace(GBaseChatRoomVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBaseChatRoomVars;
  }

  @override
  void update(void Function(GBaseChatRoomVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GBaseChatRoomVars build() {
    final _$result = _$v ?? new _$GBaseChatRoomVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
