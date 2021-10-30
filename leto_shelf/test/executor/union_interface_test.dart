// https://github.com/graphql/graphql-js/blob/8261922bafb8c2b5c5041093ce271bdfcdf133c3/src/execution/__tests__/union-interface-test.ts
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:test/test.dart';

class Dog {
  final String name;
  final bool barks;
  Dog? mother;
  Dog? father;
  final List<Dog> progeny = [];

  Dog(this.name, this.barks);

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'barks': barks,
      'mother': mother,
      'father': father,
      'progeny': progeny,
    };
  }
}

class Cat {
  final String name;
  final bool meows;
  Cat? mother;
  Cat? father;
  final List<Cat> progeny = [];

  Cat(this.name, this.meows);

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'meows': meows,
      'mother': mother,
      'father': father,
      'progeny': progeny,
    };
  }
}

class Person {
  final String name;
  final List<Object>? pets; // Dog | Cat
  final List<Object>? friends; // Dog | Cat | Person>

  Person(
    this.name, [
    this.pets,
    this.friends,
  ]);

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'pets': pets,
      'friends': friends,
    };
  }
}

final NamedType = objectType<Object>(
  'Named',
  isInterface: true,
  fields: [graphQLString.field('name')],
);

final LifeType = () {
  final LifeType = objectType<Object>(
    'Life',
    isInterface: true,
  );

  LifeType.fields.add(listOf(LifeType).field('progeny'));

  return LifeType;
}();

final MammalType = () {
  final MammalType = objectType<Object>(
    'Mammal',
    isInterface: true,
    interfaces: [LifeType],
  );

  MammalType.fields.addAll([
    field('progeny', listOf(MammalType)),
    field('mother', MammalType),
    field('father', MammalType),
  ]);
  return MammalType;
}();

final DogType = () {
  final DogType = objectType<Dog>(
    'Dog',
    interfaces: [MammalType, LifeType, NamedType],
    // isTypeOf: (value) => value is Dog,
  );

  DogType.fields.addAll([
    field('name', graphQLString),
    field('barks', graphQLBoolean),
    field('progeny', listOf(DogType)),
    field('mother', DogType),
    field('father', DogType),
  ]);
  return DogType;
}();

final CatType = () {
  final CatType = objectType<Cat>(
    'Cat',
    interfaces: [MammalType, LifeType, NamedType],
    // isTypeOf: (value) => value is Cat,
  );

  CatType.fields.addAll([
    field('name', graphQLString),
    field('meows', graphQLBoolean),
    field('progeny', listOf(CatType)),
    field('mother', CatType),
    field('father', CatType),
  ]);
  return CatType;
}();

final PetType = GraphQLUnionType<Object>(
  'Pet',
  [DogType, CatType],
  // resolveType(value) {
  //   if (value instanceof Dog) {
  //     return DogType.name;
  //   }
  //   // istanbul ignore else (See: 'https://github.com/graphql/graphql-js/issues/2618')
  //   if (value instanceof Cat) {
  //     return CatType.name;
  //   }

  //   // istanbul ignore next (Not reachable. All possible types have been considered)
  //   expect.fail('Not reachable');
  // },
);

final PersonType = () {
  final PersonType = objectType<Person>(
    'Person',
    interfaces: [NamedType, MammalType, LifeType],

    // isTypeOf: (value) => value is Person,
  );

  PersonType.fields.addAll([
    field('name', graphQLString),
    field('pets', listOf(PetType)),
    field('friends', listOf(NamedType)),
    field('progeny', listOf(PersonType)),
    field('mother', PersonType),
    field('father', PersonType),
  ]);
  return PersonType;
}();

final schema = GraphQLSchema(
  queryType: PersonType,
  // types: [PetType],
);

final garfield = () {
  final garfield = Cat('Garfield', false);
  garfield.mother = Cat("Garfield's Mom", false);
  garfield.mother!.progeny.add(garfield);
  return garfield;
}();

final odie = () {
  final odie = Dog('Odie', true);
  odie.mother = Dog("Odie's Mom", true);
  odie.mother!.progeny.add(odie);
  return odie;
}();

final liz = Person('Liz');
final john = Person('John', [garfield, odie], [liz, odie]);

