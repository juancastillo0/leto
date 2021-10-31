import 'package:leto_schema/leto_schema.dart';

part 'generics.g.dart';

GraphQLType<Result<T, T2>, Map<String, Object?>> resultGraphQLType<T, T2>(
  GraphQLType<T, Object> t1,
  GraphQLType<T2, Object> t2, {
  String? name,
}) {
  final innerT1 =
      t1 is GraphQLNonNullType ? (t1 as GraphQLNonNullType).ofType : t1;
  final innerT2 =
      t2 is GraphQLNonNullType ? (t2 as GraphQLNonNullType).ofType : t2;
  return objectType(
    name ?? 'Result${t1.printableName}${t2.printableName}',
    description: '$t1 when the operation was successful or'
        ' $t2 when an error was encountered.',
    fields: [
      innerT1.field(
        'ok',
        resolve: (result, ctx) => result.isOk ? (result as Ok).value : null,
      ),
      innerT2.field(
        'err',
        resolve: (result, ctx) => result.isOk ? null : (result as Err).value,
      ),
      graphQLBoolean.nonNull().field(
            'isOk',
            resolve: (result, ctx) => result.isOk,
          ),
    ],
  );
}

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

const strErrCodeInterfaceNE = '''
interface ErrCode {
  value: String!
  id: Int!
}
''';

@GraphQLClass()
class ErrCodeInterfaceNE<T> {
  final String? message;
  final T code;

  const ErrCodeInterfaceNE(this.code, [this.message]);
}

const strErrCode = '''
interface ErrCode {
  value: String!
  id: Int!
}
''';

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

@Mutation(genericTypeName: 'LastGetIntResult')
Result<int, ErrCodeInterfaceN<ErrCodeType?>> getIntInterfaceNEnumNull() {
  return const Err(ErrCodeInterfaceN(ErrCodeType.code1));
}
