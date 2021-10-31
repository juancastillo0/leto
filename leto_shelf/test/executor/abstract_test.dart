// https://github.com/graphql/graphql-js/blob/564757fb62bfd4e2472e6e7465971baad2371805/src/execution/__tests__/abstract-test.ts
import 'package:graphql_schema/utilities.dart' show buildSchema;
import 'package:leto_shelf/leto_shelf.dart';
import 'package:test/test.dart';

Future<Map<String, Object?>> executeQuery(
  GraphQLSchema schema,
  String query, {
  Object? rootValue,
}) async {
  final result = await GraphQL(schema).parseAndExecute(
    query,
    rootValue: rootValue,
    globalVariables: ScopedMap({'async': false}),
  );
  // const asyncResult = await execute({
  //   schema,
  //   document,
  //   rootValue,
  //   contextValue: { async: true },
  // });

  // expect(result, asyncResult);
  return result.toJson();
}

class Dog {
  String name;
  bool woofs;

  Dog(this.name, this.woofs);

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'woofs': woofs,
    };
  }
}

class Cat {
  String name;
  bool meows;

  Cat(this.name, this.meows);

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'meows': meows,
    };
  }
}

// describe('Execute: Handles execution of abstract types', () async {
void main() {
  test('isTypeOf used to resolve runtime type for Interface', () async {
    final PetType = objectType<Object>(
      'Pet',
      isInterface: true,
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
      },
    );

    final DogType = objectType<Dog>(
      'Dog',
      interfaces: [PetType],
      // TODO:
      // isTypeOf(obj, context) {
      //   const isDog = obj instanceof Dog;
      //   return context.async ? Promise.resolve(isDog) : isDog;
      // },
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
        'woofs': graphQLBoolean.fieldSpec(),
      },
    );

    final CatType = objectType<Cat>(
      'Cat',
      interfaces: [PetType],
      // TODO:
      // isTypeOf(obj, context) {
      //   final isCat = obj instanceof Cat;
      //   return context.async ? Promise.resolve(isCat) : isCat;
      // },
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
        'meows': graphQLBoolean.fieldSpec(),
      },
    );

    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          listOf(PetType).field(
            'pets',
            resolve: (_, __) {
              return [Dog('Odie', true), Cat('Garfield', false)];
            },
          ),
        ],
      ),
      // types: [CatType, DogType],
    );

    const query = '''
      {
        pets {
          name
          ... on Dog {
            woofs
          }
          ... on Cat {
            meows
          }
        }
      }
    ''';

    expect(await executeQuery(schema, query), {
      'data': {
        'pets': [
          {
            'name': 'Odie',
            'woofs': true,
          },
          {
            'name': 'Garfield',
            'meows': false,
          },
        ],
      },
    });
  });

  test('isTypeOf can throw', () async {
    final PetType = objectType<Object>(
      'Pet',
      fields: [graphQLString.field('name')],
      isInterface: true,
    );

    final DogType = objectType<Dog>(
      'Dog',
      interfaces: [PetType],
      isTypeOf: (_source, type, context) {
        const error = 'We are testing this error';
        // if (context.async) {
        //   return Promise.reject(error);
        // }
        throw error;
      },
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
        'woofs': graphQLBoolean.fieldSpec(),
      },
    );

    final CatType = objectType<Cat>(
      'Cat',
      interfaces: [PetType],
      // isTypeOf: undefined,
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
        'meows': graphQLBoolean.fieldSpec(),
      },
    );

    final schema = GraphQLSchema(
      queryType: GraphQLObjectType(
        'Query',
        fields: [
          listOf(PetType).field(
            'pets',
            resolve: (_, __) {
              return [Dog('Odie', true), Cat('Garfield', false)];
            },
          ),
        ],
      ),
      // TODO:
      // types: [DogType, CatType],
    );

    const query = '''
      {
        pets {
          name
          ... on Dog {
            woofs
          }
          ... on Cat {
            meows
          }
        }
      }
    ''';

    expect(await executeQuery(schema, query), {
      'data': {
        'pets': [null, null],
      },
      'errors': [
        {
          'message': 'We are testing this error',
          'locations': [
            {'line': 1, 'column': 8}
          ],
          'path': ['pets', 0],
        },
        {
          'message': 'We are testing this error',
          'locations': [
            {'line': 1, 'column': 8}
          ],
          'path': ['pets', 1],
        },
      ],
    });
  });

  test('isTypeOf used to resolve runtime type for Union', () async {
    final DogType = objectType<Dog>(
      'Dog',
      // isTypeOf(obj, context) {
      //   const isDog = obj instanceof Dog;
      //   return context.async ? Promise.resolve(isDog) : isDog;
      // },
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
        'woofs': graphQLBoolean.fieldSpec(),
      },
    );

    final CatType = objectType<Cat>(
      'Cat',
      // isTypeOf(obj, context) {
      //   const isCat = obj instanceof Cat;
      //   return context.async ? Promise.resolve(isCat) : isCat;
      // },
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
        'meows': graphQLBoolean.fieldSpec(),
      },
    );

    final PetType = GraphQLUnionType<Object>(
      'Pet',
      [DogType, CatType],
    );

    final schema = GraphQLSchema(
      queryType: GraphQLObjectType(
        'Query',
        fields: [
          listOf(PetType).field(
            'pets',
            resolve: (_, __) {
              return [Dog('Odie', true), Cat('Garfield', false)];
            },
          ),
        ],
      ),
    );

    // ignore: leading_newlines_in_multiline_strings
    const query = '''{
      pets {
        ... on Dog {
          name
          woofs
        }
        ... on Cat {
          name
          meows
        }
      }
    }''';

    expect(await executeQuery(schema, query), {
      'data': {
        'pets': [
          {
            'name': 'Odie',
            'woofs': true,
          },
          {
            'name': 'Garfield',
            'meows': false,
          },
        ],
      },
    });
  });

  test('resolveType can throw', () async {
    final PetType = objectType<Object>(
      'Pet',
      resolveType: (_source, type, context) {
        const error = 'We are testing this error';
        // if (context.async) {
        //   return Promise.reject(error);
        // }
        throw error;
      },
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
      },
      isInterface: true,
    );

    final DogType = objectType<Dog>(
      'Dog',
      interfaces: [PetType],
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
        'woofs': graphQLBoolean.fieldSpec(),
      },
    );

    final CatType = objectType<Cat>(
      'Cat',
      interfaces: [PetType],
      fieldsMap: {
        'name': graphQLString.fieldSpec(),
        'meows': graphQLBoolean.fieldSpec(),
      },
    );

    final schema = GraphQLSchema(
      queryType: GraphQLObjectType(
        'Query',
        fields: [
          listOf(PetType).field(
            'pets',
            resolve: (_, __) {
              return [Dog('Odie', true), Cat('Garfield', false)];
            },
          ),
        ],
      ),
      // TODO:
      // types: [CatType, DogType],
    );

    const query = '''
      {
        pets {
          name
          ... on Dog {
            woofs
          }
          ... on Cat {
            meows
          }
        }
      }
    ''';

    expect(await executeQuery(schema, query), {
      'data': {
        'pets': [null, null],
      },
      'errors': [
        {
          'message': 'We are testing this error',
          'locations': [
            {'line': 1, 'column': 8}
          ],
          'path': ['pets', 0],
        },
        {
          'message': 'We are testing this error',
          'locations': [
            {'line': 1, 'column': 8}
          ],
          'path': ['pets', 1],
        },
      ],
    });
  });

  test('resolve Union type using __typename on source object', () async {
    final schema = buildSchema('''
      type Query {
        pets: [Pet]
      }

      union Pet = Cat | Dog

      type Cat {
        name: String
        meows: Boolean
      }

      type Dog {
        name: String
        woofs: Boolean
      }
    ''');

    const query = '''
      {
        pets {
          name
          ... on Dog {
            woofs
          }
          ... on Cat {
            meows
          }
        }
      }
    ''';

    const rootValue = {
      'pets': [
        {
          '__typename': 'Dog',
          'name': 'Odie',
          'woofs': true,
        },
        {
          '__typename': 'Cat',
          'name': 'Garfield',
          'meows': false,
        },
      ],
    };

    expect(await executeQuery(schema, query, rootValue: rootValue), {
      'data': {
        'pets': [
          {
            'name': 'Odie',
            'woofs': true,
          },
          {
            'name': 'Garfield',
            'meows': false,
          },
        ],
      },
    });
  });

  test('resolve Interface type using __typename on source object', () async {
    final schema = buildSchema('''
      type Query {
        pets: [Pet]
      }

      interface Pet {
        name: String
        }

      type Cat implements Pet {
        name: String
        meows: Boolean
      }

      type Dog implements Pet {
        name: String
        woofs: Boolean
      }
    ''');

    const query = '''
      {
        pets {
          name
          ... on Dog {
            woofs
          }
          ... on Cat {
            meows
          }
        }
      }
    ''';

    const rootValue = {
      'pets': [
        {
          '__typename': 'Dog',
          'name': 'Odie',
          'woofs': true,
        },
        {
          '__typename': 'Cat',
          'name': 'Garfield',
          'meows': false,
        },
      ],
    };

    expect(await executeQuery(schema, query, rootValue: rootValue), {
      'data': {
        'pets': [
          {
            'name': 'Odie',
            'woofs': true,
          },
          {
            'name': 'Garfield',
            'meows': false,
          },
        ],
      },
    });
  });

  // TODO:
  // test('resolveType on Interface yields useful error', () async {
  //   final schema = buildSchema('''
  //     type Query {
  //       pet: Pet
  //     }

  //     interface Pet {
  //       name: String
  //     }

  //     type Cat implements Pet {
  //       name: String
  //     }

  //     type Dog implements Pet {
  //       name: String
  //     }
  //   ''');

  //   const document = '''
  //     {
  //       pet {
  //         name
  //       }
  //     }
  //   ''';

  //   function expectError({ forTypeName }: { forTypeName: unknown }) {
  //     const rootValue = { pet: { __typename: forTypeName } };
  //     const result = executeSync({ schema, document, rootValue });
  //     return {
  //       toEqual(message: string) {
  //         expect(result, {
  //           'data': { 'pet': null },
  //           'errors': [
  //             {
  //               'message': message,
  //               'locations': [{ 'line': 3, 'column': 9 }],
  //               'path': ['pet'],
  //             },
  //           ],
  //         });
  //       },
  //     };
  //   }

  //   expectError({ forTypeName: undefined }).toEqual(
  //     'Abstract type "Pet" must resolve to an Object type at runtime for field "Query.pet". Either the "Pet" type should provide a "resolveType" function or each possible type should provide an "isTypeOf" function.',
  //   );

  //   expectError({ forTypeName: 'Human' }).toEqual(
  //     'Abstract type "Pet" was resolved to a type "Human" that does not exist inside the schema.',
  //   );

  //   expectError({ forTypeName: 'String' }).toEqual(
  //     'Abstract type "Pet" was resolved to a non-object type "String".',
  //   );

  //   expectError({ forTypeName: '__Schema' }).toEqual(
  //     'Runtime Object type "__Schema" is not a possible type for "Pet".',
  //   );

  //   // FIXME: workaround since we can't inject resolveType into SDL
  //   // @ts-expect-error
  //   assertInterfaceType(schema.getType('Pet')).resolveType = () => [];
  //   expectError({ forTypeName: undefined }).toEqual(
  //     'Abstract type "Pet" must resolve to an Object type at runtime for field "Query.pet" with value { __typename: undefined }, received "[]".',
  //   );

  //   // FIXME: workaround since we can't inject resolveType into SDL
  //   // @ts-expect-error
  //   assertInterfaceType(schema.getType('Pet')).resolveType = () =>
  //     schema.getType('Cat');
  //   expectError({ forTypeName: undefined }).toEqual(
  //     'Support for returning GraphQLObjectType from resolveType was removed in graphql-js@16.0.0 please return type name instead.',
  //   );
  // });
}
