// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<ResultV<int, String?>, Object?, Object?>
    get getIntGraphQLField => _getIntGraphQLField.value;
final _getIntGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<ResultV<int, String?>, Object?, Object?>>(
    (setValue) => setValue(resultVGraphQLType<int, String?>(
          graphQLInt.nonNull(),
          graphQLString,
        ).nonNull().field<Object?>(
          'getInt',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getInt();
          },
        )));

GraphQLObjectField<ResultV<int, String>, Object?, Object?>
    get getIntReqGraphQLField => _getIntReqGraphQLField.value;
final _getIntReqGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<ResultV<int, String>, Object?, Object?>>(
    (setValue) => setValue(resultVGraphQLType<int, String>(
          graphQLInt.nonNull(),
          graphQLString.nonNull(),
        ).nonNull().field<Object?>(
          'getIntReq',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getIntReq();
          },
        )));

GraphQLObjectField<ResultV<int?, String?>, Object?, Object?>
    get getIntNullGraphQLField => _getIntNullGraphQLField.value;
final _getIntNullGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<ResultV<int?, String?>, Object?, Object?>>(
    (setValue) => setValue(resultVGraphQLType<int?, String?>(
          graphQLInt,
          graphQLString,
        ).nonNull().field<Object?>(
          'getIntNull',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return getIntNull();
          },
        )));

GraphQLObjectField<ResultV<int?, ErrCodeInterface<String>>, Object?, Object?>
    get getIntInterfaceGraphQLField => _getIntInterfaceGraphQLField.value;
final _getIntInterfaceGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<ResultV<int?, ErrCodeInterface<String>>, Object?,
        Object?>>((setValue) =>
    setValue(resultVGraphQLType<int?, ErrCodeInterface<String>>(
      graphQLInt,
      errCodeInterfaceGraphQLType<String>(graphQLString.nonNull()).nonNull(),
    ).nonNull().field<Object?>(
      'getIntInterface',
      resolve: (obj, ctx) {
        final args = ctx.args;

        return getIntInterface();
      },
    )));

GraphQLObjectField<ResultV<int, ErrCodeInterface<ErrCodeType>>, Object?,
        Object?>
    get getIntInterfaceEnumGraphQLField =>
        _getIntInterfaceEnumGraphQLField.value;
final _getIntInterfaceEnumGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<ResultV<int, ErrCodeInterface<ErrCodeType>>, Object?,
        Object?>>((setValue) =>
    setValue(resultVGraphQLType<int, ErrCodeInterface<ErrCodeType>>(
      graphQLInt.nonNull(),
      errCodeInterfaceGraphQLType<ErrCodeType>(errCodeTypeGraphQLType.nonNull())
          .nonNull(),
    ).nonNull().field<Object?>(
      'getIntInterfaceEnum',
      resolve: (obj, ctx) {
        final args = ctx.args;

        return getIntInterfaceEnum();
      },
    )));

GraphQLObjectField<ResultV<List<int?>, ErrCodeInterface<List<ErrCodeType>>>,
        Object?, Object?>
    get getIntInterfaceEnumListGraphQLField =>
        _getIntInterfaceEnumListGraphQLField.value;
final _getIntInterfaceEnumListGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<ResultV<List<int?>, ErrCodeInterface<List<ErrCodeType>>>,
        Object?, Object?>>((setValue) =>
    setValue(
        resultVGraphQLType<List<int?>, ErrCodeInterface<List<ErrCodeType>>>(
      graphQLInt.list().nonNull(),
      errCodeInterfaceGraphQLType<List<ErrCodeType>>(
              errCodeTypeGraphQLType.nonNull().list().nonNull())
          .nonNull(),
    ).nonNull().field<Object?>(
      'getIntInterfaceEnumList',
      resolve: (obj, ctx) {
        final args = ctx.args;

        return getIntInterfaceEnumList();
      },
    )));

GraphQLObjectField<ResultV<int, ErrCodeInterfaceN<ErrCodeType?>>, Object?,
        Object?>
    get getIntInterfaceNEnumNullGraphQLField =>
        _getIntInterfaceNEnumNullGraphQLField.value;
final _getIntInterfaceNEnumNullGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<ResultV<int, ErrCodeInterfaceN<ErrCodeType?>>, Object?,
        Object?>>((setValue) =>
    setValue(resultVGraphQLType<int, ErrCodeInterfaceN<ErrCodeType?>>(
      graphQLInt.nonNull(),
      errCodeInterfaceNGraphQLType<ErrCodeType?>(errCodeTypeGraphQLType)
          .nonNull(),
      name: 'LastGetIntResult',
    ).nonNull().field<Object?>(
      'getIntInterfaceNEnumNull',
      resolve: (obj, ctx) {
        final args = ctx.args;

        return getIntInterfaceNEnumNull();
      },
    )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _okVGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLObjectType<OkV>>>((_) => {});

/// Auto-generated from [OkV].
GraphQLObjectType<OkV<V, E>> okVGraphQLType<V, E>(
  GraphQLType<V, Object> vGraphQLType,
  GraphQLType<E, Object> eGraphQLType, {
  String? name,
}) {
  final __name =
      name ?? 'OkV${vGraphQLType.printableName}${eGraphQLType.printableName}';
  if (_okVGraphQLType.value[__name] != null)
    return _okVGraphQLType.value[__name]! as GraphQLObjectType<OkV<V, E>>;
  final __okVGraphQLType = objectType<OkV<V, E>>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  _okVGraphQLType.value[__name] = __okVGraphQLType;
  __okVGraphQLType.fields.addAll(
    [
      vGraphQLType.field(
        'value',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.value,
      ),
      graphQLBoolean.nonNull().field(
            'isOk',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.isOk,
          ),
    ],
  );

  return __okVGraphQLType;
}

final _errVGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLObjectType<ErrV>>>((_) => {});

/// Auto-generated from [ErrV].
GraphQLObjectType<ErrV<V, E>> errVGraphQLType<V, E>(
  GraphQLType<V, Object> vGraphQLType,
  GraphQLType<E, Object> eGraphQLType, {
  String? name,
}) {
  final __name =
      name ?? 'ErrV${vGraphQLType.printableName}${eGraphQLType.printableName}';
  if (_errVGraphQLType.value[__name] != null)
    return _errVGraphQLType.value[__name]! as GraphQLObjectType<ErrV<V, E>>;
  final __errVGraphQLType = objectType<ErrV<V, E>>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  _errVGraphQLType.value[__name] = __errVGraphQLType;
  __errVGraphQLType.fields.addAll(
    [
      eGraphQLType.field(
        'value',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.value,
      ),
      graphQLBoolean.nonNull().field(
            'isOk',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.isOk,
          ),
    ],
  );

  return __errVGraphQLType;
}

final _errCodeInterfaceGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLObjectType<ErrCodeInterface>>>(
        (_) => {});

/// Auto-generated from [ErrCodeInterface].
GraphQLObjectType<ErrCodeInterface<T>>
    errCodeInterfaceGraphQLType<T extends Object>(
  GraphQLType<T, Object> tGraphQLType, {
  String? name,
}) {
  final __name = name ?? 'ErrCodeInterface${tGraphQLType.printableName}';
  if (_errCodeInterfaceGraphQLType.value[__name] != null)
    return _errCodeInterfaceGraphQLType.value[__name]!
        as GraphQLObjectType<ErrCodeInterface<T>>;
  final __errCodeInterfaceGraphQLType = objectType<ErrCodeInterface<T>>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  _errCodeInterfaceGraphQLType.value[__name] = __errCodeInterfaceGraphQLType;
  __errCodeInterfaceGraphQLType.fields.addAll(
    [
      graphQLString.field(
        'message',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.message,
      ),
      tGraphQLType.nonNull().field(
            'code',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.code,
          ),
    ],
  );

  return __errCodeInterfaceGraphQLType;
}

final _errCodeInterfaceNGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLObjectType<ErrCodeInterfaceN>>>(
        (_) => {});

/// Auto-generated from [ErrCodeInterfaceN].
GraphQLObjectType<ErrCodeInterfaceN<T>>
    errCodeInterfaceNGraphQLType<T extends Object?>(
  GraphQLType<T, Object> tGraphQLType, {
  String? name,
}) {
  final __name = name ?? 'ErrCodeInterfaceN${tGraphQLType.printableName}';
  if (_errCodeInterfaceNGraphQLType.value[__name] != null)
    return _errCodeInterfaceNGraphQLType.value[__name]!
        as GraphQLObjectType<ErrCodeInterfaceN<T>>;
  final __errCodeInterfaceNGraphQLType = objectType<ErrCodeInterfaceN<T>>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  _errCodeInterfaceNGraphQLType.value[__name] = __errCodeInterfaceNGraphQLType;
  __errCodeInterfaceNGraphQLType.fields.addAll(
    [
      graphQLString.field(
        'message',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.message,
      ),
      tGraphQLType.field(
        'code',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.code,
      ),
    ],
  );

  return __errCodeInterfaceNGraphQLType;
}

final _errCodeInterfaceNEGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLObjectType<ErrCodeInterfaceNE>>>(
        (_) => {});

/// Auto-generated from [ErrCodeInterfaceNE].
GraphQLObjectType<ErrCodeInterfaceNE<T>> errCodeInterfaceNEGraphQLType<T>(
  GraphQLType<T, Object> tGraphQLType, {
  String? name,
}) {
  final __name = name ?? 'ErrCodeInterfaceNE${tGraphQLType.printableName}';
  if (_errCodeInterfaceNEGraphQLType.value[__name] != null)
    return _errCodeInterfaceNEGraphQLType.value[__name]!
        as GraphQLObjectType<ErrCodeInterfaceNE<T>>;
  final __errCodeInterfaceNEGraphQLType = objectType<ErrCodeInterfaceNE<T>>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  _errCodeInterfaceNEGraphQLType.value[__name] =
      __errCodeInterfaceNEGraphQLType;
  __errCodeInterfaceNEGraphQLType.fields.addAll(
    [
      graphQLString.field(
        'message',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.message,
      ),
      tGraphQLType.field(
        'code',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.code,
      ),
    ],
  );

  return __errCodeInterfaceNEGraphQLType;
}

final _errCodeGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<ErrCode>>((setValue) {
  final __name = 'ErrCode';

  final __errCodeGraphQLType = objectType<ErrCode>(
    __name,
    isInterface: true,
    interfaces: [],
  );

  setValue(__errCodeGraphQLType);
  __errCodeGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field(
            'value',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.value,
          ),
      graphQLInt.nonNull().field(
            'id',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.id,
          ),
    ],
  );

  return __errCodeGraphQLType;
});

