// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interfaces.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<NestedInterfaceImpl3?, Object?, Object?>
    get getNestedInterfaceImpl3GraphQLField =>
        _getNestedInterfaceImpl3GraphQLField.value;
final _getNestedInterfaceImpl3GraphQLField = HotReloadableDefinition<
        GraphQLObjectField<NestedInterfaceImpl3?, Object?, Object?>>(
    (setValue) => setValue(nestedInterfaceImpl3GraphQLType.field<Object?>(
          'getNestedInterfaceImpl3',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getNestedInterfaceImpl3(ctx);
          },
        )));

GraphQLObjectField<NestedInterfaceImpl2, Object?, Object?>
    get getNestedInterfaceImpl2GraphQLField =>
        _getNestedInterfaceImpl2GraphQLField.value;
final _getNestedInterfaceImpl2GraphQLField = HotReloadableDefinition<
        GraphQLObjectField<NestedInterfaceImpl2, Object?, Object?>>(
    (setValue) =>
        setValue(nestedInterfaceImpl2GraphQLType.nonNull().field<Object?>(
          'getNestedInterfaceImpl2',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getNestedInterfaceImpl2(ctx);
          },
        )));

GraphQLObjectField<NestedInterface, Object?, Object?>
    get getNestedInterfaceImplByIndexGraphQLField =>
        _getNestedInterfaceImplByIndexGraphQLField.value;
final _getNestedInterfaceImplByIndexGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<NestedInterface, Object?, Object?>>(
    (setValue) => setValue(nestedInterfaceGraphQLType.nonNull().field<Object?>(
          'getNestedInterfaceImplByIndex',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getNestedInterfaceImplByIndex(ctx, (args["index"] as int));
          },
        ))
          ..inputs.addAll([graphQLInt.nonNull().inputField('index')]));

GraphQLObjectField<DateKey, Object?, Object?> get getDateKeyGraphQLField =>
    _getDateKeyGraphQLField.value;
final _getDateKeyGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<DateKey, Object?, Object?>>(
        (setValue) => setValue(dateKeyGraphQLType.nonNull().field<Object?>(
              'getDateKey',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getDateKey((args["key"] as DateKey));
              },
            ))
              ..inputs.addAll(
                  [dateKeyGraphQLTypeInput.nonNull().inputField('key')]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _nestedInterfaceGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<NestedInterface>>((setValue) {
  final __name = 'NestedInterface';

  final __nestedInterfaceGraphQLType = objectType<NestedInterface>(
    __name,
    isInterface: true,
    interfaces: [],
  );

  setValue(__nestedInterfaceGraphQLType);
  __nestedInterfaceGraphQLType.fields.addAll(
    [
      decimalGraphQLType.nonNull().field(
            'dec',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.dec,
          )
    ],
  );

  return __nestedInterfaceGraphQLType;
});

/// Auto-generated from [NestedInterface].
GraphQLObjectType<NestedInterface> get nestedInterfaceGraphQLType =>
    _nestedInterfaceGraphQLType.value;

final _namedInterfaceGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<NamedInterface>>((setValue) {
  final __name = 'NamedInterface';

  final __namedInterfaceGraphQLType = objectType<NamedInterface>(
    __name,
    isInterface: true,
    interfaces: [],
  );

  setValue(__namedInterfaceGraphQLType);
  __namedInterfaceGraphQLType.fields.addAll(
    [
      graphQLString.field(
        'name',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.name,
      )
    ],
  );

  return __namedInterfaceGraphQLType;
});

/// Auto-generated from [NamedInterface].
GraphQLObjectType<NamedInterface> get namedInterfaceGraphQLType =>
    _namedInterfaceGraphQLType.value;

final _nestedInterfaceImplGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<NestedInterfaceImpl>>((setValue) {
  final __name = 'NestedInterfaceImpl';

  final __nestedInterfaceImplGraphQLType = objectType<NestedInterfaceImpl>(
    __name,
    isInterface: false,
    interfaces: [nestedInterfaceGraphQLType],
  );

  setValue(__nestedInterfaceImplGraphQLType);
  __nestedInterfaceImplGraphQLType.fields.addAll(
    [
      decimalGraphQLType.nonNull().field(
            'dec',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.dec,
          ),
      graphQLString.field(
        'name',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.name,
      ),
    ],
  );

  return __nestedInterfaceImplGraphQLType;
});

/// Auto-generated from [NestedInterfaceImpl].
GraphQLObjectType<NestedInterfaceImpl> get nestedInterfaceImplGraphQLType =>
    _nestedInterfaceImplGraphQLType.value;

final _nestedInterfaceImpl2GraphQLType =
    HotReloadableDefinition<GraphQLObjectType<NestedInterfaceImpl2>>(
        (setValue) {
  final __name = 'NestedInterfaceImpl2';

  final __nestedInterfaceImpl2GraphQLType = objectType<NestedInterfaceImpl2>(
    __name,
    isInterface: false,
    interfaces: [nestedInterfaceImplGraphQLType],
  );

  setValue(__nestedInterfaceImpl2GraphQLType);
  __nestedInterfaceImpl2GraphQLType.fields.addAll(
    [
      decimalGraphQLType.nonNull().field(
            'dec',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.dec,
          ),
      graphQLString.field(
        'name',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.name,
      ),
      graphQLString.nonNull().field(
            'name2',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.name2,
          ),
    ],
  );

  return __nestedInterfaceImpl2GraphQLType;
});

/// Auto-generated from [NestedInterfaceImpl2].
GraphQLObjectType<NestedInterfaceImpl2> get nestedInterfaceImpl2GraphQLType =>
    _nestedInterfaceImpl2GraphQLType.value;

final _nestedInterfaceImpl3GraphQLType =
    HotReloadableDefinition<GraphQLObjectType<NestedInterfaceImpl3>>(
        (setValue) {
  final __name = 'NestedInterfaceImpl3';

  final __nestedInterfaceImpl3GraphQLType = objectType<NestedInterfaceImpl3>(
    __name,
    isInterface: false,
    interfaces: [
      namedInterfaceGraphQLType,
      nestedInterfaceImplGraphQLType,
    ],
  );

  setValue(__nestedInterfaceImpl3GraphQLType);
  __nestedInterfaceImpl3GraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field(
            'name3',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.name3,
          ),
      decimalGraphQLType.nonNull().field(
            'dec',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.dec,
          ),
      graphQLString.field(
        'name',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.name,
      ),
    ],
  );

  return __nestedInterfaceImpl3GraphQLType;
});

