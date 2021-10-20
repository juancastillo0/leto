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
Serializer<GdeleteRoomData> _$gdeleteRoomDataSerializer =
    new _$GdeleteRoomDataSerializer();
Serializer<GgetRoomsData> _$ggetRoomsDataSerializer =
    new _$GgetRoomsDataSerializer();
Serializer<GgetRoomsData_getChatRooms> _$ggetRoomsDataGetChatRoomsSerializer =
    new _$GgetRoomsData_getChatRoomsSerializer();
Serializer<GgetRoomsData_getChatRooms_users>
    _$ggetRoomsDataGetChatRoomsUsersSerializer =
    new _$GgetRoomsData_getChatRooms_usersSerializer();
Serializer<GgetRoomsData_getChatRooms_users_user>
    _$ggetRoomsDataGetChatRoomsUsersUserSerializer =
    new _$GgetRoomsData_getChatRooms_users_userSerializer();
Serializer<GsearchUserData> _$gsearchUserDataSerializer =
    new _$GsearchUserDataSerializer();
Serializer<GsearchUserData_searchUser> _$gsearchUserDataSearchUserSerializer =
    new _$GsearchUserData_searchUserSerializer();
Serializer<GaddChatRoomUserData> _$gaddChatRoomUserDataSerializer =
    new _$GaddChatRoomUserDataSerializer();
Serializer<GaddChatRoomUserData_addChatRoomUser>
    _$gaddChatRoomUserDataAddChatRoomUserSerializer =
    new _$GaddChatRoomUserData_addChatRoomUserSerializer();
Serializer<GaddChatRoomUserData_addChatRoomUser_user>
    _$gaddChatRoomUserDataAddChatRoomUserUserSerializer =
    new _$GaddChatRoomUserData_addChatRoomUser_userSerializer();
Serializer<GdeleteChatRoomUserData> _$gdeleteChatRoomUserDataSerializer =
    new _$GdeleteChatRoomUserDataSerializer();
Serializer<GUserChatData> _$gUserChatDataSerializer =
    new _$GUserChatDataSerializer();
Serializer<GUserChatData_user> _$gUserChatDataUserSerializer =
    new _$GUserChatData_userSerializer();
Serializer<GFullChatRoomData> _$gFullChatRoomDataSerializer =
    new _$GFullChatRoomDataSerializer();
Serializer<GFullChatRoomData_users> _$gFullChatRoomDataUsersSerializer =
    new _$GFullChatRoomData_usersSerializer();
Serializer<GFullChatRoomData_users_user>
    _$gFullChatRoomDataUsersUserSerializer =
    new _$GFullChatRoomData_users_userSerializer();
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

class _$GdeleteRoomDataSerializer
    implements StructuredSerializer<GdeleteRoomData> {
  @override
  final Iterable<Type> types = const [GdeleteRoomData, _$GdeleteRoomData];
  @override
  final String wireName = 'GdeleteRoomData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GdeleteRoomData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'deleteChatRoom',
      serializers.serialize(object.deleteChatRoom,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GdeleteRoomData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GdeleteRoomDataBuilder();

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
        case 'deleteChatRoom':
          result.deleteChatRoom = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(GgetRoomsData_getChatRooms_users_user)),
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
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GgetRoomsData_getChatRooms_users_user))!
              as GgetRoomsData_getChatRooms_users_user);
          break;
      }
    }

    return result.build();
  }
}

class _$GgetRoomsData_getChatRooms_users_userSerializer
    implements StructuredSerializer<GgetRoomsData_getChatRooms_users_user> {
  @override
  final Iterable<Type> types = const [
    GgetRoomsData_getChatRooms_users_user,
    _$GgetRoomsData_getChatRooms_users_user
  ];
  @override
  final String wireName = 'GgetRoomsData_getChatRooms_users_user';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GgetRoomsData_getChatRooms_users_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GgetRoomsData_getChatRooms_users_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GgetRoomsData_getChatRooms_users_userBuilder();

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
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GsearchUserDataSerializer
    implements StructuredSerializer<GsearchUserData> {
  @override
  final Iterable<Type> types = const [GsearchUserData, _$GsearchUserData];
  @override
  final String wireName = 'GsearchUserData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsearchUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'searchUser',
      serializers.serialize(object.searchUser,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GsearchUserData_searchUser)])),
    ];

    return result;
  }

  @override
  GsearchUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsearchUserDataBuilder();

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
        case 'searchUser':
          result.searchUser.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GsearchUserData_searchUser)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GsearchUserData_searchUserSerializer
    implements StructuredSerializer<GsearchUserData_searchUser> {
  @override
  final Iterable<Type> types = const [
    GsearchUserData_searchUser,
    _$GsearchUserData_searchUser
  ];
  @override
  final String wireName = 'GsearchUserData_searchUser';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsearchUserData_searchUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GsearchUserData_searchUser deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsearchUserData_searchUserBuilder();

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
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GaddChatRoomUserDataSerializer
    implements StructuredSerializer<GaddChatRoomUserData> {
  @override
  final Iterable<Type> types = const [
    GaddChatRoomUserData,
    _$GaddChatRoomUserData
  ];
  @override
  final String wireName = 'GaddChatRoomUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GaddChatRoomUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.addChatRoomUser;
    if (value != null) {
      result
        ..add('addChatRoomUser')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GaddChatRoomUserData_addChatRoomUser)));
    }
    return result;
  }

  @override
  GaddChatRoomUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GaddChatRoomUserDataBuilder();

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
        case 'addChatRoomUser':
          result.addChatRoomUser.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GaddChatRoomUserData_addChatRoomUser))!
              as GaddChatRoomUserData_addChatRoomUser);
          break;
      }
    }

    return result.build();
  }
}

