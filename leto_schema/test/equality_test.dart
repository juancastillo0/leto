import 'package:test/test.dart';

/// Note: this doesn't test for scalar types, which are final,
/// and therefore use built-in equality.
void main() {
  test('description', () {});
  // group('equality', () {
  //   test('enums', () {
  //     expect(enumTypeFromStrings('A', ['B', 'C']),
  //         enumTypeFromStrings('A', ['B', 'C']));
  //     expect(enumTypeFromStrings('A', ['B', 'C']),
  //         isNot(enumTypeFromStrings('B', ['B', 'C'])));
  //   });

  //   test('objects', () {
  //     expect(
  //       objectType<Object>('B', fields: [
  //         field('b', graphQLString.nonNull()),
  //       ]),
  //       objectType<Object>('B', fields: [
  //         field('b', graphQLString.nonNull()),
  //       ]),
  //     );

  //     expect(
  //       objectType<Object>('B', fields: [
  //         field('b', graphQLString.nonNull()),
  //       ]),
  //       isNot(objectType<Object>('BD', fields: [
  //         field('b', graphQLString.nonNull()),
  //       ])),
  //     );

  //     expect(
  //       objectType<Object>('B', fields: [
  //         field('b', graphQLString.nonNull()),
  //       ]),
  //       isNot(objectType<Object>('B', fields: [
  //         field('ba', graphQLString.nonNull()),
  //       ])),
  //     );

  //     expect(
  //       objectType<Object>('B', fields: [
  //         field('b', graphQLString.nonNull()),
  //       ]),
  //       isNot(objectType<Object>('B', fields: [
  //         field('a', graphQLFloat.nonNull()),
  //       ])),
  //     );
  //   });

  //   test('input type', () {});

  //   test('union type', () {
  //     expect(
  //       GraphQLUnionType<Object>('A', [
  //         objectType('B', fields: [
  //           field('b', graphQLString.nonNull()),
  //         ]),
  //         objectType('C', fields: [
  //           field('c', graphQLString.nonNull()),
  //         ]),
  //       ]),
  //       GraphQLUnionType<Object>('A', [
  //         objectType('B', fields: [
  //           field('b', graphQLString.nonNull()),
  //         ]),
  //         objectType('C', fields: [
  //           field('c', graphQLString.nonNull()),
  //         ]),
  //       ]),
  //     );

  //     expect(
  //       GraphQLUnionType<Object>('A', [
  //         objectType('B', fields: [
  //           field('b', graphQLString.nonNull()),
  //         ]),
  //         objectType('C', fields: [
  //           field('c', graphQLString.nonNull()),
  //         ]),
  //       ]),
  //       isNot(GraphQLUnionType<Object>('AA', [
  //         objectType('B', fields: [
  //           field('b', graphQLString.nonNull()),
  //         ]),
  //         objectType('C', fields: [
  //           field('c', graphQLString.nonNull()),
  //         ]),
  //       ])),
  //     );

  //     expect(
  //       GraphQLUnionType<Object>('A', [
  //         objectType('BB', fields: [
  //           field('b', graphQLString.nonNull()),
  //         ]),
  //         objectType('C', fields: [
  //           field('c', graphQLString.nonNull()),
  //         ]),
  //       ]),
  //       isNot(GraphQLUnionType<Object>('AA', [
  //         objectType('BDD', fields: [
  //           field('b', graphQLString.nonNull()),
  //         ]),
  //         objectType('C', fields: [
  //           field('c', graphQLString.nonNull()),
  //         ]),
  //       ])),
  //     );
  //   });
  // });
}
