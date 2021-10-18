// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/api/user.ast.gql.dart' as _i5;
import 'package:chat_example/api/user.data.gql.dart' as _i2;
import 'package:chat_example/api/user.var.gql.dart' as _i3;
import 'package:chat_example/serializers.gql.dart' as _i6;
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'user.req.gql.g.dart';

abstract class GrefreshAuthTokenReq
    implements
        Built<GrefreshAuthTokenReq, GrefreshAuthTokenReqBuilder>,
        _i1.OperationRequest<_i2.GrefreshAuthTokenData,
            _i3.GrefreshAuthTokenVars> {
  GrefreshAuthTokenReq._();

  factory GrefreshAuthTokenReq(
          [Function(GrefreshAuthTokenReqBuilder b) updates]) =
      _$GrefreshAuthTokenReq;

  static void _initializeBuilder(GrefreshAuthTokenReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'refreshAuthToken')
    ..executeOnListen = true;
  _i3.GrefreshAuthTokenVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GrefreshAuthTokenData? Function(
      _i2.GrefreshAuthTokenData?, _i2.GrefreshAuthTokenData?)? get updateResult;
  _i2.GrefreshAuthTokenData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GrefreshAuthTokenData? parseData(Map<String, dynamic> json) =>
      _i2.GrefreshAuthTokenData.fromJson(json);
  static Serializer<GrefreshAuthTokenReq> get serializer =>
      _$grefreshAuthTokenReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GrefreshAuthTokenReq.serializer, this)
          as Map<String, dynamic>);
  static GrefreshAuthTokenReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GrefreshAuthTokenReq.serializer, json);
}

abstract class GsignInReq
    implements
        Built<GsignInReq, GsignInReqBuilder>,
        _i1.OperationRequest<_i2.GsignInData, _i3.GsignInVars> {
  GsignInReq._();

  factory GsignInReq([Function(GsignInReqBuilder b) updates]) = _$GsignInReq;

  static void _initializeBuilder(GsignInReqBuilder b) => b
    ..operation = _i4.Operation(document: _i5.document, operationName: 'signIn')
    ..executeOnListen = true;
  _i3.GsignInVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GsignInData? Function(_i2.GsignInData?, _i2.GsignInData?)?
      get updateResult;
  _i2.GsignInData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GsignInData? parseData(Map<String, dynamic> json) =>
      _i2.GsignInData.fromJson(json);
  static Serializer<GsignInReq> get serializer => _$gsignInReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GsignInReq.serializer, this)
          as Map<String, dynamic>);
  static GsignInReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GsignInReq.serializer, json);
}

abstract class GsignUpReq
    implements
        Built<GsignUpReq, GsignUpReqBuilder>,
        _i1.OperationRequest<_i2.GsignUpData, _i3.GsignUpVars> {
  GsignUpReq._();

  factory GsignUpReq([Function(GsignUpReqBuilder b) updates]) = _$GsignUpReq;

  static void _initializeBuilder(GsignUpReqBuilder b) => b
    ..operation = _i4.Operation(document: _i5.document, operationName: 'signUp')
    ..executeOnListen = true;
  _i3.GsignUpVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GsignUpData? Function(_i2.GsignUpData?, _i2.GsignUpData?)?
      get updateResult;
  _i2.GsignUpData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GsignUpData? parseData(Map<String, dynamic> json) =>
      _i2.GsignUpData.fromJson(json);
  static Serializer<GsignUpReq> get serializer => _$gsignUpReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GsignUpReq.serializer, this)
          as Map<String, dynamic>);
  static GsignUpReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GsignUpReq.serializer, json);
}

abstract class GsignOutReq
    implements
        Built<GsignOutReq, GsignOutReqBuilder>,
        _i1.OperationRequest<_i2.GsignOutData, _i3.GsignOutVars> {
  GsignOutReq._();

  factory GsignOutReq([Function(GsignOutReqBuilder b) updates]) = _$GsignOutReq;

  static void _initializeBuilder(GsignOutReqBuilder b) => b
    ..operation =
        _i4.Operation(document: _i5.document, operationName: 'signOut')
    ..executeOnListen = true;
  _i3.GsignOutVars get vars;
  _i4.Operation get operation;
  _i4.Request get execRequest =>
      _i4.Request(operation: operation, variables: vars.toJson());
  String? get requestId;
  @BuiltValueField(serialize: false)
  _i2.GsignOutData? Function(_i2.GsignOutData?, _i2.GsignOutData?)?
      get updateResult;
  _i2.GsignOutData? get optimisticResponse;
  String? get updateCacheHandlerKey;
  Map<String, dynamic>? get updateCacheHandlerContext;
  _i1.FetchPolicy? get fetchPolicy;
  bool get executeOnListen;
  @override
  _i2.GsignOutData? parseData(Map<String, dynamic> json) =>
      _i2.GsignOutData.fromJson(json);
  static Serializer<GsignOutReq> get serializer => _$gsignOutReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GsignOutReq.serializer, this)
          as Map<String, dynamic>);
  static GsignOutReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GsignOutReq.serializer, json);
}

abstract class GAUserReq
    implements
        Built<GAUserReq, GAUserReqBuilder>,
        _i1.FragmentRequest<_i2.GAUserData, _i3.GAUserVars> {
  GAUserReq._();

  factory GAUserReq([Function(GAUserReqBuilder b) updates]) = _$GAUserReq;

  static void _initializeBuilder(GAUserReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'AUser';
  _i3.GAUserVars get vars;
  _i7.DocumentNode get document;
  String? get fragmentName;
  Map<String, dynamic> get idFields;
  @override
  _i2.GAUserData? parseData(Map<String, dynamic> json) =>
      _i2.GAUserData.fromJson(json);
  static Serializer<GAUserReq> get serializer => _$gAUserReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GAUserReq.serializer, this)
          as Map<String, dynamic>);
  static GAUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GAUserReq.serializer, json);
}

abstract class GSTokenWithUserReq
    implements
        Built<GSTokenWithUserReq, GSTokenWithUserReqBuilder>,
        _i1.FragmentRequest<_i2.GSTokenWithUserData, _i3.GSTokenWithUserVars> {
  GSTokenWithUserReq._();

  factory GSTokenWithUserReq([Function(GSTokenWithUserReqBuilder b) updates]) =
      _$GSTokenWithUserReq;

  static void _initializeBuilder(GSTokenWithUserReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'STokenWithUser';
  _i3.GSTokenWithUserVars get vars;
  _i7.DocumentNode get document;
  String? get fragmentName;
  Map<String, dynamic> get idFields;
  @override
  _i2.GSTokenWithUserData? parseData(Map<String, dynamic> json) =>
      _i2.GSTokenWithUserData.fromJson(json);
  static Serializer<GSTokenWithUserReq> get serializer =>
      _$gSTokenWithUserReqSerializer;
  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GSTokenWithUserReq.serializer, this)
          as Map<String, dynamic>);
  static GSTokenWithUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GSTokenWithUserReq.serializer, json);
}
