// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_config_test.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<ClassConfig2, Object?, Object?>
    get getClassConfig2GraphQLField => _getClassConfig2GraphQLField.value;
final _getClassConfig2GraphQLField =
    HotReloadableDefinition<GraphQLObjectField<ClassConfig2, Object?, Object?>>(
        (setValue) => setValue(classConfig2GraphQLType.nonNull().field<Object?>(
              'getClassConfig2',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getClassConfig2();
              },
            )));

GraphQLObjectField<ClassConfig, Object?, Object?>
    get getClassConfigGraphQLField => _getClassConfigGraphQLField.value;
final _getClassConfigGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<ClassConfig, Object?, Object?>>(
        (setValue) => setValue(classConfigGraphQLType.nonNull().field<Object?>(
              'getClassConfig',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getClassConfig();
              },
            )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _classConfigGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ClassConfig>>((setValue) {
  final __name = 'RenamedClassConfig';

  final __classConfigGraphQLType =
      objectType<ClassConfig>(__name, isInterface: false, interfaces: []);

  setValue(__classConfigGraphQLType);
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
});

/// Auto-generated from [ClassConfig].
GraphQLObjectType<ClassConfig> get classConfigGraphQLType =>
    _classConfigGraphQLType.value;

final _classConfig2GraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ClassConfig2>>((setValue) {
  final __name = 'ClassConfig2';

  final __classConfig2GraphQLType = objectType<ClassConfig2>(__name,
      isInterface: false, interfaces: [customInterface]);

  setValue(__classConfig2GraphQLType);
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
});

/// Auto-generated from [ClassConfig2].
GraphQLObjectType<ClassConfig2> get classConfig2GraphQLType =>
    _classConfig2GraphQLType.value;
