// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:leto/leto.dart';
import 'package:leto/src/extensions/logging_extension.dart';
import 'package:leto/src/extensions/map_error_extension.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

class CustomError {
  final String msg;

  CustomError(this.msg);

  @override
  String toString() {
    return 'CustomError($msg)';
  }
}

void main() {
  test('logging extension', () async {
    const logs = [
      '{"operation":"opName","type":"query","result":{"data":{"fieldName":null}},"variables":null,"query":"query opName { fieldName }"}',
      '{"operation":"subsOpName","type":"subscription","result":{"data":"Stream<GraphQLResult>"},"variables":null,"query":"subscription subsOpName { subsFieldName }"}',
      '{"operation":"subsOpName","type":"subscription_event","result":{"data":{"subsFieldName":"1"}},"variables":null,"query":"subscription subsOpName { subsFieldName }"}',
      '{"operation":"subsOpName","type":"subscription_event","result":{"data":{"subsFieldName":"2"}},"variables":null,"query":"subscription subsOpName { subsFieldName }"}',
      r'{"operation":"opName","type":"query","result":{"errors":[{"message":"mapped:wrongInput"}],"data":{"fieldName":null}},"extensions":{"anyExtension":true},"variables":{"input":"wrongInput"},"query":"query opName($input: String) { fieldName(input: $input) }"}',
      r'{"operation":"wrongName","type":"unknown","result":{"errors":[{"message":"Operation named \"wrongName\" not found in query."}]},"extensions":{"anyExtension":{"value":2}},"variables":{"input":"wrongInput"},"query":"query opName($input: String) { fieldName(input: $input) }"}',
    ];

    int eventId = 0;
    DateTime before = clock.now();
    final executor = GraphQL(
      GraphQLSchema(
        queryType: objectType('Query', fields: [
          graphQLString.field(
            'fieldName',
            inputs: [
              graphQLString.inputField('input'),
            ],
            resolve: (_, ctx) {
              final input = ctx.args['input'] as String?;
              if (input != null && input.startsWith('wrong')) {
                throw CustomError(input);
              }
              return input;
            },
          ),
        ]),
        subscriptionType: objectType('Subscription', fields: [
          graphQLString.field(
            'subsFieldName',
            subscribe: (_, ctx) {
              return () async* {
                yield '1';
                await Future<void>.delayed(const Duration(seconds: 1));
                yield '2';
              }();
            },
          ),
        ]),
      ),
      extensions: [
        MapErrorExtension((thrown) {
          final inner = thrown.error;
          if (inner is CustomError) {
            return GraphQLException.fromMessage(
              'mapped:${inner.msg}',
              sourceError: thrown.error,
              stackTrace: thrown.stackTrace,
            );
          }
          return null;
        }),
        LoggingExtension(
          expectAsync1(
            (event) {
              final values = json.decode(
                event.toJsonString(withVariables: true),
              ) as Map<String, Object?>;
              final time = DateTime.parse(values.remove('time')! as String);
              expect(time.isAfter(before), true);
              expect(values.remove('dur')! as int > 0, true);
              before = time;

              final _log = json.decode(logs[eventId]) as Map<String, Object?>;
              expect(values, _log);

              if (eventId == 5) {
                expect(values.containsKey('variables'), true);
                expect(event.toJson().containsKey('variables'), false);
                expect(event.toString(), isNot(contains('variables')));
              }
              eventId++;
            },
            count: 6,
          ),
          onResolverError: expectAsync1((err) {
            expect(err.error, isA<CustomError>());
          }, count: 1),
        ),
      ],
    );

    await executor.parseAndExecute('query opName { fieldName }');
    final resultStream = await executor.parseAndExecute(
      'subscription subsOpName { subsFieldName }',
    );
    await resultStream.subscriptionStream!.toList();

    await executor.parseAndExecute(
      r'query opName($input: String) { fieldName(input: $input) }',
      variableValues: {'input': 'wrongInput'},
      extensions: {'anyExtension': true},
    );
    await executor.parseAndExecute(
      r'query opName($input: String) { fieldName(input: $input) }',
      variableValues: {'input': 'wrongInput'},
      extensions: {
        'anyExtension': {'value': 2}
      },
      operationName: 'wrongName',
    );
  });
}
