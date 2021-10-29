import 'package:decimal/decimal.dart';
import 'package:graphql_generator_example/decimal.dart';
import 'package:graphql_generator_example/graphql_api.schema.dart';
import 'package:graphql_generator_example/inputs.dart';
import 'package:graphql_schema/graphql_schema.dart';

part 'main.g.dart';

@GraphQLInput()
class TodoItemInput {
  const TodoItemInput({
    required this.text,
    this.nested,
  });

  final String text;
  final TodoItemInputNested? nested;

  factory TodoItemInput.fromJson(Map<String, Object?> json) => TodoItemInput(
        text: json['text']! as String,
        nested: json['nested'] == null
            ? null
            : TodoItemInputNested.fromJson(
                json['nested']! as Map<String, Object?>,
              ),
      );
}

@GraphQLInput()
class TodoItemInputS {
  const TodoItemInputS({
    required this.text,
    this.nested,
  });

  final String text;
  final TodoItemInputNested? nested;

  // ignore: prefer_constructors_over_static_methods
  static TodoItemInputS fromJson(Map<String, Object?> json) => TodoItemInputS(
        text: json['text']! as String,
        nested: json['nested'] == null
            ? null
            : TodoItemInputNested.fromJson(
                json['nested']! as Map<String, Object?>,
              ),
      );
}

@GraphQLInput()
class TodoItemInputNested {
  const TodoItemInputNested({required this.cost});

  final Decimal? cost;

  // ignore: prefer_constructors_over_static_methods
  static TodoItemInputNested fromJson(Map<String, Object?> json) =>
      TodoItemInputNested(
        cost: Decimal.tryParse(json['cost'] as String? ?? ''),
      );
}

@GraphQLClass()
class TodoItem {
  /// A description of the todo item
  String? text;

  @GraphQLDocumentation(description: 'Whether this item is complete.')
  bool? isComplete;

  @Deprecated("Don't use this")
  DateTime createdAt;

  Decimal? cost;

  TodoItem({
    this.text,
    this.isComplete,
    required this.createdAt,
  });
}

@Query()
String getName() {
  return '';
}

void main() {
  print(todoItemGraphQLType.fields.map((f) => f.name));
  const schemaSrt = '''
type Query {
  getName: String!
}

"""An ISO-8601 Date."""
type Date

"""A number that allows computation without losing precision."""
type Decimal

type TodoItem {
  """A description of the todo item"""
  text: String
  """Whether this item is complete."""
  isComplete: Boolean
  @deprecated(reason: "Don't use this")
  createdAt: Date!
  cost: Decimal
}''';

  print(graphqlApiSchema.schemaStr);

  InputGen<int> d = graphqlApiSchema.serdeCtx.fromJson({
    'name': 'nn',
    'generic': 1,
  });
  print(d.toJson());
}
