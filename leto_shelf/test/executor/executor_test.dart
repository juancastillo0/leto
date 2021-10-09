// https://github.com/graphql/graphql-js/blob/e6820a98b27b0d0c0c880edfe3b5b39a72496a62/src/execution/__tests__/executor-test.ts

import 'dart:convert';

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:test/test.dart';

void main() {
  Iterable<GraphQLObjectField<Object, Object, T>>
      fieldsFromMap<T extends Object>(
    Map<String, GraphQLType> map,
  ) {
    return map.entries.map((e) => e.value.field(e.key));
  }

  GraphQLObjectType<T> objectTypeFromMap<T extends Object>(
    String name,
    Map<String, GraphQLType> map,
  ) {
    return objectType(
      name,
      fields: fieldsFromMap(map),
    );
  }

  Future<void> simpleTest(
    Map<String, GraphQLType> fields,
    Map<String, Object?>? rootValue,
    String document,
    Map<String, Object?> expectedResponse, {
    String? operationName,
  }) async {
    final schema = GraphQLSchema(
      queryType: objectTypeFromMap(
        'Type',
        fields,
      ),
    );

    final result = await GraphQL(schema, introspect: false, validate: false)
        .parseAndExecute(
      document,
      initialValue: rootValue,
      operationName: operationName,
    );

    expect(result.toJson(), expectedResponse);
  }

  group('Execute: Handles basic execution tasks', () {
    test('executes arbitrary code', () async {
      final data = {
        'a': () => 'Apple',
        'b': () => 'Banana',
        'c': () => 'Cookie',
        'd': () => 'Donut',
        'e': () => 'Egg',
        'f': 'Fish',
        // Called only by DataType::pic static resolver
        'pic': (int size) => 'Pic of size: $size',
      };

      final deepData = {
        'a': () => 'Already Been Done',
        'b': () => 'Boring',
        'c': () => ['Contrived', null, 'Confusing'],
        'deeper': () => [data, null, data],
      };

      Object promiseData() {
        return Future.value(data);
      }

      data.addAll({
        'deep': () => deepData,
        'promise': promiseData,
      });

      final DataType = GraphQLObjectType<Map<String, Object?>>(
        'DataType',
      );

      final DeepDataType = GraphQLObjectType<Object>(
        'DeepDataType',
        fields: {
          field('a', graphQLString),
          field('b', graphQLString),
          field('c', listOf(graphQLString)),
          field('deeper', listOf(DataType)),
        },
      );

      DataType.fields.addAll([
        field('a', graphQLString),
        field('b', graphQLString),
        field('c', graphQLString),
        field('d', graphQLString),
        field('e', graphQLString),
        field('f', graphQLString),
        field(
          'pic',
          graphQLString,
          inputs: {
            GraphQLFieldInput('size', graphQLInt),
          },
          resolve: (obj, ctx) =>
              (obj['pic'] as Function(int))(ctx.args['size'] as int),
        ),
        field('deep', DeepDataType),
        field('promise', DataType),
      ]);

      const document = r'''
        query ($size: Int) {
          a,
          b,
          x: c
          ...c
          f
          ...on DataType {
            pic(size: $size)
            promise {
              a
            }
          }
          deep {
            a
            b
            c
            deeper {
              a
              b
            }
          }
        }

        fragment c on DataType {
          d
          e
        }
      ''';

      final result =
          await GraphQL(GraphQLSchema(queryType: DataType)).parseAndExecute(
        document,
        initialValue: data,
        variableValues: {'size': 100},
      );

      expect(result.toJson(), {
        'data': {
          'a': 'Apple',
          'b': 'Banana',
          'x': 'Cookie',
          'd': 'Donut',
          'e': 'Egg',
          'f': 'Fish',
          'pic': 'Pic of size: 100',
          'promise': {'a': 'Apple'},
          'deep': {
            'a': 'Already Been Done',
            'b': 'Boring',
            'c': ['Contrived', null, 'Confusing'],
            'deeper': [
              {'a': 'Apple', 'b': 'Banana'},
              null,
              {'a': 'Apple', 'b': 'Banana'},
            ],
          },
        },
      });
    });

    test('merges parallel fragments', () async {
      // final data = {'a': 'Apple', 'b': 'Banana', 'c': 'Cherry'};
      final Type = objectType<Object>('Type', fields: [
        graphQLString.field('a', resolve: (_, __) => 'Apple'),
        graphQLString.field('b', resolve: (_, __) => 'Banana'),
        graphQLString.field('c', resolve: (_, __) => 'Cherry'),
      ]);
      Type.fields.add(
        Type.field('deep', resolve: (_, __) => <String, Object?>{}),
      );

      final schema = GraphQLSchema(queryType: Type);

      const document = '''
      { a, ...FragOne, ...FragTwo }

      fragment FragOne on Type {
        b
        deep { b, deeper: deep { b } }
      }

      fragment FragTwo on Type {
        c
        deep { c, deeper: deep { c } }
      }
    ''';

      final result = await GraphQL(schema).parseAndExecute(document);
      print(printSchema(schema));
      print(result);
      expect(result.toJson(), {
        'data': {
          'a': 'Apple',
          'b': 'Banana',
          'c': 'Cherry',
          'deep': {
            'b': 'Banana',
            'c': 'Cherry',
            'deeper': {
              'b': 'Banana',
              'c': 'Cherry',
            },
          },
        },
      });
    });

    test('provides info about current execution state', () async {
      ReqCtx<Object>? _resolvedInfo;
      final testType = GraphQLObjectType<Object>(
        'Test',
        fields: [
          graphQLString.field(
            'test',
            resolve: (obj, ctx) {
              _resolvedInfo = ctx;
            },
          ),
        ],
      );
      final schema = GraphQLSchema(queryType: testType);

      const document = r'query ($var: String) { result: test }';
      final rootValue = {'root': 'val'};
      final variableValues = {'var': 'abc'};

      await GraphQL(schema, introspect: false).parseAndExecute(document,
          initialValue: rootValue, variableValues: variableValues);

      // TODO:
      // expect(resolvedInfo).to.have.all.keys(
      //   'fieldName',
      //   'fieldNodes',
      //   'returnType',
      //   'parentType',
      //   'path',
      //   'schema',
      //   'fragments',
      //   'rootValue',
      //   'operation',
      //   'variableValues',
      // );

      // final operation = document.definitions[0];
      // invariant(operation.kind === Kind.OPERATION_DEFINITION);
      final resolvedInfo = _resolvedInfo;
      if (resolvedInfo == null) {
        throw Error();
      }
      final parentType = resolvedInfo.parentCtx.objectType;

      expect({
        'fieldName': resolvedInfo.field.name,
        'returnType': resolvedInfo.field.type,
        'path': resolvedInfo.path,
        'parentType': parentType,
        'schema': resolvedInfo.parentCtx.base.schema,
        'rootValue': resolvedInfo.parentCtx.base.rootValue,
        'variableValues': resolvedInfo.parentCtx.base.variableValues,
      }, {
        'fieldName': 'test',
        'returnType': graphQLString,
        'path': ['result'],
        'parentType': testType,
        'schema': schema,
        'rootValue': rootValue,
        'variableValues': {'var': 'abc'},
        // 'operation': operation,
      });

      // final field = operation.selectionSet.selections[0];
      // expect(resolvedInfo).to.deep.include({
      //   fieldNodes: [field],
      //   path: { prev: undefined, key: 'result', typename: 'Test' },
      // });
    });

    test('populates path correctly with complex types', () async {
      late List<Object> path;
      final someObject = objectType<Object>(
        'SomeObject',
        fields: [
          graphQLString.field(
            'test',
            resolve: (obj, ctx) {
              path = ctx.path;
            },
          ),
        ],
      );
      final someUnion = GraphQLUnionType(
        'SomeUnion',
        [someObject],
        // TODO:
        // resolveType() {
        //   return 'SomeObject';
        // },
      );
      final testType = objectType<Object>(
        'SomeQuery',
        fields: [
          field(
            'test',
            listOf(someUnion.nonNull()).nonNull(),
          )
        ],
      );
      final schema = GraphQLSchema(queryType: testType);
      final rootValue = {
        'test': [<String, Object?>{}]
      };
      const document = '''
        query {
          l1: test {
            ... on SomeObject {
              l2: test
            }
          }
        }
      ''';

      await GraphQL(schema).parseAndExecute(document, initialValue: rootValue);

      expect(path, ['l1', 0, 'l2']);

      // TODO:
      // expect(path, {
      //   'key': 'l2',
      //   'typename': 'SomeObject',
      //   'prev': {
      //     'key': 0,
      //     'typename': null,
      //     'prev': {
      //       'key': 'l1',
      //       'typename': 'SomeQuery',
      //       'prev': null,
      //     },
      //   },
      // });
    });

    test('threads root value context correctly', () async {
      Object? resolvedRootValue;
      final schema = GraphQLSchema(
        queryType: objectType(
          'Type',
          fields: [
            graphQLString.field(
              'a',
              resolve: (rootValueArg, ctx) {
                resolvedRootValue = rootValueArg;
              },
            )
          ],
        ),
      );

      final rootValue = {'contextThing': 'thing'};

      await GraphQL(schema).parseAndExecute(
        'query Example { a }',
        initialValue: rootValue,
      );

      expect(resolvedRootValue, rootValue);
    });

    test('correctly threads arguments', () async {
      Object? resolvedArgs;
      final schema = GraphQLSchema(
        queryType: objectType(
          'Type',
          fields: [
            field(
              'b',
              graphQLString,
              inputs: [
                GraphQLFieldInput('numArg', graphQLInt),
                GraphQLFieldInput('stringArg', graphQLString),
              ],
              resolve: (_, ctx) {
                resolvedArgs = ctx.args;
              },
            )
          ],
        ),
      );

      const document = '''
        query Example {
          b(numArg: 123, stringArg: "foo")
        }
      ''';

      await GraphQL(schema).parseAndExecute(document);
      expect(resolvedArgs, {'numArg': 123, 'stringArg': 'foo'});
    });

    test('nulls out error subtrees', () async {
      final schema = GraphQLSchema(
        queryType: GraphQLObjectType(
          'Type',
          fields: [
            field('sync', graphQLString),
            field('syncError', graphQLString),
            field('syncRawError', graphQLString),
            field('syncReturnError', graphQLString),
            field('syncReturnErrorList', listOf(graphQLString)),
            field('async', graphQLString),
            field('asyncReject', graphQLString),
            field('asyncRejectWithExtensions', graphQLString),
            field('asyncRawReject', graphQLString),
            field('asyncEmptyReject', graphQLString),
            field('asyncError', graphQLString),
            field('asyncRawError', graphQLString),
            field('asyncReturnError', graphQLString),
            field('asyncReturnErrorWithExtensions', graphQLString),
          ],
        ),
      );

      const document = '''
        {
          sync
          syncError
          syncRawError
          syncReturnError
          syncReturnErrorList
          async
          asyncReject
          asyncRawReject
          asyncEmptyReject
          asyncError
          asyncRawError
          asyncReturnError
          asyncReturnErrorWithExtensions
        }
      ''';

      final rootValue = {
        'sync': () {
          return 'sync';
        },
        'syncError': () {
          throw GraphQLExceptionError('Error getting syncError');
        },
        'syncRawError': () {
          // eslint-disable-next-line @typescript-eslint/no-throw-literal
          throw 'Error getting syncRawError';
        },
        'syncReturnError': () {
          return throw GraphQLExceptionError('Error getting syncReturnError');
        },
        'syncReturnErrorList': () {
          // TODO: didn't throw
          return [
            'sync0',
            () => throw GraphQLExceptionError(
                'Error getting syncReturnErrorList1'),
            'sync2',
            () => throw GraphQLExceptionError(
                'Error getting syncReturnErrorList3'),
          ];
        },
        'async': () {
          return Future.microtask(() => 'async');
        },
        'asyncReject': () {
          return Future<Object>.microtask(
            () => Future.error(
                GraphQLExceptionError('Error getting asyncReject')),
          );
        },
        'asyncRawReject': () {
          // eslint-disable-next-line prefer-promise-reject-errors
          return Future<Object>.error('Error getting asyncRawReject');
        },
        'asyncEmptyReject': () {
          // eslint-disable-next-line prefer-promise-reject-errors
          return Future<Object>.error('');
        },
        'asyncError': () {
          return Future.microtask(() {
            throw GraphQLExceptionError('Error getting asyncError');
          });
        },
        'asyncRawError': () {
          return Future.microtask(() {
            // eslint-disable-next-line @typescript-eslint/no-throw-literal
            throw 'Error getting asyncRawError';
          });
        },
        'asyncReturnError': () async {
          // TODO: didn't throw
          // TODO: support async errors?
          // return throw Future.value(
          //   GraphQLExceptionError('Error getting asyncReturnError'),
          // );
          return throw GraphQLExceptionError('Error getting asyncReturnError');
        },
        'asyncReturnErrorWithExtensions': () {
          final error = GraphQLExceptionError(
            'Error getting asyncReturnErrorWithExtensions',
            extensions: {'foo': 'bar'},
          );

          // TODO: didn't throw
          // TODO: support async errors?
          // return throw Future.value(error);
          return Future.value(error).then((value) => throw value);
        },
      };

      final result = await GraphQL(schema)
          .parseAndExecute(document, initialValue: rootValue);

      expect(result.toJson(), {
        'data': {
          'sync': 'sync',
          'syncError': null,
          'syncRawError': null,
          'syncReturnError': null,
          'syncReturnErrorList': ['sync0', null, 'sync2', null],
          'async': 'async',
          'asyncReject': null,
          'asyncRawReject': null,
          'asyncEmptyReject': null,
          'asyncError': null,
          'asyncRawError': null,
          'asyncReturnError': null,
          'asyncReturnErrorWithExtensions': null,
        },
        'errors': unorderedEquals(<Object>[
          {
            'message': 'Error getting syncError',
            'locations': [
              {'line': 2, 'column': 10}
            ],
            'path': ['syncError'],
          },
          {
            // Unexpected error value:
            'message': 'Error getting syncRawError',
            'locations': [
              {'line': 3, 'column': 10}
            ],
            'path': ['syncRawError'],
          },
          {
            'message': 'Error getting syncReturnError',
            'locations': [
              {'line': 4, 'column': 10}
            ],
            'path': ['syncReturnError'],
          },
          {
            'message': 'Error getting syncReturnErrorList1',
            'locations': [
              {'line': 5, 'column': 10}
            ],
            'path': ['syncReturnErrorList', 1],
          },
          {
            'message': 'Error getting syncReturnErrorList3',
            'locations': [
              {'line': 5, 'column': 10}
            ],
            'path': ['syncReturnErrorList', 3],
          },
          {
            'message': 'Error getting asyncReject',
            'locations': [
              {'line': 7, 'column': 10}
            ],
            'path': ['asyncReject'],
          },
          {
            // Unexpected error value:
            'message': 'Error getting asyncRawReject',
            'locations': [
              {'line': 8, 'column': 10}
            ],
            'path': ['asyncRawReject'],
          },
          {
            // Unexpected error value: undefined
            'message': '',
            'locations': [
              {'line': 9, 'column': 10}
            ],
            'path': ['asyncEmptyReject'],
          },
          {
            'message': 'Error getting asyncError',
            'locations': [
              {'line': 10, 'column': 10}
            ],
            'path': ['asyncError'],
          },
          {
            // Unexpected error value:
            'message': 'Error getting asyncRawError',
            'locations': [
              {'line': 11, 'column': 10}
            ],
            'path': ['asyncRawError'],
          },
          {
            'message': 'Error getting asyncReturnError',
            'locations': [
              {'line': 12, 'column': 10}
            ],
            'path': ['asyncReturnError'],
          },
          {
            'message': 'Error getting asyncReturnErrorWithExtensions',
            'locations': [
              {'line': 13, 'column': 10}
            ],
            'path': ['asyncReturnErrorWithExtensions'],
            'extensions': {'foo': 'bar'},
          },
        ]),
      });
    });

    test('nulls error subtree for promise rejection #1071', () async {
      final schema = GraphQLSchema(
        queryType: objectType('Query', fields: [
          listOf(objectType<Object>(
            'Food',
            fields: [
              graphQLString.field('name'),
            ],
          )).field(
            'foods',
            resolve: (parent, ctx) {
              return Future.error(GraphQLExceptionError('Oops'));
            },
          )
        ]),
      );

      const document = '''
        query {
          foods {
            name
          }
        }
      ''';

      final result = await GraphQL(schema).parseAndExecute(document);

      expect(result.toJson(), {
        'data': {'foods': null},
        'errors': [
          {
            'locations': [
              {'column': 10, 'line': 1}
            ],
            'message': 'Oops',
            'path': ['foods'],
          },
        ],
      });
    });

    test('Full response path is included for non-nullable fields', () async {
      GraphQLObjectType<Object> A = () {
        final A = objectType('A');
        A.fields.addAll([
          field(
            'nullableA',
            A,
            resolve: (_, __) => <String, Object?>{},
          ),
          field(
            'nonNullA',
            A.nonNull(),
            resolve: (_, __) => <String, Object?>{},
          ),
          field(
            'throws',
            graphQLString.nonNull(),
            resolve: (_, __) {
              throw GraphQLExceptionError('Catch me if you can');
            },
          ),
        ]);
        return A;
      }();

      final schema = GraphQLSchema(
        queryType: objectType(
          'query',
          fields: [
            A.nonNull().field(
                  'nullableA',
                  resolve: (_, __) => <String, Object?>{},
                ),
          ],
        ),
      );

      const document = '''
        query {
          nullableA {
            aliasedA: nullableA {
              nonNullA {
                anotherA: nonNullA {
                  throws
                }
              }
            }
          }
        }
      ''';

      final result = await GraphQL(schema).parseAndExecute(document);
      expect(result.toJson(), {
        'data': {
          'nullableA': {
            'aliasedA': null,
          },
        },
        'errors': [
          {
            'message': 'Catch me if you can',
            'locations': [
              {'line': 5, 'column': 18}
            ],
            'path': ['nullableA', 'aliasedA', 'nonNullA', 'anotherA', 'throws'],
          },
        ],
      });
    });

    test('uses the inline operation if no operation name is provided',
        () async {
      final schema = GraphQLSchema(
        queryType: objectType(
          'Type',
          fields: [graphQLString.field('a')],
        ),
      );
      final rootValue = {'a': 'b'};

      final result = await GraphQL(schema).parseAndExecute(
        '{ a }',
        initialValue: rootValue,
      );
      expect(result.toJson(), {
        'data': {'a': 'b'}
      });
    });

    test('uses the only operation if no operation name is provided', () async {
      await simpleTest(
        {'a': graphQLString},
        {'a': 'b'},
        'query Example { a }',
        {
          'data': {'a': 'b'}
        },
      );
    });

    test('uses the named operation if operation name is provided', () async {
      await simpleTest(
        {'a': graphQLString},
        {'a': 'b'},
        'query Example { first: a } query OtherExample { second: a }',
        {
          'data': {'second': 'b'}
        },
        operationName: 'OtherExample',
      );
    });

    test('provides error if no operation is provided', () async {
      await simpleTest(
        {'a': graphQLString},
        {'a': 'b'},
        'fragment Example on Type { a }',
        {
          'errors': [
            {'message': 'This document does not define any operations.'}
          ],
        },
      );
    });

    test('errors if no op name is provided with multiple operations', () async {
      await simpleTest(
        {'a': graphQLString},
        null,
        'query Example { a } query OtherExample { a }',
        {
          'errors': [
            {
              'message': 'Multiple operations found, '
                  'please provide an operation name.',
            },
          ],
        },
      );
    });

    test('errors if unknown operation name is provided', () async {
      await simpleTest(
        {'a': graphQLString},
        null,
        '''
        query Example { a }
        query OtherExample { a }
        ''',
        {
          'errors': [
            {'message': 'Operation named "UnknownExample" not found in query.'}
          ],
        },
        operationName: 'UnknownExample',
      );
    });

    test('errors if empty string is provided as operation name', () async {
      final schema = GraphQLSchema(
        queryType: GraphQLObjectType(
          'Type',
          fields: {
            field('a', graphQLString),
          },
        ),
      );
      const document = '{ a }';
      const operationName = '';

      final result = await GraphQL(schema)
          .parseAndExecute(document, operationName: operationName);
      expect(result.toJson(), {
        'errors': [
          {'message': 'Operation named "" not found in query.'}
        ],
      });
    });

    // it('uses the query schema for queries', () {
    //   final schema = new GraphQLSchema({
    //     query: new GraphQLObjectType({
    //       name: 'Q',
    //       fields: {
    //         a: { type: GraphQLString },
    //       },
    //     }),
    //     mutation: new GraphQLObjectType({
    //       name: 'M',
    //       fields: {
    //         c: { type: GraphQLString },
    //       },
    //     }),
    //     subscription: new GraphQLObjectType({
    //       name: 'S',
    //       fields: {
    //         a: { type: GraphQLString },
    //       },
    //     }),
    //   });
    //   final document = parse(`
    //     query Q { a }
    //     mutation M { c }
    //     subscription S { a }
    //   `);
    //   final rootValue = { a: 'b', c: 'd' };
    //   final operationName = 'Q';

    //   final result = executeSync({ schema, document, rootValue, operationName });
    //   expect(result).to.deep.equal({ data: { a: 'b' } });
    // });

    // it('uses the mutation schema for mutations', () {
    //   final schema = new GraphQLSchema({
    //     query: new GraphQLObjectType({
    //       name: 'Q',
    //       fields: {
    //         a: { type: GraphQLString },
    //       },
    //     }),
    //     mutation: new GraphQLObjectType({
    //       name: 'M',
    //       fields: {
    //         c: { type: GraphQLString },
    //       },
    //     }),
    //   });
    //   final document = parse(`
    //     query Q { a }
    //     mutation M { c }
    //   `);
    //   final rootValue = { a: 'b', c: 'd' };
    //   final operationName = 'M';

    //   final result = executeSync({ schema, document, rootValue, operationName });
    //   expect(result).to.deep.equal({ data: { c: 'd' } });
    // });

    // it('uses the subscription schema for subscriptions', () {
    //   final schema = new GraphQLSchema({
    //     query: new GraphQLObjectType({
    //       name: 'Q',
    //       fields: {
    //         a: { type: GraphQLString },
    //       },
    //     }),
    //     subscription: new GraphQLObjectType({
    //       name: 'S',
    //       fields: {
    //         a: { type: GraphQLString },
    //       },
    //     }),
    //   });
    //   final document = parse(`
    //     query Q { a }
    //     subscription S { a }
    //   `);
    //   final rootValue = { a: 'b', c: 'd' };
    //   final operationName = 'S';

    //   final result = executeSync({ schema, document, rootValue, operationName });
    //   expect(result).to.deep.equal({ data: { a: 'b' } });
    // });

    test('correct field ordering despite execution order', () async {
      await simpleTest(
        {
          'a': graphQLString,
          'b': graphQLString,
          'c': graphQLString,
          'd': graphQLString,
          'e': graphQLString,
        },
        {
          'a': 'a',
          'b': Future.value('b'),
          'c': 'c',
          'd': Future.value('d'),
          'e': 'e',
        },
        '{ a, b, c, d, e }',
        {
          'data': {'a': 'a', 'b': 'b', 'c': 'c', 'd': 'd', 'e': 'e'},
        },
      );
    });

    test('Avoids recursion', () async {
      await simpleTest(
        {'a': graphQLString},
        {'a': 'b'},
        '''
        {
          a
          ...Frag
          ...Frag
        }

        fragment Frag on Type {
          a,
          ...Frag
        }
      ''',
        {
          'data': {'a': 'b'},
        },
      );
    });

    test('ignores missing sub selections on fields', () async {
      await simpleTest(
        {
          'a': objectType(
            'SomeType',
            fields: fieldsFromMap({'b': graphQLString}),
          )
        },
        {
          'a': {'b': 'c'}
        },
        '{ a }',
        {
          'data': {'a': <String, Object?>{}},
        },
      );
    });

    test('does not include illegal fields in output', () async {
      await simpleTest(
        {'a': graphQLString},
        null,
        '{ thisIsIllegalDoNotIncludeMe }',
        {
          'data': <String, Object?>{},
        },
      );
    });

    test('does not include arguments that were not set', () async {
      final schema = GraphQLSchema(
        queryType: objectType(
          'Type',
          fields: [
            graphQLString.field(
              'field',
              resolve: (_source, ctx) => jsonEncode(ctx.args),
              inputs: [
                GraphQLFieldInput('a', graphQLBoolean),
                GraphQLFieldInput('b', graphQLBoolean),
                GraphQLFieldInput('c', graphQLBoolean),
                GraphQLFieldInput('d', graphQLInt),
                GraphQLFieldInput('e', graphQLInt),
              ],
            ),
          ],
        ),
      );

      final result = await GraphQL(schema, introspect: false).parseAndExecute(
        '{ field(a: true, c: false, e: 0) }',
      );

      expect(result.toJson(), {
        'data': {
          'field': '{"a":true,"c":false,"e":0}',
        },
      });
    });

    test('fails when an isTypeOf check is not met', () async {
      final SpecialType = objectType<Special>(
        'SpecialType',
        // isTypeOf(obj, context) {
        //   final result = obj instanceof Special;
        //   return context?.async ? Promise.resolve(result) : result;
        // },
        fields: [graphQLString.field('value')],
      );

      final schema = GraphQLSchema(
        queryType: objectType(
          'Query',
          fields: fieldsFromMap({
            'specials': listOf(SpecialType),
          }),
        ),
      );

      final rootValue = {
        'specials': [Special('foo'), NotSpecial('bar')],
      };

      final result = await GraphQL(schema, introspect: false).parseAndExecute(
        '{ specials { value } }',
        initialValue: rootValue,
      );
      expect(result.toJson(), {
        'data': {
          'specials': [
            {'value': 'foo'},
            null
          ],
        },
        'errors': [
          {
            'message': stringContainsInOrder(
                ['"SpecialType"', 'Query.specials[1]', 'NotSpecial']),
            // 'Expected value of type "SpecialType" '
            //     'but got: { value: "bar" }.',
            'locations': [
              {'line': 0, 'column': 2}
            ],
            'path': ['specials', 1],
          },
        ],
      });

      // final contextValue = {async: true};
      // final asyncResult = await execute({
      //   schema,
      //   document,
      //   rootValue,
      //   contextValue,
      // });
      // expect(asyncResult).to.deep.equal(result);
    });

    // it('fails when serialize of custom scalar does not return a value', () {
    //   final customScalar = new GraphQLScalarType({
    //     name: 'CustomScalar',
    //     serialize() {
    //       /* returns nothing */
    //     },
    //   });
    //   final schema = new GraphQLSchema({
    //     query: new GraphQLObjectType({
    //       name: 'Query',
    //       fields: {
    //         customScalar: {
    //           type: customScalar,
    //           resolve: () => 'CUSTOM_VALUE',
    //         },
    //       },
    //     }),
    //   });

    //   final result = executeSync({ schema, document: parse('{ customScalar }') });
    //   expectJSON(result).to.deep.equal({
    //     data: { customScalar: null },
    //     errors: [
    //       {
    //         message:
    //           'Expected `CustomScalar.serialize("CUSTOM_VALUE")` to return non-nullable value, returned: undefined',
    //         locations: [{ line: 1, column: 3 }],
    //         path: ['customScalar'],
    //       },
    //     ],
    //   });
    // });

    test('executes ignoring invalid non-executable definitions', () async {
      await simpleTest(
        {'foo': graphQLString},
        null,
        '''
        { foo }

        type Query { bar: String }
      ''',
        {
          'data': {'foo': null}
        },
      );
    });

    test('uses a custom field resolver', () async {
      final schema = GraphQLSchema(
        queryType: objectType(
          'Query',
          fields: fieldsFromMap({
            'foo': graphQLString,
          }),
        ),
      );

      final result = await GraphQL(
        schema,
        introspect: false,
        defaultFieldResolver: (obj, fieldName, ctx) => fieldName,
      ).parseAndExecute('{ foo }');

      expect(result.toJson(), {
        'data': {'foo': 'foo'}
      });
    });

    test('uses a custom type resolver', () async {
      const document = '{ foo { bar } }';

      final fooInterface = objectType<Object>(
        'FooInterface',
        fields: fieldsFromMap(
          {
            'bar': graphQLString,
          },
        ),
        isInterface: true,
      );

      // TODO:
      final fooObject = objectType<Object>(
        'FooObject',
        interfaces: [fooInterface],
        fields: fieldsFromMap({
          'bar': graphQLString,
        }),
      );

      final schema = GraphQLSchema(
        queryType: objectType(
          'Query',
          fields: fieldsFromMap({
            'foo': fooInterface,
          }),
        ),
        // types: [fooObject],
      );

      const rootValue = {
        'foo': {'bar': 'bar'}
      };

      // TODO:
      // let possibleTypes;
      // final result = executeSync({
      //   schema,
      //   document,
      //   rootValue,
      //   typeResolver(_source, _context, info, abstractType) {
      //     // Resolver should be able to figure out all possible types on its own
      //     possibleTypes = info.schema.getPossibleTypes(abstractType);

      //     return 'FooObject';
      //   },
      // });

      final result = await GraphQL(schema, introspect: false).parseAndExecute(
        document,
        initialValue: rootValue,
      );
      expect(result.toJson(), {
        'data': {
          'foo': {'bar': 'bar'}
        }
      });
      // expect(possibleTypes).to.deep.equal([fooObject]);
    });
  });
}

class Special {
  final String value;

  Special(this.value);

  Map<String, Object?> toJson() => {'value': value};
}

class NotSpecial {
  final String value;

  NotSpecial(this.value);
}
