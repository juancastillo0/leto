// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final getIntGraphQLField =
    resultVGraphQLType<int, String?>(graphQLInt.nonNull(), graphQLString)
        .nonNull()
        .field<Object?>(
  'getInt',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getInt();
  },
);

final getIntReqGraphQLField = resultVGraphQLType<int, String>(
        graphQLInt.nonNull(), graphQLString.nonNull())
    .nonNull()
    .field<Object?>(
  'getIntReq',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntReq();
  },
);

final getIntNullGraphQLField =
    resultVGraphQLType<int?, String?>(graphQLInt, graphQLString)
        .nonNull()
        .field<Object?>(
  'getIntNull',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntNull();
  },
);

final getIntInterfaceGraphQLField =
    resultVGraphQLType<int?, ErrCodeInterface<String>>(
            graphQLInt,
            errCodeInterfaceGraphQLType<String>(graphQLString.nonNull())
                .nonNull())
        .nonNull()
        .field<Object?>(
  'getIntInterface',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntInterface();
  },
);

final getIntInterfaceEnumGraphQLField =
    resultVGraphQLType<int, ErrCodeInterface<ErrCodeType>>(
            graphQLInt.nonNull(),
            errCodeInterfaceGraphQLType<ErrCodeType>(
                    errCodeTypeGraphQLType.nonNull())
                .nonNull())
        .nonNull()
        .field<Object?>(
  'getIntInterfaceEnum',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntInterfaceEnum();
  },
);

final getIntInterfaceEnumListGraphQLField =
    resultVGraphQLType<List<int?>, ErrCodeInterface<List<ErrCodeType>>>(
            graphQLInt.list().nonNull(),
            errCodeInterfaceGraphQLType<List<ErrCodeType>>(
                    errCodeTypeGraphQLType.nonNull().list().nonNull())
                .nonNull())
        .nonNull()
        .field<Object?>(
  'getIntInterfaceEnumList',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntInterfaceEnumList();
  },
);

final getIntInterfaceNEnumNullGraphQLField =
    resultVGraphQLType<int, ErrCodeInterfaceN<ErrCodeType?>>(
            graphQLInt.nonNull(),
            errCodeInterfaceNGraphQLType<ErrCodeType?>(errCodeTypeGraphQLType)
                .nonNull(),
            name: 'LastGetIntResult')
        .nonNull()
        .field<Object?>(
  'getIntInterfaceNEnumNull',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getIntInterfaceNEnumNull();
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

Map<String, GraphQLObjectType<OkV>> _okVGraphQLType = {};

/// Auto-generated from [OkV].
GraphQLObjectType<OkV<V, E>> okVGraphQLType<V, E>(
  GraphQLType<V, Object> vGraphQLType,
  GraphQLType<E, Object> eGraphQLType,
) {
  final __name =
      'OkV${vGraphQLType.printableName}${eGraphQLType.printableName}';
  if (_okVGraphQLType[__name] != null)
    return _okVGraphQLType[__name]! as GraphQLObjectType<OkV<V, E>>;

  final __okVGraphQLType =
      objectType<OkV<V, E>>(__name, isInterface: false, interfaces: []);

  _okVGraphQLType[__name] = __okVGraphQLType;
  __okVGraphQLType.fields.addAll(
    [
      vGraphQLType.field('value', resolve: (obj, ctx) => obj.value),
      graphQLBoolean.nonNull().field('isOk', resolve: (obj, ctx) => obj.isOk)
    ],
  );

  return __okVGraphQLType;
}

Map<String, GraphQLObjectType<ErrV>> _errVGraphQLType = {};

/// Auto-generated from [ErrV].
GraphQLObjectType<ErrV<V, E>> errVGraphQLType<V, E>(
  GraphQLType<V, Object> vGraphQLType,
  GraphQLType<E, Object> eGraphQLType,
) {
  final __name =
      'ErrV${vGraphQLType.printableName}${eGraphQLType.printableName}';
  if (_errVGraphQLType[__name] != null)
    return _errVGraphQLType[__name]! as GraphQLObjectType<ErrV<V, E>>;

  final __errVGraphQLType =
      objectType<ErrV<V, E>>(__name, isInterface: false, interfaces: []);

  _errVGraphQLType[__name] = __errVGraphQLType;
  __errVGraphQLType.fields.addAll(
    [
      eGraphQLType.field('value', resolve: (obj, ctx) => obj.value),
      graphQLBoolean.nonNull().field('isOk', resolve: (obj, ctx) => obj.isOk)
    ],
  );

  return __errVGraphQLType;
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

  final __errCodeInterfaceGraphQLType = objectType<ErrCodeInterface<T>>(__name,
      isInterface: false, interfaces: []);

  _errCodeInterfaceGraphQLType[__name] = __errCodeInterfaceGraphQLType;
  __errCodeInterfaceGraphQLType.fields.addAll(
    [
      graphQLString.field('message', resolve: (obj, ctx) => obj.message),
      tGraphQLType.nonNull().field('code', resolve: (obj, ctx) => obj.code)
    ],
  );

  return __errCodeInterfaceGraphQLType;
}

Map<String, GraphQLObjectType<ErrCodeInterfaceN>>
    _errCodeInterfaceNGraphQLType = {};

/// Auto-generated from [ErrCodeInterfaceN].
GraphQLObjectType<ErrCodeInterfaceN<T>>
    errCodeInterfaceNGraphQLType<T extends Object?>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'ErrCodeInterfaceN${tGraphQLType.printableName}';
  if (_errCodeInterfaceNGraphQLType[__name] != null)
    return _errCodeInterfaceNGraphQLType[__name]!
        as GraphQLObjectType<ErrCodeInterfaceN<T>>;

  final __errCodeInterfaceNGraphQLType = objectType<ErrCodeInterfaceN<T>>(
      __name,
      isInterface: false,
      interfaces: []);

  _errCodeInterfaceNGraphQLType[__name] = __errCodeInterfaceNGraphQLType;
  __errCodeInterfaceNGraphQLType.fields.addAll(
    [
      graphQLString.field('message', resolve: (obj, ctx) => obj.message),
      tGraphQLType.field('code', resolve: (obj, ctx) => obj.code)
    ],
  );

  return __errCodeInterfaceNGraphQLType;
}

