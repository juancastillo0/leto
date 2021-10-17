// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/api/messages.data.gql.dart' as _i3;
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
        GBaseChatRoom {
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
  BuiltList<GgetRoomsData_getChatRooms_messages> get messages;
  BuiltList<GgetRoomsData_getChatRooms_users> get users;
  static Serializer<GgetRoomsData_getChatRooms> get serializer =>
      _$ggetRoomsDataGetChatRoomsSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      GgetRoomsData_getChatRooms.serializer, this) as Map<String, dynamic>);
  static GgetRoomsData_getChatRooms? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GgetRoomsData_getChatRooms.serializer, json);
}

abstract class GgetRoomsData_getChatRooms_messages
    implements
        Built<GgetRoomsData_getChatRooms_messages,
            GgetRoomsData_getChatRooms_messagesBuilder>,
        _i3.GFullMessage {
  GgetRoomsData_getChatRooms_messages._();

  factory GgetRoomsData_getChatRooms_messages(
          [Function(GgetRoomsData_getChatRooms_messagesBuilder b) updates]) =
      _$GgetRoomsData_getChatRooms_messages;

  static void _initializeBuilder(
          GgetRoomsData_getChatRooms_messagesBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get chatId;
  String get message;
  _i2.GDate get createdAt;
  GgetRoomsData_getChatRooms_messages_referencedMessage? get referencedMessage;
  static Serializer<GgetRoomsData_getChatRooms_messages> get serializer =>
      _$ggetRoomsDataGetChatRoomsMessagesSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GgetRoomsData_getChatRooms_messages.serializer, this)
      as Map<String, dynamic>);
  static GgetRoomsData_getChatRooms_messages? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GgetRoomsData_getChatRooms_messages.serializer, json);
}

abstract class GgetRoomsData_getChatRooms_messages_referencedMessage
    implements
        Built<GgetRoomsData_getChatRooms_messages_referencedMessage,
            GgetRoomsData_getChatRooms_messages_referencedMessageBuilder>,
        _i3.GFullMessage_referencedMessage {
  GgetRoomsData_getChatRooms_messages_referencedMessage._();

  factory GgetRoomsData_getChatRooms_messages_referencedMessage(
      [Function(GgetRoomsData_getChatRooms_messages_referencedMessageBuilder b)
          updates]) = _$GgetRoomsData_getChatRooms_messages_referencedMessage;

  static void _initializeBuilder(
          GgetRoomsData_getChatRooms_messages_referencedMessageBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get message;
  _i2.GDate get createdAt;
  int get chatId;
  static Serializer<GgetRoomsData_getChatRooms_messages_referencedMessage>
      get serializer =>
          _$ggetRoomsDataGetChatRoomsMessagesReferencedMessageSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      GgetRoomsData_getChatRooms_messages_referencedMessage.serializer,
      this) as Map<String, dynamic>);
  static GgetRoomsData_getChatRooms_messages_referencedMessage? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GgetRoomsData_getChatRooms_messages_referencedMessage.serializer,
          json);
}

abstract class GgetRoomsData_getChatRooms_users
    implements
        Built<GgetRoomsData_getChatRooms_users,
            GgetRoomsData_getChatRooms_usersBuilder> {
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
