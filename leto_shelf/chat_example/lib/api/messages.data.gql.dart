// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/api_schema.schema.gql.dart' as _i2;
import 'package:chat_example/serializers.gql.dart' as _i1;

part 'messages.data.gql.g.dart';

abstract class GgetMessagesData
    implements Built<GgetMessagesData, GgetMessagesDataBuilder> {
  GgetMessagesData._();

  factory GgetMessagesData([Function(GgetMessagesDataBuilder b) updates]) =
      _$GgetMessagesData;

  static void _initializeBuilder(GgetMessagesDataBuilder b) =>
      b..G__typename = 'Query';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GgetMessagesData_getMessage> get getMessage;
  static Serializer<GgetMessagesData> get serializer =>
      _$ggetMessagesDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GgetMessagesData.serializer, this)
          as Map<String, dynamic>);
  static GgetMessagesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GgetMessagesData.serializer, json);
}

abstract class GgetMessagesData_getMessage
    implements
        Built<GgetMessagesData_getMessage, GgetMessagesData_getMessageBuilder>,
        GFullMessage {
  GgetMessagesData_getMessage._();

  factory GgetMessagesData_getMessage(
          [Function(GgetMessagesData_getMessageBuilder b) updates]) =
      _$GgetMessagesData_getMessage;

  static void _initializeBuilder(GgetMessagesData_getMessageBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get chatId;
  int get userId;
  String get message;
  _i2.GDate get createdAt;
  GgetMessagesData_getMessage_referencedMessage? get referencedMessage;
  static Serializer<GgetMessagesData_getMessage> get serializer =>
      _$ggetMessagesDataGetMessageSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      GgetMessagesData_getMessage.serializer, this) as Map<String, dynamic>);
  static GgetMessagesData_getMessage? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GgetMessagesData_getMessage.serializer, json);
}

abstract class GgetMessagesData_getMessage_referencedMessage
    implements
        Built<GgetMessagesData_getMessage_referencedMessage,
            GgetMessagesData_getMessage_referencedMessageBuilder>,
        GFullMessage_referencedMessage {
  GgetMessagesData_getMessage_referencedMessage._();

  factory GgetMessagesData_getMessage_referencedMessage(
      [Function(GgetMessagesData_getMessage_referencedMessageBuilder b)
          updates]) = _$GgetMessagesData_getMessage_referencedMessage;

  static void _initializeBuilder(
          GgetMessagesData_getMessage_referencedMessageBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get message;
  _i2.GDate get createdAt;
  int get chatId;
  int get userId;
  static Serializer<GgetMessagesData_getMessage_referencedMessage>
      get serializer => _$ggetMessagesDataGetMessageReferencedMessageSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          GgetMessagesData_getMessage_referencedMessage.serializer, this)
      as Map<String, dynamic>);
  static GgetMessagesData_getMessage_referencedMessage? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GgetMessagesData_getMessage_referencedMessage.serializer, json);
}

abstract class GsendMessageData
    implements Built<GsendMessageData, GsendMessageDataBuilder> {
  GsendMessageData._();

  factory GsendMessageData([Function(GsendMessageDataBuilder b) updates]) =
      _$GsendMessageData;

  static void _initializeBuilder(GsendMessageDataBuilder b) =>
      b..G__typename = 'Mutation';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GsendMessageData_sendMessage? get sendMessage;
  static Serializer<GsendMessageData> get serializer =>
      _$gsendMessageDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsendMessageData.serializer, this)
          as Map<String, dynamic>);
  static GsendMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsendMessageData.serializer, json);
}

abstract class GsendMessageData_sendMessage
    implements
        Built<GsendMessageData_sendMessage,
            GsendMessageData_sendMessageBuilder>,
        GFullMessage {
  GsendMessageData_sendMessage._();

  factory GsendMessageData_sendMessage(
          [Function(GsendMessageData_sendMessageBuilder b) updates]) =
      _$GsendMessageData_sendMessage;

  static void _initializeBuilder(GsendMessageData_sendMessageBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get chatId;
  int get userId;
  String get message;
  _i2.GDate get createdAt;
  GsendMessageData_sendMessage_referencedMessage? get referencedMessage;
  static Serializer<GsendMessageData_sendMessage> get serializer =>
      _$gsendMessageDataSendMessageSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      GsendMessageData_sendMessage.serializer, this) as Map<String, dynamic>);
  static GsendMessageData_sendMessage? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GsendMessageData_sendMessage.serializer, json);
}

abstract class GsendMessageData_sendMessage_referencedMessage
    implements
        Built<GsendMessageData_sendMessage_referencedMessage,
            GsendMessageData_sendMessage_referencedMessageBuilder>,
        GFullMessage_referencedMessage {
  GsendMessageData_sendMessage_referencedMessage._();

  factory GsendMessageData_sendMessage_referencedMessage(
      [Function(GsendMessageData_sendMessage_referencedMessageBuilder b)
          updates]) = _$GsendMessageData_sendMessage_referencedMessage;

  static void _initializeBuilder(
          GsendMessageData_sendMessage_referencedMessageBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get message;
  _i2.GDate get createdAt;
  int get chatId;
  int get userId;
  static Serializer<GsendMessageData_sendMessage_referencedMessage>
      get serializer =>
          _$gsendMessageDataSendMessageReferencedMessageSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          GsendMessageData_sendMessage_referencedMessage.serializer, this)
      as Map<String, dynamic>);
  static GsendMessageData_sendMessage_referencedMessage? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GsendMessageData_sendMessage_referencedMessage.serializer, json);
}