Map<String, GraphQLObjectType<ErrCodeInterfaceNE>>
    _errCodeInterfaceNEGraphQLType = {};

/// Auto-generated from [ErrCodeInterfaceNE].
GraphQLObjectType<ErrCodeInterfaceNE<T>> errCodeInterfaceNEGraphQLType<T>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'ErrCodeInterfaceNE${tGraphQLType.printableName}';
  if (_errCodeInterfaceNEGraphQLType[__name] != null)
    return _errCodeInterfaceNEGraphQLType[__name]!
        as GraphQLObjectType<ErrCodeInterfaceNE<T>>;

  final __errCodeInterfaceNEGraphQLType = objectType<ErrCodeInterfaceNE<T>>(
      __name,
      isInterface: false,
      interfaces: []);

  _errCodeInterfaceNEGraphQLType[__name] = __errCodeInterfaceNEGraphQLType;
  __errCodeInterfaceNEGraphQLType.fields.addAll(
    [
      graphQLString.field('message', resolve: (obj, ctx) => obj.message),
      tGraphQLType.field('code', resolve: (obj, ctx) => obj.code)
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
      objectType<ErrCode>(__name, isInterface: true, interfaces: []);

  _errCodeGraphQLType = __errCodeGraphQLType;
  __errCodeGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('value', resolve: (obj, ctx) => obj.value),
      graphQLInt.nonNull().field('id', resolve: (obj, ctx) => obj.id)
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
      __name,
      isInterface: false,
      interfaces: []);

  _errCodeInterfaceNEEGraphQLType[__name] = __errCodeInterfaceNEEGraphQLType;
  __errCodeInterfaceNEEGraphQLType.fields.addAll(
    [
      graphQLString.field('message', resolve: (obj, ctx) => obj.message),
      tGraphQLType.nonNull().field('code', resolve: (obj, ctx) => obj.code)
    ],
  );

  return __errCodeInterfaceNEEGraphQLType;
}

/// Auto-generated from [ErrCodeType].
final GraphQLEnumType<ErrCodeType> errCodeTypeGraphQLType =
    GraphQLEnumType('ErrCodeType', [
  GraphQLEnumValue('code1', ErrCodeType.code1),
  GraphQLEnumValue('code2', ErrCodeType.code2)
]);
