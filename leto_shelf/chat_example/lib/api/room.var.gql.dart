// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/api_schema.schema.gql.dart' as _i2;
import 'package:chat_example/serializers.gql.dart' as _i1;

part 'room.var.gql.g.dart';

abstract class GcreateRoomVars
    implements Built<GcreateRoomVars, GcreateRoomVarsBuilder> {
  GcreateRoomVars._();

  factory GcreateRoomVars([Function(GcreateRoomVarsBuilder b) updates]) =
      _$GcreateRoomVars;

  String get name;
  static Serializer<GcreateRoomVars> get serializer =>
      _$gcreateRoomVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GcreateRoomVars.serializer, this)
          as Map<String, dynamic>);
  static GcreateRoomVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GcreateRoomVars.serializer, json);
}

abstract class GdeleteRoomVars
    implements Built<GdeleteRoomVars, GdeleteRoomVarsBuilder> {
  GdeleteRoomVars._();

  factory GdeleteRoomVars([Function(GdeleteRoomVarsBuilder b) updates]) =
      _$GdeleteRoomVars;

  int get id;
  static Serializer<GdeleteRoomVars> get serializer =>
      _$gdeleteRoomVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GdeleteRoomVars.serializer, this)
          as Map<String, dynamic>);
  static GdeleteRoomVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GdeleteRoomVars.serializer, json);
}

abstract class GgetRoomsVars
    implements Built<GgetRoomsVars, GgetRoomsVarsBuilder> {
  GgetRoomsVars._();

  factory GgetRoomsVars([Function(GgetRoomsVarsBuilder b) updates]) =
      _$GgetRoomsVars;

  static Serializer<GgetRoomsVars> get serializer => _$ggetRoomsVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GgetRoomsVars.serializer, this)
          as Map<String, dynamic>);
  static GgetRoomsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GgetRoomsVars.serializer, json);
}

abstract class GsearchUserVars
    implements Built<GsearchUserVars, GsearchUserVarsBuilder> {
  GsearchUserVars._();

  factory GsearchUserVars([Function(GsearchUserVarsBuilder b) updates]) =
      _$GsearchUserVars;

  String get name;
  static Serializer<GsearchUserVars> get serializer =>
      _$gsearchUserVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsearchUserVars.serializer, this)
          as Map<String, dynamic>);
  static GsearchUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsearchUserVars.serializer, json);
}

abstract class GaddChatRoomUserVars
    implements Built<GaddChatRoomUserVars, GaddChatRoomUserVarsBuilder> {
  GaddChatRoomUserVars._();

  factory GaddChatRoomUserVars(
          [Function(GaddChatRoomUserVarsBuilder b) updates]) =
      _$GaddChatRoomUserVars;

  _i2.GChatRoomUserRole? get role;
  int get chatId;
  int get userId;
  static Serializer<GaddChatRoomUserVars> get serializer =>
      _$gaddChatRoomUserVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GaddChatRoomUserVars.serializer, this)
          as Map<String, dynamic>);
  static GaddChatRoomUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GaddChatRoomUserVars.serializer, json);
}

abstract class GdeleteChatRoomUserVars
    implements Built<GdeleteChatRoomUserVars, GdeleteChatRoomUserVarsBuilder> {
  GdeleteChatRoomUserVars._();

  factory GdeleteChatRoomUserVars(
          [Function(GdeleteChatRoomUserVarsBuilder b) updates]) =
      _$GdeleteChatRoomUserVars;

  int get chatId;
  int get userId;
  static Serializer<GdeleteChatRoomUserVars> get serializer =>
      _$gdeleteChatRoomUserVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GdeleteChatRoomUserVars.serializer, this)
          as Map<String, dynamic>);
  static GdeleteChatRoomUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GdeleteChatRoomUserVars.serializer, json);
}

abstract class GUserChatVars
    implements Built<GUserChatVars, GUserChatVarsBuilder> {
  GUserChatVars._();

  factory GUserChatVars([Function(GUserChatVarsBuilder b) updates]) =
      _$GUserChatVars;

  static Serializer<GUserChatVars> get serializer => _$gUserChatVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GUserChatVars.serializer, this)
          as Map<String, dynamic>);
  static GUserChatVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GUserChatVars.serializer, json);
}

abstract class GFullChatRoomVars
    implements Built<GFullChatRoomVars, GFullChatRoomVarsBuilder> {
  GFullChatRoomVars._();

  factory GFullChatRoomVars([Function(GFullChatRoomVarsBuilder b) updates]) =
      _$GFullChatRoomVars;

  static Serializer<GFullChatRoomVars> get serializer =>
      _$gFullChatRoomVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GFullChatRoomVars.serializer, this)
          as Map<String, dynamic>);
  static GFullChatRoomVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GFullChatRoomVars.serializer, json);
}

abstract class GBaseChatRoomVars
    implements Built<GBaseChatRoomVars, GBaseChatRoomVarsBuilder> {
  GBaseChatRoomVars._();

  factory GBaseChatRoomVars([Function(GBaseChatRoomVarsBuilder b) updates]) =
      _$GBaseChatRoomVars;

  static Serializer<GBaseChatRoomVars> get serializer =>
      _$gBaseChatRoomVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GBaseChatRoomVars.serializer, this)
          as Map<String, dynamic>);
  static GBaseChatRoomVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GBaseChatRoomVars.serializer, json);
}
