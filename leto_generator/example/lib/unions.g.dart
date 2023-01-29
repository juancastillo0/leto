// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unions.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<int, Object?, Object?>
    get returnFiveFromFreezedInputGraphQLField =>
        _returnFiveFromFreezedInputGraphQLField.value;
final _returnFiveFromFreezedInputGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<int, Object?, Object?>>(
        (setValue) => setValue(graphQLInt.nonNull().field<Object?>(
              'returnFiveFromFreezedInput',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return returnFiveFromFreezedInput(
                    ctx, (args["input"] as FreezedSingleInput));
              },
            ))
              ..inputs.addAll([
                freezedSingleInputGraphQLTypeInput.nonNull().inputField('input')
              ]));

GraphQLObjectField<UnionA?, Object?, Object?> get getUnionAGraphQLField =>
    _getUnionAGraphQLField.value;
final _getUnionAGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<UnionA?, Object?, Object?>>(
        (setValue) => setValue(unionAGraphQLType.field<Object?>(
              'getUnionA',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getUnionA(ctx);
              },
              description: 'gets Union A',
            )));

GraphQLObjectField<List<UnionNoFreezed>, Object?, Object?>
    get getUnionNoFrezzedGraphQLField => _getUnionNoFrezzedGraphQLField.value;
final _getUnionNoFrezzedGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<List<UnionNoFreezed>, Object?, Object?>>(
    (setValue) => setValue(
            unionNoFreezedGraphQLType.nonNull().list().nonNull().field<Object?>(
          'getUnionNoFrezzed',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getUnionNoFrezzed();
          },
        )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final freezedSingleInputSerializer = SerializerValue<FreezedSingleInput>(
  key: "FreezedSingleInput",
  fromJson: (ctx, json) =>
      FreezedSingleInput.fromJson(json), // _$$_FreezedSingleInputFromJson,
  // toJson: (m) => _$$_FreezedSingleInputToJson(m as _$_FreezedSingleInput),
);
final _freezedSingleInputGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<FreezedSingleInput>>(
        (setValue) {
  final __name = 'FreezedSingleInput';

  final __freezedSingleInputGraphQLTypeInput =
      inputObjectType<FreezedSingleInput>(__name);

  setValue(__freezedSingleInputGraphQLTypeInput);
  __freezedSingleInputGraphQLTypeInput.fields.addAll(
    [
      graphQLString.inputField('positional'),
      graphQLInt.nonNull().inputField(
            'five',
            defaultValue: 5,
            description: 'five with default',
          ),
    ],
  );

  return __freezedSingleInputGraphQLTypeInput;
});

/// Auto-generated from [FreezedSingleInput].
GraphQLInputObjectType<FreezedSingleInput>
    get freezedSingleInputGraphQLTypeInput =>
        _freezedSingleInputGraphQLTypeInput.value;

final unionA1Serializer = SerializerValue<_UnionA1>(
  key: "_UnionA1",
  fromJson: (ctx, json) => _UnionA1.fromJson(json), // _$$_UnionA1FromJson,
  // toJson: (m) => _$$_UnionA1ToJson(m as _$_UnionA1),
);
final _unionA1GraphQLType =
    HotReloadableDefinition<GraphQLObjectType<_UnionA1>>((setValue) {
  final __name = 'UnionA1';

  final __unionA1GraphQLType = objectType<_UnionA1>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__unionA1GraphQLType);
  __unionA1GraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field(
            'one',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.one,
            description: 'five with default',
          )
    ],
  );

  return __unionA1GraphQLType;
});

/// Auto-generated from [_UnionA1].
GraphQLObjectType<_UnionA1> get unionA1GraphQLType => _unionA1GraphQLType.value;

final unionA2Serializer = SerializerValue<_UnionA2>(
  key: "_UnionA2",
  fromJson: (ctx, json) => _UnionA2.fromJson(json), // _$$_UnionA2FromJson,
  // toJson: (m) => _$$_UnionA2ToJson(m as _$_UnionA2),
);
final _unionA2GraphQLType =
    HotReloadableDefinition<GraphQLObjectType<_UnionA2>>((setValue) {
  final __name = 'UnionA2';

  final __unionA2GraphQLType = objectType<_UnionA2>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__unionA2GraphQLType);
  __unionA2GraphQLType.fields.addAll(
    [
      decimalGraphQLType.field(
        'dec',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.dec,
        deprecationReason: 'custom deprecated msg',
      )
    ],
  );

  return __unionA2GraphQLType;
});

/// Auto-generated from [_UnionA2].
GraphQLObjectType<_UnionA2> get unionA2GraphQLType => _unionA2GraphQLType.value;

final unionA3Serializer = SerializerValue<UnionA3>(
  key: "UnionA3",
  fromJson: (ctx, json) => UnionA3.fromJson(json), // _$$UnionA3FromJson,
  // toJson: (m) => _$$UnionA3ToJson(m as _$UnionA3),
);
final _unionA3GraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UnionA3>>((setValue) {
  final __name = 'UnionA3';

  final __unionA3GraphQLType = objectType<UnionA3>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__unionA3GraphQLType);
  __unionA3GraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().list().field(
            'one',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.one,
            description: 'description for one',
          )
    ],
  );

  return __unionA3GraphQLType;
});

/// Auto-generated from [UnionA3].
GraphQLObjectType<UnionA3> get unionA3GraphQLType => _unionA3GraphQLType.value;

