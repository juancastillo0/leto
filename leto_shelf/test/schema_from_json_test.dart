import 'package:shelf_graphql_example/schema/safe_json.dart';
import 'package:shelf_graphql_example/schema/schema_from_json.dart';
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
}
