import 'dart:convert';

import 'package:leto/leto.dart';
import 'package:leto/types/json.dart';
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
      doubles: [-2, 3.4],
      nested: [],
      nestedNullItem: [],
      nestedNull: [
        InputMN(
          name: 'axa',
          jsonListArgDef: [],
        )
      ],
    );
    const gen = InputGen(name: 'daw', generic: null);
    const gen2 = InputGen(name: 'daw', generic: <Object?>[]);
    final serde = InputJsonSerde(
      name: 'dw',
      inputGenM: InputGen(
        name: 'daw',
        generic: InputM(
          name: 'amos',
          ints: [2],
          doubles: [],
          nested: [],
          nestedNullItem: [
            null,
            InputMN(
              name: 'aca',
              jsonListArgDef: [
                Json.map({}),
              ],
              parentNullDef: [
                [
                  InputM(
                    name: 'ddaw',
                    doubles: [-2, 2.3],
                    ints: [-2],
                    nestedNullItem: [null],
                    nested: [
                      InputMN(
                        name: 'd',
                        jsonListArgDef: [
                          Json.map({'dw': Json.list([])}),
                        ],
                        parentNullDef: InputMN.parentNullDefDefault(),
                      )
                    ],
                  )
                ]
              ],
            )
          ],
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

    (variablesQuery['mInput'] as Map)['nestedNull'][0]['parentNullDef'] =
        jsonDecode(jsonEncode(InputMN.parentNullDefDefault()));

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
      'gen2': const InputGen2<String, List<List<int>?>>(
        name: 'name',
        generic: 'fawd',
        valueNull: null,
        value: [],
        listValueNull: [
          null,
          [
            null,
            [1]
          ]
        ],
        listValue: [
          [null],
          [
            [3],
            []
          ]
        ],
      )
    })) as Map<String, Object?>;

    final resultMut = await GraphQL(graphqlApiSchema).parseAndExecute(
      r'''
        mutation m($serde: InputJsonSerde, $gen:InputGenInputJsonSerdeReqList,
        $gen2: InputGen2StringReqIntReqListListReq) {
          mutationMultipleParamsOptionalPos(
            serde: $serde
            defTwo: 32
            gen: $gen
            gen2: $gen2
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

  test('input one of and combined', () async {
    for (final subs in combinedObjectInputGraphQLStr) {
      expect(graphqlApiSchema.schemaStr, contains(subs.trim()));
    }

    GraphQLResult result = await GraphQL(graphqlApiSchema).parseAndExecute(
      r'''
query m($inputCombined: CombinedObjectInput!) {
  combinedFromInput(inputCombined:$inputCombined) {
    val
    otherVal
    onlyInOutput
    onlyInOutputMethod
  }
}
    ''',
      variableValues: {'inputCombined': CombinedObject('daw').toJson()},
    );

    expect(result.toJson(), {
      'data': {
        'combinedFromInput': {
          'val': 'daw',
          'otherVal': 3,
          'onlyInOutput': 3,
          'onlyInOutputMethod': 'daw3',
        },
      },
    });

    const _oneOfQuery = r'''
query m($input: OneOfInput!) {
  combinedFromOneOf(input:$input) {
    val
    otherVal
    onlyInOutput
    onlyInOutputMethod
  }
}
    ''';

    result = await GraphQL(graphqlApiSchema).parseAndExecute(
      _oneOfQuery,
      variableValues: {
        'input': OneOfInput.combined(CombinedObject('daw3d')).toJson()
      },
    );

    expect(result.toJson(), {
      'data': {
        'combinedFromOneOf': {
          'val': 'daw3d',
          'otherVal': 5,
          'onlyInOutput': 5,
          'onlyInOutputMethod': 'daw3d5',
        },
      },
    });

    result = await GraphQL(graphqlApiSchema).parseAndExecute(
      _oneOfQuery,
      variableValues: {'input': const OneOfInput.str('dw').toJson()},
    );

    expect(result.toJson(), {
      'data': {
        'combinedFromOneOf': null,
      },
    });

    result = await GraphQL(graphqlApiSchema).parseAndExecute(
      _oneOfQuery,
      variableValues: {'input': <String, Object?>{}},
    );

    expect(result.toJson(), {
      'errors': [
        {
          'message': 'A @oneOf() input type can only have one field.',
          'locations': [
            {'line': 0, 'column': 9}
          ]
        }
      ],
    });

    result = await GraphQL(graphqlApiSchema).parseAndExecute(
      _oneOfQuery,
      variableValues: {
        'input': <String, Object?>{
          'str': 'ded',
          'oneOfFreezed': const OneOfFreezedInput('ccc').toJson(),
        },
      },
    );

    expect(result.toJson(), {
      'errors': [
        {
          'message': 'A @oneOf() input type can only have one field.',
          'locations': [
            {'line': 0, 'column': 9}
          ]
        }
      ],
    });
    result = await GraphQL(graphqlApiSchema).parseAndExecute(
      _oneOfQuery,
      variableValues: {
        'input': {'combined': null}
      },
    );

    expect(result.toJson(), {
      'errors': [
        {
          'message': 'A @oneOf() input type can only have one field.',
          'locations': [
            {'line': 0, 'column': 9}
          ]
        }
      ],
    });
  });
}
