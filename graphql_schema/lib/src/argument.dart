part of graphql_schema.src.schema;

/// An input to a GraphQL field. This is analogous
/// to a function parameter in Dart.
@immutable
class GraphQLFieldInput<Value, Serialized> {
  /// The name of this field.
  final String name;

  /// The type that input values must conform to.
  final GraphQLType<Value, Serialized> type;

  /// An optional default value for this field.
  final Value? defaultValue;

  /// An optional description for this field.
  ///
  /// This is useful when documenting your API for consumers like GraphiQL.
  final String? description;

  /// If [defaultValue] is `null`, and `null` is a valid value
  /// for this parameter, set this to `true`.
  final bool defaultsToNull;

  static bool _isInputTypeOrScalar(GraphQLType type) {
    return type.when(
      enum_: (type) => true,
      scalar: (type) => true,
      input: (type) => true,
      object: (type) => false,
      union: (type) => type.possibleTypes.every(_isInputTypeOrScalar),
      list: (type) => _isInputTypeOrScalar(type.ofType),
      nonNullable: (type) => _isInputTypeOrScalar(type.ofType),
    );
  }

  GraphQLFieldInput(
    this.name,
    this.type, {
    this.defaultValue,
    this.defaultsToNull = false,
    this.description,
  }) : assert(
          _isInputTypeOrScalar(type),
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
      other.defaultsToNull == defaultsToNull &&
      other.description == description;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      name.hashCode ^
      type.hashCode ^
      defaultValue.hashCode ^
      defaultsToNull.hashCode ^
      description.hashCode;
}
