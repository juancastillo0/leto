import 'dart:convert';
import 'dart:io';

import 'package:gql/language.dart' show parseString;
import 'package:leto_schema/utilities.dart';
import 'package:leto_schema/validate.dart';
import 'package:test/test.dart';

import 'scenarios_models.dart';
import 'test_schema.dart';

Future<void> main() async {
  final files =
      Directory('./test/validation/scenarios').listSync().whereType<File>();

  for (final file in files) {
    Scenario? scenario;
    try {
      final fileContent = await file.readAsString();
      final jsonContent = json.decode(fileContent) as Map<String, Object?>;
      scenario = Scenario.fromJson(jsonContent);
    } catch (e) {
      print('ERROR in file ${file.uri.pathSegments.last} $e');
    }
    if (scenario == null) {
      continue;
    }
    group(scenario.name, () {
      for (final testCase in scenario!.tests) {
        String? skip;
        final rules = testCase.rules
            ?.map((e) {
              final valid = validationFromName(e);
              if (valid == null) {
                skip = 'validation name not found: $e';
              }
              return valid;
            })
            .whereType<ValidationRule>()
            .toList();

        test(testCase.name, () {
          final _schemaIn = testCase.schema ?? scenario!.schema;
          final schema = _schemaIn == null
              ? null
              : _schemaIn == 'testSchema'
                  ? testSchema
                  : buildSchema(_schemaIn);

          final document = parseString(testCase.document);

          if (schema != null) {
            final errors = validateDocument(
              schema,
              document,
              rules: rules ?? specifiedRules,
            );

            expect(
              errors.map(
                (e) => {
                  'message': e.message,
                  'locations': e.locations.map((e) => e.toJson())
                },
              ),
              (testCase.errors ?? []).map((e) {
                final json = e.toJson();

                return {
                  ...json,
                  if (e.locations.isNotEmpty)
                    'locations': e.locations.map(
                      (e) => {
                        'line': e.line - 1,
                        'column': e.column - 1,
                      },
                    )
                };
              }),
            );
          } else {
            // TOOD:
          }
        }, skip: skip);
      }
    });
  }
}
