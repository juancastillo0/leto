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
  test('execute queries and mutations with no input', () async {
    final _queryFields = graphqlApiSchema.queryType!.fields
        .where((f) => f.inputs.isEmpty)
        .map(fieldSelection)
        .join('\n');
    final resultQueries =
        await GraphQL(graphqlApiSchema).parseAndExecute('{ $_queryFields }');
    expect(resultQueries.errors, isEmpty);
    expect(resultQueries.data, isNotNull);

    final _mutFields = graphqlApiSchema.mutationType!.fields
        .where((f) => f.inputs.isEmpty)
        .map(fieldSelection)
        .join('\n');

    final resultMutations = await GraphQL(graphqlApiSchema)
        .parseAndExecute(' mutation { $_mutFields }');
    expect(resultMutations.errors, isEmpty);
    expect(resultMutations.data, isNotNull);
  });
}
