import 'dart:convert';

import 'package:gql/language.dart';
import 'package:leto/leto.dart';
import 'package:leto/types/json.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_shelf_example/schema/schema_from_json.dart';
import 'package:test/test.dart';

void main() {
  void checkJson(String jsonStr, SerdeType type) {
    final json = Json.fromJson(jsonStr);
    final serdeType = serdeTypeFromJson(json);
    expect(serdeType, type);
  }

  test('serdeTypeFromJson', () {
    final json = Json.fromJson('''
    [{"n":"d"},{"n": null}]
    ''');
    final serdeType = serdeTypeFromJson(json);
    if (serdeType is! SerdeTypeList) {
      throw Exception('serdeType: $serdeType');
    }
    final generic = serdeType.generic;
    if (generic is! SerdeTypeNested) {
      throw Exception('generic: $generic');
    }
    expect(generic.props['n'], const SerdeType.option(SerdeType.str));
    checkJson(
      '''
    [{"n":"d"},{"n": null}]
    ''',
      const SerdeType.list(SerdeType.nested(
        {'n': SerdeType.option(SerdeType.str)},
      )),
    );
  });

  test('serdeTypeFromJson full', () {
    checkJson(
      '''[{"s":"d", "a": [1]},{"s": null, "a": ["s"]}]''',
      const SerdeType.list(SerdeType.nested(
        {
          's': SerdeType.option(SerdeType.str),
          'a': SerdeType.list(
            SerdeType.unionType({SerdeType.int, SerdeType.str}),
          ),
        },
      )),
    );
  });

  test('serdeTypeFromJson full 2', () {
    checkJson(
      '''[{"s":"d", "a": [1], "n": {"nd":2.3}},{"s": null, "a": ["s"]}]''',
      const SerdeType.list(SerdeType.nested(
        {
          's': SerdeType.option(SerdeType.str),
          'a': SerdeType.list(
            SerdeType.unionType({SerdeType.int, SerdeType.str}),
          ),
          'n': SerdeType.option(SerdeType.nested({
            'nd': SerdeType.num,
          })),
        },
      )),
    );
  });

  test('serdeTypeFromJson server', () async {
    const jsonString =
        '''[{"s":"d", "a": [1], "n": {"nd":2.3}},{"s": null, "a": ["s"]}]''';
    final field = graphqlFieldFromJson(
      fieldName: 'items',
      jsonString: jsonString,
      typeName: 'RootType',
    );
    final schema = GraphQLSchema(
      queryType: objectType('Query', fields: [field]),
    );
    final gqlServer = GraphQL(schema, introspect: false);
    final schemaStr = printNode(schema.schemaNode);

    expect(schemaStr, '''
type Query {
  items: [RootTypeItem!]!
}

type RootTypeItem {
  s: String
  a: [Json!]!
  n: RootTypeItemn
}

"""
Represents a JSON value.
"""
scalar Json

type RootTypeItemn {
  nd: Float!
}''');

    final result = await gqlServer.parseAndExecute('{items{s, a, n {nd}}}');
    final items = jsonDecode(jsonString) as List;
    items[1] = {
      ...items[1] as Map<String, Object?>,
      'n': null,
    };
    expect(result.toJson(), {
      'data': <String, Object?>{
        'items': items,
      }
    });
  });
}
