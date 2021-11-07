// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_config_test.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ClassConfig2, Object, Object>
    getClassConfig2GraphQLField = field(
  'getClassConfig2',
  classConfig2GraphQLType.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getClassConfig2();
  },
);

final GraphQLObjectField<ClassConfig, Object, Object>
    getClassConfigGraphQLField = field(
  'getClassConfig',
  classConfigGraphQLType.nonNull(),
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

  final __classConfigGraphQLType = objectType<ClassConfig>('RenamedClassConfig',
      isInterface: false, interfaces: []);

  _classConfigGraphQLType = __classConfigGraphQLType;
  __classConfigGraphQLType.fields.addAll(
    [
      field('value', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.value,
          deprecationReason: 'value deprecated'),
      field('valueOverridden', graphQLString,
          resolve: (obj, ctx) => obj.valueOverridden),
      field('valueNull', graphQLString, resolve: (obj, ctx) => obj.valueNull),
      field('value2', graphQLString, resolve: (obj, ctx) => obj.value2)
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

  final __classConfig2GraphQLType = objectType<ClassConfig2>('ClassConfig2',
      isInterface: false, interfaces: [customInterface]);

  _classConfig2GraphQLType = __classConfig2GraphQLType;
  __classConfig2GraphQLType.fields.addAll(
    [
      field('value', graphQLString.nonNull(), resolve: (obj, ctx) => obj.value),
      field('valueOverridden', graphQLString,
          resolve: (obj, ctx) => obj.valueOverridden),
      field('renamedValue2', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.value2)
    ],
  );

  return __classConfig2GraphQLType;
}
