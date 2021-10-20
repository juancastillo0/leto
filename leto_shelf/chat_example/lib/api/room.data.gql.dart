// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/api/user.data.gql.dart' as _i3;
import 'package:chat_example/api_schema.schema.gql.dart' as _i2;
import 'package:chat_example/serializers.gql.dart' as _i1;

part 'room.data.gql.g.dart';

abstract class GcreateRoomData
    implements Built<GcreateRoomData, GcreateRoomDataBuilder> {
  GcreateRoomData._();

  factory GcreateRoomData([Function(GcreateRoomDataBuilder b) updates]) =
      _$GcreateRoomData;

  static void _initializeBuilder(GcreateRoomDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GcreateRoomData_createChatRoom? get createChatRoom;
  static Serializer<GcreateRoomData> get serializer =>
      _$gcreateRoomDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GcreateRoomData.serializer, this)
          as Map<String, dynamic>);
  static GcreateRoomData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GcreateRoomData.serializer, json);
}

abstract class GcreateRoomData_createChatRoom
    implements
        Built<GcreateRoomData_createChatRoom,
            GcreateRoomData_createChatRoomBuilder>,
        GBaseChatRoom {
  GcreateRoomData_createChatRoom._();

  factory GcreateRoomData_createChatRoom(
          [Function(GcreateRoomData_createChatRoomBuilder b) updates]) =
      _$GcreateRoomData_createChatRoom;

  static void _initializeBuilder(GcreateRoomData_createChatRoomBuilder b) =>
      b..G__typename = 'ChatRoom';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get name;
  _i2.GDate get createdAt;
  static Serializer<GcreateRoomData_createChatRoom> get serializer =>
      _$gcreateRoomDataCreateChatRoomSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      GcreateRoomData_createChatRoom.serializer, this) as Map<String, dynamic>);
  static GcreateRoomData_createChatRoom? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GcreateRoomData_createChatRoom.serializer, json);
}

abstract class GdeleteRoomData
    implements Built<GdeleteRoomData, GdeleteRoomDataBuilder> {
  GdeleteRoomData._();

  factory GdeleteRoomData([Function(GdeleteRoomDataBuilder b) updates]) =
      _$GdeleteRoomData;

  static void _initializeBuilder(GdeleteRoomDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get deleteChatRoom;
  static Serializer<GdeleteRoomData> get serializer =>
      _$gdeleteRoomDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GdeleteRoomData.serializer, this)
          as Map<String, dynamic>);
  static GdeleteRoomData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GdeleteRoomData.serializer, json);
}

abstract class GgetRoomsData
    implements Built<GgetRoomsData, GgetRoomsDataBuilder> {
  GgetRoomsData._();

  factory GgetRoomsData([Function(GgetRoomsDataBuilder b) updates]) =
      _$GgetRoomsData;

  static void _initializeBuilder(GgetRoomsDataBuilder b) =>
      b..G__typename = 'Query';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GgetRoomsData_getChatRooms> get getChatRooms;
  static Serializer<GgetRoomsData> get serializer => _$ggetRoomsDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GgetRoomsData.serializer, this)
          as Map<String, dynamic>);
  static GgetRoomsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GgetRoomsData.serializer, json);
}

abstract class GgetRoomsData_getChatRooms
    implements
        Built<GgetRoomsData_getChatRooms, GgetRoomsData_getChatRoomsBuilder>,
        GFullChatRoom {
  GgetRoomsData_getChatRooms._();

  factory GgetRoomsData_getChatRooms(
          [Function(GgetRoomsData_getChatRoomsBuilder b) updates]) =
      _$GgetRoomsData_getChatRooms;

  static void _initializeBuilder(GgetRoomsData_getChatRoomsBuilder b) =>
      b..G__typename = 'ChatRoom';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get name;
  _i2.GDate get createdAt;
  BuiltList<GgetRoomsData_getChatRooms_users> get users;
  static Serializer<GgetRoomsData_getChatRooms> get serializer =>
      _$ggetRoomsDataGetChatRoomsSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      GgetRoomsData_getChatRooms.serializer, this) as Map<String, dynamic>);
  static GgetRoomsData_getChatRooms? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GgetRoomsData_getChatRooms.serializer, json);
}

