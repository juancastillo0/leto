import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

void main() {
  test('no query type', () async {
    final schema = GraphQLSchema(
      mutationType: objectType(
        'Mutation',
      ),
    );
    final result = await GraphQL(schema, validate: false).parseAndExecute(
      'query q { fieldName }',
    );

    expect(
      result.errors.map((e) => e.message),
      ['The schema does not define a query type.'],
    );
  });

  test('no mutation type', () async {
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
      ),
    );
    final result = await GraphQL(schema, validate: false).parseAndExecute(
      'mutation q { fieldName }',
    );

    expect(
      result.errors.map((e) => e.message),
      ['The schema does not define a mutation type.'],
    );
  });

  test('no subscription type', () async {
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
      ),
    );
    final result = await GraphQL(schema, validate: false).parseAndExecute(
      'subscription q { fieldName }',
    );

    expect(
      result.errors.map((e) => e.message),
      ['The schema does not define a subscription type.'],
    );
  });

  test('no subscription field name', () async {
    final schema = GraphQLSchema(
      subscriptionType: objectType(
        'Subscription',
      ),
    );
    final result = await GraphQL(schema, validate: false).parseAndExecute(
      'subscription q { fieldName }',
    );

    expect(
      result.errors.map((e) => e.toJson()),
      [
        {
          'message': 'Subscription has no field named "fieldName".',
          'locations': [
            {'line': 0, 'column': 17}
          ]
        }
      ],
    );
  });

  test('no subscription field subscribe resolver', () async {
    final schema = GraphQLSchema(
      subscriptionType: objectType('Subscription',
          fields: [field('fieldName', graphQLString)]),
    );
    final result = await GraphQL(schema, validate: false).parseAndExecute(
      'subscription q { fieldName }',
    );

    expect(
      result.errors.map((e) => e.toJson()),
      [
        {
          'message':
              'Could not resolve subscription field event stream for "fieldName".',
          'path': ['fieldName'],
          'locations': [
            {'line': 0, 'column': 17}
          ]
        }
      ],
    );
  });

  test('Error in parsing SourceSpanException', () async {
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
      ),
    );
    final result = await GraphQL(schema, validate: false).parseAndExecute(
      'subsc d92n doa dakl }',
    );

    expect(result.errors.length, 1);
    final error = result.errors.first;
    expect(
      error.sourceError,
      isA<SourceSpanException>(),
    );
    expect(
      error.stackTrace,
      isA<StackTrace>(),
    );
    expect(
      error.locations.length,
      1,
    );
  });

  test('InvalidOperationType', () async {
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
      ),
      subscriptionType: objectType(
        'Subscription',
        fields: [
          field('fieldName', graphQLString),
        ],
      ),
    );

    final validOperationTypes = [OperationType.query];
    const query = 'subscription q { fieldName }';
    expect(
      () => GraphQL(schema, validate: false).parseAndExecute(
        query,
        validOperationTypes: validOperationTypes,
      ),
      throwsA(
        predicate(
          (e) =>
              e is InvalidOperationType &&
              e.ctx.query == query &&
              e.validOperationTypes == validOperationTypes &&
              e.operation.name?.value == 'q' &&
              e.operation.type == OperationType.subscription &&
              e.toString().contains(
                    'InvalidOperationType(operationName: q,'
                    ' operationType: OperationType.subscription',
                  ),
        ),
      ),
    );
  });
  test('multiple fields in subscription', () async {
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
      ),
      subscriptionType: objectType(
        'Subscription',
        fields: [
          field('fieldName', graphQLString),
          field('fieldName2', graphQLString),
        ],
      ),
    );
    const query = 'subscription q { fieldName fieldName2 }';
    final result = await GraphQL(schema, validate: false).parseAndExecute(
      query,
    );

    expect(
      result.errors.map((e) => e.message),
      ['The grouped field set for subscriptions must have exactly one entry.'],
    );
  }, skip: 'inner subscription multiple fields validation');

  test('GraphQLConfig', () async {
    final ref = ScopedRef<String?>.local((scope) => null);
    GraphQL? _executor;

    final schema = GraphQLSchema(
      queryType: objectType('Query', fields: [
        field(
          'fieldName',
          graphQLString,
          resolve: (_, ctx) {
            _executor = GraphQL.fromCtx(ctx);
            return ref.get(ctx);
          },
        )
      ]),
    );
    final config = GraphQLConfig(
      globalVariables: ScopedMap(overrides: [
        ref.override((scope) => 'result text'),
      ]),
    );
    final executor = GraphQL.fromConfig(schema, config);
    final result = await executor.parseAndExecute(
      '{ fieldName }',
    );

    expect(
      result.data,
      {
        'fieldName': 'result text',
      },
    );
    expect(executor, _executor);
  });
}
