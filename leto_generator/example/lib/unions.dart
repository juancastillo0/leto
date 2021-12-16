import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:leto_generator_example/decimal.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/validate_rules.dart';

part 'unions.freezed.dart';
part 'unions.g.dart';

@GraphQLInput()
@freezed
class FreezedSingleInput with _$FreezedSingleInput {
  const factory FreezedSingleInput.cc(
    String? positional, {
    // five with default
    @Default(5) int five,
  }) = _FreezedSingleInput;

  factory FreezedSingleInput.fromJson(Map<String, Object?> json) =>
      _$FreezedSingleInputFromJson(json);
}

@Query()
int returnFiveFromFreezedInput(Ctx ctx, FreezedSingleInput input) {
  return input.five;
}

final unionsASchemaString = [
  '''
input FreezedSingleInput {
  positional: String

  """five with default"""
  five: Int! = 5
}''',
  '''
returnFiveFromFreezedInput(input: FreezedSingleInput!): Int!
''',
  '''
union UnionA = UnionA1 | UnionA2 | UnionA3 | UnionA4
''',
  '''
type UnionA1 {
  """five with default"""
  one: Int!
}''',
  '''
type UnionA2 {
  dec: Decimal @deprecated(reason: "custom deprecated msg")
}''',
  '''
type UnionA3 {
  """description for one"""
  one: [Int!]
}''',
  '''
type UnionA4 {
  oneRenamed: [Int!]!
}''',
  '''
"""gets Union A"""
  getUnionA: UnionA''',
];

// @example-start{generator-unions-freezed}
@GraphQLClass()
@freezed
class UnionA with _$UnionA {
  const factory UnionA.a1({
    // five with default
    @Default(5) int one,
  }) = _UnionA1;

  const factory UnionA.a2({
    @JsonKey(fromJson: decimalFromJson, toJson: decimalToJson)
    @Deprecated('custom deprecated msg')
        Decimal? dec,
  }) = _UnionA2;

  const factory UnionA.a3({
    @GraphQLDocumentation(description: 'description for one') List<int>? one,
  }) = UnionA3;

  const factory UnionA.a4({
    @GraphQLField(name: 'oneRenamed') required List<int> one,
  }) = _UnionA4;

  factory UnionA.fromJson(Map<String, Object?> json) => _$UnionAFromJson(json);
}
// @example-end{generator-unions-freezed}

final unionARef = ScopeRef<UnionA>();

@Query()
@GraphQLDocumentation(description: 'gets Union A')
FutureOr<UnionA?> getUnionA(Ctx ctx) {
  return unionARef.get(ctx);
}

const unionNoFreezedSchemaStr = [
  '''
"""
Description from annotation.

Union generated from raw Dart classes
"""
union UnionNoFreezedRenamed @cost(complexity: 50) = UnionNoFreezedA | UnionNoFreezedB''',
  '''
type UnionNoFreezedA {
  value: String!
}''',
  '''
type UnionNoFreezedB {
  value: Int!
}'''
];

// @example-start{unions-example-generator}
GraphQLAttachments unionNoFreezedAttachments() => const [ElementComplexity(50)];

@AttachFn(unionNoFreezedAttachments)
@GraphQLDocumentation(
  description: '''
Description from annotation.

Union generated from raw Dart classes
''',
)
@GraphQLUnion(name: 'UnionNoFreezedRenamed')
class UnionNoFreezed {
  const factory UnionNoFreezed.a(String value) = UnionNoFreezedA.named;
  const factory UnionNoFreezed.b(int value) = UnionNoFreezedB;
}

@GraphQLClass()
class UnionNoFreezedA implements UnionNoFreezed {
  final String value;

  const UnionNoFreezedA.named(this.value);
}

@GraphQLClass()
class UnionNoFreezedB implements UnionNoFreezed {
  final int value;

  const UnionNoFreezedB(this.value);
}

@Query()
List<UnionNoFreezed> getUnionNoFrezzed() {
  return const [UnionNoFreezed.a('value'), UnionNoFreezed.b(12)];
}
// @example-end{unions-example-generator}
