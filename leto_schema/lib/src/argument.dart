part of leto_schema.src.schema;

/// An input to a GraphQL field. This is analogous
/// to a function parameter in Dart.
@immutable
class GraphQLFieldInput<Value, Serialized> implements ObjectField {
  /// The name of this field.
  @override
  final String name;

  /// An optional description for this field.
  ///
  /// This is useful when documenting your API for consumers like GraphiQL.
  @override
  final String? description;

  /// The type that input values must conform to.
  @override
  final GraphQLType<Value, Serialized> type;

  /// An optional default value for this field.
  final Value? defaultValue;

  /// If [defaultValue] is `null`, and `null` is a valid value
  /// for this parameter's [type], set this to `true` if you want for `null`
  /// to be the default value.
  final bool defaultsToNull;

  /// If this input is deprecated, this would be the deprecation reason.
  ///
  /// If it's an empty String, [DEFAULT_DEPRECATION_REASON]
  /// "No longer supported" will be used.
  final String? deprecationReason;

  /// Returns true if this type input is non-nullable and
  /// doesn't have a default value
  bool get isRequired => type.isNonNullable && defaultValue == null;

  @override
  final GraphQLAttachments attachments;

  @override
  final InputValueDefinitionNode? astNode;

  /// An input to a GraphQL field. This is analogous
  /// to a function parameter in Dart.
  GraphQLFieldInput(
    this.name,
    this.type, {
    this.defaultValue,
    this.description,
    this.deprecationReason,
    this.defaultsToNull = false,
    this.attachments = const [],
    this.astNode,
  })  : assert(
          !checkAsserts || isInputType(type),
          'All inputs to a GraphQL field must either be scalar types'
          ' or explicitly marked as INPUT_OBJECT. Call'
          ' `GraphQLObjectType.asInputObject()` on any'
          ' object types you are passing as inputs to a field.',
        ),
        assert(
          !defaultsToNull || (type.isNullable && defaultValue == null),
          'If defaultsToNull is true, type $type should be nullable'
          ' and default value $defaultValue should be null',
        );

  /// Throws an exception if the default value cannot be deserialized
  static void validateDefaultSerialization(
    SerdeCtx serdeCtx,
    GraphQLFieldInput field,
  ) {
    Object? serialized = field.defaultValue;
    if (serialized != null) {
      try {
        serialized = field.type.serialize(serialized);
      } catch (_) {}
      field.type.deserialize(serdeCtx, serialized);
    }
  }
}
