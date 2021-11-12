// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics_oxidized.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object, Object>
    resultUnionObjectGraphQLField = field(
  'resultUnionObject',
  resultUGraphQLType<SuccessGet, UnionErrCode>(
          successGetGraphQLType.nonNull(), unionErrCodeGraphQLType.nonNull(),
          name: 'UnionObjectResult')
      .nonNull(),
  description: r"resultUnionObject description",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultUnionObject();
  },
);

final GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object, Object>
    resultUnionObjectErrGraphQLField = field(
  'resultUnionObjectErrRenamed',
  resultUGraphQLType<SuccessGet, UnionErrCode>(
          successGetGraphQLType.nonNull(), unionErrCodeGraphQLType.nonNull())
      .nonNull(),
  description: r"resultUnionObjectErr description",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultUnionObjectErr();
  },
  deprecationReason: r"use resultUnionObject",
);

final GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object, Object>
    resultUnionObjectMutErrGraphQLField = field(
  'resultUnionObjectMutErrRenamed',
  resultUGraphQLType<SuccessGet, UnionErrCode>(
          successGetGraphQLType.nonNull(), unionErrCodeGraphQLType.nonNull())
      .nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultUnionObjectMutErr();
  },
);

final GraphQLObjectField<Result<int, String>, Object, Object>
    resultObjectGraphQLField = field(
  'resultObject',
  resultGraphQLType<int, String>(graphQLInt.nonNull(), graphQLString.nonNull(),
          name: 'ObjectResult')
      .nonNull(),
  description: r"resultObject description",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultObject();
  },
);

final GraphQLObjectField<Result<String, List<UnionErrCode?>>, Object, Object>
    resultObjectErrGraphQLField = field(
  'resultObjectErrRenamed',
  resultGraphQLType<String, List<UnionErrCode?>>(
          graphQLString.nonNull(), unionErrCodeGraphQLType.list().nonNull())
      .nonNull(),
  description: r"resultObjectErr description",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return resultObjectErr();
  },
  deprecationReason: r"use resultObject",
);

final GraphQLObjectField<Result<SuccessGet, ErrCode>, Object, Object>
    resultObjectMutErrGraphQLField = field(
  'resultObjectMutErrRenamed',
  resultGraphQLType<SuccessGet, ErrCode>(
          successGetGraphQLType.nonNull(), errCodeGraphQLType.nonNull())
      .nonNull(),
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
      objectType<SuccessGet>('SuccessGet', isInterface: false, interfaces: []);

  _successGetGraphQLType = __successGetGraphQLType;
  __successGetGraphQLType.fields.addAll(
    [field('value', graphQLString.nonNull(), resolve: (obj, ctx) => obj.value)],
  );

  return __successGetGraphQLType;
}

GraphQLObjectType<UnionErrCode>? _unionErrCodeGraphQLType;

/// Auto-generated from [UnionErrCode].
GraphQLObjectType<UnionErrCode> get unionErrCodeGraphQLType {
  final __name = 'UnionErrCode';
  if (_unionErrCodeGraphQLType != null)
    return _unionErrCodeGraphQLType! as GraphQLObjectType<UnionErrCode>;

  final __unionErrCodeGraphQLType = objectType<UnionErrCode>('UnionErrCode',
      isInterface: false, interfaces: [errCodeGraphQLType]);

  _unionErrCodeGraphQLType = __unionErrCodeGraphQLType;
  __unionErrCodeGraphQLType.fields.addAll(
    [
      field('id', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.id),
      field('value', graphQLString.nonNull(), resolve: (obj, ctx) => obj.value)
    ],
  );

  return __unionErrCodeGraphQLType;
}
