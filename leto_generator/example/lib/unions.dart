import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_generator_example/decimal.dart';
import 'package:leto_schema/leto_schema.dart';

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

@GraphQLClass()
class NestedInterfaceImpl3 extends NestedInterfaceImpl {
  final String name3;

  NestedInterfaceImpl3({
    required Decimal dec,
    required String? name,
    required this.name3,
  }) : super(name, dec);
}

@Query()
Future<NestedInterfaceImpl3> getNestedInterfaceImpl3() async {
  return NestedInterfaceImpl3(
    dec: Decimal.parse('12.3'),
    name3: 'name33',
    name: null,
  );
}
