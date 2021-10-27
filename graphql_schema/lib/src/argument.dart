part of graphql_schema.src.schema;

/// An input to a GraphQL field. This is analogous
/// to a function parameter in Dart.
@immutable
class GraphQLFieldInput<Value extends Object, Serialized extends Object>
    implements ObjectField {
  /// The name of this field.
  @override
  final String name;

  /// An optional description for this field.
  ///
  /// This is useful when documenting your API for consumers like GraphiQL.
  final String? description;

  /// The type that input values must conform to.
  @override
  final GraphQLType<Value, Serialized> type;

  /// An optional default value for this field.
  final Value? defaultValue;

  final String? deprecationReason;

  static bool isInputType(GraphQLType type) {
    return type.when(
      enum_: (type) => true,
      scalar: (type) => true,
      input: (type) => true,
      object: (type) => false,
      union: (type) => false, // type.possibleTypes.every(isInputType),
      list: (type) => isInputType(type.ofType),
      nonNullable: (type) => isInputType(type.ofType),
    );
  }

  GraphQLFieldInput(
    this.name,
    this.type, {
    this.defaultValue,
    this.description,
    this.deprecationReason,
  }) : assert(
          isInputType(type),
          'All inputs to a GraphQL field must either be scalar types'
          ' or explicitly marked as INPUT_OBJECT. Call'
          ' `GraphQLObjectType.asInputObject()` on any'
          ' object types you are passing as inputs to a field.',
        );

  @override
  bool operator ==(Object other) =>
      other is GraphQLFieldInput &&
      other.runtimeType == runtimeType &&
      other.name == name &&
      other.type == type &&
      other.defaultValue == other.defaultValue &&
      other.description == description &&
      other.deprecationReason == deprecationReason;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      name.hashCode ^
      type.hashCode ^
      defaultValue.hashCode ^
      description.hashCode ^
      deprecationReason.hashCode;
}