/// Auto-generated from [NestedInterfaceImpl3].
GraphQLObjectType<NestedInterfaceImpl3> get nestedInterfaceImpl3GraphQLType =>
    _nestedInterfaceImpl3GraphQLType.value;

final dateKeySerializer = SerializerValue<DateKey>(
  key: "DateKey",
  fromJson: (ctx, json) => DateKey.fromJson(json), // _$DateKeyFromJson,
  // toJson: (m) => _$DateKeyToJson(m as DateKey),
);
final _dateKeyGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<DateKey>>((setValue) {
  final __name = 'DateKey';

  final __dateKeyGraphQLType = objectType<DateKey>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__dateKeyGraphQLType);
  __dateKeyGraphQLType.fields.addAll(
    [
      graphQLDate.nonNull().field(
            'date',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.date,
          ),
      graphQLBigInt.nonNull().field(
            'key',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.key,
          ),
      graphQLString.nonNull().field(
            'stringKey',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.stringKey,
          ),
    ],
  );

  return __dateKeyGraphQLType;
});

/// Auto-generated from [DateKey].
GraphQLObjectType<DateKey> get dateKeyGraphQLType => _dateKeyGraphQLType.value;
final _dateKeyGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<DateKey>>((setValue) {
  final __name = 'DateKeyInput';

  final __dateKeyGraphQLTypeInput = inputObjectType<DateKey>(__name);

  setValue(__dateKeyGraphQLTypeInput);
  __dateKeyGraphQLTypeInput.fields.addAll(
    [
      graphQLDate.nonNull().inputField('date'),
      graphQLBigInt.nonNull().inputField('key'),
    ],
  );

  return __dateKeyGraphQLTypeInput;
});

/// Auto-generated from [DateKey].
GraphQLInputObjectType<DateKey> get dateKeyGraphQLTypeInput =>
    _dateKeyGraphQLTypeInput.value;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateKey _$DateKeyFromJson(Map<String, dynamic> json) => DateKey(
      DateTime.parse(json['date'] as String),
      BigInt.parse(json['key'] as String),
    );

Map<String, dynamic> _$DateKeyToJson(DateKey instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'key': instance.key.toString(),
    };