/// Auto-generated from [ErrCode].
GraphQLObjectType<ErrCode> get errCodeGraphQLType => _errCodeGraphQLType.value;

final _errCodeInterfaceNEEGraphQLType = HotReloadableDefinition<
    Map<String, GraphQLObjectType<ErrCodeInterfaceNEE>>>((_) => {});

/// Auto-generated from [ErrCodeInterfaceNEE].
GraphQLObjectType<ErrCodeInterfaceNEE<T>>
    errCodeInterfaceNEEGraphQLType<T extends ErrCode>(
  GraphQLType<T, Object> tGraphQLType, {
  String? name,
}) {
  final __name = name ?? 'ErrCodeInterfaceNEE${tGraphQLType.printableName}';
  if (_errCodeInterfaceNEEGraphQLType.value[__name] != null)
    return _errCodeInterfaceNEEGraphQLType.value[__name]!
        as GraphQLObjectType<ErrCodeInterfaceNEE<T>>;
  final __errCodeInterfaceNEEGraphQLType = objectType<ErrCodeInterfaceNEE<T>>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  _errCodeInterfaceNEEGraphQLType.value[__name] =
      __errCodeInterfaceNEEGraphQLType;
  __errCodeInterfaceNEEGraphQLType.fields.addAll(
    [
      graphQLString.field(
        'message',
        resolve: (
          obj,
          ctx,
        ) =>
            obj.message,
      ),
      tGraphQLType.nonNull().field(
            'code',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.code,
          ),
    ],
  );

  return __errCodeInterfaceNEEGraphQLType;
}

/// Auto-generated from [ErrCodeType].
final GraphQLEnumType<ErrCodeType> errCodeTypeGraphQLType = GraphQLEnumType(
  'ErrCodeType',
  [
    GraphQLEnumValue(
      'code1',
      ErrCodeType.code1,
    ),
    GraphQLEnumValue(
      'code2',
      ErrCodeType.code2,
    ),
  ],
);
