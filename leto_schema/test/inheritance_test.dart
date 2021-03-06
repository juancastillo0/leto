import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

void main() {
  group('interface', () {
    final a = objectType<Object>(
      'A',
      isInterface: true,
      fields: [
        field('text', graphQLString.nonNull()),
      ],
    );

    final b = objectType<Object>(
      'B',
      isInterface: true,
      interfaces: [a],
      fields: [
        field('text', graphQLString.nonNull()),
      ],
    );

    final c = objectType<Object>(
      'C',
      isInterface: true,
      interfaces: [b],
      fields: [
        field('text', graphQLString.nonNull()),
      ],
    );

    test('child implements parent', () {
      expect(b.isImplementationOf(a), true);
      expect(c.isImplementationOf(b), true);
    });

    test('parent does not implement child', () {
      expect(a.isImplementationOf(b), false);
    });

    test('child interfaces contains parent', () {
      expect(b.interfaces, contains(a));
      expect(c.interfaces, contains(b));
    });

    test('parent possibleTypes contains child', () {
      expect(a.possibleTypes, contains(b));
      expect(b.possibleTypes, contains(c));
    });

    test('grandchild implements grandparent', () {
      expect(c.isImplementationOf(a), true);
    });

    test('grandparent does not implement grandchild', () {
      expect(a.isImplementationOf(c), false);
    });

    test('grandchild interfaces contains grandparent', () {
      expect(c.interfaces, contains(a));
    });

    test('grandparent possibleTypes contains grandchild', () {
      expect(a.possibleTypes, contains(c));
    });
  });
}
