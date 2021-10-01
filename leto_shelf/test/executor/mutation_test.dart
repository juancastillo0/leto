// https://github.com/graphql/graphql-js/blob/8261922bafb8c2b5c5041093ce271bdfcdf133c3/src/execution/__tests__/mutations-test.ts
// import { expect } from 'chai';
// import { describe, it } from 'mocha';

// import { expectJSON } from '../../__testUtils__/expectJSON';

// import { resolveOnNextTick } from '../../__testUtils__/resolveOnNextTick';

// import { parse } from '../../language/parser';

// import { GraphQLInt } from '../../type/scalars';
// import { GraphQLSchema } from '../../type/schema';
// import { GraphQLObjectType } from '../../type/definition';

// import { execute, executeSync } from '../execute';

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:test/test.dart';

class NumberHolder {
  int theNumber;

  NumberHolder(this.theNumber);
}

class Root {
  final NumberHolder numberHolder;

  Root(int originalNumber) : numberHolder = NumberHolder(originalNumber);

  NumberHolder immediatelyChangeTheNumber(int newNumber) {
    numberHolder.theNumber = newNumber;
    return numberHolder;
  }

  Future<NumberHolder> promiseToChangeTheNumber(int newNumber) async {
    return Future.microtask(() => immediatelyChangeTheNumber(newNumber));
  }

  NumberHolder failToChangeTheNumber() {
    throw GraphQLException.fromMessage('Cannot change the number');
  }

  Future<NumberHolder> promiseAndFailToChangeTheNumber() async {
    await Future.microtask(
      () => throw GraphQLException.fromMessage('Cannot change the number'),
    );
  }
}

final numberHolderType = objectType<NumberHolder>(
  'NumberHolder',
  fields: [
    graphQLInt.field('theNumber', resolve: (obj, ctx) => obj.theNumber),
  ],
);

final schema = GraphQLSchema(
  queryType: objectType(
    'Query',
    fields: [numberHolderType.field('numberHolder')],
  ),
  mutationType: objectType<Root>('Mutation', fields: [
    numberHolderType.field(
      'immediatelyChangeTheNumber',
      inputs: [GraphQLFieldInput('newNumber', graphQLInt.nonNull())],
      resolve: (obj, ctx) {
        return obj.immediatelyChangeTheNumber(ctx.args['newNumber']! as int);
      },
    ),
    numberHolderType.field(
      'promiseToChangeTheNumber',
      inputs: [GraphQLFieldInput('newNumber', graphQLInt.nonNull())],
      resolve: (obj, ctx) {
        return obj.promiseToChangeTheNumber(ctx.args['newNumber']! as int);
      },
    ),
    numberHolderType.field(
      'failToChangeTheNumber',
      inputs: [GraphQLFieldInput('newNumber', graphQLInt.nonNull())],
      resolve: (obj, ctx) {
        return obj.failToChangeTheNumber();
      },
    ),
    numberHolderType.field(
      'promiseAndFailToChangeTheNumber',
      inputs: [GraphQLFieldInput('newNumber', graphQLInt.nonNull())],
      resolve: (obj, ctx) {
        return obj.promiseAndFailToChangeTheNumber();
      },
    ),
  ]),
);

/// 'Execute: Handles mutation execution ordering'
void main() {
  test('evaluates mutations serially', () async {
    const document = '''
      mutation M {
        first: immediatelyChangeTheNumber(newNumber: 1) {
          theNumber
        },
        second: promiseToChangeTheNumber(newNumber: 2) {
          theNumber
        },
        third: immediatelyChangeTheNumber(newNumber: 3) {
          theNumber
        }
        fourth: promiseToChangeTheNumber(newNumber: 4) {
          theNumber
        },
        fifth: immediatelyChangeTheNumber(newNumber: 5) {
          theNumber
        }
      }
    ''';

    final rootValue = Root(6);
    final mutationResult = await GraphQL(schema, introspect: false)
        .parseAndExecute(document, initialValue: rootValue);

    expect(mutationResult.toJson(), {
      'data': {
        'first': {'theNumber': 1},
        'second': {'theNumber': 2},
        'third': {'theNumber': 3},
        'fourth': {'theNumber': 4},
        'fifth': {'theNumber': 5},
      },
    });
  });

  test('does not include illegal mutation fields in output', () async {
    const document = 'mutation { thisIsIllegalDoNotIncludeMe }';

    final result = await GraphQL(
      schema,
      introspect: false,
      validate: false,
    ).parseAndExecute(document);
    expect(result.toJson(), {
      'data': <String, Object?>{},
    });
  });

  test('evaluates mutations correctly in the presence of a failed mutation',
      () async {
    const document = '''
      mutation M {
        first: immediatelyChangeTheNumber(newNumber: 1) {
          theNumber
        },
        second: promiseToChangeTheNumber(newNumber: 2) {
          theNumber
        },
        third: failToChangeTheNumber(newNumber: 3) {
          theNumber
        }
        fourth: promiseToChangeTheNumber(newNumber: 4) {
          theNumber
        },
        fifth: immediatelyChangeTheNumber(newNumber: 5) {
          theNumber
        }
        sixth: promiseAndFailToChangeTheNumber(newNumber: 6) {
          theNumber
        }
      }
    ''';

    final rootValue = Root(6);
    final result = await GraphQL(schema, introspect: false)
        .parseAndExecute(document, initialValue: rootValue);

    expect(result.toJson(), {
      'data': {
        'first': {'theNumber': 1},
        'second': {'theNumber': 2},
        'third': null,
        'fourth': {'theNumber': 4},
        'fifth': {'theNumber': 5},
        'sixth': null,
      },
      'errors': [
        {
          'message': 'Cannot change the number',
          'locations': [
            {'line': 7, 'column': 8}
          ],
          'path': ['third'],
        },
        {
          'message': 'Cannot change the number',
          'locations': [
            {'line': 16, 'column': 8}
          ],
          'path': ['sixth'],
        },
      ],
    });
  });
}
