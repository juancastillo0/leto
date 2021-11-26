// @ClassResolver(fieldName: 'nestedResolver')
// class ResolverNested {
//   @Query()
//   String queryInClassNested(Ctx ctx, int value) {
//     return '';
//   }

//   @Mutation()
//   String mutationInClassNested(List<int?> values) {
//     return '';
//   }
// }

// import 'package:leto/leto.dart';
// import 'package:leto_generator_example/graphql_api.schema.dart';
// import 'package:leto_generator_example/resolver_class.dart';
// import 'package:test/test.dart';

// ignore_for_file: unnecessary_this

import 'dart:async';

import 'package:leto/leto.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/resolver_class.dart';
import 'package:test/test.dart';

void main() {
  test('resolver classes', () async {
    for (final str in schemaStrClassResolvers) {
      expect(graphqlApiSchema.schemaStr, contains(str));
    }

    final exec = GraphQL(graphqlApiSchema);

    const query =
        '{queryInClass, queryInClass2, queryInClass3, queryInClass4, queryInClass5, queryInClass6}';

    void _check(GraphQLResult result) {
      expect(result.toJson(), {
        'data': {
          'queryInClass': isA<String>(),
          'queryInClass2': isA<String>(),
          'queryInClass3': isA<String>(),
          'queryInClass4': isA<String>(),
          'queryInClass5': isA<String>(),
          'queryInClass6': isA<String>(),
        }
      });
    }

    final result = await exec.parseAndExecute(query);
    _check(result);
    final initialData = result.toJson()['data'] as Map<String, Object?>;

    final result2 = await exec.parseAndExecute(query);

    _check(result2);
    expect(result2.toJson(), {
      'data': {
        'queryInClass': isNot(initialData['queryInClass']),
        'queryInClass2': initialData['queryInClass2'],
        'queryInClass3': isNot(initialData['queryInClass3']),
        'queryInClass4': initialData['queryInClass4'],
        'queryInClass5': initialData['queryInClass5'],
        'queryInClass6': initialData['queryInClass6'],
      }
    });

    // TODO: return the previous value or dont allow overrides
    refResolver6.set(exec.baseGlobalVariables, Future.value(Resolver6()));

    final result3 = await exec.parseAndExecute(query);
    _check(result3);
    expect(result3.toJson(), {
      'data': {
        'queryInClass': isNot(initialData['queryInClass']),
        'queryInClass2': initialData['queryInClass2'],
        'queryInClass3': isNot(initialData['queryInClass3']),
        'queryInClass4': initialData['queryInClass4'],
        'queryInClass5': initialData['queryInClass5'],
        'queryInClass6': isNot(initialData['queryInClass6']),
      }
    });
  });
}
