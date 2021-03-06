import 'package:leto_schema/leto_schema.dart';

final GraphQLSchema todoSchema = new GraphQLSchema(
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
  var validation = todoSchema.queryType!.validate(
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
    validation.errors.forEach((s) => print('  * $s'));
  }

  // Serialization
  print(todoSchema.queryType!.serialize({
    'text': 'Clean your room!',
    'created_at': new DateTime.now().subtract(new Duration(days: 10))
  }));
}