final unionA4Serializer = SerializerValue<_UnionA4>(
  key: "_UnionA4",
  fromJson: (ctx, json) => _UnionA4.fromJson(json), // _$$_UnionA4FromJson,
  // toJson: (m) => _$$_UnionA4ToJson(m as _$_UnionA4),
);
final _unionA4GraphQLType =
    HotReloadableDefinition<GraphQLObjectType<_UnionA4>>((setValue) {
  final __name = 'UnionA4';

  final __unionA4GraphQLType = objectType<_UnionA4>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__unionA4GraphQLType);
  __unionA4GraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().list().nonNull().field(
            'oneRenamed',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.one,
          )
    ],
  );

  return __unionA4GraphQLType;
});

/// Auto-generated from [_UnionA4].
GraphQLObjectType<_UnionA4> get unionA4GraphQLType => _unionA4GraphQLType.value;

final unionASerializer = SerializerValue<UnionA>(
  key: "UnionA",
  fromJson: (ctx, json) => UnionA.fromJson(json), // _$UnionAFromJson,
  // toJson: (m) => _$UnionAToJson(m as UnionA),
);

/// Generated from [UnionA]
GraphQLUnionType<UnionA> get unionAGraphQLType => _unionAGraphQLType.value;

final _unionAGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<UnionA>>((setValue) {
  final type = GraphQLUnionType<UnionA>(
    'UnionA',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    unionA1GraphQLType,
    unionA2GraphQLType,
    unionA3GraphQLType,
    unionA4GraphQLType,
  ]);
  return type;
});

/// Generated from [UnionNoFreezed]
GraphQLUnionType<UnionNoFreezed> get unionNoFreezedGraphQLType =>
    _unionNoFreezedGraphQLType.value;

final _unionNoFreezedGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<UnionNoFreezed>>((setValue) {
  final type = GraphQLUnionType<UnionNoFreezed>(
    'UnionNoFreezedRenamed',
    const [],
    description:
        'Description from annotation.\n\nUnion generated from raw Dart classes',
    extra: GraphQLTypeDefinitionExtra.attach([
      ...unionNoFreezedAttachments(),
    ]),
  );
  setValue(type);
  type.possibleTypes.addAll([
    unionNoFreezedAGraphQLType,
    unionNoFreezedBGraphQLType,
  ]);
  return type;
});

final _unionNoFreezedAGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UnionNoFreezedA>>((setValue) {
  final __name = 'UnionNoFreezedA';

  final __unionNoFreezedAGraphQLType = objectType<UnionNoFreezedA>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__unionNoFreezedAGraphQLType);
  __unionNoFreezedAGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field(
            'value',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.value,
          )
    ],
  );

  return __unionNoFreezedAGraphQLType;
});

/// Auto-generated from [UnionNoFreezedA].
GraphQLObjectType<UnionNoFreezedA> get unionNoFreezedAGraphQLType =>
    _unionNoFreezedAGraphQLType.value;

final _unionNoFreezedBGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UnionNoFreezedB>>((setValue) {
  final __name = 'UnionNoFreezedB';

  final __unionNoFreezedBGraphQLType = objectType<UnionNoFreezedB>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__unionNoFreezedBGraphQLType);
  __unionNoFreezedBGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field(
            'value',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.value,
          )
    ],
  );

  return __unionNoFreezedBGraphQLType;
});

/// Auto-generated from [UnionNoFreezedB].
GraphQLObjectType<UnionNoFreezedB> get unionNoFreezedBGraphQLType =>
    _unionNoFreezedBGraphQLType.value;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FreezedSingleInput _$$_FreezedSingleInputFromJson(
        Map<String, dynamic> json) =>
    _$_FreezedSingleInput(
      json['positional'] as String?,
      five: json['five'] as int? ?? 5,
    );

Map<String, dynamic> _$$_FreezedSingleInputToJson(
        _$_FreezedSingleInput instance) =>
    <String, dynamic>{
      'positional': instance.positional,
      'five': instance.five,
    };

_$_UnionA1 _$$_UnionA1FromJson(Map<String, dynamic> json) => _$_UnionA1(
      one: json['one'] as int? ?? 5,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_UnionA1ToJson(_$_UnionA1 instance) =>
    <String, dynamic>{
      'one': instance.one,
      'runtimeType': instance.$type,
    };

_$_UnionA2 _$$_UnionA2FromJson(Map<String, dynamic> json) => _$_UnionA2(
      dec: decimalFromJson(json['dec']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_UnionA2ToJson(_$_UnionA2 instance) =>
    <String, dynamic>{
      'dec': decimalToJson(instance.dec),
      'runtimeType': instance.$type,
    };

_$UnionA3 _$$UnionA3FromJson(Map<String, dynamic> json) => _$UnionA3(
      one: (json['one'] as List<dynamic>?)?.map((e) => e as int).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnionA3ToJson(_$UnionA3 instance) => <String, dynamic>{
      'one': instance.one,
      'runtimeType': instance.$type,
    };

_$_UnionA4 _$$_UnionA4FromJson(Map<String, dynamic> json) => _$_UnionA4(
      one: (json['one'] as List<dynamic>).map((e) => e as int).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_UnionA4ToJson(_$_UnionA4 instance) =>
    <String, dynamic>{
      'one': instance.one,
      'runtimeType': instance.$type,
    };
