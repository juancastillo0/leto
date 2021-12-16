import 'dart:async';
import 'dart:convert' show json;

import 'package:json_annotation/json_annotation.dart';
import 'package:leto/types/json.dart';
import 'package:leto_schema/leto_schema.dart';

part 'inputs.g.dart';

const inputsSchemaStr = [
  '''
input InputM {
  name: String!
  date: Date
  ints: [Int!]!
  doubles: [Float!]!
  nested: [InputMNRenamed!]!
  nestedNullItem: [InputMNRenamed]!
  nestedNullItemNull: [InputMNRenamed]
  nestedNull: [InputMNRenamed!]
}''',
  '''
input InputMNRenamed {
  name: String!
  parent: InputM
  json: Json!
  jsonListArgDef: [Json!]! = [{}]
  parentNullDef: [[InputM!]] = [null, [{name: "defaultName", date: null, ints: [0, 0], doubles: [0.0, 0.1], nested: [], nestedNullItem: [], nestedNullItemNull: null, nestedNull: null}]]
}''',
  '''
input InputJsonSerde {
  name: String!
  parent: InputM
  inputGenM: InputGenInputMReq
  inputGenMNull: InputGenInputM
}''',
  '''
input InputGenIntReq {
  name: String!
  generic: Int!
}''',
  '''testInputGen(input: InputGenIntReq!): Int!''',
  '''
queryMultipleParams(serde: InputJsonSerde, serdeReq: InputJsonSerde!, defTwo: Int! = 2, mInput: InputM, gen: InputGenInputJsonSerde!): String!''',
  '''
  mutationMultipleParamsOptionalPos(serde: InputJsonSerde, defTwo: Int! = 2, gen: InputGenInputJsonSerdeReqList, gen2: InputGen2StringReqIntReqListListReq): String!''',
];

@GraphQLInput()
@JsonSerializable()
class InputM {
  final String name;
  final DateTime? date;
  final List<int> ints;
  final List<double> doubles;

  final List<InputMN> nested;
  final List<InputMN?> nestedNullItem;
  final List<InputMN?>? nestedNullItemNull;
  final List<InputMN>? nestedNull;

  const InputM({
    required this.name,
    this.date,
    required this.ints,
    required this.doubles,
    required this.nested,
    required this.nestedNullItem,
    this.nestedNullItemNull,
    this.nestedNull,
  });

  factory InputM.fromJson(Map<String, Object?> json) => _$InputMFromJson(json);
  Map<String, Object?> toJson() => _$InputMToJson(this);
}

// @example-start{generator-input-object}
@GraphQLInput(name: 'InputMNRenamed')
class InputMN {
  final String name;
  final InputM? parent;
  final Json json;
  @GraphQLArg(defaultCode: 'const [JsonMap({})]')
  final List<Json> jsonListArgDef;
  @GraphQLArg(defaultFunc: parentNullDefDefault)
  final List<List<InputM>?>? parentNullDef;

  static List<List<InputM>?> parentNullDefDefault() => [
        null,
        [
          const InputM(
            name: 'defaultName',
            nested: [],
            nestedNullItem: [],
            ints: [0, 0],
            doubles: [0, 0.1],
          )
        ]
      ];

  const InputMN({
    required this.name,
    this.parent,
    this.json = const JsonList([JsonNumber(1)]),
    required this.jsonListArgDef,
    this.parentNullDef,
  });

  factory InputMN.fromJson(Map<String, Object?> json) {
    return InputMN(
      name: json['name']! as String,
      parent: json['parent'] != null
          ? InputM.fromJson(json['parent']! as Map<String, Object?>)
          : null,
      json: Json.fromJson(json['json']),
      jsonListArgDef: List.of(
        (json['jsonListArgDef'] as List).map(
          (Object? e) => Json.fromJson(e),
        ),
      ),
      parentNullDef: json['parentNullDef'] != null
          ? List.of(
              (json['parentNullDef']! as List<Object?>).map(
                (e) => e == null
                    ? null
                    : List.of(
                        (e as List<Object?>).map(
                          (e) => InputM.fromJson(e as Map<String, Object?>),
                        ),
                      ),
              ),
            )
          : null,
    );
  }

  Map<String, Object?> toJson() => {
        'name': name,
        'parent': parent,
        'json': json,
        'jsonListArgDef': jsonListArgDef,
        if (parentNullDef != null) 'parentNullDef': parentNullDef,
      };
}
// @example-end{generator-input-object}

@GraphQLInput()
@JsonSerializable()
class InputJsonSerde {
  final String name;
  final InputM? parent;
  final InputGen<InputM>? inputGenM;
  final InputGen<InputM?>? inputGenMNull;

  InputJsonSerde({
    required this.name,
    this.parent,
    this.inputGenM,
    this.inputGenMNull,
  });

  factory InputJsonSerde.fromJson(Map<String, Object?> json) =>
      _$InputJsonSerdeFromJson(json);

  Map<String, Object?> toJson() => _$InputJsonSerdeToJson(this);
}

// @example-start{generator-input-object-generic}
@GraphQLInput()
@JsonSerializable(genericArgumentFactories: true)
class InputGen<T> {
  final String name;
  final T generic;

  const InputGen({
    required this.name,
    required this.generic,
  });

  factory InputGen.fromJson(
    Map<String, Object?> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$InputGenFromJson(json, fromJsonT);

  Map<String, Object?> toJson() => {'name': name, 'generic': generic};
}
// @example-end{generator-input-object-generic}

// TODO: add schema string tests
@GraphQLInput()
@JsonSerializable(genericArgumentFactories: true)
class InputGen2<T, O extends Object> {
  final String name;
  final T generic;
  final O? valueNull;
  final List<O?> listValueNull;
  final O value;
  final List<O> listValue;

  const InputGen2({
    required this.name,
    required this.generic,
    required this.valueNull,
    required this.value,
    required this.listValue,
    required this.listValueNull,
  });

  factory InputGen2.fromJson(
    Map<String, Object?> json,
    T Function(Object?) fromJsonT,
    O Function(Object?) fromJsonO,
  ) =>
      _$InputGen2FromJson(json, fromJsonT, fromJsonO);

  Map<String, Object?> toJson() => _$InputGen2ToJson(
        this,
        (b) => b,
        (c) => c,
      );
}

@Query()
int testInputGen(InputGen<int> input) {
  return input.generic;
}

@Query()
String queryMultipleParams(
  InputJsonSerde? serde, {
  required InputJsonSerde serdeReq,
  int defTwo = 2,
  InputM? mInput,
  required InputGen<InputJsonSerde?> gen,
}) {
  return json.encode({
    'serde': serde,
    'serdeReq': serdeReq,
    'defTwo': defTwo,
    'mInput': mInput,
    'gen': gen,
  });
}

@Mutation()
FutureOr<String> mutationMultipleParamsOptionalPos([
  InputJsonSerde? serde,
  int defTwo = 2,
  InputGen<List<InputJsonSerde>?>? gen,
  InputGen2<String, List<List<int>?>>? gen2,
]) {
  return json.encode({
    'serde': serde,
    'defTwo': defTwo,
    'gen': gen,
    'gen2': gen2,
  });
}
