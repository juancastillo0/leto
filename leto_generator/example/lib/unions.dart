import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:leto_generator_example/decimal.dart';
import 'package:leto_schema/leto_schema.dart';

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
int returnFiveFromFreezedInput(ReqCtx ctx, FreezedSingleInput input) {
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
];

@GraphQLClass()
@freezed
class UnionA with _$UnionA {
  const factory UnionA.a1({
    // five with default
    @Default(5) int one,
  }) = _UnionA1;

  const factory UnionA.a2({
    @Deprecated('custom deprecated msg') Decimal? dec,
  }) = _UnionA2;

  const factory UnionA.a3({
    @GraphQLDocumentation(description: 'description for one') List<int>? one,
  }) = UnionA3;

  const factory UnionA.a4({
    @GraphQLField(name: 'oneRenamed') required List<int> one,
  }) = _UnionA4;
}

final unionARef = ScopeRef<UnionA>();

@Query()
FutureOr<UnionA> getUnionA(ReqCtx ctx) {
  return unionARef.get(ctx)!;
}

final unionsSchemaString = '''
interface NestedInterface {
  dec: Decimal!
}
||
interface NamedInterface {
  name: String
}
||
type NestedInterfaceImpl implements NestedInterface {
  dec: Decimal!
  name: String
}
||
type NestedInterfaceImpl2 implements NestedInterface {
  dec: Decimal!
  name: String
  name2: String!
}
||
type NestedInterfaceImpl3 implements NamedInterface & NestedInterface {
  name3: String!
  dec: Decimal!
  name: String
}
||
"""${decimalGraphQLType.description}"""
scalar Decimal
||
getNestedInterfaceImpl3: NestedInterfaceImpl3
||
getNestedInterfaceImpl2: NestedInterfaceImpl2
||
getNestedInterfaceImplByIndex(index: Int!): NestedInterface
''';

@GraphQLClass()
abstract class NestedInterface {
  Decimal get dec;
}

@GraphQLClass()
abstract class NamedInterface {
  String? get name;
}

@GraphQLClass()
class NestedInterfaceImpl implements NestedInterface {
  @override
  final Decimal dec;

  final String? name;

  NestedInterfaceImpl(this.name, this.dec);
}

@GraphQLClass()
class NestedInterfaceImpl2 implements NestedInterfaceImpl {
  @override
  final Decimal dec;

  @override
  final String? name;
  final String name2;

  NestedInterfaceImpl2({
    required this.dec,
    required this.name,
    required this.name2,
  });
}

@GraphQLClass()
class NestedInterfaceImpl3 extends NestedInterfaceImpl
    implements NamedInterface {
  final String name3;

  NestedInterfaceImpl3({
    required Decimal dec,
    required String? name,
    required this.name3,
  }) : super(name, dec);
}

final interfaceState = RefWithDefault.global(
  (scope) => InterfaceState(
    m2: NestedInterfaceImpl2(
      dec: Decimal.parse('22.3'),
      name2: 'name22',
      name: null,
    ),
    m3: NestedInterfaceImpl3(
      dec: Decimal.parse('12.3'),
      name3: 'name33',
      name: null,
    ),
  ),
);

class InterfaceState {
  NestedInterfaceImpl3 m3;
  NestedInterfaceImpl2 m2;

  InterfaceState({
    required this.m3,
    required this.m2,
  });
}

@Query()
Future<NestedInterfaceImpl3?> getNestedInterfaceImpl3(ReqCtx ctx) async {
  return interfaceState.get(ctx).m3;
}

@Query()
NestedInterfaceImpl2 getNestedInterfaceImpl2(ReqCtx ctx) {
  return interfaceState.get(ctx).m2;
}

@Query()
NestedInterface getNestedInterfaceImplByIndex(ReqCtx ctx, int index) {
  return index == 2 ? interfaceState.get(ctx).m2 : interfaceState.get(ctx).m3;
}
