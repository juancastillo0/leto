// ignore_for_file: non_constant_identifier_names

import 'package:leto_schema/introspection.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';
import 'package:test/test.dart';

/// Type System: Schema
void main() {
  test('Define sample schema', () {
    final BlogImage = objectType<Object>(
      'Image',
      fieldsMap: {
        'url': graphQLString.fieldSpec(),
        'width': graphQLInt.fieldSpec(),
        'height': graphQLInt.fieldSpec(),
      },
    );

    final BlogAuthor = GraphQLObjectType<Object>(
      'Author',
      fields: [
        graphQLString.field('id'),
        graphQLString.field('name'),
        BlogImage.field(
          'pic',
          inputs: [
            inputField('width', graphQLInt),
            inputField('height', graphQLInt)
          ],
        ),
      ],
    );
    final BlogArticle = GraphQLObjectType<Object>(
      'Article',
      fields: [
        graphQLString.field('id'),
        graphQLBoolean.field('isPublished'),
        BlogAuthor.field('author'),
        graphQLString.field('title'),
        graphQLString.field('body'),
      ],
    );

    BlogAuthor.fields.add(BlogArticle.field('recentArticle'));

    final BlogQuery = GraphQLObjectType<Object>(
      'Query',
      fields: [
        BlogArticle.field(
          'article',
          inputs: [inputField('id', graphQLString)],
        ),
        BlogArticle.list().field('feed'),
      ],
    );

    final BlogMutation = GraphQLObjectType<Object>(
      'Mutation',
      fields: [
        field('writeArticle', BlogArticle),
      ],
    );

    final BlogSubscription = GraphQLObjectType<Object>(
      'Subscription',
      fields: [
        field(
          'articleSubscribe',
          BlogArticle,
          inputs: [inputField('id', graphQLString)],
        ),
      ],
    );

    final schema = GraphQLSchema(
      description: 'Sample schema',
      queryType: BlogQuery,
      mutationType: BlogMutation,
      subscriptionType: BlogSubscription,
    );

    expect(printSchema(schema), '''
"""Sample schema"""
schema {
  query: Query
  mutation: Mutation
  subscription: Subscription
}

type Query {
  article(id: String): Article
  feed: [Article]
}

type Article {
  id: String
  isPublished: Boolean
  author: Author
  title: String
  body: String
}

type Author {
  id: String
  name: String
  pic(width: Int, height: Int): Image
  recentArticle: Article
}

type Image {
  url: String
  width: Int
  height: Int
}

type Mutation {
  writeArticle: Article
}

type Subscription {
  articleSubscribe(id: String): Article
}''');
  });

  group('Root types', () {
    final testType = GraphQLObjectType('TestType', fields: {});

    test('defines a query root', () {
      final schema = GraphQLSchema(queryType: testType);
      expect(schema.typeMap.keys, containsAll(<String>['TestType']));
    });

    test('defines a mutation root', () {
      final schema = GraphQLSchema(mutationType: testType);
      expect(schema.typeMap.keys, containsAll(<String>['TestType']));
    });

    test('defines a subscription root', () {
      final schema = GraphQLSchema(subscriptionType: testType);
      expect(schema.typeMap.keys, containsAll(<String>['TestType']));
    });
  });

  group('Type Map', () {
    test('includes interface possible types in the type map', () {
      final SomeInterface = objectType(
        'SomeInterface',
        fields: {},
        isInterface: true,
      );

      final SomeSubtype = GraphQLObjectType(
        'SomeSubtype',
        fields: {},
        interfaces: [SomeInterface],
      );

      final schema = GraphQLSchema(
        queryType: GraphQLObjectType(
          'Query',
          fields: [
            field('iface', SomeInterface),
          ],
        ),
        otherTypes: [SomeSubtype],
      );

      expect(schema.getType('SomeInterface'), SomeInterface);
      expect(schema.getType('SomeSubtype'), SomeSubtype);

      expect(SomeSubtype.isImplementationOf(SomeInterface), true);
    });

    test("includes interface's thunk subtypes in the type map", () {
      final AnotherInterface = GraphQLObjectType(
        'AnotherInterface',
        fields: {},
        isInterface: true,
      );

      final SomeInterface = GraphQLObjectType(
        'SomeInterface',
        fields: {},
        interfaces: [AnotherInterface],
        isInterface: true,
      );

      final SomeSubtype = GraphQLObjectType(
        'SomeSubtype',
        fields: {},
        interfaces: [SomeInterface],
      );

      final schema = GraphQLSchema(otherTypes: [SomeSubtype]);

      expect(schema.getType('SomeInterface'), SomeInterface);
      expect(schema.getType('AnotherInterface'), AnotherInterface);
      expect(schema.getType('SomeSubtype'), SomeSubtype);
    });

    test('includes nested input objects in the map', () {
      final NestedInputObject = GraphQLInputObjectType<Object>(
        'NestedInputObject',
        fields: [],
      );

      final SomeInputObject = GraphQLInputObjectType<Object>(
        'SomeInputObject',
        fields: [
          inputField('nested', NestedInputObject),
        ],
      );

      final schema = GraphQLSchema(
        queryType: GraphQLObjectType(
          'Query',
          fields: [
            field(
              'something',
              graphQLString,
              inputs: [inputField('input', SomeInputObject)],
            ),
          ],
        ),
      );

      expect(schema.getType('SomeInputObject'), SomeInputObject);
      expect(schema.getType('NestedInputObject'), NestedInputObject);
    });

    test('includes input types only used in directives', () {
      final directive = GraphQLDirective(
        name: 'dir',
        locations: [DirectiveLocation.OBJECT],
        inputs: [
          GraphQLInputObjectType<Object>('Foo', fields: {}).inputField('arg'),
          GraphQLInputObjectType<Object>('Bar', fields: {}).list().inputField(
                'argList',
              ),
        ],
      );
      final schema = GraphQLSchema(directives: [directive]);

      expect(schema.typeMap.keys, containsAll(<String>['Foo', 'Bar']));
    });
  });

  GraphQLScalarTypeValue<Object?, Object?> _testScalarType(String name) {
    return GraphQLScalarTypeValue(
      name: name,
      description: null,
      specifiedByURL: null,
      validate: (key, input) => ValidationResult.ok(input),
      serialize: (value) => value,
      deserialize: (serdeCtx, serialized) => serialized,
    );
  }

  test('preserves the order of user provided types', () {
    final aType = GraphQLObjectType<Object>(
      'A',
      fields: [
        field('sub', _testScalarType('ASub')),
      ],
    );
    final zType = GraphQLObjectType<Object>(
      'Z',
      fields: [
        field('sub', _testScalarType('ZSub')),
      ],
    );
    final queryType = GraphQLObjectType<Object>(
      'Query',
      fields: [
        field('a', aType),
        field('z', zType),
        field('sub', _testScalarType('QuerySub')),
      ],
    );
    final schema = reflectSchema(GraphQLSchema(
      otherTypes: [zType, queryType, aType],
      queryType: queryType,
    ));

    final typeNames = schema.typeMap.keys;
    expect(
      typeNames,
      // TODO: was ordered
      unorderedEquals(<String>[
        'Z',
        'ZSub',
        'Query',
        'QuerySub',
        'A',
        'ASub',
        'Boolean',
        'String',
        '__Schema',
        '__Type',
        '__TypeKind',
        '__Field',
        '__InputValue',
        '__EnumValue',
        '__Directive',
        '__DirectiveLocation',
      ]),
    );

    // Also check that this order is stable
    // final copySchema = GraphQLSchema(schema.toConfig());
    // expect(Object.keys(copySchema.typeMap())).to.deep.equal(typeNames);
  });

  // test('can be Object.toStringified', ()  {
  //   final schema = GraphQLSchema();

  //   expect(Object.prototype.toString.call(schema),
  //     '[object GraphQLSchema]',
  //   );
  // });

  group('Validity', () {
    group('when not assumed valid', () {
      // TODO:
      // test('configures the schema to still needing validation', ()  {
      //   expect(
      //     GraphQLSchema(
      //       assumeValid: false,
      //     ).__validationErrors,
      //   ,undefined);
      // });

      //   test('checks the configuration for mistakes', ()  {
      //     // @ts-expect-error
      //     expect(() => GraphQLSchema(JSON.parse)).to.throw();
      //     // @ts-expect-error
      //     expect(() => GraphQLSchema({ types: {} })).to.throw();
      //     // @ts-expect-error
      //     expect(() => GraphQLSchema({ directives: {} })).to.throw();
      //   });
      // });

      group('A Schema must contain uniquely named types', () {
        test('rejects a Schema which redefines a built-in type', () {
          final FakeString = _testScalarType(
            'String',
          );

          final QueryType = GraphQLObjectType<Object>(
            'Query',
            fields: [
              graphQLString.field('normal'),
              FakeString.field('fake'),
            ],
          );

          expect(
              () => GraphQLSchema(queryType: QueryType),
              throwsA(predicate(
                (e) =>
                    e is SameNameGraphQLTypeException &&
                    e.type1 == FakeString &&
                    e.type2 == graphQLString,
              )));
        });

        test('rejects a Schema when a provided type has no name', () {
          final query = GraphQLObjectType<Object>(
            'Query',
            fields: [graphQLString.field('foo')],
          );
          final types = <GraphQLType>[_testScalarType(''), query];

          // @ts-expect-error
          expect(
              () => GraphQLSchema(queryType: query, otherTypes: types),
              throwsA(predicate(
                (e) => e is UnnamedTypeException && e.type == types[0],
              )));
        });

        test('rejects a Schema which defines an object type twice', () {
          final types = [
            GraphQLObjectType('SameName', fields: {}),
            GraphQLObjectType('SameName', fields: {}),
          ];

          expect(
              () => GraphQLSchema(otherTypes: types),
              throwsA(predicate(
                (e) =>
                    e is SameNameGraphQLTypeException &&
                    e.type1 == types[1] &&
                    e.type2 == types[0],
              )));
        });

        test('rejects a Schema which defines fields with conflicting types',
            () {
          final fields = <GraphQLObjectField>[];
          final QueryType = GraphQLObjectType<Object>(
            'Query',
            fields: [
              field('a', GraphQLObjectType('SameName', fields: fields)),
              field('b', GraphQLObjectType('SameName', fields: fields)),
            ],
          );

          expect(
            () => GraphQLSchema(queryType: QueryType),
            throwsA(predicate((e) =>
                e is SameNameGraphQLTypeException &&
                e.type1 == QueryType.fields[1].type &&
                e.type2 == QueryType.fields[0].type)),
          );
        });
      });

      group('when assumed valid', () {
        // TODO:
        // test('configures the schema to have no errors', ()  {
        //   expect(
        //     GraphQLSchema(
        //       assumeValid: true,
        //     ).__validationErrors,
        //   ).to.deep.equal([]);
        // });
      });
    });
  });
}
