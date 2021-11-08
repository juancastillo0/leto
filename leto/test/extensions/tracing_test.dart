import 'dart:convert' show json;

import 'package:collection/src/iterable_extensions.dart';
import 'package:leto/leto.dart';
import 'package:leto_generator_example/tasks/tasks.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

Map<String, Object?> persistedQueryExtension(String sha256Hash) {
  return {
    'persistedQuery': {'version': 1, 'sha256Hash': sha256Hash}
  };
}

void main() {
  final schema = GraphQLSchema(
    queryType: objectType(
      'Query',
      fields: [
        getTasksGraphQLField,
      ],
    ),
  );

  final scope = ScopedMap.empty();
  final data = tasksRef.get(scope).tasks;
  final traces = <TracingBuilder>[];

  void onExecute(TracingBuilder t) {
    traces.add(t);
    final built = t.build();
    expect(
      json.decode(json.encode(built)),
      json.decode(json.encode(t)),
    );
  }

  final executor = GraphQL(
    schema,
    extensions: [
      GraphQLTracingExtension(
        onExecute: onExecute,
      )
    ],
  );

  Future<Map<String, Object?>> _exec(
    String query, {
    String? operationName,
    Map<String, Object?>? extensions,
  }) async {
    final childScope = scope.child();
    final result = await executor.parseAndExecute(
      query,
      operationName: operationName,
      extensions: extensions,
      globalVariables: childScope,
    );
    return json.decode(json.encode(result)) as Map<String, Object?>;
  }

  test('tracing extension', () async {
    const query = '''
{ getTasks {
  id
  name
  description
  image
  weight
  extra
  createdTimestamp
  assignedTo {
    id
    name
  }
} }
''';

    final before = DateTime.now();

    final jsonResp = await _exec(query);
    const _traceItemMatcher = {
      'startOffset': TypeMatcher<int>(),
      'duration': TypeMatcher<int>(),
    };
    final trace = Tracing.fromJson(
      (jsonResp['extensions'] as Map)['tracing'] as Map<String, Object?>,
    );

    expect(traces.length, 1);
    expect(trace.startTime.isAfter(before), true);
    expect(trace.endTime.isAfter(trace.startTime), true);
    expect(jsonResp, {
      'data': {
        'getTasks': [
          ...data.map(
            (e) => e.toJson()
              ..['assignedTo'] = e.assignedTo.map((e) => e.toJson()).toList(),
          )
        ]
      },
      'extensions': {
        'tracing': {
          'parsing': _traceItemMatcher,
          'validation': _traceItemMatcher,
          'version': 1,
          'startTime': const TypeMatcher<String>(),
          'endTime': const TypeMatcher<String>(),
          'duration': const TypeMatcher<int>(),
          'execution': {
            'resolvers': isNotEmpty,
          }
        }
      },
    });

    int i = -1;
    final resolvers = [
      {
        'path': ['getTasks'],
        'parentType': 'Query',
        'fieldName': 'getTasks',
        'returnType': '[Task!]!',
        ..._traceItemMatcher,
      },
      ...data.expand(
        (task) {
          i++;
          return taskGraphQLType.fields.expand(
            (element) {
              return [
                {
                  'path': ['getTasks', i, element.name],
                  'parentType': 'Task',
                  'fieldName': element.name,
                  'returnType': '${element.type}',
                  ..._traceItemMatcher,
                },
                if (element.name == 'assignedTo') ...[
                  ...task.assignedTo.mapIndexed(
                    (ui, e) => {
                      'path': ['getTasks', i, 'assignedTo', ui, 'id'],
                      'parentType': 'User',
                      'fieldName': 'id',
                      'returnType': 'ID!',
                      ..._traceItemMatcher,
                    },
                  ),
                  ...task.assignedTo.mapIndexed(
                    (ui, e) => {
                      'path': ['getTasks', i, 'assignedTo', ui, 'name'],
                      'parentType': 'User',
                      'fieldName': 'name',
                      'returnType': 'String!',
                      ..._traceItemMatcher,
                    },
                  )
                ],
              ];
            },
          );
        },
      ),
    ];
    final map = Map.fromEntries(resolvers.map(
      (e) => MapEntry((e['path']! as List).join(','), e),
    ));
    expect(map.length, resolvers.length);
    for (final t in trace.execution!.resolvers.entries) {
      final expected = map[t.key.path.join(',')];
      if (expected == null) {
        throw Exception(t.key.path.join(','));
      }
      expect(t.key == ResolverTracing.fromJson(expected), true);
      expect({...t.key.toJson(t.value)}, expected);
    }
  });
}