abstract class GgetRoomsData_getChatRooms_users
    implements
        Built<GgetRoomsData_getChatRooms_users,
            GgetRoomsData_getChatRooms_usersBuilder>,
        GFullChatRoom_users,
        GUserChat {
  GgetRoomsData_getChatRooms_users._();

  factory GgetRoomsData_getChatRooms_users(
          [Function(GgetRoomsData_getChatRooms_usersBuilder b) updates]) =
      _$GgetRoomsData_getChatRooms_users;

  static void _initializeBuilder(GgetRoomsData_getChatRooms_usersBuilder b) =>
      b..G__typename = 'ChatRoomUser';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get userId;
  int get chatId;
  _i2.GChatRoomUserRole get role;
  GgetRoomsData_getChatRooms_users_user get user;
  static Serializer<GgetRoomsData_getChatRooms_users> get serializer =>
      _$ggetRoomsDataGetChatRoomsUsersSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GgetRoomsData_getChatRooms_users.serializer, this)
      as Map<String, dynamic>);
  static GgetRoomsData_getChatRooms_users? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GgetRoomsData_getChatRooms_users.serializer, json);
}

abstract class GgetRoomsData_getChatRooms_users_user
    implements
        Built<GgetRoomsData_getChatRooms_users_user,
            GgetRoomsData_getChatRooms_users_userBuilder>,
        GFullChatRoom_users_user,
        GUserChat_user,
        _i3.GAUser {
  GgetRoomsData_getChatRooms_users_user._();

  factory GgetRoomsData_getChatRooms_users_user(
          [Function(GgetRoomsData_getChatRooms_users_userBuilder b) updates]) =
      _$GgetRoomsData_getChatRooms_users_user;

  static void _initializeBuilder(
          GgetRoomsData_getChatRooms_users_userBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GgetRoomsData_getChatRooms_users_user> get serializer =>
      _$ggetRoomsDataGetChatRoomsUsersUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GgetRoomsData_getChatRooms_users_user.serializer, this)
      as Map<String, dynamic>);
  static GgetRoomsData_getChatRooms_users_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GgetRoomsData_getChatRooms_users_user.serializer, json);
}

abstract class GsearchUserData
    implements Built<GsearchUserData, GsearchUserDataBuilder> {
  GsearchUserData._();

  factory GsearchUserData([Function(GsearchUserDataBuilder b) updates]) =
      _$GsearchUserData;

  static void _initializeBuilder(GsearchUserDataBuilder b) =>
      b..G__typename = 'Query';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GsearchUserData_searchUser> get searchUser;
  static Serializer<GsearchUserData> get serializer =>
      _$gsearchUserDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsearchUserData.serializer, this)
          as Map<String, dynamic>);
  static GsearchUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsearchUserData.serializer, json);
}

abstract class GsearchUserData_searchUser
    implements
        Built<GsearchUserData_searchUser, GsearchUserData_searchUserBuilder>,
        _i3.GAUser {
  GsearchUserData_searchUser._();

  factory GsearchUserData_searchUser(
          [Function(GsearchUserData_searchUserBuilder b) updates]) =
      _$GsearchUserData_searchUser;

  static void _initializeBuilder(GsearchUserData_searchUserBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GsearchUserData_searchUser> get serializer =>
      _$gsearchUserDataSearchUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      GsearchUserData_searchUser.serializer, this) as Map<String, dynamic>);
  static GsearchUserData_searchUser? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GsearchUserData_searchUser.serializer, json);
}

abstract class GaddChatRoomUserData
    implements Built<GaddChatRoomUserData, GaddChatRoomUserDataBuilder> {
  GaddChatRoomUserData._();

  factory GaddChatRoomUserData(
          [Function(GaddChatRoomUserDataBuilder b) updates]) =
      _$GaddChatRoomUserData;

  static void _initializeBuilder(GaddChatRoomUserDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GaddChatRoomUserData_addChatRoomUser? get addChatRoomUser;
  static Serializer<GaddChatRoomUserData> get serializer =>
      _$gaddChatRoomUserDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GaddChatRoomUserData.serializer, this)
          as Map<String, dynamic>);
  static GaddChatRoomUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GaddChatRoomUserData.serializer, json);
}

