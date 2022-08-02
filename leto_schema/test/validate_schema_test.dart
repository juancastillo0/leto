// ignore_for_file: implicit_dynamic_list_literal

import 'package:gql/language.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/utilities/build_schema.dart' as bs;
import 'package:leto_schema/src/utilities/extend_schema.dart' as es;
import 'package:leto_schema/src/validate/rules_prelude.dart';
import 'package:leto_schema/src/validate/validate_schema.dart' as vs;
import 'package:test/test.dart';
import 'package:test/test.dart' as t;

List<Map<String, Object?>> validateSchema(Object schema) {
  List<GraphQLError> errors;
  try {
    if (schema is List<GraphQLError>) {
      errors = schema;
    } else {
      errors = vs.validateSchema(schema as GraphQLSchema);
    }
  } on GraphQLException catch (e) {
    errors = e.errors;
  }
  return errors
      .map((e) => {
            'message': e.message,
            // TODO: 3I some ast nodes don't have spans from package:gql parsing
            // if (e.locations.isNotEmpty)
            //   'locations': e.locations
            //       .map((e) => {'line': e.line + 2, 'column': e.column + 1})
            //       .toList()
          })
      .toList();
}

Object buildSchema(String document) {
  try {
    return bs.buildSchema(document);
  } on GraphQLException catch (e) {
    return e.errors;
  }
}

void expectJSON(Object? actual, Object? matcher) {
  final exp = matcher is List
      ? matcher.map((Object? e) => (e as Map)..remove('locations')).toList()
      : matcher;
  t.expect(actual, exp);
}

Object extendSchema(Object schema, DocumentNode document) {
  if (schema is GraphQLSchema) {
    try {
      return es.extendSchema(schema, document);
    } on GraphQLException catch (e) {
      return e.errors;
    }
  } else {
    return schema;
  }
}

final SomeSchema = buildSchema('''
  scalar SomeScalar

  interface SomeInterface { f: SomeObject }

  type SomeObject implements SomeInterface { f: SomeObject }

  union SomeUnion = SomeObject

  enum SomeEnum { ONLY }

  input SomeInputObject { val: String = "hello" }

  directive @SomeDirective on QUERY
''') as GraphQLSchema;

final SomeScalarType = SomeSchema.getType('SomeScalar') as GraphQLScalarType;
final SomeInterfaceType = SomeSchema.getType('SomeInterface')
    as GraphQLObjectType; // GraphQLInterfaceType
final SomeObjectType = SomeSchema.getType('SomeObject') as GraphQLObjectType;
final SomeUnionType = SomeSchema.getType('SomeUnion') as GraphQLUnionType;
final SomeEnumType = SomeSchema.getType('SomeEnum') as GraphQLEnumType;
final SomeInputObjectType =
    SomeSchema.getType('SomeInputObject') as GraphQLInputObjectType;
final SomeDirective =
    SomeSchema.getDirective('SomeDirective') as GraphQLDirective;

List<GraphQLType> withModifiers<T extends GraphQLNamedType<Object?, Object?>>(
  T type,
) {
  return [
    type,
    type.list(),
    type.nonNull(),
    type.list().nonNull(),
  ];
}

// GraphQLOutputType
final outputTypes = <GraphQLType>[
  ...withModifiers(graphQLString),
  ...withModifiers(SomeScalarType),
  ...withModifiers(SomeEnumType),
  ...withModifiers(SomeObjectType),
  ...withModifiers(SomeUnionType),
  ...withModifiers(SomeInterfaceType),
];

// GraphQLInputType
final notOutputTypes = <GraphQLType>[
  ...withModifiers(SomeInputObjectType),
];

// GraphQLInputType
final inputTypes = <GraphQLType>[
  ...withModifiers(graphQLString),
  ...withModifiers(SomeScalarType),
  ...withModifiers(SomeEnumType),
  ...withModifiers(SomeInputObjectType),
];

// GraphQLOutputType
final notInputTypes = <GraphQLType>[
  ...withModifiers(SomeObjectType),
  ...withModifiers(SomeUnionType),
  ...withModifiers(SomeInterfaceType),
];

// GraphQLOutputType
GraphQLSchema schemaWithFieldType(GraphQLType type) {
  return GraphQLSchema(
    queryType: GraphQLObjectType<Object?>(
      'Query',
      fields: [field('f', type)],
    ),
  );
}

