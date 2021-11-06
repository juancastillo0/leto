import 'package:leto_schema/leto_schema.dart';

part 'generics.g.dart';

GraphQLType<ResultV<T, T2>, Map<String, Object?>> resultVGraphQLType<T, T2>(
  GraphQLType<T, Object> t1,
  GraphQLType<T2, Object> t2, {
  String? name,
}) {
  final innerT1 =
      t1 is GraphQLNonNullType ? (t1 as GraphQLNonNullType).ofType : t1;
  final innerT2 =
      t2 is GraphQLNonNullType ? (t2 as GraphQLNonNullType).ofType : t2;
  return objectType(
    name ?? 'ResultV${t1.printableName}${t2.printableName}',
    description: '$t1 when the operation was successful or'
        ' $t2 when an error was encountered.',
    fields: [
      innerT1.field(
        'ok',
        resolve: (result, ctx) => result.isOk ? (result as OkV).value : null,
      ),
      innerT2.field(
        'err',
        resolve: (result, ctx) => result.isOk ? null : (result as ErrV).value,
      ),
      graphQLBoolean.nonNull().field(
            'isOk',
            resolve: (result, ctx) => result.isOk,
          ),
    ],
  );
}

abstract class ResultV<V, E> {
  const ResultV();
  bool get isOk;
}

@GraphQLClass()
class OkV<V, E> extends ResultV<V, E> {
  const OkV(this.value);

  @override
  bool get isOk => true;

  final V value;
}

@GraphQLClass()
class ErrV<V, E> extends ResultV<V, E> {
  const ErrV(this.value);

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
ResultV<int, String?> getInt() {
  return const OkV(3);
}

@Mutation()
ResultV<int, String> getIntReq() {
  return const OkV(3);
}

@Mutation()
ResultV<int?, String?> getIntNull() {
  return const OkV(null);
}

@Mutation()
ResultV<int?, ErrCodeInterface<String>> getIntInterface() {
  return const OkV(null);
}

@Mutation()
ResultV<int, ErrCodeInterface<ErrCodeType>> getIntInterfaceEnum() {
  return const ErrV(ErrCodeInterface(ErrCodeType.code1));
}

@Mutation()
ResultV<List<int?>, ErrCodeInterface<List<ErrCodeType>>>
    getIntInterfaceEnumList() {
  return const ErrV(ErrCodeInterface([ErrCodeType.code1]));
}

@Mutation(genericTypeName: 'LastGetIntResult')
ResultV<int, ErrCodeInterfaceN<ErrCodeType?>> getIntInterfaceNEnumNull() {
  return const ErrV(ErrCodeInterfaceN(ErrCodeType.code1));
}
