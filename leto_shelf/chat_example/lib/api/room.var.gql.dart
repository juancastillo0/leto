// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
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
