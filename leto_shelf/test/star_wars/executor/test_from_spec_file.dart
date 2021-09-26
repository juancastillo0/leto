import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:test/test.dart';
import 'package:toml/toml.dart';

/// Executes tests described in [filepath] for a given graphql [server].
///
/// The file should have the format specified in [GraphQLTestGroup]
Future<void> startFileSpecTest(
  GraphQL server, {
  String filepath = 'test/star_wars/executor/variables_test_spec.toml',
}) async {
  Future<Map<String, Object?>> executeQuery(
    String query, {
    Map<String, Object?>? variableValues,
    Object? rootValue,
  }) async {
    final values = await server.parseAndExecute(
      query,
      variableValues: variableValues,
      initialValue: rootValue,
    );
    return values.toJson();
  }

  final testSpec = await TomlDocument.load(filepath);
  final map = testSpec.toMap();
  final gqlTestGroup = GraphQLTestGroup.fromJson(map);
  group(gqlTestGroup.description, () {
    for (final tc in gqlTestGroup.tests) {
      test(tc.description, () async {
        final result = await executeQuery(
          tc.query,
          variableValues: tc.variables,
          rootValue: tc.rootValue,
        );
        expect(result, tc.expected);
      });
    }
  });
}

class GraphQLTestGroup {
  final String description;
  final Map<String, String>? queries;
  final Map<String, Map<String, Object?>>? variables;
  final List<GraphQLTestCase> tests;

  const GraphQLTestGroup({
    required this.description,
    required this.queries,
    required this.variables,
    required this.tests,
  });

  Map<String, Object?> toJson() {
    return {
      'description': description,
      'queries': queries,
      'variables': variables,
      'tests': tests.map((x) => x.toJson()).toList(),
    };
  }

  factory GraphQLTestGroup.fromJson(Map<String, Object?> map) {
    final tests = <GraphQLTestCase>[];
    final testGroup = GraphQLTestGroup(
      description: map['description']! as String,
      queries: (map['queries'] as Map<String, Object?>?)?.cast(),
      variables: (map['variables'] as Map<String, Object?>?)?.cast(),
      tests: tests,
    );
    tests.addAll((map['tests']! as List<Object?>).map(
      (x) => GraphQLTestCase.fromJson(
        x! as Map<String, Object?>,
        testGroup,
      ),
    ));
    return testGroup;
  }

  @override
  String toString() =>
      'GraphQLTestGroup(description: $description, queries: $queries,'
      ' variables: $variables, tests: $tests)';
}

class GraphQLTestCase {
  final String description;
  final String query;
  final String? operationName;
  final Map<String, Object?>? variables;
  final Map<String, Object?> expected;
  final Map<String, Object?>? rootValue;

  const GraphQLTestCase({
    required this.description,
    required this.query,
    required this.expected,
    this.operationName,
    this.variables,
    this.rootValue,
  });

  Map<String, Object?> toJson() {
    return {
      'description': description,
      'query': query,
      'operationName': operationName,
      'expected': expected,
      'variables': variables,
      'rootValue': rootValue,
    };
  }

  factory GraphQLTestCase.fromJson(
    Map<String, Object?> map, [
    GraphQLTestGroup? group,
  ]) {
    String query = map['query']! as String;
    if (group?.queries?[query] != null) {
      query = group!.queries![query]!;
    }
    Object? variables = map['variables'];

    if (variables is String) {
      final fromGroup = group?.variables?[variables];
      if (fromGroup == null) {
        throw Exception('Variables $variables not found in group.');
      }
      variables = fromGroup;
    }

    return GraphQLTestCase(
      description: map['description']! as String,
      query: query,
      operationName: map['operationName'] as String?,
      expected: (map['expected']! as Map).cast(),
      variables: (variables as Map?)?.cast(),
      rootValue: (map['rootValue'] as Map?)?.cast(),
    );
  }

  @override
  String toString() {
    return 'GraphQLTestCase(description: $description, query: $query,'
        ' operationName: $operationName, expected: $expected,'
        ' variables: $variables, rootValue: $rootValue)';
  }
}
