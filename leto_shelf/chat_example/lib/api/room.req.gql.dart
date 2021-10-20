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

abstract class GdeleteRoomReq
    implements
        Built<GdeleteRoomReq, GdeleteRoomReqBuilder>,
        _i1.OperationRequest<_i2.GdeleteRoomData, _i3.GdeleteRoomVars> {
  GdeleteRoomReq._();

  factory GdeleteRoomReq([Function(GdeleteRoomReqBuilder b) updates]) =
      _$GdeleteRoomReq;

  static void _initializeBuilder(GdeleteRoomReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'deleteRoom')
    ..executeOnListen = true;
  _i3.GdeleteRoomVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GdeleteRoomData? Function(_i2.GdeleteRoomData?, _i2.GdeleteRoomData?)?
      get updateResult;
  _i2.GdeleteRoomData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GdeleteRoomData? parseData(Map<String, dynamic> json) =>
      _i2.GdeleteRoomData.fromJson(json);
  static Serializer<GdeleteRoomReq> get serializer =>
      _$gdeleteRoomReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GdeleteRoomReq.serializer, this)
          as Map<String, dynamic>);
  static GdeleteRoomReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GdeleteRoomReq.serializer, json);
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

abstract class GsearchUserReq
    implements
        Built<GsearchUserReq, GsearchUserReqBuilder>,
        _i1.OperationRequest<_i2.GsearchUserData, _i3.GsearchUserVars> {
  GsearchUserReq._();

  factory GsearchUserReq([Function(GsearchUserReqBuilder b) updates]) =
      _$GsearchUserReq;

  static void _initializeBuilder(GsearchUserReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'searchUser')
    ..executeOnListen = true;
  _i3.GsearchUserVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GsearchUserData? Function(_i2.GsearchUserData?, _i2.GsearchUserData?)?
      get updateResult;
  _i2.GsearchUserData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GsearchUserData? parseData(Map<String, dynamic> json) =>
      _i2.GsearchUserData.fromJson(json);
  static Serializer<GsearchUserReq> get serializer =>
      _$gsearchUserReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GsearchUserReq.serializer, this)
          as Map<String, dynamic>);
  static GsearchUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GsearchUserReq.serializer, json);
}

abstract class GaddChatRoomUserReq
    implements
        Built<GaddChatRoomUserReq, GaddChatRoomUserReqBuilder>,
        _i1.OperationRequest<_i2.GaddChatRoomUserData,
            _i3.GaddChatRoomUserVars> {
  GaddChatRoomUserReq._();

  factory GaddChatRoomUserReq(
      [Function(GaddChatRoomUserReqBuilder b) updates]) = _$GaddChatRoomUserReq;

  static void _initializeBuilder(GaddChatRoomUserReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'addChatRoomUser')
    ..executeOnListen = true;
  _i3.GaddChatRoomUserVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GaddChatRoomUserData? Function(
      _i2.GaddChatRoomUserData?, _i2.GaddChatRoomUserData?)? get updateResult;
  _i2.GaddChatRoomUserData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GaddChatRoomUserData? parseData(Map<String, dynamic> json) =>
      _i2.GaddChatRoomUserData.fromJson(json);
  static Serializer<GaddChatRoomUserReq> get serializer =>
      _$gaddChatRoomUserReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GaddChatRoomUserReq.serializer, this)
          as Map<String, dynamic>);
  static GaddChatRoomUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GaddChatRoomUserReq.serializer, json);
}

abstract class GdeleteChatRoomUserReq
    implements
        Built<GdeleteChatRoomUserReq, GdeleteChatRoomUserReqBuilder>,
        _i1.OperationRequest<_i2.GdeleteChatRoomUserData,
            _i3.GdeleteChatRoomUserVars> {
  GdeleteChatRoomUserReq._();

  factory GdeleteChatRoomUserReq(
          [Function(GdeleteChatRoomUserReqBuilder b) updates]) =
      _$GdeleteChatRoomUserReq;

  static void _initializeBuilder(GdeleteChatRoomUserReqBuilder b) => b
    ..operation = _i4.Operation(
        document: _i5.document, operationName: 'deleteChatRoomUser')
    ..executeOnListen = true;
  _i3.GdeleteChatRoomUserVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GdeleteChatRoomUserData? Function(
          _i2.GdeleteChatRoomUserData?, _i2.GdeleteChatRoomUserData?)?
      get updateResult;
  _i2.GdeleteChatRoomUserData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GdeleteChatRoomUserData? parseData(Map<String, dynamic> json) =>
      _i2.GdeleteChatRoomUserData.fromJson(json);
  static Serializer<GdeleteChatRoomUserReq> get serializer =>
      _$gdeleteChatRoomUserReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GdeleteChatRoomUserReq.serializer, this)
          as Map<String, dynamic>);
  static GdeleteChatRoomUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GdeleteChatRoomUserReq.serializer, json);
}

abstract class GUserChatReq
    implements
        Built<GUserChatReq, GUserChatReqBuilder>,
        _i1.FragmentRequest<_i2.GUserChatData, _i3.GUserChatVars> {
  GUserChatReq._();

  factory GUserChatReq([Function(GUserChatReqBuilder b) updates]) =
      _$GUserChatReq;

  static void _initializeBuilder(GUserChatReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'UserChat';
  _i3.GUserChatVars get vars;
  _i7.DocumentNode get document;
  String? get fragmentName;
  Map<String, dynamic> get idFields;
  @override
  _i2.GUserChatData? parseData(Map<String, dynamic> json) =>
      _i2.GUserChatData.fromJson(json);
  static Serializer<GUserChatReq> get serializer => _$gUserChatReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GUserChatReq.serializer, this)
          as Map<String, dynamic>);
  static GUserChatReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GUserChatReq.serializer, json);
}

abstract class GFullChatRoomReq
    implements
        Built<GFullChatRoomReq, GFullChatRoomReqBuilder>,
        _i1.FragmentRequest<_i2.GFullChatRoomData, _i3.GFullChatRoomVars> {
  GFullChatRoomReq._();

  factory GFullChatRoomReq([Function(GFullChatRoomReqBuilder b) updates]) =
      _$GFullChatRoomReq;

  static void _initializeBuilder(GFullChatRoomReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'FullChatRoom';
  _i3.GFullChatRoomVars get vars;
  _i7.DocumentNode get document;
  String? get fragmentName;
  Map<String, dynamic> get idFields;
  @override
  _i2.GFullChatRoomData? parseData(Map<String, dynamic> json) =>
      _i2.GFullChatRoomData.fromJson(json);
  static Serializer<GFullChatRoomReq> get serializer =>
      _$gFullChatRoomReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GFullChatRoomReq.serializer, this)
          as Map<String, dynamic>);
  static GFullChatRoomReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GFullChatRoomReq.serializer, json);
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
