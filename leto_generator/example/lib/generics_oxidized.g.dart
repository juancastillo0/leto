// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics_oxidized.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final resultUnionObjectGraphQLField =
    resultUGraphQLType<SuccessGet, UnionErrCode>(
            successGetGraphQLType.nonNull(), unionErrCodeGraphQLType.nonNull(),
            name: 'UnionObjectResult')
        .nonNull()
        .field<Object?>(
  'resultUnionObject',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultUnionObject();
  },
  description: r"resultUnionObject description",
);

final resultUnionObjectErrGraphQLField =
    resultUGraphQLType<SuccessGet, UnionErrCode>(
            successGetGraphQLType.nonNull(), unionErrCodeGraphQLType.nonNull())
        .nonNull()
        .field<Object?>(
  'resultUnionObjectErrRenamed',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultUnionObjectErr();
  },
  description: r"resultUnionObjectErr description",
  deprecationReason: r"use resultUnionObject",
);

final resultUnionObjectMutErrGraphQLField =
    resultUGraphQLType<SuccessGet, UnionErrCode>(
            successGetGraphQLType.nonNull(), unionErrCodeGraphQLType.nonNull())
        .nonNull()
        .field<Object?>(
  'resultUnionObjectMutErrRenamed',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultUnionObjectMutErr();
  },
);

final resultObjectGraphQLField = resultGraphQLType<int, String>(
        graphQLInt.nonNull(), graphQLString.nonNull(),
        name: 'ObjectResult')
    .nonNull()
    .field<Object?>(
  'resultObject',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultObject();
  },
  description: r"resultObject description",
);

final resultObjectErrGraphQLField =
    resultGraphQLType<String, List<UnionErrCode?>>(
            graphQLString.nonNull(), unionErrCodeGraphQLType.list().nonNull())
        .nonNull()
        .field<Object?>(
  'resultObjectErrRenamed',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultObjectErr();
  },
  description: r"resultObjectErr description",
  deprecationReason: r"use resultObject",
);

final resultObjectMutErrGraphQLField = resultGraphQLType<SuccessGet, ErrCode>(
        successGetGraphQLType.nonNull(), errCodeGraphQLType.nonNull())
    .nonNull()
    .field<Object?>(
  'resultObjectMutErrRenamed',
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultObjectMutErr();
  },
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectType<SuccessGet>? _successGetGraphQLType;

/// Auto-generated from [SuccessGet].
GraphQLObjectType<SuccessGet> get successGetGraphQLType {
  final __name = 'SuccessGet';
  if (_successGetGraphQLType != null)
    return _successGetGraphQLType! as GraphQLObjectType<SuccessGet>;

  final __successGetGraphQLType =
      objectType<SuccessGet>(__name, isInterface: false, interfaces: []);

  _successGetGraphQLType = __successGetGraphQLType;
  __successGetGraphQLType.fields.addAll(
    [graphQLString.nonNull().field('value', resolve: (obj, ctx) => obj.value)],
  );

  return __successGetGraphQLType;
}

GraphQLObjectType<UnionErrCode>? _unionErrCodeGraphQLType;

/// Auto-generated from [UnionErrCode].
GraphQLObjectType<UnionErrCode> get unionErrCodeGraphQLType {
  final __name = 'UnionErrCode';
  if (_unionErrCodeGraphQLType != null)
    return _unionErrCodeGraphQLType! as GraphQLObjectType<UnionErrCode>;

  final __unionErrCodeGraphQLType = objectType<UnionErrCode>(__name,
      isInterface: false, interfaces: [errCodeGraphQLType]);

  _unionErrCodeGraphQLType = __unionErrCodeGraphQLType;
  __unionErrCodeGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field('id', resolve: (obj, ctx) => obj.id),
      graphQLString.nonNull().field('value', resolve: (obj, ctx) => obj.value)
    ],
  );

  return __unionErrCodeGraphQLType;
}
