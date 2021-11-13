import 'package:leto_schema/leto_schema.dart';

bool isCompositeType(GraphQLType? type) =>
    type is GraphQLObjectType || type is GraphQLUnionType;

bool isOutputType(GraphQLType? type) =>
    type != null &&
    type.when(
      enum_: (type) => true,
      scalar: (type) => true,
      object: (type) => true,
      input: (type) => false,
      union: (type) => true,
      list: (type) => isOutputType(type.ofType),
      nonNullable: (type) => isOutputType(type.ofType),
    );

/// Returns true if [type] can be used as a GraphQL input.
bool isInputType(GraphQLType? type) {
  return type != null &&
      type.when(
        enum_: (type) => true,
        scalar: (type) => true,
        input: (type) => true,
        object: (type) => false,
        union: (type) => false,
        list: (type) => isInputType(type.ofType),
        nonNullable: (type) => isInputType(type.ofType),
      );
}

/// Returns true if the [type] is an introspection type
bool isIntrospectionType(GraphQLType type) {
  return introspectionTypeNames.contains(type.name);
}

/// All introspection type names
const introspectionTypeNames = [
  '__Schema',
  '__Directive',
  '__DirectiveLocation',
  '__Type',
  '__Field',
  '__InputValue',
  '__EnumValue',
  '__TypeKind',
];