/// 'Execute: Union and intersection types'
void main() {
  Future<Map<String, Object?>> execute(
    String document, {
    Object? rootValue,
    bool validate = true,
  }) async {
    final result = await GraphQL(
      schema,
      validate: validate,
    ).parseAndExecute(
      document,
      rootValue: rootValue,
    );
    return result.toJson();
  }

  test('can introspect on union and intersection types', () async {
    const document = '''
      {
        Named: __type(name: "Named") {
          kind
          name
          fields { name }
          interfaces { name }
          possibleTypes { name }
          enumValues { name }
          inputFields { name }
        }
        Mammal: __type(name: "Mammal") {
          kind
          name
          fields { name }
          interfaces { name }
          possibleTypes { name }
          enumValues { name }
          inputFields { name }
        }
        Pet: __type(name: "Pet") {
          kind
          name
          fields { name }
          interfaces { name }
          possibleTypes { name }
          enumValues { name }
          inputFields { name }
        }
      }
    ''';

    expect(await execute(document), {
      'data': {
        'Named': {
          'kind': 'INTERFACE',
          'name': 'Named',
          'fields': [
            {'name': 'name'}
          ],
          'interfaces': <Object>[],
          'possibleTypes': unorderedEquals(<Object>[
            {'name': 'Dog'},
            {'name': 'Cat'},
            {'name': 'Person'}
          ]),
          'enumValues': null,
          'inputFields': null,
        },
        'Mammal': {
          'kind': 'INTERFACE',
          'name': 'Mammal',
          'fields': [
            {'name': 'progeny'},
            {'name': 'mother'},
            {'name': 'father'}
          ],
          'interfaces': [
            {'name': 'Life'}
          ],
          'possibleTypes': unorderedEquals(<Object>[
            {'name': 'Dog'},
            {'name': 'Cat'},
            {'name': 'Person'}
          ]),
          'enumValues': null,
          'inputFields': null,
        },
        'Pet': {
          'kind': 'UNION',
          'name': 'Pet',
          'fields': null,
          'interfaces': null,
          'possibleTypes': unorderedEquals(<Object>[
            {'name': 'Dog'},
            {'name': 'Cat'}
          ]),
          'enumValues': null,
          'inputFields': null,
        },
      },
    });
  });

  test('executes using union types', () async {
    // NOTE: This is an *invalid* query, but it should be an *executable* query.
    const document = '''
      {
        __typename
        name
        pets {
          __typename
          name
          barks
          meows
        }
      }
    ''';

    expect(await execute(document, rootValue: john, validate: false), {
      'data': {
        '__typename': 'Person',
        'name': 'John',
        'pets': [
          {
            '__typename': 'Cat',
            'name': 'Garfield',
            'meows': false,
          },
          {
            '__typename': 'Dog',
            'name': 'Odie',
            'barks': true,
          },
        ],
      },
    });
  });

  test('executes union types with inline fragments', () async {
    // This is the valid version of the query in the above test.
    const document = '''
      {
        __typename
        name
        pets {
          __typename
          ... on Dog {
            name
            barks
          }
          ... on Cat {
            name
            meows
          }
        }
      }
    ''';

    expect(await execute(document, rootValue: john), {
      'data': {
        '__typename': 'Person',
        'name': 'John',
        'pets': [
          {
            '__typename': 'Cat',
            'name': 'Garfield',
            'meows': false,
          },
          {
            '__typename': 'Dog',
            'name': 'Odie',
            'barks': true,
          },
        ],
      },
    });
  });

  test('executes using interface types', () async {
    // NOTE: This is an *invalid* query, but it should be an *executable* query.
    const document = '''
      {
        __typename
        name
        friends {
          __typename
          name
          barks
          meows
        }
      }
    ''';

    expect(await execute(document, rootValue: john, validate: false), {
      'data': {
        '__typename': 'Person',
        'name': 'John',
        'friends': [
          {'__typename': 'Person', 'name': 'Liz'},
          {'__typename': 'Dog', 'name': 'Odie', 'barks': true},
        ],
      },
    });
  });

  test('executes interface types with inline fragments', () async {
    // This is the valid version of the query in the above test.
    const document = '''
      {
        __typename
        name
        friends {
          __typename
          name
          ... on Dog {
            barks
          }
          ... on Cat {
            meows
          }
          ... on Mammal {
            mother {
              __typename
              ... on Dog {
                name
                barks
              }
              ... on Cat {
                name
                meows
              }
            }
          }
        }
      }
    ''';

    expect(await execute(document, rootValue: john), {
      'data': {
        '__typename': 'Person',
        'name': 'John',
        'friends': [
          {
            '__typename': 'Person',
            'name': 'Liz',
            'mother': null,
          },
          {
            '__typename': 'Dog',
            'name': 'Odie',
            'barks': true,
            'mother': {
              '__typename': 'Dog',
              'name': "Odie's Mom",
              'barks': true
            },
          },
        ],
      },
    });
  });

  test('executes interface types with named fragments', () async {
    const document = '''
      {
        __typename
        name
        friends {
          __typename
          name
          ...DogBarks
          ...CatMeows
        }
      }
      fragment  DogBarks on Dog {
        barks
      }
      fragment  CatMeows on Cat {
        meows
      }
    ''';

    expect(await execute(document, rootValue: john), {
      'data': {
        '__typename': 'Person',
        'name': 'John',
        'friends': [
          {
            '__typename': 'Person',
            'name': 'Liz',
          },
          {
            '__typename': 'Dog',
            'name': 'Odie',
            'barks': true,
          },
        ],
      },
    });
  });

  test('allows fragment conditions to be abstract types', () async {
    const document = '''
      {
        __typename
        name
        pets {
          ...PetFields,
          ...on Mammal {
            mother {
              ...ProgenyFields
            }
          }
        }
        friends { ...FriendFields }
      }
      fragment PetFields on Pet {
        __typename
        ... on Dog {
          name
          barks
        }
        ... on Cat {
          name
          meows
        }
      }
      fragment FriendFields on Named {
        __typename
        name
        ... on Dog {
          barks
        }
        ... on Cat {
          meows
        }
      }
      fragment ProgenyFields on Life {
        progeny {
          __typename
        }
      }
    ''';

    expect(await execute(document, rootValue: john), {
      'data': {
        '__typename': 'Person',
        'name': 'John',
        'pets': [
          {
            '__typename': 'Cat',
            'name': 'Garfield',
            'meows': false,
            'mother': {
              'progeny': [
                {'__typename': 'Cat'}
              ]
            },
          },
          {
            '__typename': 'Dog',
            'name': 'Odie',
            'barks': true,
            'mother': {
              'progeny': [
                {'__typename': 'Dog'}
              ]
            },
          },
        ],
        'friends': [
          {
            '__typename': 'Person',
            'name': 'Liz',
          },
          {
            '__typename': 'Dog',
            'name': 'Odie',
            'barks': true,
          },
        ],
      },
    });
  });

  test('gets execution info in resolver', () async {
    Object? encounteredContext;
    Object? encounteredSchema;
    Object? encounteredRootValue;

    final NamedType2 = objectType<Object>(
      'Named',
      fields: [
        field('name', graphQLString),
      ],
      isInterface: true,
      resolveType: (_source, type, ctx) {
        encounteredContext = ctx.globals;
        encounteredSchema = ctx.base.schema;
        encounteredRootValue = ctx.base.rootValue;
        return 'Person';
      },
    );

    final PersonType2 = objectType<Object>(
      'Person',
      interfaces: [NamedType2],
      fields: [
        field('name', graphQLString),
        field('friends', listOf(NamedType2)),
      ],
    );
    final schema2 = GraphQLSchema(queryType: PersonType2);
    const document = '{ name, friends { name } }';
    final rootValue = Person('John', [], [liz]);
    final contextValue = ScopedMap({'authToken': '123abc'});

    final result = await GraphQL(
      schema2,
      introspect: false,
    ).parseAndExecute(
      document,
      rootValue: rootValue,
      globalVariables: contextValue,
    );
    expect(result.toJson(), {
      'data': {
        'name': 'John',
        'friends': [
          {'name': 'Liz'}
        ],
      },
    });

    expect(encounteredSchema, schema2);
    expect(encounteredRootValue, rootValue);
    expect(encounteredContext, contextValue);
  });
}
