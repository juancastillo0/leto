// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/api/messages.ast.gql.dart' as _i5;
import 'package:chat_example/api/messages.data.gql.dart' as _i2;
import 'package:chat_example/api/messages.var.gql.dart' as _i3;
import 'package:chat_example/serializers.gql.dart' as _i6;
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'messages.req.gql.g.dart';

abstract class GgetMessagesReq
    implements
        Built<GgetMessagesReq, GgetMessagesReqBuilder>,
        _i1.OperationRequest<_i2.GgetMessagesData, _i3.GgetMessagesVars> {
  GgetMessagesReq._();

  factory GgetMessagesReq([Function(GgetMessagesReqBuilder b) updates]) =
      _$GgetMessagesReq;

  static void _initializeBuilder(GgetMessagesReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'getMessages')
    ..executeOnListen = true;
  _i3.GgetMessagesVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GgetMessagesData? Function(_i2.GgetMessagesData?, _i2.GgetMessagesData?)?
      get updateResult;
  _i2.GgetMessagesData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GgetMessagesData? parseData(Map<String, dynamic> json) =>
      _i2.GgetMessagesData.fromJson(json);
  static Serializer<GgetMessagesReq> get serializer =>
      _$ggetMessagesReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GgetMessagesReq.serializer, this)
          as Map<String, dynamic>);
  static GgetMessagesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GgetMessagesReq.serializer, json);
}

abstract class GsendMessageReq
    implements
        Built<GsendMessageReq, GsendMessageReqBuilder>,
        _i1.OperationRequest<_i2.GsendMessageData, _i3.GsendMessageVars> {
  GsendMessageReq._();

  factory GsendMessageReq([Function(GsendMessageReqBuilder b) updates]) =
      _$GsendMessageReq;

  static void _initializeBuilder(GsendMessageReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'sendMessage')
    ..executeOnListen = true;
  _i3.GsendMessageVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GsendMessageData? Function(_i2.GsendMessageData?, _i2.GsendMessageData?)?
      get updateResult;
  _i2.GsendMessageData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GsendMessageData? parseData(Map<String, dynamic> json) =>
      _i2.GsendMessageData.fromJson(json);
  static Serializer<GsendMessageReq> get serializer =>
      _$gsendMessageReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GsendMessageReq.serializer, this)
          as Map<String, dynamic>);
  static GsendMessageReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GsendMessageReq.serializer, json);
}

abstract class GonMessageSentReq
    implements
        Built<GonMessageSentReq, GonMessageSentReqBuilder>,
        _i1.OperationRequest<_i2.GonMessageSentData, _i3.GonMessageSentVars> {
  GonMessageSentReq._();

  factory GonMessageSentReq([Function(GonMessageSentReqBuilder b) updates]) =
      _$GonMessageSentReq;

  static void _initializeBuilder(GonMessageSentReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'onMessageSent')
    ..executeOnListen = true;
  _i3.GonMessageSentVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GonMessageSentData? Function(
      _i2.GonMessageSentData?, _i2.GonMessageSentData?)? get updateResult;
  _i2.GonMessageSentData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GonMessageSentData? parseData(Map<String, dynamic> json) =>
      _i2.GonMessageSentData.fromJson(json);
  static Serializer<GonMessageSentReq> get serializer =>
      _$gonMessageSentReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GonMessageSentReq.serializer, this)
          as Map<String, dynamic>);
  static GonMessageSentReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GonMessageSentReq.serializer, json);
}

abstract class GFullMessageReq
    implements
        Built<GFullMessageReq, GFullMessageReqBuilder>,
        _i1.FragmentRequest<_i2.GFullMessageData, _i3.GFullMessageVars> {
  GFullMessageReq._();

  factory GFullMessageReq([Function(GFullMessageReqBuilder b) updates]) =
      _$GFullMessageReq;

  static void _initializeBuilder(GFullMessageReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'FullMessage';
  _i3.GFullMessageVars get vars;
  _i7.DocumentNode get document;
  String? get fragmentName;
  Map<String, dynamic> get idFields;
  @override
  _i2.GFullMessageData? parseData(Map<String, dynamic> json) =>
      _i2.GFullMessageData.fromJson(json);
  static Serializer<GFullMessageReq> get serializer =>
      _$gFullMessageReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GFullMessageReq.serializer, this)
          as Map<String, dynamic>);
  static GFullMessageReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GFullMessageReq.serializer, json);
}