abstract class GaddChatRoomUserData_addChatRoomUser
    implements
        Built<GaddChatRoomUserData_addChatRoomUser,
            GaddChatRoomUserData_addChatRoomUserBuilder>,
        GUserChat {
  GaddChatRoomUserData_addChatRoomUser._();

  factory GaddChatRoomUserData_addChatRoomUser(
          [Function(GaddChatRoomUserData_addChatRoomUserBuilder b) updates]) =
      _$GaddChatRoomUserData_addChatRoomUser;

  static void _initializeBuilder(
          GaddChatRoomUserData_addChatRoomUserBuilder b) =>
      b..G__typename = 'ChatRoomUser';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get userId;
  int get chatId;
  _i2.GChatRoomUserRole get role;
  GaddChatRoomUserData_addChatRoomUser_user get user;
  static Serializer<GaddChatRoomUserData_addChatRoomUser> get serializer =>
      _$gaddChatRoomUserDataAddChatRoomUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GaddChatRoomUserData_addChatRoomUser.serializer, this)
      as Map<String, dynamic>);
  static GaddChatRoomUserData_addChatRoomUser? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GaddChatRoomUserData_addChatRoomUser.serializer, json);
}

abstract class GaddChatRoomUserData_addChatRoomUser_user
    implements
        Built<GaddChatRoomUserData_addChatRoomUser_user,
            GaddChatRoomUserData_addChatRoomUser_userBuilder>,
        GUserChat_user,
        _i3.GAUser {
  GaddChatRoomUserData_addChatRoomUser_user._();

  factory GaddChatRoomUserData_addChatRoomUser_user(
      [Function(GaddChatRoomUserData_addChatRoomUser_userBuilder b)
          updates]) = _$GaddChatRoomUserData_addChatRoomUser_user;

  static void _initializeBuilder(
          GaddChatRoomUserData_addChatRoomUser_userBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GaddChatRoomUserData_addChatRoomUser_user> get serializer =>
      _$gaddChatRoomUserDataAddChatRoomUserUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          GaddChatRoomUserData_addChatRoomUser_user.serializer, this)
      as Map<String, dynamic>);
  static GaddChatRoomUserData_addChatRoomUser_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GaddChatRoomUserData_addChatRoomUser_user.serializer, json);
}

abstract class GdeleteChatRoomUserData
    implements Built<GdeleteChatRoomUserData, GdeleteChatRoomUserDataBuilder> {
  GdeleteChatRoomUserData._();

  factory GdeleteChatRoomUserData(
          [Function(GdeleteChatRoomUserDataBuilder b) updates]) =
      _$GdeleteChatRoomUserData;

  static void _initializeBuilder(GdeleteChatRoomUserDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get deleteChatRoomUser;
  static Serializer<GdeleteChatRoomUserData> get serializer =>
      _$gdeleteChatRoomUserDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GdeleteChatRoomUserData.serializer, this)
          as Map<String, dynamic>);
  static GdeleteChatRoomUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GdeleteChatRoomUserData.serializer, json);
}

abstract class GUserChat {
  String get G__typename;
  int get userId;
  int get chatId;
  _i2.GChatRoomUserRole get role;
  GUserChat_user get user;
  Map<String, dynamic> toJson();
}

abstract class GUserChat_user implements _i3.GAUser {
  String get G__typename;
  int get id;
  String? get name;
  Map<String, dynamic> toJson();
}

abstract class GUserChatData
    implements Built<GUserChatData, GUserChatDataBuilder>, GUserChat {
  GUserChatData._();

  factory GUserChatData([Function(GUserChatDataBuilder b) updates]) =
      _$GUserChatData;

  static void _initializeBuilder(GUserChatDataBuilder b) =>
      b..G__typename = 'ChatRoomUser';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get userId;
  int get chatId;
  _i2.GChatRoomUserRole get role;
  GUserChatData_user get user;
  static Serializer<GUserChatData> get serializer => _$gUserChatDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GUserChatData.serializer, this)
          as Map<String, dynamic>);
  static GUserChatData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GUserChatData.serializer, json);
}

abstract class GUserChatData_user
    implements
        Built<GUserChatData_user, GUserChatData_userBuilder>,
        GUserChat_user,
        _i3.GAUser {
  GUserChatData_user._();

  factory GUserChatData_user([Function(GUserChatData_userBuilder b) updates]) =
      _$GUserChatData_user;

  static void _initializeBuilder(GUserChatData_userBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GUserChatData_user> get serializer =>
      _$gUserChatDataUserSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GUserChatData_user.serializer, this)
          as Map<String, dynamic>);
  static GUserChatData_user? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GUserChatData_user.serializer, json);
}

