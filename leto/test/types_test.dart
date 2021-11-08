import 'dart:convert';

import 'package:leto/types/json.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

void main() {
  test('json type', () {
    final raw = {
      'value': [
        2,
        null,
        true,
        'daw',
        const JsonMap({'inner': JsonStr('-1')})
      ],
    };
    final value = Json.graphQLType.deserialize(SerdeCtx(), raw);

    expect(
      value.toJsonShallow(),
      {
        'value': const JsonList(
          [
            JsonNumber(2),
            Json.null_,
            Json.boolean(true),
            JsonStr('daw'),
            JsonMap({'inner': JsonStr('-1')})
          ],
        ),
      },
    );

    expect(json.encode(value), json.encode(raw));
  });

  test('json type parsing error', () {
    final raw = {
      'keyProp': [
        2,
        null,
        {
          'innerProp': {'set value'}
        }
      ],
    };

    try {
      Json.fromJson(raw);
      throw Error();
    } on Exception catch (e) {
      // ignore: avoid_dynamic_calls
      final message = (e as dynamic).message as String;
      expect(
        message,
        'value[keyProp][2][innerProp] = {set value} is not a valid JSON',
      );
    }
  });
}
