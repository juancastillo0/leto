import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_generator_example/decimal.dart';
import 'package:graphql_schema/graphql_schema.dart';

part 'unions.freezed.dart';
part 'unions.g.dart';

@GraphQLInput()
@freezed
class UnionSingleInput with _$UnionSingleInput {
  const factory UnionSingleInput.cc(
    String? positional, {
    // five with default
    @Default(5) int five,
  }) = _UnionSingleInput;

  factory UnionSingleInput.fromJson(Map<String, Object?> json) =>
      _$UnionSingleInputFromJson(json);
}

@GraphQLClass()
@freezed
class UnionA with _$UnionA {
  const factory UnionA.a1({
    // five with default
    @Default(5) int one,
  }) = _UnionA1;

  const factory UnionA.a2({
    // five with default
    Decimal? dec,
  }) = _UnionA2;

  const factory UnionA.a3({
    // five with default
    List<int>? one,
  }) = UnionA3;

  const factory UnionA.a4({
    // five with default
    List<int>? one,
  }) = _UnionA4;
}

@GraphQLClass()
abstract class NestedInterface {
  Decimal get dec;
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
