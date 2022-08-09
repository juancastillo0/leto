import 'package:leto_schema/leto_schema.dart';

part 'generics.g.dart';

final _resultVGraphQLTypes = <String, GraphQLObjectType<ResultV>>{};

GraphQLObjectType<ResultV<T, T2>> resultVGraphQLType<T, T2>(
  GraphQLType<T, Object> t1,
  GraphQLType<T2, Object> t2, {
  String? name,
}) {
  final _name = name ?? 'ResultV${t1.printableName}${t2.printableName}';
  if (_resultVGraphQLTypes.containsKey(_name))
    return _resultVGraphQLTypes[_name]! as GraphQLObjectType<ResultV<T, T2>>;

  final innerT1 = t1.nullable();
  final innerT2 = t2.nullable();
  final type = objectType<ResultV<T, T2>>(
    _name,
    description: '$t1 when the operation was successful or'
        ' $t2 when an error was encountered.',
  );
  _resultVGraphQLTypes[_name] = type;

  type.fields.addAll([
    innerT1.field(
      'ok',
      resolve: (result, ctx) =>
          result.isOk ? (result as OkV<T, T2>).value : null,
    ),
    innerT2.field(
      'err',
      resolve: (result, ctx) =>
          result.isOk ? null : (result as ErrV<T, T2>).value,
    ),
    graphQLBoolean.nonNull().field(
          'isOk',
          resolve: (result, ctx) => result.isOk,
        ),
  ]);
  return type;
}

abstract class ResultV<V, E> {
  const ResultV();
  bool get isOk;
}

@GraphQLObject()
class OkV<V, E> extends ResultV<V, E> {
  const OkV(this.value);

  @override
  bool get isOk => true;

  final V value;
}

@GraphQLObject()
class ErrV<V, E> extends ResultV<V, E> {
  const ErrV(this.value);

  @override
  bool get isOk => false;

  final E value;
}

@GraphQLEnum()
enum ErrCodeType {
  code1,
  code2,
}

// @example-start{generic-generator}
@GraphQLObject()
class ErrCodeInterface<T extends Object> {
  final String? message;
  final T code;

  const ErrCodeInterface(this.code, [this.message]);
}
// @example-end{generic-generator}

@GraphQLObject()
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

@GraphQLObject()
class ErrCodeInterfaceNE<T> {
  final String? message;
  final T code;

  const ErrCodeInterfaceNE(this.code, [this.message]);
}

// TODO: 1T test this
const strErrCode = '''
interface ErrCode {
  value: String!
  id: Int!
}
''';

@GraphQLObject()
abstract class ErrCode {
  String get value;
  int get id;
}

@GraphQLObject()
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
