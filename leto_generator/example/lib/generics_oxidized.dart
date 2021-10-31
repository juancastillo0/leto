// import 'package:graphql_schema/graphql_schema.dart';
// import 'package:oxidized/oxidized.dart';

// part 'generics_oxidized.g.dart';

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
//   return Some(['dw', 'caio']);
// }

// @Query()
// Option<List<String?>> someListNull() {
//   return Some(['dw', null]);
// }

// @Query()
// Option<List<Option<String>>> someListSome() {
//   return Some([Some('dw'), const None()]);
// }

// abstract class ResultU<T extends Object, E extends Object>
//     implements Result<T, E> {}

// class OkU<T extends Object, E extends Object> extends Ok<T, E>
//     implements ResultU<T, E> {
//   OkU(T s) : super(s);
// }

// class ErrU<T extends Object, E extends Object> extends Err<T, E>
//     implements ResultU<T, E> {
//   ErrU(E s) : super(s);
// }

// GraphQLType<ResultU<T, T2>, Map<String, Object?>>
//     resultUGraphQLType<T extends Object, T2 extends Object>(
//   GraphQLType<T, Object> _t1,
//   GraphQLType<T2, Object> _t2, {
//   String? name,
// }) {
//   final t1 = (_t1 is GraphQLNonNullType
//       ? (_t1 as GraphQLNonNullType).ofType
//       : _t1) as GraphQLObjectType;
//   final t2 = (_t2 is GraphQLNonNullType
//       ? (_t2 as GraphQLNonNullType).ofType
//       : _t2) as GraphQLObjectType;
//   return GraphQLUnionType(
//     name ?? 'ResultU${t1.name}${t2.name}',
//     [t1, t2],
//     description: '${t1.name} when the operation was successful or'
//         ' ${t2.name} when an error was encountered.',
//     extractInner: (result) => result.when(ok: (ok) => ok, err: (err) => err),
//     resolveType: (result, union, ctx) => result is Err ? t2.name : t1.name,
//   );
// }
