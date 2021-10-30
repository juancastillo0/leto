import 'package:graphql_schema/graphql_schema.dart';

part 'generics.g.dart';

@GraphQLClass()
abstract class Result<V, E> {
  const Result();
  bool get isOk;
}

@GraphQLClass()
class Ok<V, E> extends Result<V, E> {
  const Ok(this.value);

  @override
  bool get isOk => true;

  final V value;
}

@GraphQLClass()
class Err<V, E> extends Result<V, E> {
  const Err(this.value);

  @override
  bool get isOk => false;

  final E value;
}

@GraphQLClass()
enum ErrCodeType {
  code1,
  code2,
}

@GraphQLClass()
class ErrCodeInterface<T extends Object> {
  final String? message;
  final T code;

  const ErrCodeInterface(this.code, [this.message]);
}

@GraphQLClass()
class ErrCodeInterfaceN<T extends Object?> {
  final String? message;
  final T code;

  const ErrCodeInterfaceN(this.code, [this.message]);
}

@GraphQLClass()
class ErrCodeInterfaceNE<T> {
  final String? message;
  final T code;

  const ErrCodeInterfaceNE(this.code, [this.message]);
}

@GraphQLClass()
abstract class ErrCode {
  String get value;
  int get id;
}

@GraphQLClass()
class ErrCodeInterfaceNEE<T extends ErrCode> {
  final String? message;
  final T code;

  const ErrCodeInterfaceNEE(this.code, [this.message]);
}

@Mutation()
Result<int, String?> getInt() {
  return const Ok(3);
}

@Mutation()
Result<int, String> getIntReq() {
  return const Ok(3);
}

@Mutation()
Result<int?, String?> getIntNull() {
  return const Ok(null);
}

@Mutation()
Result<int?, ErrCodeInterface<String>> getIntInterface() {
  return const Ok(null);
}

@Mutation()
Result<int, ErrCodeInterface<ErrCodeType>> getIntInterfaceEnum() {
  return const Err(ErrCodeInterface(ErrCodeType.code1));
}

@Mutation()
Result<List<int?>, ErrCodeInterface<List<ErrCodeType>>>
    getIntInterfaceEnumList() {
  return const Err(ErrCodeInterface([ErrCodeType.code1]));
}