class _$GaddChatRoomUserData_addChatRoomUserSerializer
    implements StructuredSerializer<GaddChatRoomUserData_addChatRoomUser> {
  @override
  final Iterable<Type> types = const [
    GaddChatRoomUserData_addChatRoomUser,
    _$GaddChatRoomUserData_addChatRoomUser
  ];
  @override
  final String wireName = 'GaddChatRoomUserData_addChatRoomUser';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GaddChatRoomUserData_addChatRoomUser object,
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
      'user',
      serializers.serialize(object.user,
          specifiedType:
              const FullType(GaddChatRoomUserData_addChatRoomUser_user)),
    ];

    return result;
  }

  @override
  GaddChatRoomUserData_addChatRoomUser deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GaddChatRoomUserData_addChatRoomUserBuilder();

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
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GaddChatRoomUserData_addChatRoomUser_user))!
              as GaddChatRoomUserData_addChatRoomUser_user);
          break;
      }
    }

    return result.build();
  }
}

class _$GaddChatRoomUserData_addChatRoomUser_userSerializer
    implements StructuredSerializer<GaddChatRoomUserData_addChatRoomUser_user> {
  @override
  final Iterable<Type> types = const [
    GaddChatRoomUserData_addChatRoomUser_user,
    _$GaddChatRoomUserData_addChatRoomUser_user
  ];
  @override
  final String wireName = 'GaddChatRoomUserData_addChatRoomUser_user';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GaddChatRoomUserData_addChatRoomUser_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GaddChatRoomUserData_addChatRoomUser_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GaddChatRoomUserData_addChatRoomUser_userBuilder();

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
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GdeleteChatRoomUserDataSerializer
    implements StructuredSerializer<GdeleteChatRoomUserData> {
  @override
  final Iterable<Type> types = const [
    GdeleteChatRoomUserData,
    _$GdeleteChatRoomUserData
  ];
  @override
  final String wireName = 'GdeleteChatRoomUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GdeleteChatRoomUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'deleteChatRoomUser',
      serializers.serialize(object.deleteChatRoomUser,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GdeleteChatRoomUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GdeleteChatRoomUserDataBuilder();

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
        case 'deleteChatRoomUser':
          result.deleteChatRoomUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GUserChatDataSerializer implements StructuredSerializer<GUserChatData> {
  @override
  final Iterable<Type> types = const [GUserChatData, _$GUserChatData];
  @override
  final String wireName = 'GUserChatData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUserChatData object,
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
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(GUserChatData_user)),
    ];

    return result;
  }

  @override
  GUserChatData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUserChatDataBuilder();

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
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GUserChatData_user))!
              as GUserChatData_user);
          break;
      }
    }

    return result.build();
  }
}

class _$GUserChatData_userSerializer
    implements StructuredSerializer<GUserChatData_user> {
  @override
  final Iterable<Type> types = const [GUserChatData_user, _$GUserChatData_user];
  @override
  final String wireName = 'GUserChatData_user';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserChatData_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUserChatData_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUserChatData_userBuilder();

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
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GFullChatRoomDataSerializer
    implements StructuredSerializer<GFullChatRoomData> {
  @override
  final Iterable<Type> types = const [GFullChatRoomData, _$GFullChatRoomData];
  @override
  final String wireName = 'GFullChatRoomData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFullChatRoomData object,
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
      'users',
      serializers.serialize(object.users,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GFullChatRoomData_users)])),
    ];

    return result;
  }

  @override
  GFullChatRoomData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFullChatRoomDataBuilder();

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
        case 'users':
          result.users.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GFullChatRoomData_users)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GFullChatRoomData_usersSerializer
    implements StructuredSerializer<GFullChatRoomData_users> {
  @override
  final Iterable<Type> types = const [
    GFullChatRoomData_users,
    _$GFullChatRoomData_users
  ];
  @override
  final String wireName = 'GFullChatRoomData_users';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFullChatRoomData_users object,
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
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(GFullChatRoomData_users_user)),
    ];

    return result;
  }

  @override
  GFullChatRoomData_users deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFullChatRoomData_usersBuilder();

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
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GFullChatRoomData_users_user))!
              as GFullChatRoomData_users_user);
          break;
      }
    }

    return result.build();
  }
}

class _$GFullChatRoomData_users_userSerializer
    implements StructuredSerializer<GFullChatRoomData_users_user> {
  @override
  final Iterable<Type> types = const [
    GFullChatRoomData_users_user,
    _$GFullChatRoomData_users_user
  ];
  @override
  final String wireName = 'GFullChatRoomData_users_user';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFullChatRoomData_users_user object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GFullChatRoomData_users_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFullChatRoomData_users_userBuilder();

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
              specifiedType: const FullType(String)) as String?;
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

