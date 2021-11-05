// https://github.com/graphql/graphql-js/blob/8261922bafb8c2b5c5041093ce271bdfcdf133c3/src/execution/__tests__/variables-test.ts
import 'package:leto/leto.dart';
import 'package:leto/types/json.dart';
import 'package:leto_schema/leto_schema.dart';

import 'package:test/test.dart';

// final TestComplexScalar = new GraphQLScalarType({
//   name: 'ComplexScalar',
//   parseValue(value) {
//     expect(value).to.equal('SerializedValue');
//     return 'DeserializedValue';
//   },
//   parseLiteral(ast) {
//     expect(ast).to.include({ kind: 'StringValue', value: 'SerializedValue' });
//     return 'DeserializedValue';
//   },
// });

final testComplexScalar = TestComplexScalar();

class TestComplexScalar extends GraphQLScalarType<String, String> {
  @override
  String get name => 'ComplexScalar';
  @override
  String? get description => null;

  @override
  String deserialize(SerdeCtx serdeCtx, String serialized) {
    assert(serialized == 'SerializedValue');
    return 'DeserializedValue';
  }

  @override
  String serialize(String value) {
    assert(value == 'DeserializedValue');
    return 'SerializedValue';
  }

  @override
  ValidationResult<String> validate(String key, Object? input) {
    if (input is String && input == 'SerializedValue') {
      return ValidationResult.ok(input);
    }
    return ValidationResult.failure(
        ['Expected $key = $input to be "SerializedValue"']);
  }

  @override
  Iterable<Object?> get props => [];
}

final TestInputObject = GraphQLInputObjectType<Object>(
  'TestInputObject',
  fields: [
    GraphQLFieldInput('a', graphQLString),
    GraphQLFieldInput('b', listOf(graphQLString)),
    GraphQLFieldInput('c', graphQLString.nonNull()),
    GraphQLFieldInput('d', testComplexScalar),
  ],
);

final TestNestedInputObject = GraphQLInputObjectType<Map<String, Object?>>(
  'TestNestedInputObject',
  fields: [
    GraphQLFieldInput('na', TestInputObject.nonNull()),
    GraphQLFieldInput('nb', graphQLString.nonNull()),
  ],
);

// TODO: should we allow non null values? is GraphQLType generics?
// maybe support Option, Result
// final TestEnum = GraphQLEnumType<Map<String, Object?>>(
//   'TestEnum',
//   const [
//     GraphQLEnumValue('NULL', {'value': null}),
//     // TODO: {'value': undefined}
//     GraphQLEnumValue('UNDEFINED', {'value': null}),
//     GraphQLEnumValue('NAN', {'value': double.nan}),
//     GraphQLEnumValue('FALSE', {'value': false}),
//     GraphQLEnumValue('CUSTOM', {'value': 'custom value'}),
//     GraphQLEnumValue('DEFAULT_VALUE', {}),
//   ],
// );

final TestEnum = GraphQLEnumType<Json>(
  'TestEnum',
  const [
    GraphQLEnumValue('NULL', Json.null_),
    // TODO: {'value': undefined}
    GraphQLEnumValue('UNDEFINED', Json.null_),
    GraphQLEnumValue('NAN', JsonNumber(double.nan)),
    GraphQLEnumValue('FALSE', JsonBoolean(false)),
    GraphQLEnumValue('CUSTOM', JsonStr('custom value')),
    // TODO: default value
    GraphQLEnumValue('DEFAULT_VALUE', JsonStr('DEFAULT_VALUE')),
  ],
);

GraphQLObjectField<Json, Object?, Object?> fieldWithInputArg<V>(
  String name,
  GraphQLType<V, Object?> type, {
  V? defaultValue,
}) {
  return jsonGraphQLType.field(
    name,
    inputs: [
      GraphQLFieldInput(
        'input',
        type,
        defaultValue: defaultValue,
      )
    ],
    resolve: (_, ctx) {
      if (ctx.args.containsKey('input')) {
        final value = Json.fromJson(ctx.args['input']);
        // TODO: a GraphQL Type can't serialize to 'null' like JsonNone would do
        return value;
      }
    },
  );
}

