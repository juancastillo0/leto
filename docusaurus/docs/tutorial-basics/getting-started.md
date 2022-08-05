
# Quickstart

This provides a simple introduction to Leto, you can explore more in the following sections of this README or by looking at the tests, documentation and examples for each package. A fullstack Dart example with Flutter client and Leto/Shelf server can be found in https://github.com/juancastillo0/leto/tree/main/chat_example

The source code for this quickstart can be found in https://github.com/juancastillo0/leto/blob/main/leto_shelf/example/lib/quickstart_server.dart.

### Install

Add dependencies to your pubspec.yaml

All packages haven't been published at the moment. You can use them directly from git as explained in this [issue](https://github.com/juancastillo0/leto/issues/3) or you could also clone the repository locally and use relative dependencies like this [example](https://github.com/juancastillo0/leto/blob/df12485d0edc4e2d1016a581113c3411922137c5/chat_example/server/pubspec.yaml).

```yaml
dependencies:
  leto_schema: ^0.0.1
  leto: ^0.0.1
  leto_shelf: ^0.0.1
  shelf: ^1.0.0
  shelf_router: ^1.0.0
  # Not nessary for the server, just for testing it
  http: ^1.0.0

dev_dependencies:
  # Only if you use code generation
  leto_generator: ^0.0.1
  build_runner: ^2.0.0
```

### Create a `GraphQLSchema`


Specify the logic for your server, this could be anything such as accessing a database, reading a file or sending and http request. We will use a controller class with a stream that emits events on mutation to support subscriptions.

<!-- include{quickstart-controller-state-definition} -->
```dart
// this annotations is only necessary for code generation
@GraphQLClass()
class Model {
  final String state;
  final DateTime createdAt;

  const Model(this.state, this.createdAt);
}

/// Set up your state.
/// This could be anything such as a database connection
final stateRef = RefWithDefault<ModelController>.global(
  (scope) => ModelController(
    Model('InitialState', DateTime.now()),
  ),
);

class ModelController {
  Model? _value;
  Model? get value => _value;

  final _streamController = StreamController<Model>.broadcast();
  Stream<Model> get stream => _streamController.stream;

  ModelController(this._value);

  void setValue(Model newValue) {
    if (newValue.state == 'InvalidState') {
      // This will appear as an GraphQLError in the response.
      // You can pass more information using custom extensions.
      throw GraphQLError(
        "Can't be in InvalidState.",
        extensions: {'errorCodeExtension': 'INVALID_STATE'},
      );
    }
    _value = newValue;
    _streamController.add(newValue);
  }
}
```
<!-- include-end{quickstart-controller-state-definition} -->

With the logic that you want to expose, you can create the GraphQLSchema instance and access the controller state using the `Ctx` for each resolver and the `RefWithDefault.get` method. This is a schema with Query, Mutation and Subscription with a simple model. However, GraphQL is a very expressive language with [Unions](#unions), [Enums](#enums), [complex Input Objects](#inputs-and-input-objects), [collections](#wrapping-types) and more. For more documentation on writing GraphQL Schemas with Leto you can read the following sections, tests and examples for each package. // TODO: 1A more docs in the code

<!-- include{quickstart-make-schema} -->
```dart
/// Create a [GraphQLSchema]
GraphQLSchema makeGraphQLSchema() {
  final GraphQLObjectType<Model> modelGraphQLType = objectType<Model>(
    'Model',
    fields: [
      graphQLString.nonNull().field(
            'state',
            resolve: (Model model, Ctx ctx) => model.state,
          ),
      graphQLDate.nonNull().field(
            'createdAt',
            resolve: (Model model, Ctx ctx) => model.createdAt,
          ),
    ],
  );
  final schema = GraphQLSchema(
    queryType: objectType('Query', fields: [
      modelGraphQLType.field(
        'getState',
        description: 'Get the current state',
        resolve: (Object? rootValue, Ctx ctx) => stateRef.get(ctx).value,
      ),
    ]),
    mutationType: objectType('Mutation', fields: [
      graphQLBoolean.nonNull().field(
        'setState',
        inputs: [
          GraphQLFieldInput(
            'newState',
            graphQLString.nonNull(),
            description: "The new state, can't be 'WrongState'!.",
          ),
        ],
        resolve: (Object? rootValue, Ctx ctx) {
          final newState = ctx.args['newState']! as String;
          if (newState == 'WrongState') {
            return false;
          }
          stateRef.get(ctx).setValue(Model(newState, DateTime.now()));
          return true;
        },
      ),
    ]),
    subscriptionType: objectType('Subscription', fields: [
      modelGraphQLType.nonNull().field(
            'onStateChange',
            subscribe: (Object? rootValue, Ctx ctx) => stateRef.get(ctx).stream,
          )
    ]),
  );
  assert(schema.schemaStr == schemaString.trim());
  return schema;
}

```
<!-- include-end{quickstart-make-schema} -->

This will represent the following GraphQL Schema definition:

<!-- include{quickstart-schema-string} -->
```graphql
type Query {
  """Get the current state"""
  getState: Model
}

type Model {
  state: String!
  createdAt: Date!
}

"""An ISO-8601 Date."""
scalar Date

type Mutation {
  setState(
    """The new state, can't be 'WrongState'!."""
    newState: String!
  ): Boolean!
}

type Subscription {
  onStateChange: Model!
}
```
<!-- include-end{quickstart-schema-string} -->

// TODO: 1A rename GraphQLClass and graphQLString -> stringGraphQLType
// TODO: 1A use scope overrides and do not allow modifications
// TODO: 1A id attachment/directive
// TODO: 1T
type CompilerLog {
  toString: String!

TODO: 1T class ProcessExecResult implements ProcessResult {
[WARNING] leto_generator:graphql_types on lib/src/compiler_models.dart:
Cannot infer the GraphQLType for field ProcessResult.stdout (type=dynamic). Please annotate the Dart type, provide a dynamic.graphQLType static getter or add the type to `build.yaml` "customTypes" property.
[WARNING] leto_generator:graphql_types on lib/src/compiler_models.dart:
Cannot infer the GraphQLType for field ProcessResult.stderr (type=dynamic). Please annotate the Dart type, provide a dynamic.graphQLType static getter or add the type to `build.yaml` "customTypes" property.

You can use code generation to create a function similar to `makeGraphQLSchema` with the following resolver definitions with annotations.

<!-- include{quickstart-make-schema-code-gen} -->
```dart
/// Code Generation
/// Using leto_generator, [makeGraphQLSchema] could be generated
/// with the following annotated functions and the [GraphQLClass]
/// annotation over [Model]

/// Get the current state
@Query()
Model? getState(Ctx ctx) {
  return stateRef.get(ctx).value;
}

@Mutation()
bool setState(
  Ctx ctx,
  // The new state, can't be 'WrongState'!.
  String newState,
) {
  if (newState == 'WrongState') {
    return false;
  }

  stateRef.get(ctx).setValue(Model(newState, DateTime.now()));
  return true;
}

@Subscription()
Stream<Model> onStateChange(Ctx ctx) {
  return stateRef.get(ctx).stream;
}
```
<!-- include-end{quickstart-make-schema-code-gen} -->

This generates the same `modelGraphQLType` in `<file>.g.dart` and `graphqlApiSchema` in 'lib/graphql_api.schema.dart' (TODO: configurable). The documentation comments will be used as description in the generated schema. More information on code generation can be found in the following sections, in the `package:leto_generator`'s [README](https://github.com/juancastillo0/leto/tree/main/leto_generator) or in the code generation [example](https://github.com/juancastillo0/leto/tree/main/leto_generator/example).