// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/serializers.gql.dart' as _i1;

part 'messages.var.gql.g.dart';

abstract class GgetMessagesVars
    implements Built<GgetMessagesVars, GgetMessagesVarsBuilder> {
  GgetMessagesVars._();

  factory GgetMessagesVars([Function(GgetMessagesVarsBuilder b) updates]) =
      _$GgetMessagesVars;

  int get chatId;
  static Serializer<GgetMessagesVars> get serializer =>
      _$ggetMessagesVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GgetMessagesVars.serializer, this)
          as Map<String, dynamic>);
  static GgetMessagesVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GgetMessagesVars.serializer, json);
}

abstract class GsendMessageVars
    implements Built<GsendMessageVars, GsendMessageVarsBuilder> {
  GsendMessageVars._();

  factory GsendMessageVars([Function(GsendMessageVarsBuilder b) updates]) =
      _$GsendMessageVars;

  int get chatId;
  String get message;
  int? get referencedMessageId;
  static Serializer<GsendMessageVars> get serializer =>
      _$gsendMessageVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsendMessageVars.serializer, this)
          as Map<String, dynamic>);
  static GsendMessageVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsendMessageVars.serializer, json);
}

abstract class GonMessageSentVars
    implements Built<GonMessageSentVars, GonMessageSentVarsBuilder> {
  GonMessageSentVars._();

  factory GonMessageSentVars([Function(GonMessageSentVarsBuilder b) updates]) =
      _$GonMessageSentVars;

  int get chatId;
  static Serializer<GonMessageSentVars> get serializer =>
      _$gonMessageSentVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GonMessageSentVars.serializer, this)
          as Map<String, dynamic>);
  static GonMessageSentVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GonMessageSentVars.serializer, json);
}

abstract class GFullMessageVars
    implements Built<GFullMessageVars, GFullMessageVarsBuilder> {
  GFullMessageVars._();

  factory GFullMessageVars([Function(GFullMessageVarsBuilder b) updates]) =
      _$GFullMessageVars;

  static Serializer<GFullMessageVars> get serializer =>
      _$gFullMessageVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GFullMessageVars.serializer, this)
          as Map<String, dynamic>);
  static GFullMessageVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GFullMessageVars.serializer, json);
}
