// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GcreateRoomData> _$gcreateRoomDataSerializer =
    new _$GcreateRoomDataSerializer();
Serializer<GcreateRoomData_createChatRoom>
    _$gcreateRoomDataCreateChatRoomSerializer =
    new _$GcreateRoomData_createChatRoomSerializer();
Serializer<GgetRoomsData> _$ggetRoomsDataSerializer =
    new _$GgetRoomsDataSerializer();
Serializer<GgetRoomsData_getChatRooms> _$ggetRoomsDataGetChatRoomsSerializer =
    new _$GgetRoomsData_getChatRoomsSerializer();
Serializer<GgetRoomsData_getChatRooms_messages>
    _$ggetRoomsDataGetChatRoomsMessagesSerializer =
    new _$GgetRoomsData_getChatRooms_messagesSerializer();
Serializer<GgetRoomsData_getChatRooms_messages_referencedMessage>
    _$ggetRoomsDataGetChatRoomsMessagesReferencedMessageSerializer =
    new _$GgetRoomsData_getChatRooms_messages_referencedMessageSerializer();
Serializer<GgetRoomsData_getChatRooms_users>
    _$ggetRoomsDataGetChatRoomsUsersSerializer =
    new _$GgetRoomsData_getChatRooms_usersSerializer();
Serializer<GBaseChatRoomData> _$gBaseChatRoomDataSerializer =
    new _$GBaseChatRoomDataSerializer();

class _$GcreateRoomDataSerializer
    implements StructuredSerializer<GcreateRoomData> {
  @override
  final Iterable<Type> types = const [GcreateRoomData, _$GcreateRoomData];
  @override
  final String wireName = 'GcreateRoomData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GcreateRoomData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.createChatRoom;
    if (value != null) {
      result
        ..add('createChatRoom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GcreateRoomData_createChatRoom)));
    }
    return result;
  }

  @override
  GcreateRoomData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GcreateRoomDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createChatRoom':
          result.createChatRoom.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GcreateRoomData_createChatRoom))!
              as GcreateRoomData_createChatRoom);
          break;
      }
    }

    return result.build();
  }
}

