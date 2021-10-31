import 'package:decimal/decimal.dart';
import 'package:leto_generator_example/decimal.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_generator_example/inputs.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto/leto.dart';

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

Future<void> main() async {
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

  String fieldSelection(GraphQLObjectField<Object?, Object?, Object?> f) {
    final type = f.type;
    final _innerType =
        type is GraphQLWrapperType ? (type as GraphQLWrapperType).ofType : type;
    final innerType = _innerType is GraphQLWrapperType
        ? (_innerType as GraphQLWrapperType).ofType
        : _innerType;
    if (innerType is GraphQLObjectType) {
      return ' ${f.name} { ${innerType.fields.map(fieldSelection).join(' ')} } ';
    } else if (innerType is GraphQLUnionType) {
      return ' ${f.name} { ${innerType.possibleTypes.map((e) {
        return ' ... on ${e.name} { ${e.fields.map(fieldSelection).join(' ')} } ';
      })} }';
    }
    return ' ${f.name} ';
  }

  final allQueries = '{ ${graphqlApiSchema.queryType!.fields.where((f) {
        return f.inputs.isEmpty;
      }).map(fieldSelection).join(' ')} }';

  final resultQueries =
      await GraphQL(graphqlApiSchema).parseAndExecute(allQueries);
  assert(resultQueries.errors.isEmpty);

  final data = resultQueries.data! as Map<String, Object?>;
  print(data);

  final allMutations =
      ' mutation { ${graphqlApiSchema.mutationType!.fields.where((f) {
            return f.inputs.isEmpty;
          }).map(fieldSelection).join(' ')} }';

  final resultMutations =
      await GraphQL(graphqlApiSchema).parseAndExecute(allMutations);
  final dataMutation = resultMutations.data! as Map<String, Object?>;
  print(dataMutation);
  assert(resultMutations.errors.isEmpty);
}

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
