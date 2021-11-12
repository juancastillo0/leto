// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unions.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<int, Object, Object>
    returnFiveFromFreezedInputGraphQLField = field(
  'returnFiveFromFreezedInput',
  graphQLInt.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return returnFiveFromFreezedInput(
        ctx, (args["input"] as FreezedSingleInput));
  },
  inputs: [
    freezedSingleInputGraphQLType.nonNull().inputField(
          "input",
        )
  ],
);

final GraphQLObjectField<UnionA, Object, Object> getUnionAGraphQLField = field(
  'getUnionA',
  unionAGraphQLType,
  description: r"gets Union A",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getUnionA(ctx);
  },
);

final GraphQLObjectField<NestedInterfaceImpl3, Object, Object>
    getNestedInterfaceImpl3GraphQLField = field(
  'getNestedInterfaceImpl3',
  nestedInterfaceImpl3GraphQLType,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getNestedInterfaceImpl3(ctx);
  },
);

final GraphQLObjectField<NestedInterfaceImpl2, Object, Object>
    getNestedInterfaceImpl2GraphQLField = field(
  'getNestedInterfaceImpl2',
  nestedInterfaceImpl2GraphQLType.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getNestedInterfaceImpl2(ctx);
  },
);

final GraphQLObjectField<NestedInterface, Object, Object>
    getNestedInterfaceImplByIndexGraphQLField = field(
  'getNestedInterfaceImplByIndex',
  nestedInterfaceGraphQLType.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getNestedInterfaceImplByIndex(ctx, (args["index"] as int));
  },
  inputs: [
    graphQLInt.nonNull().coerceToInputObject().inputField(
          "index",
        )
  ],
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final freezedSingleInputSerializer = SerializerValue<FreezedSingleInput>(
  key: "FreezedSingleInput",
  fromJson: (ctx, json) =>
      FreezedSingleInput.fromJson(json), // _$$_FreezedSingleInputFromJson,
  // toJson: (m) => _$$_FreezedSingleInputToJson(m as _$_FreezedSingleInput),
);

GraphQLInputObjectType<FreezedSingleInput>? _freezedSingleInputGraphQLType;

/// Auto-generated from [FreezedSingleInput].
GraphQLInputObjectType<FreezedSingleInput> get freezedSingleInputGraphQLType {
  final __name = 'FreezedSingleInput';
  if (_freezedSingleInputGraphQLType != null)
    return _freezedSingleInputGraphQLType!
        as GraphQLInputObjectType<FreezedSingleInput>;

  final __freezedSingleInputGraphQLType =
      inputObjectType<FreezedSingleInput>('FreezedSingleInput');

  _freezedSingleInputGraphQLType = __freezedSingleInputGraphQLType;
  __freezedSingleInputGraphQLType.fields.addAll(
    [
      inputField('positional', graphQLString.coerceToInputObject()),
      inputField('five', graphQLInt.nonNull().coerceToInputObject(),
          defaultValue: 5, description: 'five with default')
    ],
  );

  return __freezedSingleInputGraphQLType;
}

final unionA1Serializer = SerializerValue<_UnionA1>(
  key: "_UnionA1",
  fromJson: (ctx, json) => _UnionA1.fromJson(json), // _$$_UnionA1FromJson,
  // toJson: (m) => _$$_UnionA1ToJson(m as _$_UnionA1),
);

GraphQLObjectType<_UnionA1>? _unionA1GraphQLType;

/// Auto-generated from [_UnionA1].
GraphQLObjectType<_UnionA1> get unionA1GraphQLType {
  final __name = 'UnionA1';
  if (_unionA1GraphQLType != null)
    return _unionA1GraphQLType! as GraphQLObjectType<_UnionA1>;

  final __unionA1GraphQLType =
      objectType<_UnionA1>('UnionA1', isInterface: false, interfaces: []);

  _unionA1GraphQLType = __unionA1GraphQLType;
  __unionA1GraphQLType.fields.addAll(
    [
      field('one', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.one, description: 'five with default')
    ],
  );

  return __unionA1GraphQLType;
}

final unionA2Serializer = SerializerValue<_UnionA2>(
  key: "_UnionA2",
  fromJson: (ctx, json) => _UnionA2.fromJson(json), // _$$_UnionA2FromJson,
  // toJson: (m) => _$$_UnionA2ToJson(m as _$_UnionA2),
);

GraphQLObjectType<_UnionA2>? _unionA2GraphQLType;