final TestType = GraphQLObjectType(
  'TestType',
  fields: {
    fieldWithInputArg('fieldWithEnumInput', TestEnum),
    fieldWithInputArg(
      'fieldWithNonNullableEnumInput',
      TestEnum.nonNull(),
    ),
    fieldWithInputArg('fieldWithObjectInput', TestInputObject),
    fieldWithInputArg('fieldWithNullableStringInput', graphQLString),
    fieldWithInputArg(
      'fieldWithNonNullableStringInput',
      graphQLString.nonNull(),
    ),
    fieldWithInputArg(
      'fieldWithDefaultArgumentValue',
      graphQLString,
      defaultValue: 'Hello World',
    ),
    fieldWithInputArg(
      'fieldWithNonNullableStringInputAndDefaultArgumentValue',
      graphQLString.nonNull(),
      defaultValue: 'Hello World',
    ),
    fieldWithInputArg(
      'fieldWithNestedInputObject',
      TestNestedInputObject,
      // TODO: was 'Hello World',
      defaultValue: <String, Object?>{},
    ),
    fieldWithInputArg('list', listOf(graphQLString)),
    fieldWithInputArg(
      'nnList',
      listOf(graphQLString).nonNull(),
    ),
    fieldWithInputArg(
      'listNN',
      listOf(graphQLString.nonNull()),
    ),
    fieldWithInputArg(
      'nnListNN',
      listOf(graphQLString.nonNull()).nonNull(),
    ),
    // TODO:
    // fieldWithInputArg(
    //   'nnListE',
    //   listOf(TestEnum).nonNull(),
    // ),
    // fieldWithInputArg(
    //   'listENN',
    //   listOf(TestEnum.nonNull()),
    // ),
    // fieldWithInputArg(
    //   'nnListENN',
    //   listOf(TestEnum.nonNull()).nonNull(),
    // ),
  },
);

final schema = GraphQLSchema(queryType: TestType);

final server = GraphQL(schema);

Future<Map<String, Object?>> executeQuery(
  String query, [
  Map<String, Object?>? variableValues,
]) async {
  final values = await server.parseAndExecute(
    query,
    variableValues: variableValues,
  );
  return values.toJson();
}

