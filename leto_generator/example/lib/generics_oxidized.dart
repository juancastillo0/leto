import 'package:leto_generator_example/generics.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:oxidized/oxidized.dart';

part 'generics_oxidized.g.dart';

// @Query()
// Option<String> someValue() {
//   return Some('v');
// }

// @Query()
// Option<String> noneValue() {
//   return const None();
// }

// @Query()
// Option<List<String>> someList() {
//   return Some(['dw', 'cao']);
// }

// @Query()
// Option<List<String?>> someListNull() {
//   return Some(['dw', null]);
// }

// @Query()
// Option<List<Option<String>>> someListSome() {
//   return Some([Some('dw'), const None()]);
// }

const genericsOxidizedSchemaStr = [
  '''
type SuccessGet {
  value: String!
}''',
  '''
type UnionErrCode implements ErrCode {
  id: Int!
  value: String!
}''',
  '''
type UnionErrCode implements ErrCode {
  id: Int!
  value: String!
}''',
  '''
"""
SuccessGet when the operation was successful or UnionErrCode when an error was encountered.
"""
union UnionObjectResult = SuccessGet | UnionErrCode''',
  '''
"""
SuccessGet when the operation was successful or UnionErrCode when an error was encountered.
"""
union ResultUSuccessGetUnionErrCode = SuccessGet | UnionErrCode''',
  '''
  """resultUnionObject description"""
  resultUnionObject: UnionObjectResult!''',
  '''
  """resultUnionObjectErr description"""
  resultUnionObjectErrRenamed: ResultUSuccessGetUnionErrCode! @deprecated(reason: "use resultUnionObject")''',
  '''
  resultUnionObjectMutErrRenamed: ResultUSuccessGetUnionErrCode!''',
  '''
"""
Int! when the operation was successful or String! when an error was encountered.
"""
type ObjectResult {
  ok: Int
  err: String
  isOk: Boolean!
}''',
  '''
"""
String! when the operation was successful or [UnionErrCode]! when an error was encountered.
"""
type ResultStringUnionErrCodeList {
  ok: String
  err: [UnionErrCode]
  isOk: Boolean!
}''',
  '''
"""
SuccessGet! when the operation was successful or ErrCode! when an error was encountered.
"""
type ResultSuccessGetErrCode {
  ok: SuccessGet
  err: ErrCode
  isOk: Boolean!
}''',
  '''
  """resultObject description"""
  resultObject: ObjectResult!''',
  '''
  """resultObjectErr description"""
  resultObjectErrRenamed: ResultStringUnionErrCodeList! @deprecated(reason: "use resultObject")''',
  '''
  resultObjectMutErrRenamed: ResultSuccessGetErrCode!''',
  '''
"""
ResultUSuccessGetUnionErrCode! when the operation was successful or ErrCode! when an error was encountered.
"""
type ResultResultUSuccessGetUnionErrCodeErrCode {
  ok: ResultUSuccessGetUnionErrCode
  err: ErrCode
  isOk: Boolean!
}
''',
  '''
  resultUnionInSuccess: ResultResultUSuccessGetUnionErrCodeErrCode''',
];

@GraphQLClass()
class SuccessGet {
  final String value;

  SuccessGet(this.value);
}

@GraphQLClass()
class UnionErrCode implements ErrCode {
  @override
  final int id;
  @override
  final String value;

  UnionErrCode(this.id, this.value);
}

@GraphQLDocumentation(description: 'resultUnionObject description')
@Query(genericTypeName: 'UnionObjectResult')
ResultU<SuccessGet, UnionErrCode> resultUnionObject() {
  return OkU(SuccessGet('success'));
}

@GraphQLDocumentation(
  deprecationReason: 'use resultUnionObject',
  description: 'resultUnionObjectErr description',
)
@Query(name: 'resultUnionObjectErrRenamed')
ResultU<SuccessGet, UnionErrCode> resultUnionObjectErr() {
  return ErrU(UnionErrCode(0, 'msj'));
}

@Mutation(name: 'resultUnionObjectMutErrRenamed')
ResultU<SuccessGet, UnionErrCode> resultUnionObjectMutErr() {
  return ErrU(UnionErrCode(0, 'msj'));
}

@GraphQLDocumentation(description: 'resultObject description')
@Query(genericTypeName: 'ObjectResult')
Result<int, String> resultObject() {
  return Ok(34);
}

