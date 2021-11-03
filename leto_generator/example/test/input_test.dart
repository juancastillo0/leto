import 'dart:convert';

import 'package:leto/leto.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:test/test.dart';

void main() {
  test('input generator', () async {
    for (final subs in inputsSchemaStr) {
      expect(graphqlApiSchema.schemaStr, contains(subs.trim()));
    }

    const mInput = InputM(
      name: 'maop',
      ints: [],
      nested: [],
      nestedNullItem: [],
      nestedNull: [InputMN(name: 'axa')],
    );
    const gen = InputGen(name: 'daw', generic: null);
    const gen2 = InputGen(name: 'daw', generic: []);
    final serde = InputJsonSerde(
      name: 'dw',
      inputGenM: const InputGen(
        name: 'daw',
        generic: InputM(
          name: 'amos',
          ints: [2],
          nested: [],
          nestedNullItem: [null, InputMN(name: 'aca')],
        ),
      ),
    );

    final variablesQuery = jsonDecode(jsonEncode({
      'serde': null,
      'defTwo': -4,
      'mInput': mInput,
      'gen': gen,
      'serdeReq': serde,
    })) as Map<String, Object?>;

    final resultQuery = await GraphQL(graphqlApiSchema).parseAndExecute(
      r'''
      query q($serdeReq: InputJsonSerde!, 
          $defTwo: Int!, $mInput: InputM!,
          $gen:InputGenInputJsonSerde!) {
        queryMultipleParams(
         serde: null
         serdeReq: $serdeReq
         defTwo: $defTwo
         mInput: $mInput
         gen: $gen
        )
      }
    ''',
      variableValues: variablesQuery,
    );

    final jsonResultQuery = resultQuery.toJson();
    final dataQuery = jsonResultQuery['data']! as Map<String, Object?>;
    dataQuery['queryMultipleParams'] = jsonDecode(
      dataQuery['queryMultipleParams']! as String,
    );
    expect(jsonResultQuery, {
      'data': {
        'queryMultipleParams': variablesQuery,
      }
    });

    final variablesMut = jsonDecode(jsonEncode({
      'serde': null,
      'defTwo': 32,
      'gen': gen2,
    })) as Map<String, Object?>;

    final resultMut = await GraphQL(graphqlApiSchema).parseAndExecute(
      r'''
        mutation m($serde: InputJsonSerde, $gen:InputGenInputJsonSerdeReqList) {
          mutationMultipleParamsOptionalPos(
            serde: $serde2
            defTwo: 32
            gen: $gen
          )
        }
    ''',
      variableValues: variablesMut,
    );

    final jsonResultMut = resultMut.toJson();
    final dataMut = jsonResultMut['data']! as Map<String, Object?>;
    dataMut['mutationMultipleParamsOptionalPos'] = jsonDecode(
      dataMut['mutationMultipleParamsOptionalPos']! as String,
    );
    expect(jsonResultMut, {
      'data': {
        'mutationMultipleParamsOptionalPos': variablesMut,
      }
    });
  });
}