class _$GcreateRoomData_createChatRoomSerializer
    implements StructuredSerializer<GcreateRoomData_createChatRoom> {
  @override
  final Iterable<Type> types = const [
    GcreateRoomData_createChatRoom,
    _$GcreateRoomData_createChatRoom
  ];
  @override
  final String wireName = 'GcreateRoomData_createChatRoom';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GcreateRoomData_createChatRoom object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
    ];

    return result;
  }

  @override
  GcreateRoomData_createChatRoom deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GcreateRoomData_createChatRoomBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsDataSerializer implements StructuredSerializer<GgetRoomsData> {
  @override
  final Iterable<Type> types = const [GgetRoomsData, _$GgetRoomsData];
  @override
  final String wireName = 'GgetRoomsData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GgetRoomsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'getChatRooms',
      serializers.serialize(object.getChatRooms,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GgetRoomsData_getChatRooms)])),
    ];

    return result;
  }

  @override
  GgetRoomsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetRoomsDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'getChatRooms':
          result.getChatRooms.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GgetRoomsData_getChatRooms)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsData_getChatRoomsSerializer
    implements StructuredSerializer<GgetRoomsData_getChatRooms> {
  @override
  final Iterable<Type> types = const [
    GgetRoomsData_getChatRooms,
    _$GgetRoomsData_getChatRooms
  ];
  @override
  final String wireName = 'GgetRoomsData_getChatRooms';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetRoomsData_getChatRooms object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
      'messages',
      serializers.serialize(object.messages,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GgetRoomsData_getChatRooms_messages)])),
      'users',
      serializers.serialize(object.users,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GgetRoomsData_getChatRooms_users)])),
    ];

    return result;
  }

  @override
  GgetRoomsData_getChatRooms deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetRoomsData_getChatRoomsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'messages':
          result.messages.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GgetRoomsData_getChatRooms_messages)
              ]))! as BuiltList<Object?>);
          break;
        case 'users':
          result.users.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GgetRoomsData_getChatRooms_users)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsData_getChatRooms_messagesSerializer
    implements StructuredSerializer<GgetRoomsData_getChatRooms_messages> {
  @override
  final Iterable<Type> types = const [
    GgetRoomsData_getChatRooms_messages,
    _$GgetRoomsData_getChatRooms_messages
  ];
  @override
  final String wireName = 'GgetRoomsData_getChatRooms_messages';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetRoomsData_getChatRooms_messages object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
    ];
    Object? value;
    value = object.referencedMessage;
    if (value != null) {
      result
        ..add('referencedMessage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GgetRoomsData_getChatRooms_messages_referencedMessage)));
    }
    return result;
  }

  @override
  GgetRoomsData_getChatRooms_messages deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetRoomsData_getChatRooms_messagesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'referencedMessage':
          result.referencedMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GgetRoomsData_getChatRooms_messages_referencedMessage))!
              as GgetRoomsData_getChatRooms_messages_referencedMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsData_getChatRooms_messages_referencedMessageSerializer
    implements
        StructuredSerializer<
            GgetRoomsData_getChatRooms_messages_referencedMessage> {
  @override
  final Iterable<Type> types = const [
    GgetRoomsData_getChatRooms_messages_referencedMessage,
    _$GgetRoomsData_getChatRooms_messages_referencedMessage
  ];
  @override
  final String wireName =
      'GgetRoomsData_getChatRooms_messages_referencedMessage';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GgetRoomsData_getChatRooms_messages_referencedMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GgetRoomsData_getChatRooms_messages_referencedMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GgetRoomsData_getChatRooms_messages_referencedMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsData_getChatRooms_usersSerializer
    implements StructuredSerializer<GgetRoomsData_getChatRooms_users> {
  @override
  final Iterable<Type> types = const [
    GgetRoomsData_getChatRooms_users,
    _$GgetRoomsData_getChatRooms_users
  ];
  @override
  final String wireName = 'GgetRoomsData_getChatRooms_users';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetRoomsData_getChatRooms_users object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
      'chatId',
      serializers.serialize(object.chatId, specifiedType: const FullType(int)),
      'role',
      serializers.serialize(object.role,
          specifiedType: const FullType(_i2.GChatRoomUserRole)),
    ];

    return result;
  }

  @override
  GgetRoomsData_getChatRooms_users deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetRoomsData_getChatRooms_usersBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'chatId':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'role':
          result.role = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GChatRoomUserRole))
              as _i2.GChatRoomUserRole;
          break;
      }
    }

    return result.build();
  }
}

class _$GBaseChatRoomDataSerializer
    implements StructuredSerializer<GBaseChatRoomData> {
  @override
  final Iterable<Type> types = const [GBaseChatRoomData, _$GBaseChatRoomData];
  @override
  final String wireName = 'GBaseChatRoomData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GBaseChatRoomData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GDate)),
    ];

    return result;
  }

  @override
  GBaseChatRoomData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GBaseChatRoomDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GDate))! as _i2.GDate);
          break;
      }
    }

    return result.build();
  }
}

class _$GcreateRoomData extends GcreateRoomData {
  @override
  final String G__typename;
  @override
  final GcreateRoomData_createChatRoom? createChatRoom;

  factory _$GcreateRoomData([void Function(GcreateRoomDataBuilder)? updates]) =>
      (new GcreateRoomDataBuilder()..update(updates)).build();

  _$GcreateRoomData._({required this.G__typename, this.createChatRoom})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GcreateRoomData', 'G__typename');
  }

  @override
  GcreateRoomData rebuild(void Function(GcreateRoomDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GcreateRoomDataBuilder toBuilder() =>
      new GcreateRoomDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GcreateRoomData &&
        G__typename == other.G__typename &&
        createChatRoom == other.createChatRoom;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), createChatRoom.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GcreateRoomData')
          ..add('G__typename', G__typename)
          ..add('createChatRoom', createChatRoom))
        .toString();
  }
}

