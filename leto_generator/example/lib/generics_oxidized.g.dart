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
