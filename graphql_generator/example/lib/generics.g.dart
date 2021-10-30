// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<Result<int, String?>, Object, Object>
    getIntGraphQLField = field(
  'getInt',
  resultGraphQLType(graphQLInt.nonNull(), graphQLString).nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getInt();
  },
);

final GraphQLObjectField<Result<int, String>, Object, Object>
    getIntReqGraphQLField = field(
  'getIntReq',
  resultGraphQLType(graphQLInt.nonNull(), graphQLString.nonNull()).nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntReq();
  },
);

final GraphQLObjectField<Result<int?, String?>, Object, Object>
    getIntNullGraphQLField = field(
  'getIntNull',
  resultGraphQLType(graphQLInt, graphQLString).nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntNull();
  },
);

final GraphQLObjectField<Result<int?, ErrCodeInterface<String>>, Object, Object>
    getIntInterfaceGraphQLField = field(
  'getIntInterface',
  resultGraphQLType(graphQLInt,
          errCodeInterfaceGraphQLType(graphQLString.nonNull()).nonNull())
      .nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntInterface();
  },
);

final GraphQLObjectField<Result<int, ErrCodeInterface<ErrCodeType>>, Object,
    Object> getIntInterfaceEnumGraphQLField = field(
  'getIntInterfaceEnum',
  resultGraphQLType(
          graphQLInt.nonNull(),
          errCodeInterfaceGraphQLType(errCodeTypeGraphQLType.nonNull())
              .nonNull())
      .nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntInterfaceEnum();
  },
);

final GraphQLObjectField<
    Result<List<int?>, ErrCodeInterface<List<ErrCodeType?>>>,
    Object,
    Object> getIntInterfaceEnumListGraphQLField = field(
  'getIntInterfaceEnumList',
  resultGraphQLType(
          listOf(graphQLInt).nonNull(),
          errCodeInterfaceGraphQLType(
                  listOf(errCodeTypeGraphQLType.nonNull()).nonNull())
              .nonNull())
      .nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntInterfaceEnumList();
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

Map<String, GraphQLObjectType<Result>> _resultGraphQLType = {};

/// Auto-generated from [Result].
GraphQLObjectType<Result<V, E>>
    resultGraphQLType<V extends Object, E extends Object>(
  GraphQLType<V, Object> vGraphQLType,
  GraphQLType<E, Object> eGraphQLType,
) {
  final __name =
      'Result${vGraphQLType.printableName}${eGraphQLType.printableName}';
  if (_resultGraphQLType[__name] != null)
    return _resultGraphQLType[__name]! as GraphQLObjectType<Result<V, E>>;

  final __resultGraphQLType = objectType<Result<V, E>>(
      'Result${vGraphQLType.printableName}${eGraphQLType.printableName}',
      isInterface: true,
      interfaces: []);

  _resultGraphQLType[__name] = __resultGraphQLType;
  __resultGraphQLType.fields.addAll(
    [field('isOk', graphQLBoolean.nonNull(), resolve: (obj, ctx) => obj.isOk)],
  );

  return __resultGraphQLType;
}

Map<String, GraphQLObjectType<Ok>> _okGraphQLType = {};

/// Auto-generated from [Ok].
GraphQLObjectType<Ok<V, E>> okGraphQLType<V extends Object, E extends Object>(
  GraphQLType<V, Object> vGraphQLType,
  GraphQLType<E, Object> eGraphQLType,
) {
  final __name = 'Ok${vGraphQLType.printableName}${eGraphQLType.printableName}';
  if (_okGraphQLType[__name] != null)
    return _okGraphQLType[__name]! as GraphQLObjectType<Ok<V, E>>;

  final __okGraphQLType = objectType<Ok<V, E>>(
      'Ok${vGraphQLType.printableName}${eGraphQLType.printableName}',
      isInterface: false,
      interfaces: []);

  _okGraphQLType[__name] = __okGraphQLType;
  __okGraphQLType.fields.addAll(
    [
      field('value', vGraphQLType.nonNull(), resolve: (obj, ctx) => obj.value),
      field('isOk', graphQLBoolean.nonNull(), resolve: (obj, ctx) => obj.isOk)
    ],
  );

  return __okGraphQLType;
}

Map<String, GraphQLObjectType<Err>> _errGraphQLType = {};

/// Auto-generated from [Err].
GraphQLObjectType<Err<V, E>> errGraphQLType<V extends Object, E extends Object>(
  GraphQLType<V, Object> vGraphQLType,
  GraphQLType<E, Object> eGraphQLType,
) {
  final __name =
      'Err${vGraphQLType.printableName}${eGraphQLType.printableName}';
  if (_errGraphQLType[__name] != null)
    return _errGraphQLType[__name]! as GraphQLObjectType<Err<V, E>>;

  final __errGraphQLType = objectType<Err<V, E>>(
      'Err${vGraphQLType.printableName}${eGraphQLType.printableName}',
      isInterface: false,
      interfaces: []);

  _errGraphQLType[__name] = __errGraphQLType;
  __errGraphQLType.fields.addAll(
    [
      field('value', eGraphQLType.nonNull(), resolve: (obj, ctx) => obj.value),
      field('isOk', graphQLBoolean.nonNull(), resolve: (obj, ctx) => obj.isOk)
    ],
  );

  return __errGraphQLType;
}

Map<String, GraphQLObjectType<ErrCodeInterface>> _errCodeInterfaceGraphQLType =
    {};

/// Auto-generated from [ErrCodeInterface].
GraphQLObjectType<ErrCodeInterface<T>>
    errCodeInterfaceGraphQLType<T extends Object>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'ErrCodeInterface${tGraphQLType.printableName}';
  if (_errCodeInterfaceGraphQLType[__name] != null)
    return _errCodeInterfaceGraphQLType[__name]!
        as GraphQLObjectType<ErrCodeInterface<T>>;

  final __errCodeInterfaceGraphQLType = objectType<ErrCodeInterface<T>>(
      'ErrCodeInterface${tGraphQLType.printableName}',
      isInterface: false,
      interfaces: []);

  _errCodeInterfaceGraphQLType[__name] = __errCodeInterfaceGraphQLType;
  __errCodeInterfaceGraphQLType.fields.addAll(
    [
      field('message', graphQLString, resolve: (obj, ctx) => obj.message),
      field('code', tGraphQLType.nonNull(), resolve: (obj, ctx) => obj.code)
    ],
  );

  return __errCodeInterfaceGraphQLType;
}