/// Auto-generated from [_UnionA2].
GraphQLObjectType<_UnionA2> get unionA2GraphQLType {
  final __name = 'UnionA2';
  if (_unionA2GraphQLType != null)
    return _unionA2GraphQLType! as GraphQLObjectType<_UnionA2>;

  final __unionA2GraphQLType =
      objectType<_UnionA2>('UnionA2', isInterface: false, interfaces: []);

  _unionA2GraphQLType = __unionA2GraphQLType;
  __unionA2GraphQLType.fields.addAll(
    [
      field('dec', decimalGraphQLType,
          resolve: (obj, ctx) => obj.dec,
          deprecationReason: 'custom deprecated msg')
    ],
  );

  return __unionA2GraphQLType;
}

final unionA3Serializer = SerializerValue<UnionA3>(
  key: "UnionA3",
  fromJson: (ctx, json) => UnionA3.fromJson(json), // _$$UnionA3FromJson,
  // toJson: (m) => _$$UnionA3ToJson(m as _$UnionA3),
);

GraphQLObjectType<UnionA3>? _unionA3GraphQLType;

/// Auto-generated from [UnionA3].
GraphQLObjectType<UnionA3> get unionA3GraphQLType {
  final __name = 'UnionA3';
  if (_unionA3GraphQLType != null)
    return _unionA3GraphQLType! as GraphQLObjectType<UnionA3>;

  final __unionA3GraphQLType =
      objectType<UnionA3>('UnionA3', isInterface: false, interfaces: []);

  _unionA3GraphQLType = __unionA3GraphQLType;
  __unionA3GraphQLType.fields.addAll(
    [
      field('one', graphQLInt.nonNull().list(),
          resolve: (obj, ctx) => obj.one, description: 'description for one')
    ],
  );

  return __unionA3GraphQLType;
}

final unionA4Serializer = SerializerValue<_UnionA4>(
  key: "_UnionA4",
  fromJson: (ctx, json) => _UnionA4.fromJson(json), // _$$_UnionA4FromJson,
  // toJson: (m) => _$$_UnionA4ToJson(m as _$_UnionA4),
);

GraphQLObjectType<_UnionA4>? _unionA4GraphQLType;

/// Auto-generated from [_UnionA4].
GraphQLObjectType<_UnionA4> get unionA4GraphQLType {
  final __name = 'UnionA4';
  if (_unionA4GraphQLType != null)
    return _unionA4GraphQLType! as GraphQLObjectType<_UnionA4>;

  final __unionA4GraphQLType =
      objectType<_UnionA4>('UnionA4', isInterface: false, interfaces: []);

  _unionA4GraphQLType = __unionA4GraphQLType;
  __unionA4GraphQLType.fields.addAll(
    [
      field('oneRenamed', graphQLInt.nonNull().list().nonNull(),
          resolve: (obj, ctx) => obj.one)
    ],
  );

  return __unionA4GraphQLType;
}

final unionASerializer = SerializerValue<UnionA>(
  key: "UnionA",
  fromJson: (ctx, json) => UnionA.fromJson(json), // _$UnionAFromJson,
  // toJson: (m) => _$UnionAToJson(m as UnionA),
);

GraphQLUnionType<UnionA>? _unionAGraphQLType;
GraphQLUnionType<UnionA> get unionAGraphQLType {
  return _unionAGraphQLType ??= GraphQLUnionType(
    'UnionA',
    [
      unionA1GraphQLType,
      unionA2GraphQLType,
      unionA3GraphQLType,
      unionA4GraphQLType
    ],
  );
}

GraphQLObjectType<NestedInterface>? _nestedInterfaceGraphQLType;

/// Auto-generated from [NestedInterface].
GraphQLObjectType<NestedInterface> get nestedInterfaceGraphQLType {
  final __name = 'NestedInterface';
  if (_nestedInterfaceGraphQLType != null)
    return _nestedInterfaceGraphQLType! as GraphQLObjectType<NestedInterface>;

  final __nestedInterfaceGraphQLType = objectType<NestedInterface>(
      'NestedInterface',
      isInterface: true,
      interfaces: []);

  _nestedInterfaceGraphQLType = __nestedInterfaceGraphQLType;
  __nestedInterfaceGraphQLType.fields.addAll(
    [
      field('dec', decimalGraphQLType.nonNull(), resolve: (obj, ctx) => obj.dec)
    ],
  );

  return __nestedInterfaceGraphQLType;
}

GraphQLObjectType<NamedInterface>? _namedInterfaceGraphQLType;

/// Auto-generated from [NamedInterface].
GraphQLObjectType<NamedInterface> get namedInterfaceGraphQLType {
  final __name = 'NamedInterface';
  if (_namedInterfaceGraphQLType != null)
    return _namedInterfaceGraphQLType! as GraphQLObjectType<NamedInterface>;

  final __namedInterfaceGraphQLType = objectType<NamedInterface>(
      'NamedInterface',
      isInterface: true,
      interfaces: []);

  _namedInterfaceGraphQLType = __namedInterfaceGraphQLType;
  __namedInterfaceGraphQLType.fields.addAll(
    [field('name', graphQLString, resolve: (obj, ctx) => obj.name)],
  );

  return __namedInterfaceGraphQLType;
}

