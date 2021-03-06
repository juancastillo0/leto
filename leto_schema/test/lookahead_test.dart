import 'package:leto/leto.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

void main() {
  test('peek over nested models', () async {
    final nestedModelType = objectType<Map<String, Object?>>(
      'NestedModel',
      fields: [
        graphQLString.field('nestedName'),
      ],
    );
    nestedModelType.fields.add(
      nestedModelType.field('deep'),
    );

    final modelType = objectType<Map<String, Object?>>('Model', fields: [
      graphQLString.field('name'),
      nestedModelType.field('nested'),
      nestedModelType.nonNull().field('nestedNonNull'),
      listOf(nestedModelType).field('nestedList'),
      listOf(nestedModelType).nonNull().field('nestedListNonNull'),
      listOf(nestedModelType.nonNull())
          .nonNull()
          .field('nestedNonNullListNonNull'),
    ]);

    late Ctx resolveCtx;
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          modelType.field('model', resolve: (_, ctx) {
            resolveCtx = ctx;
            return null;
          }),
        ],
      ),
    );

    await GraphQL(schema).parseAndExecute('''
query {
  model {
    name
    nested {
      nestedName
      deepAlias: deep {
        nestedName
      }
    }
    nestedNonNull {
      ... {
        nestedName
      }
    }
    nestedList {
      ... OnlyName
    }
    nestedList2: nestedList {
      nestedName
      ... All
    }
    nestedListNonNull {
      ... All
    }
    nestedNonNullListNonNull {
      nestedName
    }
  }
}

fragment OnlyName on NestedModel {
  nestedName
}

fragment All on NestedModel {
  nameAlias: nestedName
  deep {
    nestedName
  }
}
''');

    final peek = resolveCtx.lookahead()!.forObject;
    final peekMap = peek.map;
    expect(peekMap.keys, [
      'name',
      'nested',
      'nestedNonNull',
      'nestedList',
      'nestedListNonNull',
      'nestedNonNullListNonNull',
    ]);

    final namePeek = peekMap['name']!.lookAhead();
    expect(namePeek, null);

    final nestedPeek = peekMap['nested']!.lookAhead()!;
    expect(nestedPeek.forObject.map.keys, ['nestedName', 'deep']);
    expect(nestedPeek.fieldNodes.length, 1);

    final nestedDeep = nestedPeek.forObject.nested('deep')!;
    expect(nestedDeep.forObject.map.keys, ['nestedName']);
    expect(nestedDeep.fieldNodes.length, 1);

    final nestedDeepPeek = nestedDeep.forObject.map['nestedName']!.lookAhead();
    expect(nestedDeepPeek, null);

    final nestedNonNullPeek = peekMap['nestedNonNull']!.lookAhead()!;
    expect(nestedNonNullPeek.forObject.map.keys, ['nestedName']);
    expect(nestedNonNullPeek.fieldNodes.length, 1);

    final nestedListPeek = peekMap['nestedList']!.lookAhead()!;
    expect(nestedListPeek.forObject.map.keys, ['nestedName', 'deep']);
    expect(nestedListPeek.fieldNodes.length, 2);

    final nestedListNonNullPeek = peekMap['nestedListNonNull']!.lookAhead()!;
    expect(nestedListNonNullPeek.forObject.map.keys, ['nestedName', 'deep']);
    expect(nestedListNonNullPeek.fieldNodes.length, 1);

    final nestedListNonNullDeepPeek =
        nestedListNonNullPeek.forObject.map['deep']!.lookAhead()!;
    expect(nestedListNonNullDeepPeek.forObject.map.keys, ['nestedName']);
    expect(nestedListNonNullDeepPeek.fieldNodes.length, 1);

    final nestedNonNullListNonNullPeek =
        peekMap['nestedNonNullListNonNull']!.lookAhead()!;
    expect(nestedNonNullListNonNullPeek.forObject.map.keys, ['nestedName']);
    expect(nestedNonNullListNonNullPeek.fieldNodes.length, 1);
  });

  test('peek over union models', () async {
    final model1Type = objectType<Map<String, Object?>>(
      'Model1',
      fields: [
        graphQLString.field('name1'),
      ],
    );
    model1Type.fields.add(
      model1Type.field('deep'),
    );

    final model2Type = objectType<Map<String, Object?>>(
      'Model2',
      fields: [
        graphQLString.field('name2'),
      ],
    );

    final modelUnionType = GraphQLUnionType<Map<String, Object?>>(
      'ModelUnion',
      [
        model1Type,
        model2Type,
      ],
    );

    final modelType = objectType<Map<String, Object?>>('Model', fields: [
      graphQLString.field('name'),
      modelUnionType.field('nested'),
      modelUnionType.nonNull().field('nestedNonNull'),
      listOf(modelUnionType).field('nestedList'),
      listOf(modelUnionType).nonNull().field('nestedListNonNull'),
      listOf(modelUnionType.nonNull())
          .nonNull()
          .field('nestedNonNullListNonNull'),
    ]);

    late Ctx resolveCtx;
    final schema = GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          modelType.field('model', resolve: (_, ctx) {
            resolveCtx = ctx;
            return null;
          }),
        ],
      ),
    );

    await GraphQL(schema).parseAndExecute('''
    query {
      model {
        name
        nested {
          ... on Model1 {
            name1
            deep {
              name1
            }
          }
          ... on Model2 {
            name2
          }
        }
      }
    }
    ''');

    // nestedNonNull {
    //   nestedName
    // }
    // nestedList {
    //   nestedName
    // }
    // nestedListNonNull {
    //   nestedName
    // }
    // nestedNonNullListNonNull {
    //   nestedName
    // }
    final peek = resolveCtx.lookahead()!.forObject;
    final peekMap = peek.map;
    expect(peekMap.keys, [
      'name',
      'nested',
      // 'nestedNonNull',
      // 'nestedList',
      // 'nestedListNonNull',
      // 'nestedNonNullListNonNull',
    ]);

    final peekNested = peekMap['nested']!.lookAhead()!;

    expect(peekNested.isUnion, true);
    expect(peekNested.unionMap.keys, ['Model1', 'Model2']);

    final peekModel1 = peekNested.unionMap['Model1']!;
    expect(peekModel1.map.keys, ['name1', 'deep']);

    final peekModel1Deep = peekModel1.nested('deep')!;
    expect(peekModel1Deep.forObject.map.keys, ['name1']);

    final peekModel2 = peekNested.unionMap['Model2']!;
    expect(peekModel2.map.keys, ['name2']);
  });
}
