import 'package:leto/leto.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

GraphQLType _extractInnerType(GraphQLType type) {
  GraphQLType _type = type;
  while (_type is GraphQLWrapperType) {
    _type = (_type as GraphQLWrapperType).ofType;
  }
  return _type;
}

String fieldSelection(GraphQLObjectField<Object?, Object?, Object?> f) {
  final type = _extractInnerType(f.type);
  if (type is GraphQLObjectType) {
    return ' ${f.name} { ${type.fields.map(fieldSelection).join(' ')} } ';
  } else if (type is GraphQLUnionType) {
    return ' ${f.name} { ${type.possibleTypes.map((e) {
      return ' ... on ${e.name} { ${e.fields.map(fieldSelection).join(' ')} } ';
    }).join(' ')} }';
  }
  return ' ${f.name} ';
}

void main() {
  test('execute queries, mutations and subscriptions with no inputs', () async {
    bool _noRequiredInputs(GraphQLObjectField obj) {
      return obj.inputs.every(
        (i) => i.type.isNullable || i.defaultValue != null,
      );
    }

    final _queryFields = graphqlApiSchema.queryType!.fields
        .where(_noRequiredInputs)
        .map(fieldSelection)
        .join('\n');
    final resultQueries =
        await GraphQL(graphqlApiSchema).parseAndExecute('{ $_queryFields }');
    expect(resultQueries.errors, isEmpty);
    expect(resultQueries.data, isNotNull);

    final _mutFields = graphqlApiSchema.mutationType!.fields
        .where(_noRequiredInputs)
        .map(fieldSelection)
        .join('\n');

    final resultMutations = await GraphQL(graphqlApiSchema)
        .parseAndExecute(' mutation { $_mutFields }');
    expect(resultMutations.errors, isEmpty);
    expect(resultMutations.data, isNotNull);

    final _subFields = graphqlApiSchema.subscriptionType!.fields
        .where(_noRequiredInputs)
        .map(fieldSelection);

    await Future.wait(_subFields.map((e) async {
      final resultSubscription = await GraphQL(graphqlApiSchema)
          .parseAndExecute(' subscription { $e }');
      expect(resultSubscription.errors, isEmpty);
      expect(resultSubscription.isSubscription, true);
      expect(resultSubscription.subscriptionStream, isNotNull);
      expect(resultSubscription.data, isA<Stream<GraphQLResult>>());
    }));
  });
}