class _$GdeleteRoomData extends GdeleteRoomData {
  @override
  final String G__typename;
  @override
  final bool deleteChatRoom;

  factory _$GdeleteRoomData([void Function(GdeleteRoomDataBuilder)? updates]) =>
      (new GdeleteRoomDataBuilder()..update(updates)).build();

  _$GdeleteRoomData._({required this.G__typename, required this.deleteChatRoom})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GdeleteRoomData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        deleteChatRoom, 'GdeleteRoomData', 'deleteChatRoom');
  }

  @override
  GdeleteRoomData rebuild(void Function(GdeleteRoomDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GdeleteRoomDataBuilder toBuilder() =>
      new GdeleteRoomDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GdeleteRoomData &&
        G__typename == other.G__typename &&
        deleteChatRoom == other.deleteChatRoom;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), deleteChatRoom.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GdeleteRoomData')
          ..add('G__typename', G__typename)
          ..add('deleteChatRoom', deleteChatRoom))
        .toString();
  }
}

class GdeleteRoomDataBuilder
    implements Builder<GdeleteRoomData, GdeleteRoomDataBuilder> {
  _$GdeleteRoomData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _deleteChatRoom;
  bool? get deleteChatRoom => _$this._deleteChatRoom;
  set deleteChatRoom(bool? deleteChatRoom) =>
      _$this._deleteChatRoom = deleteChatRoom;

  GdeleteRoomDataBuilder() {
    GdeleteRoomData._initializeBuilder(this);
  }

  GdeleteRoomDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteChatRoom = $v.deleteChatRoom;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GdeleteRoomData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GdeleteRoomData;
  }

  @override
  void update(void Function(GdeleteRoomDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GdeleteRoomData build() {
    final _$result = _$v ??
        new _$GdeleteRoomData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GdeleteRoomData', 'G__typename'),
            deleteChatRoom: BuiltValueNullFieldError.checkNotNull(
                deleteChatRoom, 'GdeleteRoomData', 'deleteChatRoom'));
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
  final BuiltList<GgetRoomsData_getChatRooms_users> users;

  factory _$GgetRoomsData_getChatRooms(
          [void Function(GgetRoomsData_getChatRoomsBuilder)? updates]) =>
      (new GgetRoomsData_getChatRoomsBuilder()..update(updates)).build();

  _$GgetRoomsData_getChatRooms._(
      {required this.G__typename,
      required this.id,
      required this.name,
      required this.createdAt,
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
        users == other.users;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode),
            createdAt.hashCode),
        users.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetRoomsData_getChatRooms')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt)
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
              users: users.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
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
  @override
  final GgetRoomsData_getChatRooms_users_user user;

  factory _$GgetRoomsData_getChatRooms_users(
          [void Function(GgetRoomsData_getChatRooms_usersBuilder)? updates]) =>
      (new GgetRoomsData_getChatRooms_usersBuilder()..update(updates)).build();

  _$GgetRoomsData_getChatRooms_users._(
      {required this.G__typename,
      required this.userId,
      required this.chatId,
      required this.role,
      required this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GgetRoomsData_getChatRooms_users', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GgetRoomsData_getChatRooms_users', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GgetRoomsData_getChatRooms_users', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        role, 'GgetRoomsData_getChatRooms_users', 'role');
    BuiltValueNullFieldError.checkNotNull(
        user, 'GgetRoomsData_getChatRooms_users', 'user');
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
        role == other.role &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, G__typename.hashCode), userId.hashCode),
                chatId.hashCode),
            role.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetRoomsData_getChatRooms_users')
          ..add('G__typename', G__typename)
          ..add('userId', userId)
          ..add('chatId', chatId)
          ..add('role', role)
          ..add('user', user))
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

  GgetRoomsData_getChatRooms_users_userBuilder? _user;
  GgetRoomsData_getChatRooms_users_userBuilder get user =>
      _$this._user ??= new GgetRoomsData_getChatRooms_users_userBuilder();
  set user(GgetRoomsData_getChatRooms_users_userBuilder? user) =>
      _$this._user = user;

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
      _user = $v.user.toBuilder();
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
    _$GgetRoomsData_getChatRooms_users _$result;
    try {
      _$result = _$v ??
          new _$GgetRoomsData_getChatRooms_users._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GgetRoomsData_getChatRooms_users', 'G__typename'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GgetRoomsData_getChatRooms_users', 'userId'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GgetRoomsData_getChatRooms_users', 'chatId'),
              role: BuiltValueNullFieldError.checkNotNull(
                  role, 'GgetRoomsData_getChatRooms_users', 'role'),
              user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GgetRoomsData_getChatRooms_users', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GgetRoomsData_getChatRooms_users_user
    extends GgetRoomsData_getChatRooms_users_user {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;

  factory _$GgetRoomsData_getChatRooms_users_user(
          [void Function(GgetRoomsData_getChatRooms_users_userBuilder)?
              updates]) =>
      (new GgetRoomsData_getChatRooms_users_userBuilder()..update(updates))
          .build();

  _$GgetRoomsData_getChatRooms_users_user._(
      {required this.G__typename, required this.id, this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GgetRoomsData_getChatRooms_users_user', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GgetRoomsData_getChatRooms_users_user', 'id');
  }

  @override
  GgetRoomsData_getChatRooms_users_user rebuild(
          void Function(GgetRoomsData_getChatRooms_users_userBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GgetRoomsData_getChatRooms_users_userBuilder toBuilder() =>
      new GgetRoomsData_getChatRooms_users_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GgetRoomsData_getChatRooms_users_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GgetRoomsData_getChatRooms_users_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GgetRoomsData_getChatRooms_users_userBuilder
    implements
        Builder<GgetRoomsData_getChatRooms_users_user,
            GgetRoomsData_getChatRooms_users_userBuilder> {
  _$GgetRoomsData_getChatRooms_users_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GgetRoomsData_getChatRooms_users_userBuilder() {
    GgetRoomsData_getChatRooms_users_user._initializeBuilder(this);
  }

  GgetRoomsData_getChatRooms_users_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GgetRoomsData_getChatRooms_users_user other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GgetRoomsData_getChatRooms_users_user;
  }

  @override
  void update(
      void Function(GgetRoomsData_getChatRooms_users_userBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GgetRoomsData_getChatRooms_users_user build() {
    final _$result = _$v ??
        new _$GgetRoomsData_getChatRooms_users_user._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                'GgetRoomsData_getChatRooms_users_user', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GgetRoomsData_getChatRooms_users_user', 'id'),
            name: name);
    replace(_$result);
    return _$result;
  }
}

class _$GsearchUserData extends GsearchUserData {
  @override
  final String G__typename;
  @override
  final BuiltList<GsearchUserData_searchUser> searchUser;

  factory _$GsearchUserData([void Function(GsearchUserDataBuilder)? updates]) =>
      (new GsearchUserDataBuilder()..update(updates)).build();

  _$GsearchUserData._({required this.G__typename, required this.searchUser})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsearchUserData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        searchUser, 'GsearchUserData', 'searchUser');
  }

  @override
  GsearchUserData rebuild(void Function(GsearchUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsearchUserDataBuilder toBuilder() =>
      new GsearchUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsearchUserData &&
        G__typename == other.G__typename &&
        searchUser == other.searchUser;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), searchUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsearchUserData')
          ..add('G__typename', G__typename)
          ..add('searchUser', searchUser))
        .toString();
  }
}

class GsearchUserDataBuilder
    implements Builder<GsearchUserData, GsearchUserDataBuilder> {
  _$GsearchUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GsearchUserData_searchUser>? _searchUser;
  ListBuilder<GsearchUserData_searchUser> get searchUser =>
      _$this._searchUser ??= new ListBuilder<GsearchUserData_searchUser>();
  set searchUser(ListBuilder<GsearchUserData_searchUser>? searchUser) =>
      _$this._searchUser = searchUser;

  GsearchUserDataBuilder() {
    GsearchUserData._initializeBuilder(this);
  }

  GsearchUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _searchUser = $v.searchUser.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsearchUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsearchUserData;
  }

  @override
  void update(void Function(GsearchUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsearchUserData build() {
    _$GsearchUserData _$result;
    try {
      _$result = _$v ??
          new _$GsearchUserData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GsearchUserData', 'G__typename'),
              searchUser: searchUser.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'searchUser';
        searchUser.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GsearchUserData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsearchUserData_searchUser extends GsearchUserData_searchUser {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;

  factory _$GsearchUserData_searchUser(
          [void Function(GsearchUserData_searchUserBuilder)? updates]) =>
      (new GsearchUserData_searchUserBuilder()..update(updates)).build();

  _$GsearchUserData_searchUser._(
      {required this.G__typename, required this.id, this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GsearchUserData_searchUser', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GsearchUserData_searchUser', 'id');
  }

  @override
  GsearchUserData_searchUser rebuild(
          void Function(GsearchUserData_searchUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsearchUserData_searchUserBuilder toBuilder() =>
      new GsearchUserData_searchUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsearchUserData_searchUser &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GsearchUserData_searchUser')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GsearchUserData_searchUserBuilder
    implements
        Builder<GsearchUserData_searchUser, GsearchUserData_searchUserBuilder> {
  _$GsearchUserData_searchUser? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GsearchUserData_searchUserBuilder() {
    GsearchUserData_searchUser._initializeBuilder(this);
  }

  GsearchUserData_searchUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsearchUserData_searchUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsearchUserData_searchUser;
  }

  @override
  void update(void Function(GsearchUserData_searchUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GsearchUserData_searchUser build() {
    final _$result = _$v ??
        new _$GsearchUserData_searchUser._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GsearchUserData_searchUser', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GsearchUserData_searchUser', 'id'),
            name: name);
    replace(_$result);
    return _$result;
  }
}

class _$GaddChatRoomUserData extends GaddChatRoomUserData {
  @override
  final String G__typename;
  @override
  final GaddChatRoomUserData_addChatRoomUser? addChatRoomUser;

  factory _$GaddChatRoomUserData(
          [void Function(GaddChatRoomUserDataBuilder)? updates]) =>
      (new GaddChatRoomUserDataBuilder()..update(updates)).build();

  _$GaddChatRoomUserData._({required this.G__typename, this.addChatRoomUser})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GaddChatRoomUserData', 'G__typename');
  }

  @override
  GaddChatRoomUserData rebuild(
          void Function(GaddChatRoomUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GaddChatRoomUserDataBuilder toBuilder() =>
      new GaddChatRoomUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GaddChatRoomUserData &&
        G__typename == other.G__typename &&
        addChatRoomUser == other.addChatRoomUser;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), addChatRoomUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GaddChatRoomUserData')
          ..add('G__typename', G__typename)
          ..add('addChatRoomUser', addChatRoomUser))
        .toString();
  }
}

class GaddChatRoomUserDataBuilder
    implements Builder<GaddChatRoomUserData, GaddChatRoomUserDataBuilder> {
  _$GaddChatRoomUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GaddChatRoomUserData_addChatRoomUserBuilder? _addChatRoomUser;
  GaddChatRoomUserData_addChatRoomUserBuilder get addChatRoomUser =>
      _$this._addChatRoomUser ??=
          new GaddChatRoomUserData_addChatRoomUserBuilder();
  set addChatRoomUser(
          GaddChatRoomUserData_addChatRoomUserBuilder? addChatRoomUser) =>
      _$this._addChatRoomUser = addChatRoomUser;

  GaddChatRoomUserDataBuilder() {
    GaddChatRoomUserData._initializeBuilder(this);
  }

  GaddChatRoomUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _addChatRoomUser = $v.addChatRoomUser?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GaddChatRoomUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GaddChatRoomUserData;
  }

  @override
  void update(void Function(GaddChatRoomUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GaddChatRoomUserData build() {
    _$GaddChatRoomUserData _$result;
    try {
      _$result = _$v ??
          new _$GaddChatRoomUserData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GaddChatRoomUserData', 'G__typename'),
              addChatRoomUser: _addChatRoomUser?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'addChatRoomUser';
        _addChatRoomUser?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GaddChatRoomUserData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GaddChatRoomUserData_addChatRoomUser
    extends GaddChatRoomUserData_addChatRoomUser {
  @override
  final String G__typename;
  @override
  final int userId;
  @override
  final int chatId;
  @override
  final _i2.GChatRoomUserRole role;
  @override
  final GaddChatRoomUserData_addChatRoomUser_user user;

  factory _$GaddChatRoomUserData_addChatRoomUser(
          [void Function(GaddChatRoomUserData_addChatRoomUserBuilder)?
              updates]) =>
      (new GaddChatRoomUserData_addChatRoomUserBuilder()..update(updates))
          .build();

  _$GaddChatRoomUserData_addChatRoomUser._(
      {required this.G__typename,
      required this.userId,
      required this.chatId,
      required this.role,
      required this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GaddChatRoomUserData_addChatRoomUser', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GaddChatRoomUserData_addChatRoomUser', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GaddChatRoomUserData_addChatRoomUser', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        role, 'GaddChatRoomUserData_addChatRoomUser', 'role');
    BuiltValueNullFieldError.checkNotNull(
        user, 'GaddChatRoomUserData_addChatRoomUser', 'user');
  }

  @override
  GaddChatRoomUserData_addChatRoomUser rebuild(
          void Function(GaddChatRoomUserData_addChatRoomUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GaddChatRoomUserData_addChatRoomUserBuilder toBuilder() =>
      new GaddChatRoomUserData_addChatRoomUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GaddChatRoomUserData_addChatRoomUser &&
        G__typename == other.G__typename &&
        userId == other.userId &&
        chatId == other.chatId &&
        role == other.role &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, G__typename.hashCode), userId.hashCode),
                chatId.hashCode),
            role.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GaddChatRoomUserData_addChatRoomUser')
          ..add('G__typename', G__typename)
          ..add('userId', userId)
          ..add('chatId', chatId)
          ..add('role', role)
          ..add('user', user))
        .toString();
  }
}

class GaddChatRoomUserData_addChatRoomUserBuilder
    implements
        Builder<GaddChatRoomUserData_addChatRoomUser,
            GaddChatRoomUserData_addChatRoomUserBuilder> {
  _$GaddChatRoomUserData_addChatRoomUser? _$v;

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

  GaddChatRoomUserData_addChatRoomUser_userBuilder? _user;
  GaddChatRoomUserData_addChatRoomUser_userBuilder get user =>
      _$this._user ??= new GaddChatRoomUserData_addChatRoomUser_userBuilder();
  set user(GaddChatRoomUserData_addChatRoomUser_userBuilder? user) =>
      _$this._user = user;

  GaddChatRoomUserData_addChatRoomUserBuilder() {
    GaddChatRoomUserData_addChatRoomUser._initializeBuilder(this);
  }

  GaddChatRoomUserData_addChatRoomUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userId = $v.userId;
      _chatId = $v.chatId;
      _role = $v.role;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GaddChatRoomUserData_addChatRoomUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GaddChatRoomUserData_addChatRoomUser;
  }

  @override
  void update(
      void Function(GaddChatRoomUserData_addChatRoomUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GaddChatRoomUserData_addChatRoomUser build() {
    _$GaddChatRoomUserData_addChatRoomUser _$result;
    try {
      _$result = _$v ??
          new _$GaddChatRoomUserData_addChatRoomUser._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  'GaddChatRoomUserData_addChatRoomUser', 'G__typename'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GaddChatRoomUserData_addChatRoomUser', 'userId'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GaddChatRoomUserData_addChatRoomUser', 'chatId'),
              role: BuiltValueNullFieldError.checkNotNull(
                  role, 'GaddChatRoomUserData_addChatRoomUser', 'role'),
              user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GaddChatRoomUserData_addChatRoomUser',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GaddChatRoomUserData_addChatRoomUser_user
    extends GaddChatRoomUserData_addChatRoomUser_user {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;

  factory _$GaddChatRoomUserData_addChatRoomUser_user(
          [void Function(GaddChatRoomUserData_addChatRoomUser_userBuilder)?
              updates]) =>
      (new GaddChatRoomUserData_addChatRoomUser_userBuilder()..update(updates))
          .build();

  _$GaddChatRoomUserData_addChatRoomUser_user._(
      {required this.G__typename, required this.id, this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        'GaddChatRoomUserData_addChatRoomUser_user', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GaddChatRoomUserData_addChatRoomUser_user', 'id');
  }

  @override
  GaddChatRoomUserData_addChatRoomUser_user rebuild(
          void Function(GaddChatRoomUserData_addChatRoomUser_userBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GaddChatRoomUserData_addChatRoomUser_userBuilder toBuilder() =>
      new GaddChatRoomUserData_addChatRoomUser_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GaddChatRoomUserData_addChatRoomUser_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            'GaddChatRoomUserData_addChatRoomUser_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GaddChatRoomUserData_addChatRoomUser_userBuilder
    implements
        Builder<GaddChatRoomUserData_addChatRoomUser_user,
            GaddChatRoomUserData_addChatRoomUser_userBuilder> {
  _$GaddChatRoomUserData_addChatRoomUser_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GaddChatRoomUserData_addChatRoomUser_userBuilder() {
    GaddChatRoomUserData_addChatRoomUser_user._initializeBuilder(this);
  }

  GaddChatRoomUserData_addChatRoomUser_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GaddChatRoomUserData_addChatRoomUser_user other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GaddChatRoomUserData_addChatRoomUser_user;
  }

  @override
  void update(
      void Function(GaddChatRoomUserData_addChatRoomUser_userBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GaddChatRoomUserData_addChatRoomUser_user build() {
    final _$result = _$v ??
        new _$GaddChatRoomUserData_addChatRoomUser_user._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                'GaddChatRoomUserData_addChatRoomUser_user', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GaddChatRoomUserData_addChatRoomUser_user', 'id'),
            name: name);
    replace(_$result);
    return _$result;
  }
}

class _$GdeleteChatRoomUserData extends GdeleteChatRoomUserData {
  @override
  final String G__typename;
  @override
  final bool deleteChatRoomUser;

  factory _$GdeleteChatRoomUserData(
          [void Function(GdeleteChatRoomUserDataBuilder)? updates]) =>
      (new GdeleteChatRoomUserDataBuilder()..update(updates)).build();

  _$GdeleteChatRoomUserData._(
      {required this.G__typename, required this.deleteChatRoomUser})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GdeleteChatRoomUserData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        deleteChatRoomUser, 'GdeleteChatRoomUserData', 'deleteChatRoomUser');
  }

  @override
  GdeleteChatRoomUserData rebuild(
          void Function(GdeleteChatRoomUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GdeleteChatRoomUserDataBuilder toBuilder() =>
      new GdeleteChatRoomUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GdeleteChatRoomUserData &&
        G__typename == other.G__typename &&
        deleteChatRoomUser == other.deleteChatRoomUser;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, G__typename.hashCode), deleteChatRoomUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GdeleteChatRoomUserData')
          ..add('G__typename', G__typename)
          ..add('deleteChatRoomUser', deleteChatRoomUser))
        .toString();
  }
}

class GdeleteChatRoomUserDataBuilder
    implements
        Builder<GdeleteChatRoomUserData, GdeleteChatRoomUserDataBuilder> {
  _$GdeleteChatRoomUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _deleteChatRoomUser;
  bool? get deleteChatRoomUser => _$this._deleteChatRoomUser;
  set deleteChatRoomUser(bool? deleteChatRoomUser) =>
      _$this._deleteChatRoomUser = deleteChatRoomUser;

  GdeleteChatRoomUserDataBuilder() {
    GdeleteChatRoomUserData._initializeBuilder(this);
  }

  GdeleteChatRoomUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteChatRoomUser = $v.deleteChatRoomUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GdeleteChatRoomUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GdeleteChatRoomUserData;
  }

  @override
  void update(void Function(GdeleteChatRoomUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GdeleteChatRoomUserData build() {
    final _$result = _$v ??
        new _$GdeleteChatRoomUserData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GdeleteChatRoomUserData', 'G__typename'),
            deleteChatRoomUser: BuiltValueNullFieldError.checkNotNull(
                deleteChatRoomUser,
                'GdeleteChatRoomUserData',
                'deleteChatRoomUser'));
    replace(_$result);
    return _$result;
  }
}

class _$GUserChatData extends GUserChatData {
  @override
  final String G__typename;
  @override
  final int userId;
  @override
  final int chatId;
  @override
  final _i2.GChatRoomUserRole role;
  @override
  final GUserChatData_user user;

  factory _$GUserChatData([void Function(GUserChatDataBuilder)? updates]) =>
      (new GUserChatDataBuilder()..update(updates)).build();

  _$GUserChatData._(
      {required this.G__typename,
      required this.userId,
      required this.chatId,
      required this.role,
      required this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GUserChatData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(userId, 'GUserChatData', 'userId');
    BuiltValueNullFieldError.checkNotNull(chatId, 'GUserChatData', 'chatId');
    BuiltValueNullFieldError.checkNotNull(role, 'GUserChatData', 'role');
    BuiltValueNullFieldError.checkNotNull(user, 'GUserChatData', 'user');
  }

  @override
  GUserChatData rebuild(void Function(GUserChatDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserChatDataBuilder toBuilder() => new GUserChatDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserChatData &&
        G__typename == other.G__typename &&
        userId == other.userId &&
        chatId == other.chatId &&
        role == other.role &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, G__typename.hashCode), userId.hashCode),
                chatId.hashCode),
            role.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GUserChatData')
          ..add('G__typename', G__typename)
          ..add('userId', userId)
          ..add('chatId', chatId)
          ..add('role', role)
          ..add('user', user))
        .toString();
  }
}

class GUserChatDataBuilder
    implements Builder<GUserChatData, GUserChatDataBuilder> {
  _$GUserChatData? _$v;

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

  GUserChatData_userBuilder? _user;
  GUserChatData_userBuilder get user =>
      _$this._user ??= new GUserChatData_userBuilder();
  set user(GUserChatData_userBuilder? user) => _$this._user = user;

  GUserChatDataBuilder() {
    GUserChatData._initializeBuilder(this);
  }

  GUserChatDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userId = $v.userId;
      _chatId = $v.chatId;
      _role = $v.role;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserChatData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUserChatData;
  }

  @override
  void update(void Function(GUserChatDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GUserChatData build() {
    _$GUserChatData _$result;
    try {
      _$result = _$v ??
          new _$GUserChatData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GUserChatData', 'G__typename'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GUserChatData', 'userId'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GUserChatData', 'chatId'),
              role: BuiltValueNullFieldError.checkNotNull(
                  role, 'GUserChatData', 'role'),
              user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GUserChatData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserChatData_user extends GUserChatData_user {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;

  factory _$GUserChatData_user(
          [void Function(GUserChatData_userBuilder)? updates]) =>
      (new GUserChatData_userBuilder()..update(updates)).build();

  _$GUserChatData_user._(
      {required this.G__typename, required this.id, this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GUserChatData_user', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(id, 'GUserChatData_user', 'id');
  }

  @override
  GUserChatData_user rebuild(
          void Function(GUserChatData_userBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserChatData_userBuilder toBuilder() =>
      new GUserChatData_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserChatData_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GUserChatData_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GUserChatData_userBuilder
    implements Builder<GUserChatData_user, GUserChatData_userBuilder> {
  _$GUserChatData_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GUserChatData_userBuilder() {
    GUserChatData_user._initializeBuilder(this);
  }

  GUserChatData_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserChatData_user other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUserChatData_user;
  }

  @override
  void update(void Function(GUserChatData_userBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GUserChatData_user build() {
    final _$result = _$v ??
        new _$GUserChatData_user._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GUserChatData_user', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GUserChatData_user', 'id'),
            name: name);
    replace(_$result);
    return _$result;
  }
}

class _$GFullChatRoomData extends GFullChatRoomData {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String name;
  @override
  final _i2.GDate createdAt;
  @override
  final BuiltList<GFullChatRoomData_users> users;

  factory _$GFullChatRoomData(
          [void Function(GFullChatRoomDataBuilder)? updates]) =>
      (new GFullChatRoomDataBuilder()..update(updates)).build();

  _$GFullChatRoomData._(
      {required this.G__typename,
      required this.id,
      required this.name,
      required this.createdAt,
      required this.users})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GFullChatRoomData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(id, 'GFullChatRoomData', 'id');
    BuiltValueNullFieldError.checkNotNull(name, 'GFullChatRoomData', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'GFullChatRoomData', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(users, 'GFullChatRoomData', 'users');
  }

  @override
  GFullChatRoomData rebuild(void Function(GFullChatRoomDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFullChatRoomDataBuilder toBuilder() =>
      new GFullChatRoomDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFullChatRoomData &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        createdAt == other.createdAt &&
        users == other.users;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode),
            createdAt.hashCode),
        users.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GFullChatRoomData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('createdAt', createdAt)
          ..add('users', users))
        .toString();
  }
}

class GFullChatRoomDataBuilder
    implements Builder<GFullChatRoomData, GFullChatRoomDataBuilder> {
  _$GFullChatRoomData? _$v;

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

  ListBuilder<GFullChatRoomData_users>? _users;
  ListBuilder<GFullChatRoomData_users> get users =>
      _$this._users ??= new ListBuilder<GFullChatRoomData_users>();
  set users(ListBuilder<GFullChatRoomData_users>? users) =>
      _$this._users = users;

  GFullChatRoomDataBuilder() {
    GFullChatRoomData._initializeBuilder(this);
  }

  GFullChatRoomDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _createdAt = $v.createdAt.toBuilder();
      _users = $v.users.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFullChatRoomData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFullChatRoomData;
  }

  @override
  void update(void Function(GFullChatRoomDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GFullChatRoomData build() {
    _$GFullChatRoomData _$result;
    try {
      _$result = _$v ??
          new _$GFullChatRoomData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GFullChatRoomData', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GFullChatRoomData', 'id'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'GFullChatRoomData', 'name'),
              createdAt: createdAt.build(),
              users: users.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'users';
        users.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GFullChatRoomData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFullChatRoomData_users extends GFullChatRoomData_users {
  @override
  final String G__typename;
  @override
  final int userId;
  @override
  final int chatId;
  @override
  final _i2.GChatRoomUserRole role;
  @override
  final GFullChatRoomData_users_user user;

  factory _$GFullChatRoomData_users(
          [void Function(GFullChatRoomData_usersBuilder)? updates]) =>
      (new GFullChatRoomData_usersBuilder()..update(updates)).build();

  _$GFullChatRoomData_users._(
      {required this.G__typename,
      required this.userId,
      required this.chatId,
      required this.role,
      required this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GFullChatRoomData_users', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        userId, 'GFullChatRoomData_users', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        chatId, 'GFullChatRoomData_users', 'chatId');
    BuiltValueNullFieldError.checkNotNull(
        role, 'GFullChatRoomData_users', 'role');
    BuiltValueNullFieldError.checkNotNull(
        user, 'GFullChatRoomData_users', 'user');
  }

  @override
  GFullChatRoomData_users rebuild(
          void Function(GFullChatRoomData_usersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFullChatRoomData_usersBuilder toBuilder() =>
      new GFullChatRoomData_usersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFullChatRoomData_users &&
        G__typename == other.G__typename &&
        userId == other.userId &&
        chatId == other.chatId &&
        role == other.role &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, G__typename.hashCode), userId.hashCode),
                chatId.hashCode),
            role.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GFullChatRoomData_users')
          ..add('G__typename', G__typename)
          ..add('userId', userId)
          ..add('chatId', chatId)
          ..add('role', role)
          ..add('user', user))
        .toString();
  }
}

class GFullChatRoomData_usersBuilder
    implements
        Builder<GFullChatRoomData_users, GFullChatRoomData_usersBuilder> {
  _$GFullChatRoomData_users? _$v;

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

  GFullChatRoomData_users_userBuilder? _user;
  GFullChatRoomData_users_userBuilder get user =>
      _$this._user ??= new GFullChatRoomData_users_userBuilder();
  set user(GFullChatRoomData_users_userBuilder? user) => _$this._user = user;

  GFullChatRoomData_usersBuilder() {
    GFullChatRoomData_users._initializeBuilder(this);
  }

  GFullChatRoomData_usersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userId = $v.userId;
      _chatId = $v.chatId;
      _role = $v.role;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFullChatRoomData_users other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFullChatRoomData_users;
  }

  @override
  void update(void Function(GFullChatRoomData_usersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GFullChatRoomData_users build() {
    _$GFullChatRoomData_users _$result;
    try {
      _$result = _$v ??
          new _$GFullChatRoomData_users._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, 'GFullChatRoomData_users', 'G__typename'),
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, 'GFullChatRoomData_users', 'userId'),
              chatId: BuiltValueNullFieldError.checkNotNull(
                  chatId, 'GFullChatRoomData_users', 'chatId'),
              role: BuiltValueNullFieldError.checkNotNull(
                  role, 'GFullChatRoomData_users', 'role'),
              user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GFullChatRoomData_users', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFullChatRoomData_users_user extends GFullChatRoomData_users_user {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String? name;

  factory _$GFullChatRoomData_users_user(
          [void Function(GFullChatRoomData_users_userBuilder)? updates]) =>
      (new GFullChatRoomData_users_userBuilder()..update(updates)).build();

  _$GFullChatRoomData_users_user._(
      {required this.G__typename, required this.id, this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, 'GFullChatRoomData_users_user', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GFullChatRoomData_users_user', 'id');
  }

  @override
  GFullChatRoomData_users_user rebuild(
          void Function(GFullChatRoomData_users_userBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFullChatRoomData_users_userBuilder toBuilder() =>
      new GFullChatRoomData_users_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFullChatRoomData_users_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, G__typename.hashCode), id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GFullChatRoomData_users_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GFullChatRoomData_users_userBuilder
    implements
        Builder<GFullChatRoomData_users_user,
            GFullChatRoomData_users_userBuilder> {
  _$GFullChatRoomData_users_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GFullChatRoomData_users_userBuilder() {
    GFullChatRoomData_users_user._initializeBuilder(this);
  }

  GFullChatRoomData_users_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFullChatRoomData_users_user other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFullChatRoomData_users_user;
  }

  @override
  void update(void Function(GFullChatRoomData_users_userBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GFullChatRoomData_users_user build() {
    final _$result = _$v ??
        new _$GFullChatRoomData_users_user._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, 'GFullChatRoomData_users_user', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GFullChatRoomData_users_user', 'id'),
            name: name);
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
