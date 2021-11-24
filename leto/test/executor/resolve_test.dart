// https://github.com/graphql/graphql-js/blob/8261922bafb8c2b5c5041093ce271bdfcdf133c3/src/execution/__tests__/resolve-test.ts

import 'dart:convert';

import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

class Adder {
  final int _num;

  const Adder(this._num);

  int test(Map<String, Object?> args, ScopedMap context) {
    return _num + (args['addend1'] as int) + (context['addend2'] as int);
  }
}

/// Execute: resolve function
void main() {
  GraphQLSchema testSchema(
    GraphQLObjectField<Object, Object, Object> testField,
  ) {
    return GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          copyFieldWithName('test', testField),
        ],
      ),
    );
  }

  Future<Map<String, Object?>> execute(
    GraphQLSchema schema,
    String query, {
    Map<String, Object?>? variableValues,
    ScopedMap? globalVariables,
    Object? rootValue,
  }) async {
    final values = await GraphQL(
      schema,
      globalVariables: globalVariables,
    ).parseAndExecute(
      query,
      variableValues: variableValues,
      rootValue: rootValue,
    );
    return values.toJson();
  }

  test('default function accesses properties', () async {
    final result = await execute(
      testSchema(graphQLString.field('')),
      '{ test }',
      rootValue: {'test': 'testValue'},
    );

    expect(result, {
      'data': {
        'test': 'testValue',
      },
    });
  });

  test('default function calls methods', () async {
    final rootValue = {
      '_secret': 'secretValue',
      'test': () {
        return 'secretValue'; //_secret;
      },
    };

    final result = await execute(
      testSchema(graphQLString.field('')),
      '{ test }',
      rootValue: rootValue,
    );
    expect(result, {
      'data': {
        'test': 'secretValue',
      },
    });
  });

  test('default function passes args and context', () async {
    const rootValue = Adder(700);

    final schema = testSchema(
      graphQLInt.field<Adder>(
        '',
        inputs: [GraphQLFieldInput('addend1', graphQLInt)],
        resolve: (obj, ctx) => obj.test(ctx.args, ctx.globals),
      ),
    );
    final contextValue = ScopedMap({'addend2': 9});
    const document = '{ test(addend1: 80) }';

    final result = await execute(
      schema,
      document,
      rootValue: rootValue,
      globalVariables: contextValue,
    );
    expect(result, {
      'data': {'test': 789},
    });
  });

  test('uses provided resolve function', () async {
    final schema = testSchema(graphQLString.field(
      '',
      inputs: [
        GraphQLFieldInput('aStr', graphQLString),
        GraphQLFieldInput('aInt', graphQLInt),
      ],
      resolve: (parent, ctx) => jsonEncode([
        if (parent is ScopedMap) null else parent,
        ctx.args,
      ]),
    ));

    expect(await execute(schema, '{ test }'), {
      'data': {
        'test': '[null,{}]',
      },
    });

    expect(await execute(schema, '{ test }', rootValue: 'Source!'), {
      'data': {
        'test': '["Source!",{}]',
      },
    });

    expect(
        await execute(schema, '{ test(aStr: "String!") }',
            rootValue: 'Source!'),
        {
          'data': {
            'test': '["Source!",{"aStr":"String!"}]',
          },
        });

    expect(
      await execute(
        schema,
        '{ test(aInt: -123, aStr: "String!") }',
        rootValue: 'Source!',
      ),
      {
        'data': {
          'test': '["Source!",{"aStr":"String!","aInt":-123}]',
        },
      },
    );
  });
}
