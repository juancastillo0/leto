// ignore_for_file: non_constant_identifier_names

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';
import 'package:test/test.dart';

/// Type System: Schema
void main() {
  test('Define sample schema', () {
    final BlogImage = objectType(
      'Image',
      fieldsMap: {
        'url': graphQLString.fieldSpec(),
        'width': graphQLInt.fieldSpec(),
        'height': graphQLInt.fieldSpec(),
      },
    );

    final BlogAuthor = GraphQLObjectType(
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
    final BlogArticle = GraphQLObjectType(
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

    final BlogQuery = GraphQLObjectType(
      'Query',
      fields: [
        BlogArticle.field(
          'article',
          inputs: [inputField('id', graphQLString)],
        ),
        BlogArticle.list().field('feed'),
      ],
    );

    final BlogMutation = GraphQLObjectType(
      'Mutation',
      fields: [
        field('writeArticle', BlogArticle),
      ],
    );

    final BlogSubscription = GraphQLObjectType(
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
      expect(schema.typeMap().keys, containsAll(['TestType']));
    });

    test('defines a mutation root', () {
      final schema = GraphQLSchema(mutationType: testType);
      expect(schema.typeMap().keys, containsAll(['TestType']));
    });

    test('defines a subscription root', () {
      final schema = GraphQLSchema(subscriptionType: testType);
      expect(schema.typeMap().keys, containsAll(['TestType']));
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
        types: [SomeSubtype],
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

      final schema = GraphQLSchema(types: [SomeSubtype]);

      expect(schema.getType('SomeInterface'), SomeInterface);
      expect(schema.getType('AnotherInterface'), AnotherInterface);
      expect(schema.getType('SomeSubtype'), SomeSubtype);
    });

    test('includes nested input objects in the map', () {
      final NestedInputObject = GraphQLInputObjectType(
        'NestedInputObject',
        fields: [],
      );

      final SomeInputObject = GraphQLInputObjectType(
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
          inputField('arg', GraphQLInputObjectType('Foo', fields: {})),
          inputField(
            'argList',
            listOf(
              GraphQLInputObjectType('Bar', fields: {}),
            ),
          ),
        ],
      );
      final schema = GraphQLSchema(directives: [directive]);

      expect(schema.typeMap().keys, containsAll(['Foo', 'Bar']));
    });
  });

  GraphQLScalarTypeValue _testScalarType(String name) {
    return GraphQLScalarTypeValue(
      name: name,
      description: null,
      specifiedByURL: null,
      validate: (key, input) => ValidationResult.ok(input),
      serialize: (value) => value,
      deserialize: (serdeCtx, serialized) => serialized,
    );
  }

  // TODO: Introspection in schema
  // test('preserves the order of user provided types', () {
  //   final aType = GraphQLObjectType(
  //     'A',
  //     fields: [
  //       field('sub', _testScalarType('ASub')),
  //     ],
  //   );
  //   final zType = GraphQLObjectType(
  //     'Z',
  //     fields: [
  //       field('sub', _testScalarType('ZSub')),
  //     ],
  //   );
  //   final queryType = GraphQLObjectType(
  //     'Query',
  //     fields: [
  //       field('a', aType),
  //       field('z', zType),
  //       field('sub', _testScalarType('QuerySub')),
  //     ],
  //   );
  //   final schema = GraphQLSchema(
  //     types: [zType, queryType, aType],
  //     queryType: queryType,
  //   );

  //   final typeNames = schema.typeMap().keys;
  //   expect(typeNames, [
  //     'Z',
  //     'ZSub',
  //     'Query',
  //     'QuerySub',
  //     'A',
  //     'ASub',
  //     'Boolean',
  //     'String',
  //     '__Schema',
  //     '__Type',
  //     '__TypeKind',
  //     '__Field',
  //     '__InputValue',
  //     '__EnumValue',
  //     '__Directive',
  //     '__DirectiveLocation',
  //   ]);

  //   // Also check that this order is stable
  //   // final copySchema = GraphQLSchema(schema.toConfig());
  //   // expect(Object.keys(copySchema.typeMap())).to.deep.equal(typeNames);
  // });

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

          final QueryType = GraphQLObjectType(
            'Query',
            fields: [
              field('normal', graphQLString),
              field('fake', FakeString),
            ],
          );

          expect(
              () => GraphQLSchema(queryType: QueryType),
              throwsA(predicate(
                (e) =>
                    e is ArgumentError &&
                    e.message ==
                        'Schema must contain uniquely named types but'
                            ' contains multiple types named "String".',
              )));
        });

        test('rejects a Schema when a provided type has no name', () {
          final query = GraphQLObjectType(
            'Query',
            fields: [graphQLString.field('foo')],
          );
          final types = <GraphQLType>[_testScalarType(''), query];

          // @ts-expect-error
          expect(
              () => GraphQLSchema(queryType: query, types: types),
              throwsA(predicate(
                (e) =>
                    e is ArgumentError &&
                    e.message ==
                        'One of the provided types for building the'
                            ' Schema is missing a name.',
              )));
        });

        test('rejects a Schema which defines an object type twice', () {
          final types = [
            GraphQLObjectType('SameName', fields: {}),
            GraphQLObjectType('SameName', fields: {}),
          ];

          expect(
              () => GraphQLSchema(types: types),
              throwsA(predicate(
                (e) =>
                    e is ArgumentError &&
                    e.message ==
                        'Schema must contain uniquely named types but'
                            ' contains multiple types named "SameName".',
              )));
        });

        test('rejects a Schema which defines fields with conflicting types',
            () {
          final fields = <GraphQLObjectField>[];
          final QueryType = GraphQLObjectType(
            'Query',
            fields: [
              field('a', GraphQLObjectType('SameName', fields: fields)),
              field('b', GraphQLObjectType('SameName', fields: fields)),
            ],
          );

          expect(
            () => GraphQLSchema(queryType: QueryType),
            throwsA(predicate((e) =>
                e is ArgumentError &&
                e.message ==
                    'Schema must contain uniquely named types but '
                        'contains multiple types named "SameName".')),
          );
        }); // TODO:
      }, skip: '// TODO: Improve equality checks for GraphQLTypes');

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
