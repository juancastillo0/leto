import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:leto_generator_example/decimal.dart';
import 'package:leto_schema/leto_schema.dart';

part 'interfaces.g.dart';

final unionsSchemaString = [
// @example-start{generator-interfaces-graphql,extension:graphql,start:1,end:-2}
  ...'''
interface NestedInterface {
  dec: Decimal!
}

interface NamedInterface {
  name: String
}

type NestedInterfaceImpl implements NestedInterface {
  dec: Decimal!
  name: String
}

type NestedInterfaceImpl2 implements NestedInterface {
  dec: Decimal!
  name: String
  name2: String!
}

type NestedInterfaceImpl3 implements NamedInterface & NestedInterface {
  name3: String!
  dec: Decimal!
  name: String
}
'''
      .split('\n\n'),
// @example-end{generator-interfaces-graphql}
  ...'''
"""${decimalGraphQLType.description}"""
scalar Decimal
||
getNestedInterfaceImpl3: NestedInterfaceImpl3
||
getNestedInterfaceImpl2: NestedInterfaceImpl2
||
getNestedInterfaceImplByIndex(index: Int!): NestedInterface
'''
      .split('||'),
];

// @example-start{generator-interfaces}
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
// @example-end{generator-interfaces}

mixin StringKeyed {
  String get stringKey;
}

@GraphQLClass()
@GraphQLInput()
@JsonSerializable()
class DateKey with StringKeyed implements Comparable<DateKey> {
  final DateTime date;
  final BigInt key;

  const DateKey(this.date, this.key);

  @override
  String get stringKey => '${date.toIso8601String()}-$key';

  @GraphQLField(omit: true)
  @override
  int compareTo(DateKey other) {
    final dateComp = date.compareTo(other.date);
    return dateComp == 0 ? key.compareTo(other.key) : dateComp;
  }

  factory DateKey.fromJson(Map<String, Object?> json) =>
      _$DateKeyFromJson(json);
  Map<String, Object?> toJson() => _$DateKeyToJson(this);
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
Future<NestedInterfaceImpl3?> getNestedInterfaceImpl3(Ctx ctx) async {
  return interfaceState.get(ctx).m3;
}

@Query()
NestedInterfaceImpl2 getNestedInterfaceImpl2(Ctx ctx) {
  return interfaceState.get(ctx).m2;
}

@Query()
NestedInterface getNestedInterfaceImplByIndex(Ctx ctx, int index) {
  return index == 2 ? interfaceState.get(ctx).m2 : interfaceState.get(ctx).m3;
}

@Query()
DateKey getDateKey(DateKey key) {
  return key;
}