void main() {
  /// Don't assert invariants in constructors so we can test errors
  /// not caught by the type system
  checkAsserts = false;

  group('Type System: A Schema must have Object root types', () {
    test('accepts a Schema whose query type is an object type', () {
      final schema = buildSchema('''
      type Query {
        test: String
      }
    ''');
      expectJSON(validateSchema(schema), []);

      final schemaWithDef = buildSchema('''
      schema {
        query: QueryRoot
      }

      type QueryRoot {
        test: String
      }
    ''');
      expectJSON(validateSchema(schemaWithDef), []);
    });

    test('accepts a Schema whose query and mutation types are object types',
        () {
      final schema = buildSchema('''
      type Query {
        test: String
      }

      type Mutation {
        test: String
      }
    ''');
      expectJSON(validateSchema(schema), []);

      final schemaWithDef = buildSchema('''
      schema {
        query: QueryRoot
        mutation: MutationRoot
      }

      type QueryRoot {
        test: String
      }

      type MutationRoot {
        test: String
      }
    ''');
      expectJSON(validateSchema(schemaWithDef), []);
    });

    test('accepts a Schema whose query and subscription types are object types',
        () {
      final schema = buildSchema('''
      type Query {
        test: String
      }

      type Subscription {
        test: String
      }
    ''');
      expectJSON(validateSchema(schema), []);

      final schemaWithDef = buildSchema('''
      schema {
        query: QueryRoot
        subscription: SubscriptionRoot
      }

      type QueryRoot {
        test: String
      }

      type SubscriptionRoot {
        test: String
      }
    ''');
      expectJSON(validateSchema(schemaWithDef), []);
    });

    test('rejects a Schema without a query type', () {
      final schema = buildSchema('''
      type Mutation {
        test: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message': 'Query root type must be provided.',
        },
      ]);

      final schemaWithDef = buildSchema('''
      schema {
        mutation: MutationRoot
      }

      type MutationRoot {
        test: String
      }
    ''');
      expectJSON(validateSchema(schemaWithDef), [
        {
          'message': 'Query root type must be provided.',
          'locations': [
            {'line': 2, 'column': 7}
          ],
        },
      ]);
    });

    test('rejects a Schema whose query root type is not an Object type', () {
      final schema = buildSchema('''
      input Query {
        test: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message': 'Query root type must be Object type, it cannot be Query.',
          'locations': [
            {'line': 2, 'column': 7}
          ],
        },
      ]);

      final schemaWithDef = buildSchema('''
      schema {
        query: SomeInputObject
      }

      input SomeInputObject {
        test: String
      }
    ''');
      expectJSON(validateSchema(schemaWithDef), [
        {
          'message':
              'Query root type must be Object type, it cannot be SomeInputObject.',
          'locations': [
            {'line': 3, 'column': 16}
          ],
        },
      ]);
    });

    test('rejects a Schema whose mutation type is an input type', () {
      final schema = buildSchema('''
      type Query {
        field: String
      }

      input Mutation {
        test: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Mutation root type must be Object type if provided, it cannot be Mutation.',
          'locations': [
            {'line': 6, 'column': 7}
          ],
        },
      ]);

      final schemaWithDef = buildSchema('''
      schema {
        query: Query
        mutation: SomeInputObject
      }

      type Query {
        field: String
      }

      input SomeInputObject {
        test: String
      }
    ''');
      expectJSON(validateSchema(schemaWithDef), [
        {
          'message':
              'Mutation root type must be Object type if provided, it cannot be SomeInputObject.',
          'locations': [
            {'line': 4, 'column': 19}
          ],
        },
      ]);
    });

    test('rejects a Schema whose subscription type is an input type', () {
      final schema = buildSchema('''
      type Query {
        field: String
      }

      input Subscription {
        test: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Subscription root type must be Object type if provided, it cannot be Subscription.',
          'locations': [
            {'line': 6, 'column': 7}
          ],
        },
      ]);

      final schemaWithDef = buildSchema('''
      schema {
        query: Query
        subscription: SomeInputObject
      }

      type Query {
        field: String
      }

      input SomeInputObject {
        test: String
      }
    ''');
      expectJSON(validateSchema(schemaWithDef), [
        {
          'message':
              'Subscription root type must be Object type if provided, it cannot be SomeInputObject.',
          'locations': [
            {'line': 4, 'column': 23}
          ],
        },
      ]);
    });

    test('rejects a schema extended with invalid root types', () {
      var schema = buildSchema('''
      input SomeInputObject {
        test: String
      }

      interface SomeInterface {
        test: Int
      }

      schema {
        query: SomeInputObject
        mutation: SomeInterface
        subscription: SomeInputObject
      }
    ''');

      // TODO: 2A allow extending invalid schemas
      // schema = extendSchema(
      //   schema,
      //   parseString('''
      //   extend schema {
      //     query: SomeInputObject
      //   }
      // '''),
      // );

      // schema = extendSchema(
      //   schema,
      //   parseString('''
      //   extend schema {
      //     mutation: SomeInputObject
      //   }
      // '''),
      // );

      // schema = extendSchema(
      //   schema,
      //   parseString('''
      //   extend schema {
      //     subscription: SomeInputObject
      //   }
      // '''),
      // );

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Query root type must be Object type, it cannot be SomeInputObject.',
          'locations': [
            {'line': 3, 'column': 18}
          ],
        },
        {
          'message':
              'Mutation root type must be Object type if provided, it cannot be SomeInterface.',
          'locations': [
            {'line': 3, 'column': 21}
          ],
        },
        {
          'message':
              'Subscription root type must be Object type if provided, it cannot be SomeInputObject.',
          'locations': [
            {'line': 3, 'column': 25}
          ],
        },
      ]);
    });

    // test('rejects a Schema whose types are incorrectly typed', () {
    //   final schema = new GraphQLSchema(
    //     queryType: SomeObjectType,
    //     // @ts-expect-error
    //     otherTypes: [{ name: 'SomeType' }, SomeDirective],
    //   );
    //   expect(validateSchema(schema), [
    //     {
    //       'message': 'Expected GraphQL named type but got: { name: "SomeType" }.',
    //     },
    //     {
    //       'message': 'Expected GraphQL named type but got: @SomeDirective.',
    //       'locations': [{ 'line': 14, 'column': 3 }],
    //     },
    //   ]);
    // });

    // test('rejects a Schema whose directives are incorrectly typed', () {
    //   final schema = new GraphQLSchema({
    //     query: SomeObjectType,
    //     // @ts-expect-error
    //     directives: [null, 'SomeDirective', SomeScalarType],
    //   });
    //   expect(validateSchema(schema), [
    //     {
    //       'message': 'Expected directive but got: null.',
    //     },
    //     {
    //       'message': 'Expected directive but got: "SomeDirective".',
    //     },
    //     {
    //       'message': 'Expected directive but got: SomeScalar.',
    //       'locations': [{ 'line': 2, 'column': 3 }],
    //     },
    //   ]);
    // });
  });

  group('Type System: Objects must have fields', () {
    test('accepts an Object type with fields object', () {
      final schema = buildSchema('''
      type Query {
        field: SomeObject
      }

      type SomeObject {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Object type with missing fields', () {
      final schema = buildSchema('''
      type Query {
        test: IncompleteObject
      }

      type IncompleteObject
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message': 'Type IncompleteObject must define one or more fields.',
          'locations': [
            {'line': 4, 'column': 11}
          ],
        },
      ]);

      final manualSchema = schemaWithFieldType(
        GraphQLObjectType<Object>(
          'IncompleteObject',
          fields: [],
        ),
      );
      expectJSON(validateSchema(manualSchema), [
        {
          'message': 'Type IncompleteObject must define one or more fields.',
        },
      ]);

      final manualSchema2 = schemaWithFieldType(
        GraphQLObjectType<Object>(
          'IncompleteObject',
        ),
      );
      expectJSON(validateSchema(manualSchema2), [
        {
          'message': 'Type IncompleteObject must define one or more fields.',
        },
      ]);
    });

    test('rejects an Object type with incorrectly named fields', () {
      final schema = schemaWithFieldType(
        GraphQLObjectType<Object>(
          'SomeObject',
          fields: [
            graphQLString.field('__badName'),
          ],
        ),
      );
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Name "__badName" must not begin with "__", which is reserved by GraphQL introspection.',
        },
      ]);
    });
  });

  group('Type System: Fields args must be properly named', () {
    test('accepts field args with valid names', () {
      final schema = schemaWithFieldType(
        GraphQLObjectType<Object>(
          'SomeObject',
          fields: [
            graphQLString.field(
              'goodField',
              inputs: [
                graphQLString.inputField('goodArg'),
              ],
            )
          ],
        ),
      );
      expectJSON(validateSchema(schema), []);
    });

    test('rejects field arg with invalid names', () {
      final schema = schemaWithFieldType(
        GraphQLObjectType<Object>(
          'SomeObject',
          fields: [
            field(
              'badField',
              graphQLString,
              inputs: [
                inputField('__badName', graphQLString),
              ],
            ),
          ],
        ),
      );

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Name "__badName" must not begin with "__", which is reserved by GraphQL introspection.',
        },
      ]);
    });
  });

  group('Type System: Union types must be valid', () {
    test('accepts a Union type with member types', () {
      final schema = buildSchema('''
      type Query {
        test: GoodUnion
      }

      type TypeA {
        field: String
      }

      type TypeB {
        field: String
      }

      union GoodUnion =
        | TypeA
        | TypeB
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects a Union type with empty types', () {
      var schema = buildSchema('''
      type Query {
        test: BadUnion
      }

      union BadUnion
    ''');

      schema = extendSchema(
        schema,
        parseString('''
        directive @test on UNION

        extend union BadUnion @test
      '''),
      );

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Union type BadUnion must define one or more member types.',
          'locations': [
            {'line': 6, 'column': 7},
            {'line': 4, 'column': 9},
          ],
        },
      ]);
    });

    test('rejects a Union type with duplicated member type', () {
      var schema = buildSchema('''
      type Query {
        test: BadUnion
      }

      type TypeA {
        field: String
      }

      type TypeB {
        field: String
      }

      union BadUnion =
        | TypeA
        | TypeB
        | TypeA
    ''');

      expectJSON(validateSchema(schema), [
        {
          'message': 'Union type BadUnion can only include type TypeA once.',
          'locations': [
            {'line': 15, 'column': 11},
            {'line': 17, 'column': 11},
          ],
        },
      ]);

      schema =
          extendSchema(schema, parseString('extend union BadUnion = TypeB'));

      expectJSON(validateSchema(schema), [
        {
          'message': 'Union type BadUnion can only include type TypeA once.',
          'locations': [
            {'line': 15, 'column': 11},
            {'line': 17, 'column': 11},
          ],
        },
        {
          'message': 'Union type BadUnion can only include type TypeB once.',
          'locations': [
            {'line': 16, 'column': 11},
            {'line': 1, 'column': 25},
          ],
        },
      ]);
    });

    test('rejects a Union type with non-Object members types', () {
      var schema = buildSchema('''
      type Query {
        test: BadUnion
      }

      type TypeA {
        field: String
      }

      type TypeB {
        field: String
      }

      union BadUnion =
        | TypeA
        | String
        | TypeB
        | Int
    ''');

      // TODO: 2A allow extending invalid schemas
      // schema = extendSchema(schema, parseString('extend union BadUnion = Int'));

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Union type BadUnion can only include Object types, it cannot include String.',
          'locations': [
            {'line': 16, 'column': 11}
          ],
        },
        {
          'message':
              'Union type BadUnion can only include Object types, it cannot include Int.',
          'locations': [
            {'line': 1, 'column': 25}
          ],
        },
      ]);

      final badUnionMemberTypes = [
        // graphQLString,
        // SomeObjectType.nonNull(),
        // SomeObjectType.list(),
        SomeInterfaceType,
        // SomeUnionType,
        // SomeEnumType,
        // SomeInputObjectType,
      ];
      for (final memberType in badUnionMemberTypes) {
        final badUnion = GraphQLUnionType<Object>(
          'BadUnion',
          // @ts-expect-error
          [memberType],
        );
        final badSchema = schemaWithFieldType(badUnion);
        expectJSON(validateSchema(badSchema), [
          {
            'message': 'Union type BadUnion can only include Object types, '
                'it cannot include ${inspect(memberType)}.',
          },
        ]);
      }
    });
  });

  group('Type System: Input Objects must have fields', () {
    test('accepts an Input Object type with fields', () {
      final schema = buildSchema('''
      type Query {
        field(arg: SomeInputObject): String
      }

      input SomeInputObject {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Input Object type with missing fields', () {
      var schema = buildSchema('''
      type Query {
        field(arg: SomeInputObject): String
      }

      input SomeInputObject
    ''');

      schema = extendSchema(
        schema,
        parseString('''
        directive @test on INPUT_OBJECT

        extend input SomeInputObject @test
      '''),
      );

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Input Object type SomeInputObject must define one or more fields.',
          'locations': [
            {'line': 6, 'column': 7},
            {'line': 4, 'column': 9},
          ],
        },
      ]);
    });

    test('accepts an Input Object with breakable circular reference', () {
      final schema = buildSchema('''
      type Query {
        field(arg: SomeInputObject): String
      }

      input SomeInputObject {
        self: SomeInputObject
        arrayOfSelf: [SomeInputObject]
        nonNullArrayOfSelf: [SomeInputObject]!
        nonNullArrayOfNonNullSelf: [SomeInputObject!]!
        intermediateSelf: AnotherInputObject
      }

      input AnotherInputObject {
        parent: SomeInputObject
      }
    ''');

      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Input Object with non-breakable circular reference', () {
      final schema = buildSchema('''
      type Query {
        field(arg: SomeInputObject): String
      }

      input SomeInputObject {
        nonNullSelf: SomeInputObject!
      }
    ''');

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Cannot reference Input Object "SomeInputObject" within itself through a series of non-null fields: "nonNullSelf".',
          'locations': [
            {'line': 7, 'column': 9}
          ],
        },
      ]);
    });

    test(
        'rejects Input Objects with non-breakable circular reference spread across them',
        () {
      final schema = buildSchema('''
      type Query {
        field(arg: SomeInputObject): String
      }

      input SomeInputObject {
        startLoop: AnotherInputObject!
      }

      input AnotherInputObject {
        nextInLoop: YetAnotherInputObject!
      }

      input YetAnotherInputObject {
        closeLoop: SomeInputObject!
      }
    ''');

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Cannot reference Input Object "SomeInputObject" within itself through a series of non-null fields: "startLoop.nextInLoop.closeLoop".',
          'locations': [
            {'line': 7, 'column': 9},
            {'line': 11, 'column': 9},
            {'line': 15, 'column': 9},
          ],
        },
      ]);
    });

    test('rejects Input Objects with multiple non-breakable circular reference',
        () {
      final schema = buildSchema('''
      type Query {
        field(arg: SomeInputObject): String
      }

      input SomeInputObject {
        startLoop: AnotherInputObject!
      }

      input AnotherInputObject {
        closeLoop: SomeInputObject!
        startSecondLoop: YetAnotherInputObject!
      }

      input YetAnotherInputObject {
        closeSecondLoop: AnotherInputObject!
        nonNullSelf: YetAnotherInputObject!
      }
    ''');

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Cannot reference Input Object "SomeInputObject" within itself through a series of non-null fields: "startLoop.closeLoop".',
          'locations': [
            {'line': 7, 'column': 9},
            {'line': 11, 'column': 9},
          ],
        },
        {
          'message':
              'Cannot reference Input Object "AnotherInputObject" within itself through a series of non-null fields: "startSecondLoop.closeSecondLoop".',
          'locations': [
            {'line': 12, 'column': 9},
            {'line': 16, 'column': 9},
          ],
        },
        {
          'message':
              'Cannot reference Input Object "YetAnotherInputObject" within itself through a series of non-null fields: "nonNullSelf".',
          'locations': [
            {'line': 17, 'column': 9}
          ],
        },
      ]);
    });

    test('rejects an Input Object type with incorrectly typed fields', () {
      final schema = buildSchema('''
      type Query {
        field(arg: SomeInputObject): String
      }

      type SomeObject {
        field: String
      }

      union SomeUnion = SomeObject

      input SomeInputObject {
        badObject: SomeObject
        badUnion: SomeUnion
        goodInputObject: SomeInputObject
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'The type of SomeInputObject.badObject must be Input Type but got: SomeObject.',
          'locations': [
            {'line': 13, 'column': 20}
          ],
        },
        {
          'message':
              'The type of SomeInputObject.badUnion must be Input Type but got: SomeUnion.',
          'locations': [
            {'line': 14, 'column': 19}
          ],
        },
      ]);
    });

    test(
        'rejects an Input Object type with required argument that is deprecated',
        () {
      final schema = buildSchema('''
      type Query {
        field(arg: SomeInputObject): String
      }

      input SomeInputObject {
        badField: String! @deprecated
        optionalField: String @deprecated
        anotherOptionalField: String! = "" @deprecated
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Required input field SomeInputObject.badField cannot be deprecated.',
          'locations': [
            {'line': 7, 'column': 27},
            {'line': 7, 'column': 19},
          ],
        },
      ]);
    });
  });

  group('Type System: Enum types must be well defined', () {
    test('rejects an Enum type without values', () {
      var schema = buildSchema('''
      type Query {
        field: SomeEnum
      }

      enum SomeEnum
    ''');

      schema = extendSchema(
        schema,
        parseString('''
        directive @test on ENUM

        extend enum SomeEnum @test
      '''),
      );

      expectJSON(validateSchema(schema), [
        {
          'message': 'Enum type SomeEnum must define one or more values.',
          'locations': [
            {'line': 6, 'column': 7},
            {'line': 4, 'column': 9},
          ],
        },
      ]);
    });

    test('rejects an Enum type with incorrectly named values', () {
      final schema = schemaWithFieldType(
        GraphQLEnumType<Map<String, Object?>>(
          'SomeEnum',
          [
            GraphQLEnumValue('__badName', {}),
          ],
        ),
      );

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Name "__badName" must not begin with "__", which is reserved by GraphQL introspection.',
        },
      ]);
    });
  });

  group('Type System: Object fields must have output types', () {
    GraphQLSchema schemaWithObjectField(
      GraphQLObjectField<Object?, Object?, Object?> fieldConfig,
    ) {
      final BadObjectType = GraphQLObjectType<Object?>(
        'BadObject',
        fields: [
          copyFieldWithName('badField', fieldConfig),
        ],
      );

      return GraphQLSchema(
        queryType: GraphQLObjectType(
          'Query',
          fields: [
            field('f', BadObjectType),
          ],
        ),
        otherTypes: [SomeObjectType],
      );
    }

    for (final type in outputTypes) {
      final typeName = inspect(type);
      test('''accepts an output type as an Object field type: ${typeName}''',
          () {
        final schema = schemaWithObjectField(type.field(''));
        expectJSON(validateSchema(schema), []);
      });
    }

    // test('rejects an empty Object field type', () {
    //   // @ts-expect-error (type field must not be undefined)
    //   final schema = schemaWithObjectField({type: undefined});
    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //           'The type of BadObject.badField must be Output Type but got: undefined.',
    //     },
    //   ]);
    // });

    for (final type in notOutputTypes) {
      final typeStr = inspect(type);
      test('''rejects a non-output type as an Object field type: ${typeStr}''',
          () {
        // @ts-expect-error
        final schema = schemaWithObjectField(type.field(''));
        expectJSON(validateSchema(schema), [
          {
            'message':
                '''The type of BadObject.badField must be Output Type but got: ${typeStr}.''',
          },
        ]);
      });
    }

    // test('rejects a non-type value as an Object field type', () {
    //   // @ts-expect-error
    //   final schema = schemaWithObjectField({ type: Number });
    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //         'The type of BadObject.badField must be Output Type but got: [function Number].',
    //     },
    //     {
    //       'message': 'Expected GraphQL named type but got: [function Number].',
    //     },
    //   ]);
    // });

    test(
        'rejects with relevant locations for a non-output type as an Object field type',
        () {
      final schema = buildSchema('''
      type Query {
        field: [SomeInputObject]
      }

      input SomeInputObject {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'The type of Query.field must be Output Type but got: [SomeInputObject].',
          'locations': [
            {'line': 3, 'column': 16}
          ],
        },
      ]);
    });
  });

  group('Type System: Objects can only implement unique interfaces', () {
    // test('rejects an Object implementing a non-type values', () {
    //   final schema =  GraphQLSchema(
    //     queryType:  GraphQLObjectType(
    //       'BadObject',
    //       // @ts-expect-error (interfaces must not contain undefined)
    //       interfaces: [undefined],
    //       fields: { f: { type: GraphQLString } },
    //     ),
    //   );

    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //         'Type BadObject must only implement Interface types, it cannot implement undefined.',
    //     },
    //   ]);
    // });

    test('rejects an Object implementing a non-Interface type', () {
      final schema = buildSchema('''
      type Query {
        test: BadObject
      }

      input SomeInputObject {
        field: String
      }

      type BadObject implements SomeInputObject {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Type BadObject must only implement Interface types, it cannot implement SomeInputObject.',
          'locations': [
            {'line': 10, 'column': 33}
          ],
        },
      ]);
    });

    // TODO: 1A interfaces
    test('rejects an Object implementing the same interface twice', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: String
      }

      type AnotherObject implements AnotherInterface & AnotherInterface {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Type AnotherObject can only implement AnotherInterface once.',
          'locations': [
            {'line': 10, 'column': 37},
            {'line': 10, 'column': 56},
          ],
        },
      ]);
    }, skip: '// TODO: interfaces');

    // TODO: interfaces
    test(
        'rejects an Object implementing the same interface twice due to extension',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: String
      }

      type AnotherObject implements AnotherInterface {
        field: String
      }
    ''');
      final extendedSchema = extendSchema(
        schema,
        parseString('extend type AnotherObject implements AnotherInterface'),
      );
      expectJSON(validateSchema(extendedSchema), [
        {
          'message':
              'Type AnotherObject can only implement AnotherInterface once.',
          'locations': [
            {'line': 10, 'column': 37},
            {'line': 1, 'column': 38},
          ],
        },
      ]);
    }, skip: '// TODO: interfaces');
  });

  group('Type System: Interface extensions should be valid', () {
    test(
        'rejects an Object implementing the extended interface due to missing field',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: String
      }

      type AnotherObject implements AnotherInterface {
        field: String
      }
    ''');
      final extendedSchema = extendSchema(
        schema,
        parseString('''
        extend interface AnotherInterface {
          newField: String
        }

        extend type AnotherObject {
          differentNewField: String
        }
      '''),
      );
      expectJSON(validateSchema(extendedSchema), [
        {
          'message':
              'Interface field AnotherInterface.newField expected but AnotherObject does not provide it.',
          'locations': [
            {'line': 3, 'column': 11},
            {'line': 10, 'column': 7},
            {'line': 6, 'column': 9},
          ],
        },
      ]);
    });

    test(
        'rejects an Object implementing the extended interface due to missing field args',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: String
      }

      type AnotherObject implements AnotherInterface {
        field: String
      }
    ''');
      final extendedSchema = extendSchema(
        schema,
        parseString('''
        extend interface AnotherInterface {
          newField(test: Boolean): String
        }

        extend type AnotherObject {
          newField: String
        }
      '''),
      );
      expectJSON(validateSchema(extendedSchema), [
        {
          'message':
              'Interface field argument AnotherInterface.newField(test:) expected but AnotherObject.newField does not provide it.',
          'locations': [
            {'line': 3, 'column': 20},
            {'line': 7, 'column': 11},
          ],
        },
      ]);
    });

    test(
        'rejects Objects implementing the extended interface due to mismatching interface type',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: String
      }

      type AnotherObject implements AnotherInterface {
        field: String
      }
    ''');
      final extendedSchema = extendSchema(
        schema,
        parseString('''
        extend interface AnotherInterface {
          newInterfaceField: NewInterface
        }

        interface NewInterface {
          newField: String
        }

        interface MismatchingInterface {
          newField: String
        }

        extend type AnotherObject {
          newInterfaceField: MismatchingInterface
        }

        # Required to prevent unused interface errors
        type DummyObject implements NewInterface & MismatchingInterface {
          newField: String
        }
      '''),
      );
      expectJSON(validateSchema(extendedSchema), [
        {
          'message':
              'Interface field AnotherInterface.newInterfaceField expects type NewInterface but AnotherObject.newInterfaceField is type MismatchingInterface.',
          'locations': [
            {'line': 3, 'column': 30},
            {'line': 15, 'column': 30},
          ],
        },
      ]);
    });
  });

  group('Type System: Interface fields must have output types', () {
    GraphQLSchema schemaWithInterfaceField(
      GraphQLObjectField<Object?, Object?, Object?> fieldConfig,
    ) {
      final fields = [copyFieldWithName('badField', fieldConfig)];

      final BadInterfaceType = GraphQLObjectType<Object?>(
        // GraphQLInterfaceType
        'BadInterface',
        fields: fields,
        isInterface: true,
      );

      final BadImplementingType = GraphQLObjectType<Object?>(
        'BadImplementing',
        interfaces: [BadInterfaceType],
        fields: fields,
      );

      return GraphQLSchema(
        queryType: GraphQLObjectType(
          'Query',
          fields: [
            field('f', BadInterfaceType),
          ],
        ),
        otherTypes: [BadImplementingType, SomeObjectType],
      );
    }

    for (final type in outputTypes) {
      final typeName = inspect(type);
      test('''accepts an output type as an Interface field type: ${typeName}''',
          () {
        final schema = schemaWithInterfaceField(type.field<Object>(''));
        expectJSON(validateSchema(schema), []);
      });
    }

    // test('rejects an empty Interface field type', () {
    //   // @ts-expect-error (type field must not be undefined)
    //   final schema = schemaWithInterfaceField({ type: undefined });
    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //         'The type of BadImplementing.badField must be Output Type but got: undefined.',
    //     },
    //     {
    //       'message':
    //         'The type of BadInterface.badField must be Output Type but got: undefined.',
    //     },
    //   ]);
    // });

    for (final type in notOutputTypes) {
      final typeStr = inspect(type);
      test(
          '''rejects a non-output type as an Interface field type: ${typeStr}''',
          () {
        // @ts-expect-error
        final schema = schemaWithInterfaceField(type.field<Object>(''));
        expectJSON(validateSchema(schema), [
          {
            'message':
                '''The type of BadImplementing.badField must be Output Type but got: ${typeStr}.''',
          },
          {
            'message':
                '''The type of BadInterface.badField must be Output Type but got: ${typeStr}.''',
          },
        ]);
      });
    }

    // test('rejects a non-type value as an Interface field type', () {
    //   // @ts-expect-error
    //   final schema = schemaWithInterfaceField({ type: Number });
    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //         'The type of BadImplementing.badField must be Output Type but got: [function Number].',
    //     },
    //     {
    //       'message':
    //         'The type of BadInterface.badField must be Output Type but got: [function Number].',
    //     },
    //     {
    //       'message': 'Expected GraphQL named type but got: [function Number].',
    //     },
    //   ]);
    // });

    test('rejects a non-output type as an Interface field type with locations',
        () {
      final schema = buildSchema('''
      type Query {
        test: SomeInterface
      }

      interface SomeInterface {
        field: SomeInputObject
      }

      input SomeInputObject {
        foo: String
      }

      type SomeObject implements SomeInterface {
        field: SomeInputObject
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'The type of SomeInterface.field must be Output Type but got: SomeInputObject.',
          'locations': [
            {'line': 7, 'column': 16}
          ],
        },
        {
          'message':
              'The type of SomeObject.field must be Output Type but got: SomeInputObject.',
          'locations': [
            {'line': 15, 'column': 16}
          ],
        },
      ]);
    });

    test('accepts an interface not implemented by at least one object', () {
      final schema = buildSchema('''
      type Query {
        test: SomeInterface
      }

      interface SomeInterface {
        foo: String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });
  });

  group('Type System: Arguments must have input types', () {
    GraphQLSchema schemaWithArg(GraphQLType argConfig) {
      final BadObjectType = GraphQLObjectType<Object>(
        'BadObject',
        fields: [
          field(
            'badField',
            graphQLString,
            inputs: [
              inputField('badArg', argConfig),
            ],
          ),
        ],
      );

      return GraphQLSchema(
        queryType: GraphQLObjectType(
          'Query',
          fields: [
            field('f', BadObjectType),
          ],
        ),
        directives: [
          GraphQLDirective(
            name: 'BadDirective',
            inputs: [
              inputField<Object?, Object?>('badArg', argConfig),
            ],
            locations: [DirectiveLocation.QUERY],
          ),
        ],
      );
    }

    for (final type in inputTypes) {
      final typeName = inspect(type);
      test('''accepts an input type as a field arg type: ${typeName}''', () {
        final schema = schemaWithArg(type);
        expectJSON(validateSchema(schema), []);
      });
    }

    // test('rejects an empty field arg type', () {
    //   // @ts-expect-error (type field must not be undefined)
    //   final schema = schemaWithArg({ type: undefined });
    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //         'The type of @BadDirective(badArg:) must be Input Type but got: undefined.',
    //     },
    //     {
    //       'message':
    //         'The type of BadObject.badField(badArg:) must be Input Type but got: undefined.',
    //     },
    //   ]);
    // });

    for (final type in notInputTypes) {
      final typeStr = inspect(type);
      test('''rejects a non-input type as a field arg type: ${typeStr}''', () {
        // @ts-expect-error
        final schema = schemaWithArg(type);
        expectJSON(validateSchema(schema), [
          {
            'message':
                '''The type of @BadDirective(badArg:) must be Input Type but got: ${typeStr}.''',
          },
          {
            'message':
                '''The type of BadObject.badField(badArg:) must be Input Type but got: ${typeStr}.''',
          },
        ]);
      });
    }

    // test('rejects a non-type value as a field arg type', () {
    //   // @ts-expect-error
    //   final schema = schemaWithArg({ type: Number });
    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //         'The type of @BadDirective(badArg:) must be Input Type but got: [function Number].',
    //     },
    //     {
    //       'message':
    //         'The type of BadObject.badField(badArg:) must be Input Type but got: [function Number].',
    //     },
    //     {
    //       'message': 'Expected GraphQL named type but got: [function Number].',
    //     },
    //   ]);
    // });

    test('rejects an required argument that is deprecated', () {
      final schema = buildSchema('''
      directive @BadDirective(
        badArg: String! @deprecated
        optionalArg: String @deprecated
        anotherOptionalArg: String! = "" @deprecated
      ) on FIELD

      type Query {
        test(
          badArg: String! @deprecated
          optionalArg: String @deprecated
          anotherOptionalArg: String! = "" @deprecated
        ): String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Required argument @BadDirective(badArg:) cannot be deprecated.',
          'locations': [
            {'line': 3, 'column': 25},
            {'line': 3, 'column': 17},
          ],
        },
        {
          'message':
              'Required argument Query.test(badArg:) cannot be deprecated.',
          'locations': [
            {'line': 10, 'column': 27},
            {'line': 10, 'column': 19},
          ],
        },
      ]);
    });

    test('rejects a non-input type as a field arg with locations', () {
      final schema = buildSchema('''
      type Query {
        test(arg: SomeObject): String
      }

      type SomeObject {
        foo: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'The type of Query.test(arg:) must be Input Type but got: SomeObject.',
          'locations': [
            {'line': 3, 'column': 19}
          ],
        },
      ]);
    });
  });

  group('Type System: Input Object fields must have input types', () {
    GraphQLSchema schemaWithInputField(
      GraphQLType inputFieldConfig,
    ) {
      final BadInputObjectType = GraphQLInputObjectType<Object>(
        'BadInputObject',
        fields: [
          inputField('badField', inputFieldConfig),
        ],
      );

      return GraphQLSchema(
        queryType: GraphQLObjectType(
          'Query',
          fields: [
            field(
              'f',
              graphQLString,
              inputs: [
                inputField('badArg', BadInputObjectType),
              ],
            ),
          ],
        ),
      );
    }

    for (final type in inputTypes) {
      final typeName = inspect(type);
      test('''accepts an input type as an input field type: ${typeName}''', () {
        final schema = schemaWithInputField(type);
        expectJSON(validateSchema(schema), []);
      });
    }

    // test('rejects an empty input field type', () {
    //   // @ts-expect-error (type field must not be undefined)
    //   final schema = schemaWithInputField({ type: undefined });
    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //         'The type of BadInputObject.badField must be Input Type but got: undefined.',
    //     },
    //   ]);
    // });

    for (final type in notInputTypes) {
      final typeStr = inspect(type);
      test('''rejects a non-input type as an input field type: ${typeStr}''',
          () {
        // @ts-expect-error
        final schema = schemaWithInputField(type);
        expectJSON(validateSchema(schema), [
          {
            'message':
                '''The type of BadInputObject.badField must be Input Type but got: ${typeStr}.''',
          },
        ]);
      });
    }

    // test('rejects a non-type value as an input field type', () {
    //   // @ts-expect-error
    //   final schema = schemaWithInputField({ type: Number });
    //   expect(validateSchema(schema), [
    //     {
    //       'message':
    //         'The type of BadInputObject.badField must be Input Type but got: [function Number].',
    //     },
    //     {
    //       'message': 'Expected GraphQL named type but got: [function Number].',
    //     },
    //   ]);
    // });

    test('rejects a non-input type as an input object field with locations',
        () {
      final schema = buildSchema('''
      type Query {
        test(arg: SomeInputObject): String
      }

      input SomeInputObject {
        foo: SomeObject
      }

      type SomeObject {
        bar: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'The type of SomeInputObject.foo must be Input Type but got: SomeObject.',
          'locations': [
            {'line': 7, 'column': 14}
          ],
        },
      ]);
    });
  });

  group('Objects must adhere to Interface they implement', () {
    test('accepts an Object which implements an Interface', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(input: String): String
      }

      type AnotherObject implements AnotherInterface {
        field(input: String): String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test(
        'accepts an Object which implements an Interface along with more fields',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(input: String): String
      }

      type AnotherObject implements AnotherInterface {
        field(input: String): String
        anotherField: String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test(
        'accepts an Object which implements an Interface field along with additional optional arguments',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(input: String): String
      }

      type AnotherObject implements AnotherInterface {
        field(input: String, anotherInput: String): String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Object missing an Interface field', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(input: String): String
      }

      type AnotherObject implements AnotherInterface {
        anotherField: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field AnotherInterface.field expected but AnotherObject does not provide it.',
          'locations': [
            {'line': 7, 'column': 9},
            {'line': 10, 'column': 7},
          ],
        },
      ]);
    });

    test('rejects an Object with an incorrectly typed Interface field', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(input: String): String
      }

      type AnotherObject implements AnotherInterface {
        field(input: String): Int
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field AnotherInterface.field expects type String but AnotherObject.field is type Int.',
          'locations': [
            {'line': 7, 'column': 31},
            {'line': 11, 'column': 31},
          ],
        },
      ]);
    });

    test('rejects an Object with a differently typed Interface field', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      type A { foo: String }
      type B { foo: String }

      interface AnotherInterface {
        field: A
      }

      type AnotherObject implements AnotherInterface {
        field: B
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field AnotherInterface.field expects type A but AnotherObject.field is type B.',
          'locations': [
            {'line': 10, 'column': 16},
            {'line': 14, 'column': 16},
          ],
        },
      ]);
    });

    test('accepts an Object with a subtyped Interface field (interface)', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: AnotherInterface
      }

      type AnotherObject implements AnotherInterface {
        field: AnotherObject
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('accepts an Object with a subtyped Interface field (union)', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      type SomeObject {
        field: String
      }

      union SomeUnionType = SomeObject

      interface AnotherInterface {
        field: SomeUnionType
      }

      type AnotherObject implements AnotherInterface {
        field: SomeObject
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Object missing an Interface argument', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(input: String): String
      }

      type AnotherObject implements AnotherInterface {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field argument AnotherInterface.field(input:) expected but AnotherObject.field does not provide it.',
          'locations': [
            {'line': 7, 'column': 15},
            {'line': 11, 'column': 9},
          ],
        },
      ]);
    });

    test('rejects an Object with an incorrectly typed Interface argument', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(input: String): String
      }

      type AnotherObject implements AnotherInterface {
        field(input: Int): String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field argument AnotherInterface.field(input:) expects type String but AnotherObject.field(input:) is type Int.',
          'locations': [
            {'line': 7, 'column': 22},
            {'line': 11, 'column': 22},
          ],
        },
      ]);
    });

    test('rejects an Object with both an incorrectly typed field and argument',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(input: String): String
      }

      type AnotherObject implements AnotherInterface {
        field(input: Int): Int
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field AnotherInterface.field expects type String but AnotherObject.field is type Int.',
          'locations': [
            {'line': 7, 'column': 31},
            {'line': 11, 'column': 28},
          ],
        },
        {
          'message':
              'Interface field argument AnotherInterface.field(input:) expects type String but AnotherObject.field(input:) is type Int.',
          'locations': [
            {'line': 7, 'column': 22},
            {'line': 11, 'column': 22},
          ],
        },
      ]);
    });

    test(
        'rejects an Object which implements an Interface field along with additional required arguments',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field(baseArg: String): String
      }

      type AnotherObject implements AnotherInterface {
        field(
          baseArg: String,
          requiredArg: String!
          optionalArg1: String,
          optionalArg2: String = "",
        ): String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Object field AnotherObject.field includes required argument requiredArg that is missing from the Interface field AnotherInterface.field.',
          'locations': [
            {'line': 13, 'column': 11},
            {'line': 7, 'column': 9},
          ],
        },
      ]);
    });

    test('accepts an Object with an equivalently wrapped Interface field type',
        () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: [String]!
      }

      type AnotherObject implements AnotherInterface {
        field: [String]!
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Object with a non-list Interface field list type', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: [String]
      }

      type AnotherObject implements AnotherInterface {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field AnotherInterface.field expects type [String] but AnotherObject.field is type String.',
          'locations': [
            {'line': 7, 'column': 16},
            {'line': 11, 'column': 16},
          ],
        },
      ]);
    });

    test('rejects an Object with a list Interface field non-list type', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: String
      }

      type AnotherObject implements AnotherInterface {
        field: [String]
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field AnotherInterface.field expects type String but AnotherObject.field is type [String].',
          'locations': [
            {'line': 7, 'column': 16},
            {'line': 11, 'column': 16},
          ],
        },
      ]);
    });

    test('accepts an Object with a subset non-null Interface field type', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: String
      }

      type AnotherObject implements AnotherInterface {
        field: String!
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Object with a superset nullable Interface field type', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface AnotherInterface {
        field: String!
      }

      type AnotherObject implements AnotherInterface {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field AnotherInterface.field expects type String! but AnotherObject.field is type String.',
          'locations': [
            {'line': 7, 'column': 16},
            {'line': 11, 'column': 16},
          ],
        },
      ]);
    });

    // TODO: interfaces
    test('rejects an Object missing a transitive interface', () {
      final schema = buildSchema('''
      type Query {
        test: AnotherObject
      }

      interface SuperInterface {
        field: String!
      }

      interface AnotherInterface implements SuperInterface {
        field: String!
      }

      type AnotherObject implements AnotherInterface {
        field: String!
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Type AnotherObject must implement SuperInterface because it is implemented by AnotherInterface.',
          'locations': [
            {'line': 10, 'column': 45},
            {'line': 14, 'column': 37},
          ],
        },
      ]);
    }, skip: '// TODO: interfaces');
  });

  group('Interfaces must adhere to Interface they implement', () {
    test('accepts an Interface which implements an Interface', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(input: String): String
      }

      interface ChildInterface implements ParentInterface {
        field(input: String): String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test(
        'accepts an Interface which implements an Interface along with more fields',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(input: String): String
      }

      interface ChildInterface implements ParentInterface {
        field(input: String): String
        anotherField: String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test(
        'accepts an Interface which implements an Interface field along with additional optional arguments',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(input: String): String
      }

      interface ChildInterface implements ParentInterface {
        field(input: String, anotherInput: String): String
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Interface missing an Interface field', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(input: String): String
      }

      interface ChildInterface implements ParentInterface {
        anotherField: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field ParentInterface.field expected but ChildInterface does not provide it.',
          'locations': [
            {'line': 7, 'column': 9},
            {'line': 10, 'column': 7},
          ],
        },
      ]);
    });

    test('rejects an Interface with an incorrectly typed Interface field', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(input: String): String
      }

      interface ChildInterface implements ParentInterface {
        field(input: String): Int
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field ParentInterface.field expects type String but ChildInterface.field is type Int.',
          'locations': [
            {'line': 7, 'column': 31},
            {'line': 11, 'column': 31},
          ],
        },
      ]);
    });

    test('rejects an Interface with a differently typed Interface field', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      type A { foo: String }
      type B { foo: String }

      interface ParentInterface {
        field: A
      }

      interface ChildInterface implements ParentInterface {
        field: B
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field ParentInterface.field expects type A but ChildInterface.field is type B.',
          'locations': [
            {'line': 10, 'column': 16},
            {'line': 14, 'column': 16},
          ],
        },
      ]);
    });

    test('accepts an Interface with a subtyped Interface field (interface)',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field: ParentInterface
      }

      interface ChildInterface implements ParentInterface {
        field: ChildInterface
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('accepts an Interface with a subtyped Interface field (union)', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      type SomeObject {
        field: String
      }

      union SomeUnionType = SomeObject

      interface ParentInterface {
        field: SomeUnionType
      }

      interface ChildInterface implements ParentInterface {
        field: SomeObject
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Interface implementing a non-Interface type', () {
      final schema = buildSchema('''
      type Query {
        field: String
      }

      input SomeInputObject {
        field: String
      }

      interface BadInterface implements SomeInputObject {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Type BadInterface must only implement Interface types, it cannot implement SomeInputObject.',
          'locations': [
            {'line': 10, 'column': 41}
          ],
        },
      ]);
    });

    test('rejects an Interface missing an Interface argument', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(input: String): String
      }

      interface ChildInterface implements ParentInterface {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field argument ParentInterface.field(input:) expected but ChildInterface.field does not provide it.',
          'locations': [
            {'line': 7, 'column': 15},
            {'line': 11, 'column': 9},
          ],
        },
      ]);
    });

    test('rejects an Interface with an incorrectly typed Interface argument',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(input: String): String
      }

      interface ChildInterface implements ParentInterface {
        field(input: Int): String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field argument ParentInterface.field(input:) expects type String but ChildInterface.field(input:) is type Int.',
          'locations': [
            {'line': 7, 'column': 22},
            {'line': 11, 'column': 22},
          ],
        },
      ]);
    });

    test(
        'rejects an Interface with both an incorrectly typed field and argument',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(input: String): String
      }

      interface ChildInterface implements ParentInterface {
        field(input: Int): Int
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field ParentInterface.field expects type String but ChildInterface.field is type Int.',
          'locations': [
            {'line': 7, 'column': 31},
            {'line': 11, 'column': 28},
          ],
        },
        {
          'message':
              'Interface field argument ParentInterface.field(input:) expects type String but ChildInterface.field(input:) is type Int.',
          'locations': [
            {'line': 7, 'column': 22},
            {'line': 11, 'column': 22},
          ],
        },
      ]);
    });

    test(
        'rejects an Interface which implements an Interface field along with additional required arguments',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field(baseArg: String): String
      }

      interface ChildInterface implements ParentInterface {
        field(
          baseArg: String,
          requiredArg: String!
          optionalArg1: String,
          optionalArg2: String = "",
        ): String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Object field ChildInterface.field includes required argument requiredArg that is missing from the Interface field ParentInterface.field.',
          'locations': [
            {'line': 13, 'column': 11},
            {'line': 7, 'column': 9},
          ],
        },
      ]);
    });

    test(
        'accepts an Interface with an equivalently wrapped Interface field type',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field: [String]!
      }

      interface ChildInterface implements ParentInterface {
        field: [String]!
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Interface with a non-list Interface field list type', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field: [String]
      }

      interface ChildInterface implements ParentInterface {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field ParentInterface.field expects type [String] but ChildInterface.field is type String.',
          'locations': [
            {'line': 7, 'column': 16},
            {'line': 11, 'column': 16},
          ],
        },
      ]);
    });

    test('rejects an Interface with a list Interface field non-list type', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field: String
      }

      interface ChildInterface implements ParentInterface {
        field: [String]
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field ParentInterface.field expects type String but ChildInterface.field is type [String].',
          'locations': [
            {'line': 7, 'column': 16},
            {'line': 11, 'column': 16},
          ],
        },
      ]);
    });

    test('accepts an Interface with a subset non-null Interface field type',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field: String
      }

      interface ChildInterface implements ParentInterface {
        field: String!
      }
    ''');
      expectJSON(validateSchema(schema), []);
    });

    test('rejects an Interface with a superset nullable Interface field type',
        () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface ParentInterface {
        field: String!
      }

      interface ChildInterface implements ParentInterface {
        field: String
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Interface field ParentInterface.field expects type String! but ChildInterface.field is type String.',
          'locations': [
            {'line': 7, 'column': 16},
            {'line': 11, 'column': 16},
          ],
        },
      ]);
    });

    // TODO: interfaces
    test('rejects an Object missing a transitive interface', () {
      final schema = buildSchema('''
      type Query {
        test: ChildInterface
      }

      interface SuperInterface {
        field: String!
      }

      interface ParentInterface implements SuperInterface {
        field: String!
      }

      interface ChildInterface implements ParentInterface {
        field: String!
      }
    ''');
      expectJSON(validateSchema(schema), [
        {
          'message':
              'Type ChildInterface must implement SuperInterface because it is implemented by ParentInterface.',
          'locations': [
            {'line': 10, 'column': 44},
            {'line': 14, 'column': 43},
          ],
        },
      ]);
    }, skip: '// TODO: interfaces');

    test('rejects a self reference interface', () {
      final schema = buildSchema('''
      type Query {
        test: FooInterface
      }

      interface FooInterface implements FooInterface {
        field: String
      }
    ''');

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Type FooInterface cannot implement itself because it would create a circular reference.',
          'locations': [
            {'line': 6, 'column': 41}
          ],
        },
      ]);
    });

    // TODO: interfaces
    test('rejects a circular Interface implementation', () {
      final schema = buildSchema('''
      type Query {
        test: FooInterface
      }

      interface FooInterface implements BarInterface {
        field: String
      }

      interface BarInterface implements FooInterface {
        field: String
      }
    ''');

      expectJSON(validateSchema(schema), [
        {
          'message':
              'Type FooInterface cannot implement BarInterface because it would create a circular reference.',
          'locations': [
            {'line': 10, 'column': 41},
            {'line': 6, 'column': 41},
          ],
        },
        {
          'message':
              'Type BarInterface cannot implement FooInterface because it would create a circular reference.',
          'locations': [
            {'line': 6, 'column': 41},
            {'line': 10, 'column': 41},
          ],
        },
      ]);
    }, skip: '// TODO: interfaces');
  });

  group('assertValidSchema', () {
    test('do not throw on valid schemas', () {
      final schema = buildSchema('''
      type Query {
        foo: String
      }
    ''');
      vs.assertValidSchema(schema as GraphQLSchema);
    });

    test('include multiple errors into a description', () {
      final schema = buildSchema('type SomeType');
      expect(
          () => vs.assertValidSchema(schema as GraphQLSchema),
          throwsA(predicate((e) =>
              e is GraphQLException &&
              e.errors.length == 2 &&
              e.errors.first.message == 'Query root type must be provided.' &&
              e.errors[1].message ==
                  'Type SomeType must define one or more fields.')));
    });
  });
}
