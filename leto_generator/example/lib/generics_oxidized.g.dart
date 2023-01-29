// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics_oxidized.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object?, Object?>
    get resultUnionObjectGraphQLField => _resultUnionObjectGraphQLField.value;
final _resultUnionObjectGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object?,
            Object?>>(
    (setValue) => setValue(ResultU.graphQLType<SuccessGet, UnionErrCode>(
          successGetGraphQLType.nonNull(),
          unionErrCodeGraphQLType.nonNull(),
          name: 'UnionObjectResult',
        ).nonNull().field<Object?>(
          'resultUnionObject',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return resultUnionObject();
          },
          description: 'resultUnionObject description',
        )));

GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object?, Object?>
    get resultUnionObjectErrGraphQLField =>
        _resultUnionObjectErrGraphQLField.value;
final _resultUnionObjectErrGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object?,
            Object?>>(
    (setValue) => setValue(ResultU.graphQLType<SuccessGet, UnionErrCode>(
          successGetGraphQLType.nonNull(),
          unionErrCodeGraphQLType.nonNull(),
        ).nonNull().field<Object?>(
          'resultUnionObjectErrRenamed',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return resultUnionObjectErr();
          },
          description: 'resultUnionObjectErr description',
          deprecationReason: 'use resultUnionObject',
        )));

GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object?, Object?>
    get resultUnionObjectMutErrGraphQLField =>
        _resultUnionObjectMutErrGraphQLField.value;
final _resultUnionObjectMutErrGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<ResultU<SuccessGet, UnionErrCode>, Object?,
            Object?>>(
    (setValue) => setValue(ResultU.graphQLType<SuccessGet, UnionErrCode>(
          successGetGraphQLType.nonNull(),
          unionErrCodeGraphQLType.nonNull(),
        ).nonNull().field<Object?>(
          'resultUnionObjectMutErrRenamed',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return resultUnionObjectMutErr();
          },
        )));

GraphQLObjectField<Result<int, String>, Object?, Object?>
    get resultObjectGraphQLField => _resultObjectGraphQLField.value;
final _resultObjectGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<Result<int, String>, Object?, Object?>>(
    (setValue) => setValue(resultGraphQLType<int, String>(
          graphQLInt.nonNull(),
          graphQLString.nonNull(),
          name: 'ObjectResult',
        ).nonNull().field<Object?>(
          'resultObject',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return resultObject();
          },
          description: 'resultObject description',
        )));

GraphQLObjectField<Result<String, List<UnionErrCode?>>, Object?, Object?>
    get resultObjectErrGraphQLField => _resultObjectErrGraphQLField.value;
final _resultObjectErrGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<Result<String, List<UnionErrCode?>>, Object?,
            Object?>>(
    (setValue) => setValue(resultGraphQLType<String, List<UnionErrCode?>>(
          graphQLString.nonNull(),
          unionErrCodeGraphQLType.list().nonNull(),
        ).nonNull().field<Object?>(
          'resultObjectErrRenamed',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return resultObjectErr();
          },
          description: 'resultObjectErr description',
          deprecationReason: 'use resultObject',
        )));

GraphQLObjectField<Result<SuccessGet, ErrCode>, Object?, Object?>
    get resultObjectMutErrGraphQLField => _resultObjectMutErrGraphQLField.value;
final _resultObjectMutErrGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<Result<SuccessGet, ErrCode>, Object?, Object?>>(
    (setValue) => setValue(resultGraphQLType<SuccessGet, ErrCode>(
          successGetGraphQLType.nonNull(),
          errCodeGraphQLType.nonNull(),
        ).nonNull().field<Object?>(
          'resultObjectMutErrRenamed',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return resultObjectMutErr();
          },
        )));

GraphQLObjectField<Result<ResultU<SuccessGet, UnionErrCode>, ErrCode>, Object?,
        Object?>
    get resultUnionInSuccessGraphQLField =>
        _resultUnionInSuccessGraphQLField.value;
final _resultUnionInSuccessGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<Result<ResultU<SuccessGet, UnionErrCode>, ErrCode>,
        Object?, Object?>>((setValue) =>
    setValue(resultGraphQLType<ResultU<SuccessGet, UnionErrCode>, ErrCode>(
      ResultU.graphQLType<SuccessGet, UnionErrCode>(
        successGetGraphQLType.nonNull(),
        unionErrCodeGraphQLType.nonNull(),
      ).nonNull(),
      errCodeGraphQLType.nonNull(),
    ).nonNull().field<Object?>(
      'resultUnionInSuccess',
      resolve: (obj, ctx) {
        final args = ctx.args;

        return resultUnionInSuccess();
      },
    )));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _successGetGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<SuccessGet>>((setValue) {
  final __name = 'SuccessGet';

  final __successGetGraphQLType = objectType<SuccessGet>(
    __name,
    isInterface: false,
    interfaces: [],
  );

  setValue(__successGetGraphQLType);
  __successGetGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field(
            'value',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.value,
          )
    ],
  );

  return __successGetGraphQLType;
});

/// Auto-generated from [SuccessGet].
GraphQLObjectType<SuccessGet> get successGetGraphQLType =>
    _successGetGraphQLType.value;

final _unionErrCodeGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UnionErrCode>>((setValue) {
  final __name = 'UnionErrCode';

  final __unionErrCodeGraphQLType = objectType<UnionErrCode>(
    __name,
    isInterface: false,
    interfaces: [errCodeGraphQLType],
    description: '\$ \' dw "" \'\'ddw',
  );

  setValue(__unionErrCodeGraphQLType);
  __unionErrCodeGraphQLType.fields.addAll(
    [
      graphQLInt.nonNull().field(
            'id',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.id,
            description: 'The "id" of the \'error\'.',
          ),
      graphQLString.nonNull().field(
            'value',
            resolve: (
              obj,
              ctx,
            ) =>
                obj.value,
            description: 'Comment with \$\$ and \$',
          ),
    ],
  );

  return __unionErrCodeGraphQLType;
});

/// Auto-generated from [UnionErrCode].
GraphQLObjectType<UnionErrCode> get unionErrCodeGraphQLType =>
    _unionErrCodeGraphQLType.value;
