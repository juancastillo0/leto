import 'package:leto_schema/leto_schema.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inputs.g.dart';

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

  Map<String, Object?> toJson() => {'name': name, 'parent': generic};
}

@Query()
int testInputGen(InputGen<int> v) {
  return v.generic;
}
