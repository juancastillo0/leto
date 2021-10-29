// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unions.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final unionSingleInputSerializer = SerializerValue<UnionSingleInput>(
  fromJson: (ctx, json) =>
      UnionSingleInput.fromJson(json), // _$$_UnionSingleInputFromJson,
  // toJson: (m) => _$$_UnionSingleInputToJson(m as _$_UnionSingleInput),
);

GraphQLInputObjectType<UnionSingleInput>? _unionSingleInputGraphQLType;

/// Auto-generated from [UnionSingleInput].
GraphQLInputObjectType<UnionSingleInput> get unionSingleInputGraphQLType {
  final __name = 'UnionSingleInput';
  if (_unionSingleInputGraphQLType != null)
    return _unionSingleInputGraphQLType!
        as GraphQLInputObjectType<UnionSingleInput>;

  final __unionSingleInputGraphQLType =
      inputObjectType<UnionSingleInput>('UnionSingleInput');

  _unionSingleInputGraphQLType = __unionSingleInputGraphQLType;
  __unionSingleInputGraphQLType.fields.addAll(
    [
      inputField('positional', graphQLString.coerceToInputObject()),
      inputField('five', graphQLInt.nonNull().coerceToInputObject(),
          defaultValue: 5, description: 'five with default')
    ],
  );

  return __unionSingleInputGraphQLType;
}

GraphQLObjectType<_UnionA1>? _unionA1GraphQLType;

/// Auto-generated from [_UnionA1].
GraphQLObjectType<_UnionA1> get unionA1GraphQLType {
  final __name = '_UnionA1';
  if (_unionA1GraphQLType != null)
    return _unionA1GraphQLType! as GraphQLObjectType<_UnionA1>;

  final __unionA1GraphQLType =
      objectType<_UnionA1>('_UnionA1', isInterface: false, interfaces: []);

  _unionA1GraphQLType = __unionA1GraphQLType;
  __unionA1GraphQLType.fields.addAll(
    [
      field('one', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.one, description: 'five with default'),
      unionAGraphQLTypeDiscriminant()
    ],
  );

  return __unionA1GraphQLType;
}

GraphQLObjectType<_UnionA2>? _unionA2GraphQLType;

/// Auto-generated from [_UnionA2].
GraphQLObjectType<_UnionA2> get unionA2GraphQLType {
  final __name = '_UnionA2';
  if (_unionA2GraphQLType != null)
    return _unionA2GraphQLType! as GraphQLObjectType<_UnionA2>;

  final __unionA2GraphQLType =
      objectType<_UnionA2>('_UnionA2', isInterface: false, interfaces: []);

  _unionA2GraphQLType = __unionA2GraphQLType;
  __unionA2GraphQLType.fields.addAll(
    [
      field('dec', decimalGraphQLType,
          resolve: (obj, ctx) => obj.dec, description: 'five with default'),
      unionAGraphQLTypeDiscriminant()
    ],
  );

  return __unionA2GraphQLType;
}

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
      field('one', listOf(graphQLInt.nonNull()),
          resolve: (obj, ctx) => obj.one, description: 'five with default'),
      unionAGraphQLTypeDiscriminant()
    ],
  );

  return __unionA3GraphQLType;
}

GraphQLObjectType<_UnionA4>? _unionA4GraphQLType;

/// Auto-generated from [_UnionA4].
GraphQLObjectType<_UnionA4> get unionA4GraphQLType {
  final __name = '_UnionA4';
  if (_unionA4GraphQLType != null)
    return _unionA4GraphQLType! as GraphQLObjectType<_UnionA4>;

  final __unionA4GraphQLType =
      objectType<_UnionA4>('_UnionA4', isInterface: false, interfaces: []);

  _unionA4GraphQLType = __unionA4GraphQLType;
  __unionA4GraphQLType.fields.addAll(
    [
      field('one', listOf(graphQLInt.nonNull()),
          resolve: (obj, ctx) => obj.one, description: 'five with default'),
      unionAGraphQLTypeDiscriminant()
    ],
  );

  return __unionA4GraphQLType;
}

// Map<String, Object?> _$UnionAToJson(UnionA instance) => instance.toJson();

GraphQLObjectField<String, String, P>
    unionAGraphQLTypeDiscriminant<P extends UnionA>() => field(
          'runtimeType',
          enumTypeFromStrings('UnionAType', ["a1", "a2", "a3", "a4"]),
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UnionSingleInput _$$_UnionSingleInputFromJson(Map<String, dynamic> json) =>
    _$_UnionSingleInput(
      json['positional'] as String?,
      five: json['five'] as int? ?? 5,
    );

Map<String, dynamic> _$$_UnionSingleInputToJson(_$_UnionSingleInput instance) =>
    <String, dynamic>{
      'positional': instance.positional,
      'five': instance.five,
    };