abstract class GonMessageSentData
    implements Built<GonMessageSentData, GonMessageSentDataBuilder> {
  GonMessageSentData._();

  factory GonMessageSentData([Function(GonMessageSentDataBuilder b) updates]) =
      _$GonMessageSentData;

  static void _initializeBuilder(GonMessageSentDataBuilder b) =>
      b..G__typename = 'Subscription';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GonMessageSentData_onMessageSent> get onMessageSent;
  static Serializer<GonMessageSentData> get serializer =>
      _$gonMessageSentDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GonMessageSentData.serializer, this)
          as Map<String, dynamic>);
  static GonMessageSentData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GonMessageSentData.serializer, json);
}

abstract class GonMessageSentData_onMessageSent
    implements
        Built<GonMessageSentData_onMessageSent,
            GonMessageSentData_onMessageSentBuilder>,
        GFullMessage {
  GonMessageSentData_onMessageSent._();

  factory GonMessageSentData_onMessageSent(
          [Function(GonMessageSentData_onMessageSentBuilder b) updates]) =
      _$GonMessageSentData_onMessageSent;

  static void _initializeBuilder(GonMessageSentData_onMessageSentBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get chatId;
  int get userId;
  String get message;
  _i2.GDate get createdAt;
  GonMessageSentData_onMessageSent_referencedMessage? get referencedMessage;
  static Serializer<GonMessageSentData_onMessageSent> get serializer =>
      _$gonMessageSentDataOnMessageSentSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GonMessageSentData_onMessageSent.serializer, this)
      as Map<String, dynamic>);
  static GonMessageSentData_onMessageSent? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GonMessageSentData_onMessageSent.serializer, json);
}

abstract class GonMessageSentData_onMessageSent_referencedMessage
    implements
        Built<GonMessageSentData_onMessageSent_referencedMessage,
            GonMessageSentData_onMessageSent_referencedMessageBuilder>,
        GFullMessage_referencedMessage {
  GonMessageSentData_onMessageSent_referencedMessage._();

  factory GonMessageSentData_onMessageSent_referencedMessage(
      [Function(GonMessageSentData_onMessageSent_referencedMessageBuilder b)
          updates]) = _$GonMessageSentData_onMessageSent_referencedMessage;

  static void _initializeBuilder(
          GonMessageSentData_onMessageSent_referencedMessageBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get message;
  _i2.GDate get createdAt;
  int get chatId;
  int get userId;
  static Serializer<GonMessageSentData_onMessageSent_referencedMessage>
      get serializer =>
          _$gonMessageSentDataOnMessageSentReferencedMessageSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          GonMessageSentData_onMessageSent_referencedMessage.serializer, this)
      as Map<String, dynamic>);
  static GonMessageSentData_onMessageSent_referencedMessage? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          GonMessageSentData_onMessageSent_referencedMessage.serializer, json);
}

abstract class GFullMessage {
  String get G__typename;
  int get id;
  int get chatId;
  int get userId;
  String get message;
  _i2.GDate get createdAt;
  GFullMessage_referencedMessage? get referencedMessage;
  Map<String, dynamic> toJson();
}

abstract class GFullMessage_referencedMessage {
  String get G__typename;
  int get id;
  String get message;
  _i2.GDate get createdAt;
  int get chatId;
  int get userId;
  Map<String, dynamic> toJson();
}

abstract class GFullMessageData
    implements Built<GFullMessageData, GFullMessageDataBuilder>, GFullMessage {
  GFullMessageData._();

  factory GFullMessageData([Function(GFullMessageDataBuilder b) updates]) =
      _$GFullMessageData;

  static void _initializeBuilder(GFullMessageDataBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  int get chatId;
  int get userId;
  String get message;
  _i2.GDate get createdAt;
  GFullMessageData_referencedMessage? get referencedMessage;
  static Serializer<GFullMessageData> get serializer =>
      _$gFullMessageDataSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GFullMessageData.serializer, this)
          as Map<String, dynamic>);
  static GFullMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GFullMessageData.serializer, json);
}

abstract class GFullMessageData_referencedMessage
    implements
        Built<GFullMessageData_referencedMessage,
            GFullMessageData_referencedMessageBuilder>,
        GFullMessage_referencedMessage {
  GFullMessageData_referencedMessage._();

  factory GFullMessageData_referencedMessage(
          [Function(GFullMessageData_referencedMessageBuilder b) updates]) =
      _$GFullMessageData_referencedMessage;

  static void _initializeBuilder(GFullMessageData_referencedMessageBuilder b) =>
      b..G__typename = 'ChatMessage';
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get id;
  String get message;
  _i2.GDate get createdAt;
  int get chatId;
  int get userId;
  static Serializer<GFullMessageData_referencedMessage> get serializer =>
      _$gFullMessageDataReferencedMessageSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(GFullMessageData_referencedMessage.serializer, this)
      as Map<String, dynamic>);
  static GFullMessageData_referencedMessage? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(GFullMessageData_referencedMessage.serializer, json);
}
