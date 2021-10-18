// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chat_example/serializers.gql.dart' as _i1;

part 'user.var.gql.g.dart';

abstract class GrefreshAuthTokenVars
    implements Built<GrefreshAuthTokenVars, GrefreshAuthTokenVarsBuilder> {
  GrefreshAuthTokenVars._();

  factory GrefreshAuthTokenVars(
          [Function(GrefreshAuthTokenVarsBuilder b) updates]) =
      _$GrefreshAuthTokenVars;

  static Serializer<GrefreshAuthTokenVars> get serializer =>
      _$grefreshAuthTokenVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GrefreshAuthTokenVars.serializer, this)
          as Map<String, dynamic>);
  static GrefreshAuthTokenVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GrefreshAuthTokenVars.serializer, json);
}

abstract class GsignInVars implements Built<GsignInVars, GsignInVarsBuilder> {
  GsignInVars._();

  factory GsignInVars([Function(GsignInVarsBuilder b) updates]) = _$GsignInVars;

  String? get name;
  String? get password;
  static Serializer<GsignInVars> get serializer => _$gsignInVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignInVars.serializer, this)
          as Map<String, dynamic>);
  static GsignInVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsignInVars.serializer, json);
}

abstract class GsignUpVars implements Built<GsignUpVars, GsignUpVarsBuilder> {
  GsignUpVars._();

  factory GsignUpVars([Function(GsignUpVarsBuilder b) updates]) = _$GsignUpVars;

  String get name;
  String get password;
  static Serializer<GsignUpVars> get serializer => _$gsignUpVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignUpVars.serializer, this)
          as Map<String, dynamic>);
  static GsignUpVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsignUpVars.serializer, json);
}

abstract class GsignOutVars
    implements Built<GsignOutVars, GsignOutVarsBuilder> {
  GsignOutVars._();

  factory GsignOutVars([Function(GsignOutVarsBuilder b) updates]) =
      _$GsignOutVars;

  static Serializer<GsignOutVars> get serializer => _$gsignOutVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GsignOutVars.serializer, this)
          as Map<String, dynamic>);
  static GsignOutVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GsignOutVars.serializer, json);
}

abstract class GAUserVars implements Built<GAUserVars, GAUserVarsBuilder> {
  GAUserVars._();

  factory GAUserVars([Function(GAUserVarsBuilder b) updates]) = _$GAUserVars;

  static Serializer<GAUserVars> get serializer => _$gAUserVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GAUserVars.serializer, this)
          as Map<String, dynamic>);
  static GAUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GAUserVars.serializer, json);
}

abstract class GSTokenWithUserVars
    implements Built<GSTokenWithUserVars, GSTokenWithUserVarsBuilder> {
  GSTokenWithUserVars._();

  factory GSTokenWithUserVars(
      [Function(GSTokenWithUserVarsBuilder b) updates]) = _$GSTokenWithUserVars;

  static Serializer<GSTokenWithUserVars> get serializer =>
      _$gSTokenWithUserVarsSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GSTokenWithUserVars.serializer, this)
          as Map<String, dynamic>);
  static GSTokenWithUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GSTokenWithUserVars.serializer, json);
}