Map<String, GraphQLObjectType<ErrCodeInterfaceN>>
    _errCodeInterfaceNGraphQLType = {};

/// Auto-generated from [ErrCodeInterfaceN].
GraphQLObjectType<ErrCodeInterfaceN<T>>
    errCodeInterfaceNGraphQLType<T extends Object>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'ErrCodeInterfaceN${tGraphQLType.printableName}';
  if (_errCodeInterfaceNGraphQLType[__name] != null)
    return _errCodeInterfaceNGraphQLType[__name]!
        as GraphQLObjectType<ErrCodeInterfaceN<T>>;

  final __errCodeInterfaceNGraphQLType = objectType<ErrCodeInterfaceN<T>>(
      'ErrCodeInterfaceN${tGraphQLType.printableName}',
      isInterface: false,
      interfaces: []);

  _errCodeInterfaceNGraphQLType[__name] = __errCodeInterfaceNGraphQLType;
  __errCodeInterfaceNGraphQLType.fields.addAll(
    [
      field('message', graphQLString, resolve: (obj, ctx) => obj.message),
      field('code', tGraphQLType.nonNull(), resolve: (obj, ctx) => obj.code)
    ],
  );

  return __errCodeInterfaceNGraphQLType;
}

Map<String, GraphQLObjectType<ErrCodeInterfaceNE>>
    _errCodeInterfaceNEGraphQLType = {};

/// Auto-generated from [ErrCodeInterfaceNE].
GraphQLObjectType<ErrCodeInterfaceNE<T>>
    errCodeInterfaceNEGraphQLType<T extends Object>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'ErrCodeInterfaceNE${tGraphQLType.printableName}';
  if (_errCodeInterfaceNEGraphQLType[__name] != null)
    return _errCodeInterfaceNEGraphQLType[__name]!
        as GraphQLObjectType<ErrCodeInterfaceNE<T>>;

  final __errCodeInterfaceNEGraphQLType = objectType<ErrCodeInterfaceNE<T>>(
      'ErrCodeInterfaceNE${tGraphQLType.printableName}',
      isInterface: false,
      interfaces: []);

  _errCodeInterfaceNEGraphQLType[__name] = __errCodeInterfaceNEGraphQLType;
  __errCodeInterfaceNEGraphQLType.fields.addAll(
    [
      field('message', graphQLString, resolve: (obj, ctx) => obj.message),
      field('code', tGraphQLType.nonNull(), resolve: (obj, ctx) => obj.code)
    ],
  );

  return __errCodeInterfaceNEGraphQLType;
}

GraphQLObjectType<ErrCode>? _errCodeGraphQLType;

/// Auto-generated from [ErrCode].
GraphQLObjectType<ErrCode> get errCodeGraphQLType {
  final __name = 'ErrCode';
  if (_errCodeGraphQLType != null)
    return _errCodeGraphQLType! as GraphQLObjectType<ErrCode>;

  final __errCodeGraphQLType =
      objectType<ErrCode>('ErrCode', isInterface: true, interfaces: []);

  _errCodeGraphQLType = __errCodeGraphQLType;
  __errCodeGraphQLType.fields.addAll(
    [
      field('value', graphQLString.nonNull(), resolve: (obj, ctx) => obj.value),
      field('id', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.id)
    ],
  );

  return __errCodeGraphQLType;
}

Map<String, GraphQLObjectType<ErrCodeInterfaceNEE>>
    _errCodeInterfaceNEEGraphQLType = {};

/// Auto-generated from [ErrCodeInterfaceNEE].
GraphQLObjectType<ErrCodeInterfaceNEE<T>>
    errCodeInterfaceNEEGraphQLType<T extends ErrCode>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'ErrCodeInterfaceNEE${tGraphQLType.printableName}';
  if (_errCodeInterfaceNEEGraphQLType[__name] != null)
    return _errCodeInterfaceNEEGraphQLType[__name]!
        as GraphQLObjectType<ErrCodeInterfaceNEE<T>>;

  final __errCodeInterfaceNEEGraphQLType = objectType<ErrCodeInterfaceNEE<T>>(
      'ErrCodeInterfaceNEE${tGraphQLType.printableName}',
      isInterface: false,
      interfaces: []);

  _errCodeInterfaceNEEGraphQLType[__name] = __errCodeInterfaceNEEGraphQLType;
  __errCodeInterfaceNEEGraphQLType.fields.addAll(
    [
      field('message', graphQLString, resolve: (obj, ctx) => obj.message),
      field('code', tGraphQLType.nonNull(), resolve: (obj, ctx) => obj.code)
    ],
  );

  return __errCodeInterfaceNEEGraphQLType;
}

/// Auto-generated from [ErrCodeType].
final GraphQLEnumType<ErrCodeType> errCodeTypeGraphQLType = enumType(
    'ErrCodeType',
    const {'code1': ErrCodeType.code1, 'code2': ErrCodeType.code2});
