import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql/src/server_utils/graphql_request.dart';
import 'package:shelf_graphql_example/schema/books.controller.dart';
import 'package:shelf_graphql_example/schema/stream_state_callbacks.dart';
import 'package:test/test.dart';

import 'common.dart';

Future<void> main() async {
  final globals = <Object, Object?>{};
  final _streamCallbacks = StreamCallbacks();

  final books = booksControllerRef.set(
    globals,
    BooksController(bookAddedCallbacks: _streamCallbacks),
  );

  final server = await testServer(ServerConfig(
    globalVariables: globals,
    extensionList: [GraphQLTracingExtension(), GraphQLPersistedQueries()],
  ));

  test('tracing books', () async {
    final client = http.Client();
    const req = GraphQLRequest(
      query: '''
      { books { name }}
      ''',
    );
    final response2 = await client.post(
      server.url,
      body: jsonEncode(req.toJson()),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    expect(response2.statusCode, 200);

    const _traceItemMatcher = {
      'startOffset': TypeMatcher<int>(),
      'duration': TypeMatcher<int>(),
    };
    final bodyMap = jsonDecode(response2.body)! as Map<String, Object?>;
    expect(bodyMap, {
      'data': {
        'books': [
          ...books.allBooks.map((e) => {'name': e.name})
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
            'resolvers': [
              {
                'path': ['books'],
                'parentType': 'Queries',
                'fieldName': 'books',
                'returnType': '[Book]!',
                ..._traceItemMatcher,
              },
              ...Iterable.generate(
                books.allBooks.length,
                (i) => {
                  'path': ['books', i, 'name'],
                  'parentType': 'Book',
                  'fieldName': 'name',
                  'returnType': 'String!',
                  ..._traceItemMatcher,
                },
              )
            ]
          }
        }
      },
    });

    final tracing = Tracing.fromJson(
      (bodyMap['extensions']! as Map<String, Object?>)['tracing']!
          as Map<String, Object?>,
    );
    final booksTrace = tracing.execution.resolvers.values.first;

    final nestedDur = tracing.execution.resolvers.values
        .skip(1)
        .fold<int>(0, (value, element) => value + element.duration);
    expect(booksTrace.duration, greaterThan(nestedDur));
  });
}
