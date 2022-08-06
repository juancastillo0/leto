import 'package:leto_generator_example/decimal.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:leto_schema/leto_schema.dart';

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
class TodoItemInputNested {
  const TodoItemInputNested({required this.cost});

  final Decimal? cost;

  // ignore: prefer_constructors_over_static_methods
  static TodoItemInputNested fromJson(Map<String, Object?> json) =>
      TodoItemInputNested(
        cost: json['cost'] == null
            ? null
            : Decimal.parse(json['cost'].toString()),
      );
}

@GraphQLObject()
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
    // ignore: deprecated_consistency
    required this.createdAt,
  });
}

@Query()
String getName() {
  return '';
}

Future<void> main() async {
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

// TODO: 1A delete this
const ss = '''
type Query {
  testInputGen(v: InputGenIntReq!): Int!
  getNestedInterfaceImpl3: NestedInterfaceImpl3!
  getName: String!
}

input InputGenIntReq {
  name: String!
  generic: Int!
}

type NestedInterfaceImpl3 {
  name3: String!
}

type Mutation {
  getInt: ResultIntReqString!
  getIntReq: ResultIntReqStringReq!
  getIntNull: ResultIntString!
  getIntInterface: ResultIntErrCodeInterfaceStringReqReq!
  getIntInterfaceEnum: ResultIntReqErrCodeInterfaceErrCodeTypeReqReq!
  getIntInterfaceEnumList: ResultIntListReqErrCodeInterfaceErrCodeTypeReqListReqReq!
  getIntInterfaceNEnumNull: ResultIntReqErrCodeInterfaceNErrCodeTypeReq!
}

"""
Int! when the operation was successful or String when an error was encountered.
"""
type ResultIntReqString {
  ok: Int
  err: String
  isOk: Boolean!
}

"""
Int! when the operation was successful or String! when an error was encountered.
"""
type ResultIntReqStringReq {
  ok: Int
  err: String
  isOk: Boolean!
}

"""
Int when the operation was successful or String when an error was encountered.
"""
type ResultIntString {
  ok: Int
  err: String
  isOk: Boolean!
}

"""
Int when the operation was successful or ErrCodeInterfaceStringReq! when an error was encountered.
"""
type ResultIntErrCodeInterfaceStringReqReq {
  ok: Int
  err: ErrCodeInterfaceStringReq
  isOk: Boolean!
}

type ErrCodeInterfaceStringReq {
  message: String
  code: String!
}

"""
Int! when the operation was successful or ErrCodeInterfaceErrCodeTypeReq! when an error was encountered.
"""
type ResultIntReqErrCodeInterfaceErrCodeTypeReqReq {
  ok: Int
  err: ErrCodeInterfaceErrCodeTypeReq
  isOk: Boolean!
}

type ErrCodeInterfaceErrCodeTypeReq {
  message: String
  code: ErrCodeType!
}

enum ErrCodeType {
  code1
  code2
}

"""
[Int]! when the operation was successful or ErrCodeInterfaceErrCodeTypeReqListReq! when an error was encountered.
"""
type ResultIntListReqErrCodeInterfaceErrCodeTypeReqListReqReq {
  ok: [Int]
  err: ErrCodeInterfaceErrCodeTypeReqListReq
  isOk: Boolean!
}

type ErrCodeInterfaceErrCodeTypeReqListReq {
  message: String
  code: [ErrCodeType!]!
}

"""
Int! when the operation was successful or ErrCodeInterfaceNErrCodeType! when an error was encountered.
"""
type ResultIntReqErrCodeInterfaceNErrCodeTypeReq {
  ok: Int
  err: ErrCodeInterfaceNErrCodeType
  isOk: Boolean!
}

type ErrCodeInterfaceNErrCodeType {
  message: String
  code: ErrCodeType!
}

type Subscription
''';
