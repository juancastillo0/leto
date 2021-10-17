// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/api/room.ast.gql.dart' as _i5;
import 'package:chat_example/api/room.data.gql.dart' as _i2;
import 'package:chat_example/api/room.var.gql.dart' as _i3;
import 'package:chat_example/serializers.gql.dart' as _i6;
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'room.req.gql.g.dart';

abstract class GcreateRoomReq
    implements
        Built<GcreateRoomReq, GcreateRoomReqBuilder>,
        _i1.OperationRequest<_i2.GcreateRoomData, _i3.GcreateRoomVars> {
  GcreateRoomReq._();

  factory GcreateRoomReq([Function(GcreateRoomReqBuilder b) updates]) =
      _$GcreateRoomReq;

  static void _initializeBuilder(GcreateRoomReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'createRoom')
    ..executeOnListen = true;
  _i3.GcreateRoomVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GcreateRoomData? Function(_i2.GcreateRoomData?, _i2.GcreateRoomData?)?
      get updateResult;
  _i2.GcreateRoomData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GcreateRoomData? parseData(Map<String, dynamic> json) =>
      _i2.GcreateRoomData.fromJson(json);
  static Serializer<GcreateRoomReq> get serializer =>
      _$gcreateRoomReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GcreateRoomReq.serializer, this)
          as Map<String, dynamic>);
  static GcreateRoomReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GcreateRoomReq.serializer, json);
}

abstract class GgetRoomsReq
    implements
        Built<GgetRoomsReq, GgetRoomsReqBuilder>,
        _i1.OperationRequest<_i2.GgetRoomsData, _i3.GgetRoomsVars> {
  GgetRoomsReq._();

  factory GgetRoomsReq([Function(GgetRoomsReqBuilder b) updates]) =
      _$GgetRoomsReq;

  static void _initializeBuilder(GgetRoomsReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'getRooms')
    ..executeOnListen = true;
  _i3.GgetRoomsVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GgetRoomsData? Function(_i2.GgetRoomsData?, _i2.GgetRoomsData?)?
      get updateResult;
  _i2.GgetRoomsData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GgetRoomsData? parseData(Map<String, dynamic> json) =>
      _i2.GgetRoomsData.fromJson(json);
  static Serializer<GgetRoomsReq> get serializer => _$ggetRoomsReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GgetRoomsReq.serializer, this)
          as Map<String, dynamic>);
  static GgetRoomsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GgetRoomsReq.serializer, json);
}

abstract class GBaseChatRoomReq
    implements
        Built<GBaseChatRoomReq, GBaseChatRoomReqBuilder>,
        _i1.FragmentRequest<_i2.GBaseChatRoomData, _i3.GBaseChatRoomVars> {
  GBaseChatRoomReq._();

  factory GBaseChatRoomReq([Function(GBaseChatRoomReqBuilder b) updates]) =
      _$GBaseChatRoomReq;

  static void _initializeBuilder(GBaseChatRoomReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'BaseChatRoom';
  _i3.GBaseChatRoomVars get vars;
  _i7.DocumentNode get document;
  String? get fragmentName;
  Map<String, dynamic> get idFields;
  @override
  _i2.GBaseChatRoomData? parseData(Map<String, dynamic> json) =>
      _i2.GBaseChatRoomData.fromJson(json);
  static Serializer<GBaseChatRoomReq> get serializer =>
      _$gBaseChatRoomReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GBaseChatRoomReq.serializer, this)
          as Map<String, dynamic>);
  static GBaseChatRoomReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GBaseChatRoomReq.serializer, json);
}
