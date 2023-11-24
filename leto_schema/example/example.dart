// ignore_for_file: avoid_print

import 'package:leto_schema/leto_schema.dart';

final GraphQLSchema todoSchema = GraphQLSchema(
  queryType: objectType('Todo', fields: [
    field(
      'text',
      graphQLString.nonNull(),
      resolve: resolveToNull,
    ),
    field(
      'created_at',
      graphQLDate,
      resolve: resolveToNull,
    ),
  ]),
);

/// A default resolver that always returns `null`.
Object? resolveToNull(Object? _, Object? __) => null;

void main() {
  // Validation
  final validation = todoSchema.queryType!.validate(
    '@root',
    {
      'foo': 'bar',
      'text': null,
      'created_at': 24,
    },
  );

  if (validation.successful) {
    print('This is valid data!!!');
  } else {
    print('Invalid data.');
    for (final s in validation.errors) {
      print('  * $s');
    }
  }

  // Serialization
  print(todoSchema.queryType!.serialize({
    'text': 'Clean your room!',
    'created_at': DateTime.now().subtract(const Duration(days: 10))
  }));
}