GraphQLObjectType<NestedInterfaceImpl>? _nestedInterfaceImplGraphQLType;

/// Auto-generated from [NestedInterfaceImpl].
GraphQLObjectType<NestedInterfaceImpl> get nestedInterfaceImplGraphQLType {
  final __name = 'NestedInterfaceImpl';
  if (_nestedInterfaceImplGraphQLType != null)
    return _nestedInterfaceImplGraphQLType!
        as GraphQLObjectType<NestedInterfaceImpl>;

  final __nestedInterfaceImplGraphQLType = objectType<NestedInterfaceImpl>(
      'NestedInterfaceImpl',
      isInterface: false,
      interfaces: [nestedInterfaceGraphQLType]);

  _nestedInterfaceImplGraphQLType = __nestedInterfaceImplGraphQLType;
  __nestedInterfaceImplGraphQLType.fields.addAll(
    [
      field('dec', decimalGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.dec),
      field('name', graphQLString, resolve: (obj, ctx) => obj.name)
    ],
  );

  return __nestedInterfaceImplGraphQLType;
}

GraphQLObjectType<NestedInterfaceImpl2>? _nestedInterfaceImpl2GraphQLType;

/// Auto-generated from [NestedInterfaceImpl2].
GraphQLObjectType<NestedInterfaceImpl2> get nestedInterfaceImpl2GraphQLType {
  final __name = 'NestedInterfaceImpl2';
  if (_nestedInterfaceImpl2GraphQLType != null)
    return _nestedInterfaceImpl2GraphQLType!
        as GraphQLObjectType<NestedInterfaceImpl2>;

  final __nestedInterfaceImpl2GraphQLType = objectType<NestedInterfaceImpl2>(
      'NestedInterfaceImpl2',
      isInterface: false,
      interfaces: [nestedInterfaceImplGraphQLType]);

  _nestedInterfaceImpl2GraphQLType = __nestedInterfaceImpl2GraphQLType;
  __nestedInterfaceImpl2GraphQLType.fields.addAll(
    [
      field('dec', decimalGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.dec),
      field('name', graphQLString, resolve: (obj, ctx) => obj.name),
      field('name2', graphQLString.nonNull(), resolve: (obj, ctx) => obj.name2)
    ],
  );

  return __nestedInterfaceImpl2GraphQLType;
}

GraphQLObjectType<NestedInterfaceImpl3>? _nestedInterfaceImpl3GraphQLType;

/// Auto-generated from [NestedInterfaceImpl3].
GraphQLObjectType<NestedInterfaceImpl3> get nestedInterfaceImpl3GraphQLType {
  final __name = 'NestedInterfaceImpl3';
  if (_nestedInterfaceImpl3GraphQLType != null)
    return _nestedInterfaceImpl3GraphQLType!
        as GraphQLObjectType<NestedInterfaceImpl3>;

  final __nestedInterfaceImpl3GraphQLType = objectType<NestedInterfaceImpl3>(
      'NestedInterfaceImpl3',
      isInterface: false,
      interfaces: [namedInterfaceGraphQLType, nestedInterfaceImplGraphQLType]);

  _nestedInterfaceImpl3GraphQLType = __nestedInterfaceImpl3GraphQLType;
  __nestedInterfaceImpl3GraphQLType.fields.addAll(
    [
      field('name3', graphQLString.nonNull(), resolve: (obj, ctx) => obj.name3),
      field('dec', decimalGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.dec),
      field('name', graphQLString, resolve: (obj, ctx) => obj.name)
    ],
  );

  return __nestedInterfaceImpl3GraphQLType;
}

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
    );

Map<String, dynamic> _$$_UnionA1ToJson(_$_UnionA1 instance) =>
    <String, dynamic>{
      'one': instance.one,
    };

_$_UnionA2 _$$_UnionA2FromJson(Map<String, dynamic> json) => _$_UnionA2(
      dec: decimalFromJson(json['dec']),
    );

Map<String, dynamic> _$$_UnionA2ToJson(_$_UnionA2 instance) =>
    <String, dynamic>{
      'dec': decimalToJson(instance.dec),
    };

_$UnionA3 _$$UnionA3FromJson(Map<String, dynamic> json) => _$UnionA3(
      one: (json['one'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$UnionA3ToJson(_$UnionA3 instance) => <String, dynamic>{
      'one': instance.one,
    };

_$_UnionA4 _$$_UnionA4FromJson(Map<String, dynamic> json) => _$_UnionA4(
      one: (json['one'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$_UnionA4ToJson(_$_UnionA4 instance) =>
    <String, dynamic>{
      'one': instance.one,
    };