class GcreateRoomDataBuilder
    implements Builder<GcreateRoomData, GcreateRoomDataBuilder> {
  _$GcreateRoomData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GcreateRoomData_createChatRoomBuilder? _createChatRoom;
  GcreateRoomData_createChatRoomBuilder get createChatRoom =>
      _$this._createChatRoom ??= new GcreateRoomData_createChatRoomBuilder();
  set createChatRoom(GcreateRoomData_createChatRoomBuilder? createChatRoom) =>
      _$this._createChatRoom = createChatRoom;

  GcreateRoomDataBuilder() {
    GcreateRoomData._initializeBuilder(this);
  }

  GcreateRoomDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createChatRoom = $v.createChatRoom?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GcreateRoomData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GcreateRoomData;
  }

  @override
  void update(void Function(GcreateRoomDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GcreateRoomData build() {
    _$GcreateRoomData _$result;
    try {
      _$result = _$v ??
          new _$GcreateRoomData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GcreateRoomData', 'G__typename'),
              createChatRoom: _createChatRoom?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createChatRoom';
        _createChatRoom?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GcreateRoomData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GcreateRoomData_createChatRoom extends GcreateRoomData_createChatRoom {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String name;
  @override
  final _i2.GDate createdAt;

  factory _$GcreateRoomData_createChatRoom(
          [void Function(GcreateRoomData_createChatRoomBuilder)? updates]) =>
      (new GcreateRoomData_createChatRoomBuilder()..update(updates)).build();

  _$GcreateRoomData_createChatRoom._(
      {required this.G__typename,
      required this.id,
      required this.name,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GcreateRoomData_createChatRoom', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GcreateRoomData_createChatRoom', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name, 'GcreateRoomData_createChatRoom', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GcreateRoomData_createChatRoom', 'createdAt');
  }

  @override
  GcreateRoomData_createChatRoom rebuild(
          void Function(GcreateRoomData_createChatRoomBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GcreateRoomData_createChatRoomBuilder toBuilder() =>
      new GcreateRoomData_createChatRoomBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GcreateRoomData_createChatRoom &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GcreateRoomData_createChatRoom')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GcreateRoomData_createChatRoomBuilder
    implements
        Builder<GcreateRoomData_createChatRoom,
            GcreateRoomData_createChatRoomBuilder> {
  _$GcreateRoomData_createChatRoom? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GcreateRoomData_createChatRoomBuilder() {
    GcreateRoomData_createChatRoom._initializeBuilder(this);
  }

  GcreateRoomData_createChatRoomBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GcreateRoomData_createChatRoom other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GcreateRoomData_createChatRoom;
  }

  @override
  void update(void Function(GcreateRoomData_createChatRoomBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GcreateRoomData_createChatRoom build() {
    _$GcreateRoomData_createChatRoom _$result;
    try {
      _$result = _$v ??
          new _$GcreateRoomData_createChatRoom._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GcreateRoomData_createChatRoom', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GcreateRoomData_createChatRoom', 'id'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'GcreateRoomData_createChatRoom', 'name'),
              createdAt: createdAt.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GcreateRoomData_createChatRoom', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsData extends GgetRoomsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GgetRoomsData_getChatRooms> getChatRooms;

  factory _$GgetRoomsData([void Function(GgetRoomsDataBuilder)? updates]) =>
      (new GgetRoomsDataBuilder()..update(updates)).build();

  _$GgetRoomsData._({required this.G__typename, required this.getChatRooms})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GgetRoomsData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        getChatRooms, 'GgetRoomsData', 'getChatRooms');
  }

  @override
  GgetRoomsData rebuild(void Function(GgetRoomsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsDataBuilder toBuilder() => new GgetRoomsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetRoomsData &&
        G__typename == other.G__typename &&
        getChatRooms == other.getChatRooms;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), getChatRooms.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetRoomsData')
          ..add('G__typename', G__typename)
          ..add('getChatRooms', getChatRooms))
        .toString();
  }
}

class GgetRoomsDataBuilder
    implements Builder<GgetRoomsData, GgetRoomsDataBuilder> {
  _$GgetRoomsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GgetRoomsData_getChatRooms>? _getChatRooms;
  ListBuilder<GgetRoomsData_getChatRooms> get getChatRooms =>
      _$this._getChatRooms ??= new ListBuilder<GgetRoomsData_getChatRooms>();
  set getChatRooms(ListBuilder<GgetRoomsData_getChatRooms>? getChatRooms) =>
      _$this._getChatRooms = getChatRooms;

  GgetRoomsDataBuilder() {
    GgetRoomsData._initializeBuilder(this);
  }

  GgetRoomsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getChatRooms = $v.getChatRooms.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetRoomsData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsData;
  }

  @override
  void update(void Function(GgetRoomsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsData build() {
    _$GgetRoomsData _$result;
    try {
      _$result = _$v ??
          new _$GgetRoomsData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GgetRoomsData', 'G__typename'),
              getChatRooms: getChatRooms.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getChatRooms';
        getChatRooms.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetRoomsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsData_getChatRooms extends GgetRoomsData_getChatRooms {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String name;
  @override
  final _i2.GDate createdAt;
  @override
  final BuiltList<GgetRoomsData_getChatRooms_messages> messages;
  @override
  final BuiltList<GgetRoomsData_getChatRooms_users> users;

  factory _$GgetRoomsData_getChatRooms(
          [void Function(GgetRoomsData_getChatRoomsBuilder)? updates]) =>
      (new GgetRoomsData_getChatRoomsBuilder()..update(updates)).build();

  _$GgetRoomsData_getChatRooms._(
      {required this.G__typename,
      required this.id,
      required this.name,
      required this.createdAt,
      required this.messages,
      required this.users})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GgetRoomsData_getChatRooms', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GgetRoomsData_getChatRooms', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name, 'GgetRoomsData_getChatRooms', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GgetRoomsData_getChatRooms', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        messages, 'GgetRoomsData_getChatRooms', 'messages');
    BuiltValueNullFieldError.checkNotNull(
        users, 'GgetRoomsData_getChatRooms', 'users');
  }

  @override
  GgetRoomsData_getChatRooms rebuild(
          void Function(GgetRoomsData_getChatRoomsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsData_getChatRoomsBuilder toBuilder() =>
      new GgetRoomsData_getChatRoomsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetRoomsData_getChatRooms &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt &&
        messages == other.messages &&
        users == other.users;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                    name.hashCode),
                createdAt.hashCode),
            messages.hashCode),
        users.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetRoomsData_getChatRooms')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt)
          ..add('messages', messages)
          ..add('users', users))
        .toString();
  }
}

class GgetRoomsData_getChatRoomsBuilder
    implements
        Builder<GgetRoomsData_getChatRooms, GgetRoomsData_getChatRoomsBuilder> {
  _$GgetRoomsData_getChatRooms? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  ListBuilder<GgetRoomsData_getChatRooms_messages>? _messages;
  ListBuilder<GgetRoomsData_getChatRooms_messages> get messages =>
      _$this._messages ??=
          new ListBuilder<GgetRoomsData_getChatRooms_messages>();
  set messages(ListBuilder<GgetRoomsData_getChatRooms_messages>? messages) =>
      _$this._messages = messages;

  ListBuilder<GgetRoomsData_getChatRooms_users>? _users;
  ListBuilder<GgetRoomsData_getChatRooms_users> get users =>
      _$this._users ??= new ListBuilder<GgetRoomsData_getChatRooms_users>();
  set users(ListBuilder<GgetRoomsData_getChatRooms_users>? users) =>
      _$this._users = users;

  GgetRoomsData_getChatRoomsBuilder() {
    GgetRoomsData_getChatRooms._initializeBuilder(this);
  }

  GgetRoomsData_getChatRoomsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt.toBuilder();
      _messages = $v.messages.toBuilder();
      _users = $v.users.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetRoomsData_getChatRooms other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsData_getChatRooms;
  }

  @override
  void update(void Function(GgetRoomsData_getChatRoomsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsData_getChatRooms build() {
    _$GgetRoomsData_getChatRooms _$result;
    try {
      _$result = _$v ??
          new _$GgetRoomsData_getChatRooms._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GgetRoomsData_getChatRooms', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GgetRoomsData_getChatRooms', 'id'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'GgetRoomsData_getChatRooms', 'name'),
              createdAt: createdAt.build(),
              messages: messages.build(),
              users: users.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'messages';
        messages.build();
        _$failedField = 'users';
        users.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetRoomsData_getChatRooms', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsData_getChatRooms_messages
    extends GgetRoomsData_getChatRooms_messages {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int chatId;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final GgetRoomsData_getChatRooms_messages_referencedMessage?
      referencedMessage;

  factory _$GgetRoomsData_getChatRooms_messages(
          [void Function(GgetRoomsData_getChatRooms_messagesBuilder)?
              updates]) =>
      (new GgetRoomsData_getChatRooms_messagesBuilder()..update(updates))
          .build();

  _$GgetRoomsData_getChatRooms_messages._(
      {required this.G__typename,
      required this.id,
      required this.chatId,
      required this.message,
      required this.createdAt,
      this.referencedMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GgetRoomsData_getChatRooms_messages', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GgetRoomsData_getChatRooms_messages', 'id');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GgetRoomsData_getChatRooms_messages', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        message, 'GgetRoomsData_getChatRooms_messages', 'message');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GgetRoomsData_getChatRooms_messages', 'createdAt');
  }

  @override
  GgetRoomsData_getChatRooms_messages rebuild(
          void Function(GgetRoomsData_getChatRooms_messagesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsData_getChatRooms_messagesBuilder toBuilder() =>
      new GgetRoomsData_getChatRooms_messagesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetRoomsData_getChatRooms_messages &&
        G__typename == other.G__typename &&
        id == other.id &&
        chatId == other.chatId &&
        message == other.message &&
        createdAt == other.createdAt &&
        referencedMessage == other.referencedMessage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                    chatId.hashCode),
                message.hashCode),
            createdAt.hashCode),
        referencedMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetRoomsData_getChatRooms_messages')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('chatId', chatId)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('referencedMessage', referencedMessage))
        .toString();
  }
}

class GgetRoomsData_getChatRooms_messagesBuilder
    implements
        Builder<GgetRoomsData_getChatRooms_messages,
            GgetRoomsData_getChatRooms_messagesBuilder> {
  _$GgetRoomsData_getChatRooms_messages? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GgetRoomsData_getChatRooms_messages_referencedMessageBuilder?
      _referencedMessage;
  GgetRoomsData_getChatRooms_messages_referencedMessageBuilder
      get referencedMessage => _$this._referencedMessage ??=
          new GgetRoomsData_getChatRooms_messages_referencedMessageBuilder();
  set referencedMessage(
          GgetRoomsData_getChatRooms_messages_referencedMessageBuilder?
              referencedMessage) =>
      _$this._referencedMessage = referencedMessage;

  GgetRoomsData_getChatRooms_messagesBuilder() {
    GgetRoomsData_getChatRooms_messages._initializeBuilder(this);
  }

  GgetRoomsData_getChatRooms_messagesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _chatId = $v.chatId;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _referencedMessage = $v.referencedMessage?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetRoomsData_getChatRooms_messages other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsData_getChatRooms_messages;
  }

  @override
  void update(
      void Function(GgetRoomsData_getChatRooms_messagesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsData_getChatRooms_messages build() {
    _$GgetRoomsData_getChatRooms_messages _$result;
    try {
      _$result = _$v ??
          new _$GgetRoomsData_getChatRooms_messages._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GgetRoomsData_getChatRooms_messages', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GgetRoomsData_getChatRooms_messages', 'id'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GgetRoomsData_getChatRooms_messages', 'chatId'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message, 'GgetRoomsData_getChatRooms_messages', 'message'),
              createdAt: createdAt.build(),
              referencedMessage: _referencedMessage?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'referencedMessage';
        _referencedMessage?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetRoomsData_getChatRooms_messages', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsData_getChatRooms_messages_referencedMessage
    extends GgetRoomsData_getChatRooms_messages_referencedMessage {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String message;
  @override
  final _i2.GDate createdAt;
  @override
  final int chatId;

  factory _$GgetRoomsData_getChatRooms_messages_referencedMessage(
          [void Function(
                  GgetRoomsData_getChatRooms_messages_referencedMessageBuilder)?
              updates]) =>
      (new GgetRoomsData_getChatRooms_messages_referencedMessageBuilder()
            ..update(updates))
          .build();

  _$GgetRoomsData_getChatRooms_messages_referencedMessage._(
      {required this.G__typename,
      required this.id,
      required this.message,
      required this.createdAt,
      required this.chatId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        'GgetRoomsData_getChatRooms_messages_referencedMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GgetRoomsData_getChatRooms_messages_referencedMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(message,
        'GgetRoomsData_getChatRooms_messages_referencedMessage', 'message');
    BuiltValueNullFieldError.checkNotNull(createdAt,
        'GgetRoomsData_getChatRooms_messages_referencedMessage', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(chatId,
        'GgetRoomsData_getChatRooms_messages_referencedMessage', 'chatId');
  }

  @override
  GgetRoomsData_getChatRooms_messages_referencedMessage rebuild(
          void Function(
                  GgetRoomsData_getChatRooms_messages_referencedMessageBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsData_getChatRooms_messages_referencedMessageBuilder toBuilder() =>
      new GgetRoomsData_getChatRooms_messages_referencedMessageBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetRoomsData_getChatRooms_messages_referencedMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        message == other.message &&
        createdAt == other.createdAt &&
        chatId == other.chatId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, G__typename.hashCode), id.hashCode),
                message.hashCode),
            createdAt.hashCode),
        chatId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            'GgetRoomsData_getChatRooms_messages_referencedMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('chatId', chatId))
        .toString();
  }
}

class GgetRoomsData_getChatRooms_messages_referencedMessageBuilder
    implements
        Builder<GgetRoomsData_getChatRooms_messages_referencedMessage,
            GgetRoomsData_getChatRooms_messages_referencedMessageBuilder> {
  _$GgetRoomsData_getChatRooms_messages_referencedMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  GgetRoomsData_getChatRooms_messages_referencedMessageBuilder() {
    GgetRoomsData_getChatRooms_messages_referencedMessage._initializeBuilder(
        this);
  }

  GgetRoomsData_getChatRooms_messages_referencedMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _message = $v.message;
      _createdAt = $v.createdAt.toBuilder();
      _chatId = $v.chatId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetRoomsData_getChatRooms_messages_referencedMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsData_getChatRooms_messages_referencedMessage;
  }

  @override
  void update(
      void Function(
              GgetRoomsData_getChatRooms_messages_referencedMessageBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsData_getChatRooms_messages_referencedMessage build() {
    _$GgetRoomsData_getChatRooms_messages_referencedMessage _$result;
    try {
      _$result = _$v ??
          new _$GgetRoomsData_getChatRooms_messages_referencedMessage._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  'GgetRoomsData_getChatRooms_messages_referencedMessage',
                  'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id,
                  'GgetRoomsData_getChatRooms_messages_referencedMessage',
                  'id'),
              message: BuiltValueNullFieldError.checkNotNull(
                  message,
                  'GgetRoomsData_getChatRooms_messages_referencedMessage',
                  'message'),
              createdAt: createdAt.build(),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId,
                  'GgetRoomsData_getChatRooms_messages_referencedMessage',
                  'chatId'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetRoomsData_getChatRooms_messages_referencedMessage',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsData_getChatRooms_users
    extends GgetRoomsData_getChatRooms_users {
  @override
  final String G__typename;
  @override
  final int userId;
  @override
  final int chatId;
  @override
  final _i2.GChatRoomUserRole role;

  factory _$GgetRoomsData_getChatRooms_users(
          [void Function(GgetRoomsData_getChatRooms_usersBuilder)? updates]) =>
      (new GgetRoomsData_getChatRooms_usersBuilder()..update(updates)).build();

  _$GgetRoomsData_getChatRooms_users._(
      {required this.G__typename,
      required this.userId,
      required this.chatId,
      required this.role})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GgetRoomsData_getChatRooms_users', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GgetRoomsData_getChatRooms_users', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GgetRoomsData_getChatRooms_users', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        role, 'GgetRoomsData_getChatRooms_users', 'role');
  }

  @override
  GgetRoomsData_getChatRooms_users rebuild(
          void Function(GgetRoomsData_getChatRooms_usersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsData_getChatRooms_usersBuilder toBuilder() =>
      new GgetRoomsData_getChatRooms_usersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetRoomsData_getChatRooms_users &&
        G__typename == other.G__typename &&
        userId == other.userId &&
        chatId == other.chatId &&
        role == other.role;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, G__typename.hashCode), userId.hashCode),
            chatId.hashCode),
        role.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetRoomsData_getChatRooms_users')
          ..add('G__typename', G__typename)
          ..add('userId', userId)
          ..add('chatId', chatId)
          ..add('role', role))
        .toString();
  }
}

class GgetRoomsData_getChatRooms_usersBuilder
    implements
        Builder<GgetRoomsData_getChatRooms_users,
            GgetRoomsData_getChatRooms_usersBuilder> {
  _$GgetRoomsData_getChatRooms_users? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  _i2.GChatRoomUserRole? _role;
  _i2.GChatRoomUserRole? get role => _$this._role;
  set role(_i2.GChatRoomUserRole? role) => _$this._role = role;

  GgetRoomsData_getChatRooms_usersBuilder() {
    GgetRoomsData_getChatRooms_users._initializeBuilder(this);
  }

  GgetRoomsData_getChatRooms_usersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userId = $v.userId;
      _chatId = $v.chatId;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetRoomsData_getChatRooms_users other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsData_getChatRooms_users;
  }

  @override
  void update(void Function(GgetRoomsData_getChatRooms_usersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsData_getChatRooms_users build() {
    final _$result = _$v ??
        new _$GgetRoomsData_getChatRooms_users._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GgetRoomsData_getChatRooms_users', 'G__typename'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, 'GgetRoomsData_getChatRooms_users', 'userId'),
            chatId: BuiltValueNullFieldError.checkNotNull(
                chatId, 'GgetRoomsData_getChatRooms_users', 'chatId'),
            role: BuiltValueNullFieldError.checkNotNull(
                role, 'GgetRoomsData_getChatRooms_users', 'role'));
    replace(_$result);
    return _$result;
  }
}

class _$GBaseChatRoomData extends GBaseChatRoomData {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String name;
  @override
  final _i2.GDate createdAt;

  factory _$GBaseChatRoomData(
          [void Function(GBaseChatRoomDataBuilder)? updates]) =>
      (new GBaseChatRoomDataBuilder()..update(updates)).build();

  _$GBaseChatRoomData._(
      {required this.G__typename,
      required this.id,
      required this.name,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GBaseChatRoomData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(id, 'GBaseChatRoomData', 'id');
    BuiltValueNullFieldError.checkNotNull(name, 'GBaseChatRoomData', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GBaseChatRoomData', 'createdAt');
  }

  @override
  GBaseChatRoomData rebuild(void Function(GBaseChatRoomDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBaseChatRoomDataBuilder toBuilder() =>
      new GBaseChatRoomDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBaseChatRoomData &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GBaseChatRoomData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GBaseChatRoomDataBuilder
    implements Builder<GBaseChatRoomData, GBaseChatRoomDataBuilder> {
  _$GBaseChatRoomData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  _i2.GDateBuilder? _createdAt;
  _i2.GDateBuilder get createdAt =>
      _$this._createdAt ??= new _i2.GDateBuilder();
  set createdAt(_i2.GDateBuilder? createdAt) => _$this._createdAt = createdAt;

  GBaseChatRoomDataBuilder() {
    GBaseChatRoomData._initializeBuilder(this);
  }

  GBaseChatRoomDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBaseChatRoomData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBaseChatRoomData;
  }

  @override
  void update(void Function(GBaseChatRoomDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GBaseChatRoomData build() {
    _$GBaseChatRoomData _$result;
    try {
      _$result = _$v ??
          new _$GBaseChatRoomData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GBaseChatRoomData', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GBaseChatRoomData', 'id'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'GBaseChatRoomData', 'name'),
              createdAt: createdAt.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GBaseChatRoomData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