/// Execute: Handles inputs
Future<void> main() async {
  group('Handles objects and nullability', () {
    group('using inline structs', () {
      test('executes with complex input', () async {
        final result = await executeQuery('''
          {
            fieldWithObjectInput(input: {a: "foo", b: ["bar"], c: "baz"})
          }
        ''');

        expect(result, {
          'data': {
            'fieldWithObjectInput': {
              'a': 'foo',
              'b': ['bar'],
              'c': 'baz'
            },
          },
        });
      });

      test('properly parses single value to list', () async {
        final result = await executeQuery('''
          {
            fieldWithObjectInput(input: {a: "foo", b: "bar", c: "baz"})
          }
        ''');

        expect(result, {
          'data': {
            'fieldWithObjectInput': {
              'a': 'foo',
              'b': ['bar'],
              'c': 'baz'
            },
          },
        });
      });

      test('properly parses null value to null', () async {
        final result = await executeQuery('''
          {
            fieldWithObjectInput(input: {a: null, b: null, c: "C", d: null})
          }
        ''');

        expect(result, {
          'data': {
            'fieldWithObjectInput': {'a': null, 'b': null, 'c': 'C', 'd': null},
          },
        });
      });

      test('properly parses null value in list', () async {
        final result = await executeQuery('''
          {
            fieldWithObjectInput(input: {b: ["A",null,"C"], c: "C"})
          }
        ''');

        expect(result, {
          'data': {
            'fieldWithObjectInput': {
              'b': ['A', null, 'C'],
              'c': 'C'
            },
          },
        });
      });

      test('does not use incorrect value', () async {
        final result = await executeQuery('''
          {
            fieldWithObjectInput(input: ["foo", "bar", "baz"])
          }
        ''');

        expect(result, {
          'data': {
            'fieldWithObjectInput': null,
          },
          'errors': [
            {
              'message': stringContainsInOrder([
                'input',
                'TestInputObject',
                'fieldWithObjectInput',
                '[foo, bar, baz]'
              ]),
              // 'Argument "input" has invalid value ["foo", "bar", "baz"].',
              'path': ['fieldWithObjectInput'],
              'locations': [
                {'line': 1, 'column': 33}
              ],
            },
          ],
        });
      });

      test('properly runs parseLiteral on complex scalar types', () async {
        final result = await executeQuery('''
          {
            fieldWithObjectInput(input: {c: "foo", d: "SerializedValue"})
          }
        ''');

        expect(result, {
          'data': {
            'fieldWithObjectInput': {'c': 'foo', 'd': 'DeserializedValue'},
          },
        });
      });
    });

    group('using variables', () {
      const doc = r'''
        query ($input: TestInputObject) {
          fieldWithObjectInput(input: $input)
        }
      ''';

      test('executes with complex input', () async {
        const params = {
          'input': {
            'a': 'foo',
            'b': ['bar'],
            'c': 'baz'
          }
        };
        final result = await executeQuery(doc, params);

        expect(result, {
          'data': {
            'fieldWithObjectInput': {
              'a': 'foo',
              'b': ['bar'],
              'c': 'baz'
            },
          },
        });
      });

      test('uses undefined when variable not provided', () async {
        final result = await executeQuery(
          r'''
          query q($input: String) {
            fieldWithNullableStringInput(input: $input)
          }''',
          {
            // Intentionally missing variable values.
          },
        );

        expect(result, {
          'data': {
            'fieldWithNullableStringInput': null,
          },
        });
      });

      test('uses null when variable provided explicit null value', () async {
        final result = await executeQuery(
          r'''
          query q($input: String) {
            fieldWithNullableStringInput(input: $input)
          }''',
          {'input': null},
        );

        expect(result, {
          'data': {
            'fieldWithNullableStringInput': null,
          },
        });
      });

      test('uses default value when not provided', () async {
        final result = await executeQuery(r'''
          query ($input: TestInputObject = {a: "foo", b: ["bar"], c: "baz"}) {
            fieldWithObjectInput(input: $input)
          }
        ''');

        expect(result, {
          'data': {
            'fieldWithObjectInput': {
              'a': 'foo',
              'b': ['bar'],
              'c': 'baz'
            },
          },
        });
      });

      test('does not use default value when provided', () async {
        final result = await executeQuery(
          r'''
            query q($input: String = "Default value") {
              fieldWithNullableStringInput(input: $input)
            }
          ''',
          {'input': 'Variable value'},
        );

        expect(result, {
          'data': {
            'fieldWithNullableStringInput': 'Variable value',
          },
        });
      });

      test('uses explicit null value instead of default value', () async {
        final result = await executeQuery(
          r'''
          query q($input: String = "Default value") {
            fieldWithNullableStringInput(input: $input)
          }''',
          {'input': null},
        );

        expect(result, {
          'data': {
            'fieldWithNullableStringInput': null,
          },
        });
      });

      test('uses null default value when not provided', () async {
        final result = await executeQuery(
          r'''
          query q($input: String = null) {
            fieldWithNullableStringInput(input: $input)
          }''',
          {
            // Intentionally missing variable values.
          },
        );

        expect(result, {
          'data': {
            'fieldWithNullableStringInput': null,
          },
        });
      });

      test('properly parses single value to list', () async {
        const params = {
          'input': {'a': 'foo', 'b': 'bar', 'c': 'baz'}
        };
        final result = await executeQuery(doc, params);

        expect(result, {
          'data': {
            'fieldWithObjectInput': {
              'a': 'foo',
              'b': ['bar'],
              'c': 'baz'
            },
          },
        });
      });

      test('executes with complex scalar input', () async {
        const params = {
          'input': {'c': 'foo', 'd': 'SerializedValue'}
        };
        final result = await executeQuery(doc, params);

        expect(result, {
          'data': {
            'fieldWithObjectInput': {'c': 'foo', 'd': 'DeserializedValue'},
          },
        });
      });

      test('errors on null for nested non-null', () async {
        const params = {
          'input': {'a': 'foo', 'b': 'bar', 'c': null}
        };
        final result = await executeQuery(doc, params);

        expect(result, {
          // TOOD: graphql-js only sends one error
          'errors': [
            {
              // r'Variable "$input" got invalid value null at "input.c";'
              //     ' Expected non-nullable type "String!" not to be null.',
              'message': isNot(isEmpty),
              'locations': [
                {'line': 0, 'column': 16}
              ],
            },
          ],
        });
      });

      test('errors on incorrect type', () async {
        final result = await executeQuery(doc, {'input': 'foo bar'});

        expect(result, {
          'errors': [
            {
              // r'Variable "$input" got invalid value "foo bar";'
              //     ' Expected type "TestInputObject" to be an object.'
              'message': stringContainsInOrder(<String>['input', 'foo bar']),
              'locations': [
                {'line': 0, 'column': 16}
              ],
            },
          ],
        });
      });

      test('errors on omission of nested non-null', () async {
        final result = await executeQuery(doc, {
          'input': {'a': 'foo', 'b': 'bar'}
        });

        expect(result, {
          'errors': <Object>[
            {
              // r'''Variable "$input" got invalid value { 'a': "foo",
              //'b': "bar" }; Field "c" of required type "String!" was not provided.'''
              'message': stringContainsInOrder(['input', '"c"', 'String!']),
              'locations': [
                {'line': 0, 'column': 16}
              ],
            },
          ],
        });
      });

      test('errors on deep nested errors and with many errors', () async {
        const nestedDoc = r'''
          query ($input: TestNestedInputObject) {
            fieldWithNestedObjectInput(input: $input)
          }
        ''';
        final result = await executeQuery(nestedDoc, {
          'input': {
            'na': {'a': 'foo'}
          }
        });

        expect(result, {
          'errors': unorderedEquals(<Object>[
            {
              // r'Variable "$input" got invalid value { a: "foo" } at "input.na";'
              //     ' Field "c" of required type "String!" was not provided.',
              'message': stringContainsInOrder(['input', '"c"', 'String!']),
              'locations': [
                {'line': 0, 'column': 18}
              ],
            },
            {
              // r'Variable "$input" got invalid value { na: { a: "foo" } }; Field'
              //     ' "nb" of required type "String!" was not provided.',
              'message': stringContainsInOrder(['input', '"nb"', 'String!']),
              'locations': [
                {'line': 0, 'column': 18}
              ],
            },
          ]),
        });
      });

      test('errors on addition of unknown input field', () async {
        const params = {
          'input': {'a': 'foo', 'b': 'bar', 'c': 'baz', 'extra': 'dog'},
        };
        final result = await executeQuery(doc, params);

        expect(result, {
          'errors': [
            {
              // r'Variable "$input" got invalid value { a: "foo", b: "bar",'
              //     ' c: "baz", extra: "dog" }; Field "extra" is not'
              //     ' defined by type "TestInputObject".',
              'message': stringContainsInOrder(
                  ['"extra"', 'input', 'TestInputObject']),
              'locations': [
                {'line': 0, 'column': 16}
              ],
            },
          ],
        });
      });
    });
  });

  group('Handles custom enum values', () {
    test('allows custom enum values as inputs', () async {
      final result = await executeQuery('''
        {
          null: fieldWithEnumInput(input: NULL)
          NaN: fieldWithEnumInput(input: NAN)
          false: fieldWithEnumInput(input: FALSE)
          customValue: fieldWithEnumInput(input: CUSTOM)
          defaultValue: fieldWithEnumInput(input: DEFAULT_VALUE)
        }
      ''');

      expect(result, {
        'data': {
          'null': null,
          'NaN': isNaN,
          'false': false,
          'customValue': 'custom value',
          'defaultValue': 'DEFAULT_VALUE',
        },
      });
    });

    test('allows non-nullable inputs to have null as enum custom value',
        () async {
      final result = await executeQuery('''
        {
          fieldWithNonNullableEnumInput(input: NULL)
        }
      ''');

      expect(result, {
        'data': {
          // TODO: was 'null' should we stringify?
          'fieldWithNonNullableEnumInput': null,
        },
      });
    });
  });

  group('Handles nullable scalars', () {
    test('allows nullable inputs to be omitted', () async {
      final result = await executeQuery('''
        {
          fieldWithNullableStringInput
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNullableStringInput': null,
        },
      });
    });

    test('allows nullable inputs to be omitted in a variable', () async {
      final result = await executeQuery(r'''
        query ($value: String) {
          fieldWithNullableStringInput(input: $value)
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNullableStringInput': null,
        },
      });
    });

    test('allows nullable inputs to be omitted in an unlisted variable',
        () async {
      final result = await executeQuery(r'''
        query {
          fieldWithNullableStringInput(input: $value)
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNullableStringInput': null,
        },
      });
    });

    test('allows nullable inputs to be set to null in a variable', () async {
      const doc = r'''
        query ($value: String) {
          fieldWithNullableStringInput(input: $value)
        }
      ''';
      final result = await executeQuery(doc, {'value': null});

      expect(result, {
        'data': {
          'fieldWithNullableStringInput': null,
        },
      });
    });

    test('allows nullable inputs to be set to a value in a variable', () async {
      const doc = r'''
        query ($value: String) {
          fieldWithNullableStringInput(input: $value)
        }
      ''';
      final result = await executeQuery(doc, {'value': 'a'});

      expect(result, {
        'data': {
          'fieldWithNullableStringInput': 'a',
        },
      });
    });

    test('allows nullable inputs to be set to a value directly', () async {
      final result = await executeQuery('''
        {
          fieldWithNullableStringInput(input: "a")
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNullableStringInput': 'a',
        },
      });
    });
  });

  group('Handles non-nullable scalars', () {
    test('allows non-nullable variable to be omitted given a default',
        () async {
      final result = await executeQuery(r'''
        query ($value: String! = "default") {
          fieldWithNullableStringInput(input: $value)
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNullableStringInput': 'default',
        },
      });
    });

    test('allows non-nullable inputs to be omitted given a default', () async {
      final result = await executeQuery(r'''
        query ($value: String = "default") {
          fieldWithNonNullableStringInput(input: $value)
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNonNullableStringInput': 'default',
        },
      });
    });

    test('does not allow non-nullable inputs to be omitted in a variable',
        () async {
      final result = await executeQuery(r'''
        query ($value: String!) {
          fieldWithNonNullableStringInput(input: $value)
        }
      ''');

      expect(result, {
        'errors': [
          {
            // 'Variable "$value" of required type "String!" was not provided.',
            'message': stringContainsInOrder(['value', 'String!']),
            'locations': [
              {'line': 0, 'column': 16}
            ],
          },
        ],
      });
    });

    test('does not allow non-nullable inputs to be set to null in a variable',
        () async {
      const doc = r'''
        query ($value: String!) {
          fieldWithNonNullableStringInput(input: $value)
        }
      ''';
      final result = await executeQuery(doc, {'value': null});

      expect(result, {
        'errors': [
          {
            // 'Variable "$value" of non-null type "String!" must not be null.',
            'message':
                stringContainsInOrder(['value', 'String!', 'not be null']),
            'locations': [
              {'line': 0, 'column': 16}
            ],
          },
        ],
      });
    });

    test('allows non-nullable inputs to be set to a value in a variable',
        () async {
      const doc = r'''
        query ($value: String!) {
          fieldWithNonNullableStringInput(input: $value)
        }
      ''';
      final result = await executeQuery(doc, {'value': 'a'});

      expect(result, {
        'data': {
          'fieldWithNonNullableStringInput': 'a',
        },
      });
    });

    test('allows non-nullable inputs to be set to a value directly', () async {
      final result = await executeQuery('''
        {
          fieldWithNonNullableStringInput(input: "a")
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNonNullableStringInput': 'a',
        },
      });
    });

    test('reports error for missing non-nullable inputs', () async {
      final result = await executeQuery('{ fieldWithNonNullableStringInput }');

      expect(result, {
        'data': {
          'fieldWithNonNullableStringInput': null,
        },
        'errors': [
          {
            // 'Argument "input" of required type "String!" was not provided.',
            'message': stringContainsInOrder(
                ['input', 'String!', 'fieldWithNonNullableStringInput']),
            'locations': [
              {'line': 0, 'column': 2}
            ],
            'path': ['fieldWithNonNullableStringInput'],
          },
        ],
      });
    });

    test('reports error for array passed into string input', () async {
      const doc = r'''
        query ($value: String!) {
          fieldWithNonNullableStringInput(input: $value)
        }
      ''';
      final result = await executeQuery(doc, {
        'value': [1, 2, 3]
      });

      expect(result, {
        'errors': [
          {
            // r'Variable "$value" got invalid value [1, 2, 3]; String cannot represent a non string value: [1, 2, 3]',
            'message': stringContainsInOrder(['value', 'string', '[1, 2, 3]']),
            'locations': [
              {'line': 0, 'column': 16}
            ],
          },
        ],
      });

      // TODO:
      // expect(result).to.have.nested.property('errors[0].originalError');
    });

    test('reports error for non-provided variables for non-nullable inputs',
        () async {
      // Note: this test would typically fail validation before encountering
      // this execution error, however for queries which previously validated
      // and are being run against a new schema which have introduced a breaking
      // change to make a formerly non-required argument required, this asserts
      // failure before allowing the underlying code to receive a non-null value.
      final result = await executeQuery(r'''
        {
          fieldWithNonNullableStringInput(input: $foo)
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNonNullableStringInput': null,
        },
        'errors': [
          {
            // r'Argument "input" of required type "String!" was provided the variable "$foo" which was not provided a runtime value.',
            'message': stringContainsInOrder(
                ['input', 'String!', 'fieldWithNonNullableStringInput']),
            'locations': [
              {'line': 1, 'column': 42}
            ],
            'path': ['fieldWithNonNullableStringInput'],
          },
        ],
      });
    });
  });

  group('Handles lists and nullability', () {
    test('allows lists to be null', () async {
      const doc = r'''
        query ($input: [String]) {
          list(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {'input': null});

      expect(result, {
        'data': {'list': null}
      });
    });

    test('allows lists to contain values', () async {
      const doc = r'''
        query ($input: [String]) {
          list(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': ['A']
      });

      expect(result, {
        'data': {
          'list': ['A']
        }
      });
    });

    test('allows lists to contain null', () async {
      const doc = r'''
        query ($input: [String]) {
          list(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': ['A', null, 'B']
      });

      expect(result, {
        'data': {
          'list': ['A', null, 'B']
        }
      });
    });

    test('does not allow non-null lists to be null', () async {
      const doc = r'''
        query ($input: [String]!) {
          nnList(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {'input': null});

      expect(result, {
        'errors': [
          {
            'message': stringContainsInOrder(['input', '[String]!']),
            // 'Variable "$input" of non-null type "[String]!" must not be null.',
            'locations': [
              {'line': 0, 'column': 16}
            ],
          },
        ],
      });
    });

    test('allows non-null lists to contain values', () async {
      const doc = r'''
        query ($input: [String]!) {
          nnList(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': ['A']
      });

      expect(result, {
        'data': {
          'nnList': ['A']
        }
      });
    });

    test('allows non-null lists to contain null', () async {
      const doc = r'''
        query ($input: [String]!) {
          nnList(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': ['A', null, 'B']
      });

      expect(result, {
        'data': {
          'nnList': ["A", null, "B"]
        }
      });
    });

    test('allows lists of non-nulls to be null', () async {
      const doc = r'''
        query ($input: [String!]) {
          listNN(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {'input': null});

      expect(result, {
        'data': {'listNN': null}
      });
    });

    test('allows lists of non-nulls to contain values', () async {
      const doc = r'''
        query ($input: [String!]) {
          listNN(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': ['A']
      });

      expect(result, {
        'data': {
          'listNN': ["A"]
        }
      });
    });

    test('does not allow lists of non-nulls to contain null', () async {
      const doc = r'''
        query ($input: [String!]) {
          listNN(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': ['A', null, 'B']
      });

      expect(result, {
        'errors': [
          {
            'message':
                stringContainsInOrder(['input[1]', 'non-null', 'String!']),
            // 'Variable "$input" got invalid value null at "input[1]"; Expected non-nullable type "String!" not to be null.',
            'locations': [
              {'line': 0, 'column': 16}
            ],
          },
        ],
      });
    });

    test('does not allow non-null lists of non-nulls to be null', () async {
      const doc = r'''
        query ($input: [String!]!) {
          nnListNN(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {'input': null});

      expect(result, {
        'errors': [
          {
            'message':
                stringContainsInOrder(['input', '[String!]!', 'not be null']),
            // 'Variable "$input" of non-null type "[String!]!" must not be null.',
            'locations': [
              {'line': 0, 'column': 16}
            ],
          },
        ],
      });
    });

    test('allows non-null lists of non-nulls to contain values', () async {
      const doc = r'''
        query ($input: [String!]!) {
          nnListNN(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': ['A']
      });

      expect(result, {
        'data': {
          'nnListNN': ["A"]
        }
      });
    });

    test('does not allow non-null lists of non-nulls to contain null',
        () async {
      const doc = r'''
        query ($input: [String!]!) {
          nnListNN(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': ['A', null, 'B']
      });

      expect(result, {
        'errors': [
          {
            'message':
                stringContainsInOrder(['input[1]', 'non-null', 'String!']),
            // 'Variable "$input" got invalid value null at "input[1]"; Expected non-nullable type "String!" not to be null.',
            'locations': [
              {'line': 0, 'column': 16}
            ],
          },
        ],
      });
    });

    test('does not allow invalid types to be used as values', () async {
      const doc = r'''
        query ($input: TestType!) {
          fieldWithObjectInput(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {
        'input': {
          'list': ['A', 'B']
        }
      });

      expect(result, {
        'errors': [
          {
            'message': stringContainsInOrder([
              'input',
              'TestType!',
              'which cannot be used as an input type'
            ]),
            // 'Variable "$input" expected value of type "TestType!" which cannot be used as an input type.',
            'locations': [
              {'line': 0, 'column': 16}
            ],
          },
        ],
      });
    });

    test('does not allow unknown types to be used as values', () async {
      const doc = r'''
        query ($input: UnknownType!) {
          fieldWithObjectInput(input: $input)
        }
      ''';
      final result = await executeQuery(doc, {'input': 'WhoKnows'});

      expect(result, {
        'errors': [
          {
            'message': stringContainsInOrder(['Unknown', '"UnknownType"']),
            // 'Variable "$input" expected value of type "UnknownType!" which cannot be used as an input type.',
            'locations': [
              {'line': 0, 'column': 23}
            ],
          },
        ],
      });
    });
  });

  group('Execute: Uses argument default values', () {
    test('when no argument provided', () async {
      final result = await executeQuery('{ fieldWithDefaultArgumentValue }');

      expect(result, {
        'data': {
          'fieldWithDefaultArgumentValue': 'Hello World',
        },
      });
    });

    test('when omitted variable provided', () async {
      final result = await executeQuery(r'''
        query ($optional: String) {
          fieldWithDefaultArgumentValue(input: $optional)
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithDefaultArgumentValue': 'Hello World',
        },
      });
    });

    test('not when argument cannot be coerced', () async {
      final result = await executeQuery('''
        {
          fieldWithDefaultArgumentValue(input: WRONG_TYPE)
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithDefaultArgumentValue': null,
        },
        'errors': [
          {
            'message':
                stringContainsInOrder(['"input"', 'String', 'WRONG_TYPE']),
            // 'Argument "input" has invalid value WRONG_TYPE.',
            'locations': [
              {'line': 1, 'column': 40}
            ],
            'path': ['fieldWithDefaultArgumentValue'],
          },
        ],
      });
    });

    test('when no runtime value is provided to a non-null argument', () async {
      final result = await executeQuery(r'''
        query optionalVariable($optional: String) {
          fieldWithNonNullableStringInputAndDefaultArgumentValue(input: $optional)
        }
      ''');

      expect(result, {
        'data': {
          'fieldWithNonNullableStringInputAndDefaultArgumentValue':
              'Hello World',
        },
      });
    });
  });

//   group('getVariableValues: limit maximum number of coercion errors', () {
//     const doc = r'''
//       query ($input: [String!]) {
//         listNN(input: $input)
//       }
//     ''';

//     const operation = doc.definitions[0];
//     invariant(operation.kind === Kind.OPERATION_DEFINITION);
//     const { variableDefinitions } = operation;
//     invariant(variableDefinitions != null);

//     const inputValue = { 'input': [0, 1, 2] };

//     Map<String, Object?> invalidValueError(int value,int  index) {
//       return {
//         'message': '''Variable "\$input" got invalid value ${value} at "input[${index}]"; String cannot represent a non string value: ${value}''',
//         'locations': [{ 'line': 2, 'column': 14 }],
//       };
//     }

//     test('return all errors by default', () async {
//       const result = getVariableValues(schema, variableDefinitions, inputValue);

//       expect(result, {
//         'errors': [
//           invalidValueError(0, 0),
//           invalidValueError(1, 1),
//           invalidValueError(2, 2),
//         ],
//       });
//     });

//     test('when maxErrors is equal to number of errors', () async {
//       const result = getVariableValues(
//         schema,
//         variableDefinitions,
//         inputValue,
//         { 'maxErrors': 3 },
//       );

//       expect(result, {
//         'errors': [
//           invalidValueError(0, 0),
//           invalidValueError(1, 1),
//           invalidValueError(2, 2),
//         ],
//       });
//     });

// //     test('when maxErrors is less than number of errors', () async {
// //       const result = getVariableValues(
// //         schema,
// //         variableDefinitions,
// //         inputValue,
// //         { maxErrors: 2 },
// //       );

// //       expectJSON(result, {
// //         errors: [
// //           invalidValueError(0, 0),
// //           invalidValueError(1, 1),
// //           {
// //             message:
// //               'Too many errors processing variables, error limit reached. Execution aborted.',
// //           },
// //         ],
// //       });
// //     });
//   });
}
