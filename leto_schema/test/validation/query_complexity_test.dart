import 'package:gql/language.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/validate/rules/query_complexity_rule.dart';
import 'package:leto_schema/src/validate/validate.dart';
import 'package:test/test.dart';

void main() {
  const queryComplexityExtensions = {
    'validationError': {
      'code': 'queryComplexity',
      'spec': 'https://github.com/juancastillo0/leto#query-complexity',
    },
  };
  const queryDepthComplexityExtensions = {
    'validationError': {
      'code': 'queryDepthComplexity',
      'spec': 'https://github.com/juancastillo0/leto#query-complexity',
    },
  };

  test('Validation: query complexity with alias', () {
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          graphQLString.field(
            'fieldName1',
            attachments: [
              ElementComplexity(6),
            ],
          ),
          graphQLString.field(
            'fieldName2',
          ),
        ],
      ),
    );

    final errors = validateDocument(
      schema,
      parseString('{__typename fieldName1, a: fieldName1, fieldName2}'),
      rules: [queryComplexityRuleBuilder(maxComplexity: 5, maxDepth: 1)],
    );

    expect(
      errors.map((e) => e.toJson()),
      [
        {
          'message':
              'Maximum operation complexity of 5 reached. Operation complexity: 13.',
          'extensions': queryComplexityExtensions,
        }
      ],
    );
  });

  test('Validation: query complexity object', () {
    final obj = objectType<Object>('Obj');
    obj.fields.addAll([
      obj.list().field(
        'nestedObj',
        attachments: [
          ElementComplexity(6),
        ],
      ),
      graphQLString.field(
        'name',
        attachments: [
          ElementComplexity(1),
        ],
      ),
    ]);
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          obj.field(
            'obj',
            attachments: [
              ElementComplexity(3),
            ],
          ),
        ],
      ),
    );

    final errors = validateDocument(
      schema,
      parseString('''
      { 
        __typename
        obj { # 177 + 3 = 180
          ... ObjF # 177
        }
      }
      
      fragment ObjF on Obj {
        name # 177
        nestedObj { # 17 * 10 + 6 = 176
          name # 17
          nestedObj { # 1 * 10 + 6 = 16
            name # 1
          }
        }
      }
      '''),
      rules: [
        queryComplexityRuleBuilder(maxComplexity: 179, maxDepth: 3),
      ],
    );

    expect(
      errors.map((e) => e.toJson()),
      [
        {
          'message':
              'Maximum operation complexity of 179 reached. Operation complexity: 180.',
          'extensions': queryComplexityExtensions,
        },
        {
          'message':
              'Maximum operation depth of 3 reached. Operation depth: 4.',
          'extensions': queryDepthComplexityExtensions,
        }
      ],
    );
  });

  test('Validation: query complexity union named operation', () {
    final obj = objectType<Object>('Obj');
    obj.fields.addAll([
      obj.list().field(
        'nestedObj',
        attachments: [
          ElementComplexity(6),
        ],
      ),
      graphQLString.nonNull().field(
        'name',
        attachments: [
          ElementComplexity(1),
        ],
      ),
    ]);

    final unionT = GraphQLUnionType<Object>(
      'UnionT',
      [
        obj,
        objectType<Object>(
          'Obj2',
          fields: [
            listOf(graphQLInt.nonNull()).field('intList'),
          ],
          extra: GraphQLTypeDefinitionExtra.attach([
            ElementComplexity(2),
          ]),
        )
      ],
      extra: GraphQLTypeDefinitionExtra.attach([
        ElementComplexity(3),
      ]),
    );
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          obj.field(
            'obj',
            attachments: [
              ElementComplexity(3),
            ],
          ),
          unionT.field('unionT'),
        ],
      ),
    );

    final errors = validateDocument(
      schema,
      parseString('''
      query op1 { # 180 + 8 = 188
        obj { # 177 + 3 = 180
          ... ObjF # 177
        }
        unionT { # max(4, 1) + 3 + 1 = 8
          __typename
          ... on Obj2 { # 2 + 2 = 4
            intList # 1
            a: intList # 1
          }
          ... on Obj {
            name # 1
          }
        }
      }

      query op2 {
        obj { # 177 + 3 = 180
          ... ObjF # 177
        }
      }
      
      fragment ObjF on Obj {
        name # 177
        nestedObj { # 17 * 10 + 6 = 176
          name # 17
          nestedObj { # 1 * 10 + 6 = 16
            name # 1
          }
        }
      }
      '''),
      rules: [
        queryComplexityRuleBuilder(maxComplexity: 180, maxDepth: 3),
      ],
    );

    expect(
      errors.map((e) => e.toJson()),
      [
        {
          'message':
              'Maximum operation complexity of 180 reached. Operation "op1" complexity: 188.',
          'extensions': queryComplexityExtensions,
        },
        {
          'message':
              'Maximum operation depth of 3 reached. Operation "op1" depth: 4.',
          'extensions': queryDepthComplexityExtensions,
        },
        {
          'message':
              'Maximum operation depth of 3 reached. Operation "op2" depth: 4.',
          'extensions': queryDepthComplexityExtensions,
        }
      ],
    );
  });
}