abstract class GFullChatRoom implements GBaseChatRoom {
  String get G__typename;
  int get id;
  String get name;
  _i2.GDate get createdAt;
  BuiltList<GFullChatRoom_users> get users;
  Map<String, dynamic> toJson();
}

abstract class GFullChatRoom_users implements GUserChat {
  String get G__typename;
  int get userId;
  int get chatId;
  _i2.GChatRoomUserRole get role;
  GFullChatRoom_users_user get user;
  Map<String, dynamic> toJson();
}

abstract class GFullChatRoom_users_user implements GUserChat_user, _i3.GAUser {
  String get G__typename;
  int get id;
  String? get name;
  Map<String, dynamic> toJson();
}

abstract class GFullChatRoomData
    implements
        Built<GFullChatRoomData, GFullChatRoomDataBuilder>,
        GFullChatRoom,
        GBaseChatRoom {
  GFullChatRoomData._();

  factory GFullChatRoomData([Function(GFullChatRoomDataBuilder b) updates]) =
      _$GFullChatRoomData;

  static void _initializeBuilder(GFullChatRoomDataBuilder b) =>
      b..G__typename = 'ChatRoom';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get name;
  _i2.GDate get createdAt;
  BuiltList<GFullChatRoomData_users> get users;
  static Serializer<GFullChatRoomData> get serializer =>
      _$gFullChatRoomDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GFullChatRoomData.serializer, this)
          as Map<String, dynamic>);
  static GFullChatRoomData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GFullChatRoomData.serializer, json);
}

abstract class GFullChatRoomData_users
    implements
        Built<GFullChatRoomData_users, GFullChatRoomData_usersBuilder>,
        GFullChatRoom_users,
        GUserChat {
  GFullChatRoomData_users._();

  factory GFullChatRoomData_users(
          [Function(GFullChatRoomData_usersBuilder b) updates]) =
      _$GFullChatRoomData_users;

  static void _initializeBuilder(GFullChatRoomData_usersBuilder b) =>
      b..G__typename = 'ChatRoomUser';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get userId;
  int get chatId;
  _i2.GChatRoomUserRole get role;
  GFullChatRoomData_users_user get user;
  static Serializer<GFullChatRoomData_users> get serializer =>
      _$gFullChatRoomDataUsersSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GFullChatRoomData_users.serializer, this)
          as Map<String, dynamic>);
  static GFullChatRoomData_users? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GFullChatRoomData_users.serializer, json);
}

abstract class GFullChatRoomData_users_user
    implements
        Built<GFullChatRoomData_users_user,
            GFullChatRoomData_users_userBuilder>,
        GFullChatRoom_users_user,
        GUserChat_user,
        _i3.GAUser {
  GFullChatRoomData_users_user._();

  factory GFullChatRoomData_users_user(
          [Function(GFullChatRoomData_users_userBuilder b) updates]) =
      _$GFullChatRoomData_users_user;

  static void _initializeBuilder(GFullChatRoomData_users_userBuilder b) =>
      b..G__typename = 'User';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String? get name;
  static Serializer<GFullChatRoomData_users_user> get serializer =>
      _$gFullChatRoomDataUsersUserSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      GFullChatRoomData_users_user.serializer, this) as Map<String, dynamic>);
  static GFullChatRoomData_users_user? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GFullChatRoomData_users_user.serializer, json);
}

abstract class GBaseChatRoom {
  String get G__typename;
  int get id;
  String get name;
  _i2.GDate get createdAt;
  Map<String, dynamic> toJson();
}

abstract class GBaseChatRoomData
    implements
        Built<GBaseChatRoomData, GBaseChatRoomDataBuilder>,
        GBaseChatRoom {
  GBaseChatRoomData._();

  factory GBaseChatRoomData([Function(GBaseChatRoomDataBuilder b) updates]) =
      _$GBaseChatRoomData;

  static void _initializeBuilder(GBaseChatRoomDataBuilder b) =>
      b..G__typename = 'ChatRoom';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get name;
  _i2.GDate get createdAt;
  static Serializer<GBaseChatRoomData> get serializer =>
      _$gBaseChatRoomDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GBaseChatRoomData.serializer, this)
          as Map<String, dynamic>);
  static GBaseChatRoomData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GBaseChatRoomData.serializer, json);
}