@GraphQLDocumentation(
  deprecationReason: 'use resultObject',
  description: 'resultObjectErr description',
)
@Query(name: 'resultObjectErrRenamed')
Result<String, List<UnionErrCode?>> resultObjectErr() {
  return Err([UnionErrCode(0, 'msj'), null]);
}

@Mutation(name: 'resultObjectMutErrRenamed')
Result<SuccessGet, ErrCode> resultObjectMutErr() {
  return Err(UnionErrCode(0, 'msj'));
}

@Mutation()
Result<ResultU<SuccessGet, UnionErrCode>, ErrCode> resultUnionInSuccess() {
  return Ok(ErrU(UnionErrCode(10, 'msj 10')));
}
abstract class ResultU<T extends Object, E extends Object>
    implements
        // ignore: avoid_implementing_value_types
        Result<T, E> {
  /// Create an `Ok` result with the given value.
  factory ResultU.ok(T s) = OkU;

  /// Create an `Err` result with the given error.
  factory ResultU.err(E err) = ErrU;

  /// Call the `catching` function and produce a `ResultU`.
  ///
  /// If the function throws an error, it will be caught and contained in the
  /// returned result. Otherwise, the result of the function will be contained
  /// as the `OkU` value.
  factory ResultU.of(T Function() catching) {
    try {
      return OkU(catching());
    } on E catch (e) {
      return ErrU(e);
    }
  }
}

class OkU<T extends Object, E extends Object> extends Ok<T, E>
    implements ResultU<T, E> {
  OkU(T s) : super(s);
}

class ErrU<T extends Object, E extends Object> extends Err<T, E>
    implements ResultU<T, E> {
  ErrU(E s) : super(s);
}

final _resultUGraphQLTypes = <String, GraphQLType>{};

GraphQLUnionType<ResultU<T, T2>>
    resultUGraphQLType<T extends Object, T2 extends Object>(
  GraphQLType<T, Object> _t1,
  GraphQLType<T2, Object> _t2, {
  String? name,
}) {
  final t1 = (_t1 is GraphQLNonNullType
      ? (_t1 as GraphQLNonNullType).ofType
      : _t1) as GraphQLObjectType;
  final t2 = (_t2 is GraphQLNonNullType
      ? (_t2 as GraphQLNonNullType).ofType
      : _t2) as GraphQLObjectType;

  final _name = name ?? 'ResultU${t1.name}${t2.name}';
  if (_resultUGraphQLTypes.containsKey(_name)) {
    return _resultUGraphQLTypes[_name]! as GraphQLUnionType<ResultU<T, T2>>;
  }
  final type = GraphQLUnionType<ResultU<T, T2>>(
    _name,
    [],
    description: '${t1.name} when the operation was successful or'
        ' ${t2.name} when an error was encountered.',
    extractInner: (result) => result.when(ok: (ok) => ok, err: (err) => err),
    resolveType: (result, union, ctx) => result is Err ? t2.name : t1.name,
  );
  _resultUGraphQLTypes[type.name] = type;
  type.possibleTypes.addAll([t1, t2]);
  return type;
}

final _resultGraphQLTypes = <String, GraphQLObjectType<Result>>{};

GraphQLObjectType<Result<T, T2>>
    resultGraphQLType<T extends Object, T2 extends Object>(
  GraphQLType<T, Object> t1,
  GraphQLType<T2, Object> t2, {
  String? name,
}) {
  final t1Inner = t1.nullable();
  final t2Inner = t2.nullable();
  final _name =
      name ?? 'Result${t1Inner.printableName}${t2Inner.printableName}';
  if (_resultGraphQLTypes.containsKey(_name))
    return _resultGraphQLTypes[_name]! as GraphQLObjectType<Result<T, T2>>;

  final type = objectType<Result<T, T2>>(
    _name,
    description: '$t1 when the operation was successful or'
        ' $t2 when an error was encountered.',
  );
  _resultGraphQLTypes[_name] = type;

  type.fields.addAll([
    t1Inner.field(
      'ok',
      resolve: (result, ctx) => result.isOk() ? result.unwrap() : null,
    ),
    t2Inner.field(
      'err',
      resolve: (result, ctx) => result.isOk() ? null : result.unwrapErr(),
    ),
    graphQLBoolean.nonNull().field(
          'isOk',
          resolve: (result, ctx) => result.isOk(),
        ),
  ]);
  return type;
}
