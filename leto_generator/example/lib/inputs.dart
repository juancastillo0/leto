import 'dart:async';
import 'dart:convert' show json;

import 'package:json_annotation/json_annotation.dart';
import 'package:leto_schema/leto_schema.dart';

part 'inputs.g.dart';

const inputsSchemaStr = [
  '''
input InputM {
  name: String!
  date: Date
  ints: [Int!]!
  nested: [InputMN!]!
  nestedNullItem: [InputMN]!
  nestedNullItemNull: [InputMN]
  nestedNull: [InputMN!]
}''',
  '''
input InputMN {
  name: String!
  parent: InputM
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
  mutationMultipleParamsOptionalPos(serde: InputJsonSerde, defTwo: Int! = 2, gen: InputGenInputJsonSerdeReqList): String!''',
];

@GraphQLInput()
@JsonSerializable()
class InputM {
  final String name;
  final DateTime? date;
  final List<int> ints;

  final List<InputMN> nested;
  final List<InputMN?> nestedNullItem;
  final List<InputMN?>? nestedNullItemNull;
  final List<InputMN>? nestedNull;

  const InputM({
    required this.name,
    this.date,
    required this.ints,
    required this.nested,
    required this.nestedNullItem,
    this.nestedNullItemNull,
    this.nestedNull,
  });

  factory InputM.fromJson(Map<String, dynamic> json) => _$InputMFromJson(json);
  Map<String, Object?> toJson() => _$InputMToJson(this);
}

@GraphQLInput()
class InputMN {
  final String name;
  final InputM? parent;

  const InputMN({
    required this.name,
    this.parent,
  });

  factory InputMN.fromJson(Map<String, Object?> json) => InputMN(
        name: json['name']! as String,
        parent: json['parent'] != null
            ? InputM.fromJson(json['parent']! as Map<String, Object?>)
            : null,
      );

  Map<String, Object?> toJson() => {'name': name, 'parent': parent};
}

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
]) {
  return json.encode({
    'serde': serde,
    'defTwo': defTwo,
    'gen': gen,
  });
}
