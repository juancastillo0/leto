// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_config_test.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final getClassConfig2GraphQLField =
    classConfig2GraphQLType.nonNull().field<Object?>(
  'getClassConfig2',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getClassConfig2();
  },
);

final getClassConfigGraphQLField =
    classConfigGraphQLType.nonNull().field<Object?>(
  'getClassConfig',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getClassConfig();
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectType<ClassConfig>? _classConfigGraphQLType;

/// Auto-generated from [ClassConfig].
GraphQLObjectType<ClassConfig> get classConfigGraphQLType {
  final __name = 'RenamedClassConfig';
  if (_classConfigGraphQLType != null)
    return _classConfigGraphQLType! as GraphQLObjectType<ClassConfig>;

  final __classConfigGraphQLType =
      objectType<ClassConfig>(__name, isInterface: false, interfaces: []);

  _classConfigGraphQLType = __classConfigGraphQLType;
  __classConfigGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('value',
          resolve: (obj, ctx) => obj.value,
          deprecationReason: 'value deprecated'),
      graphQLString.field('valueOverridden',
          resolve: (obj, ctx) => obj.valueOverridden),
      graphQLString.field('valueNull', resolve: (obj, ctx) => obj.valueNull),
      graphQLString.field('value2', resolve: (obj, ctx) => obj.value2)
    ],
  );

  return __classConfigGraphQLType;
}

GraphQLObjectType<ClassConfig2>? _classConfig2GraphQLType;

/// Auto-generated from [ClassConfig2].
GraphQLObjectType<ClassConfig2> get classConfig2GraphQLType {
  final __name = 'ClassConfig2';
  if (_classConfig2GraphQLType != null)
    return _classConfig2GraphQLType! as GraphQLObjectType<ClassConfig2>;

  final __classConfig2GraphQLType = objectType<ClassConfig2>(__name,
      isInterface: false, interfaces: [customInterface]);

  _classConfig2GraphQLType = __classConfig2GraphQLType;
  __classConfig2GraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('value', resolve: (obj, ctx) => obj.value),
      graphQLString.field('valueOverridden',
          resolve: (obj, ctx) => obj.valueOverridden),
      graphQLString
          .nonNull()
          .field('renamedValue2', resolve: (obj, ctx) => obj.value2)
    ],
  );

  return __classConfig2GraphQLType;
}
