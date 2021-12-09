part of leto_schema.src.schema;

/// Shorthand for building a [GraphQLEnumType].
GraphQLEnumType<Value> enumType<Value>(
  String name,
  Map<String, Value> values, {
  String? description,
  GraphQLTypeDefinitionExtra<EnumTypeDefinitionNode, EnumTypeExtensionNode>
      extra = const GraphQLTypeDefinitionExtra.attach([]),
}) {
  return GraphQLEnumType(
    name,
    values.entries.map((e) => GraphQLEnumValue(e.key, e.value)).toList(),
    description: description,
    extra: extra,
  );
}

/// Shorthand for building a [GraphQLEnumType] where all the possible values
/// are mapped to Dart strings.
GraphQLEnumType<String> enumTypeFromStrings(
  String name,
  Set<String> values, {
  String? description,
  GraphQLTypeDefinitionExtra<EnumTypeDefinitionNode, EnumTypeExtensionNode>
      extra = const GraphQLTypeDefinitionExtra.attach([]),
}) {
  return GraphQLEnumType<String>(
    name,
    values.map((s) => GraphQLEnumValue(s, s)).toList(),
    description: description,
    extra: extra,
  );
}

/// A [GraphQLType] with only a predetermined number of possible values.
///
/// Though these are serialized as strings, they carry
/// special meaning with a type system.
class GraphQLEnumType<Value> extends GraphQLNamedType<Value, String>
    with _NonNullableMixin<Value, String> {
  /// The name of this enum type.
  @override
  final String name;

  /// The defined set of possible values for this type.
  ///
  /// No other values will be accepted than the ones you define.
  final List<GraphQLEnumValue<Value>> values;

  /// A description of this enum type, for tools like GraphiQL.
  @override
  final String? description;

  @override
  final GraphQLTypeDefinitionExtra<EnumTypeDefinitionNode,
      EnumTypeExtensionNode> extra;

  /// Default GraphQL enum definition constructor
  GraphQLEnumType(
    this.name,
    this.values, {
    this.description,
    this.extra = const GraphQLTypeDefinitionExtra.attach([]),
  })  : assert(
          !checkAsserts ||
              values.every(
                  (e) => !const ['true', 'false', 'null'].contains(e.name)),
          "Can't have any of 'true', 'false' or 'null'"
          ' as names of variants in enums.',
        ),
        // TODO: tests in validateSchema
        assert(
            !checkAsserts ||
                values.map((e) => e.value).toSet().length == values.length,
            'All enum variant values should be different.'),
        assert(
            !checkAsserts ||
                values.map((e) => e.name).toSet().length == values.length,
            'All enum variant names should be different.');

  @override
  String serialize(Value value) {
    return values.firstWhere((v) => v.value == value).name;
  }

  @override
  Value deserialize(SerdeCtx serdeCtx, String serialized) {
    return getValue(serialized)!.value;
  }

  /// Returns the enum value with the given name
  GraphQLEnumValue<Value>? getValue(String name) {
    return values.firstWhereOrNull((v) => v.name == name);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  ValidationResult<String> validate(String key, Object? _input) {
    final input = _input is EnumValue ? _input.value : _input;
    if (input is! String) {
      return ValidationResult<String>.failure(
          ['The enum "$name" does not accept non String values.']);
    }
    final value = values.firstWhereOrNull((v) => v.name == input);
    if (value == null) {
      return ValidationResult<String>.failure(
          ['"$input" is not a valid value for the enum "$name".']);
    }

    return ValidationResult<String>.ok(value.name);
  }

  @override
  GraphQLType<Value, String> coerceToInputObject() => this;
}

/// Enum value parsed from the ast.
/// Useful for distinguishing between enum and string values.
class EnumValue {
  /// The name of the enum variant
  final String value;

  /// Enum value parsed from the ast.
  /// Useful for distinguishing between enum and string values.
  const EnumValue(this.value);

  @override
  String toString() => 'EnumValue($value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnumValue && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// A variant of a [GraphQLEnumType].
///
/// In practice, you might not directly call this constructor very often.
/// However this will allow you to specify a [description] and
/// a [deprecationReason]
@immutable
class GraphQLEnumValue<Value> implements GraphQLElement {
  /// The name of this value.
  @override
  final String name;

  /// The Dart value associated with enum values bearing the given [name].
  final Value value;

  /// An optional description of this value; useful for tools like GraphiQL.
  @override
  final String? description;

  /// The reason, if any, that this value was deprecated,
  /// if it indeed is deprecated.
  final String? deprecationReason;

  @override
  final EnumValueDefinitionNode? astNode;

  @override
  final GraphQLAttachments attachments;

  /// A variant of a [GraphQLEnumType].
  ///
  /// In practice, you might not directly call this constructor very often.
  /// However this will allow you to specify a [description] and
  /// a [deprecationReason]
  const GraphQLEnumValue(
    this.name,
    this.value, {
    this.description,
    this.deprecationReason,
    this.astNode,
    this.attachments = const [],
  });

  /// Returns `true` if this value has a [deprecationReason].
  bool get isDeprecated => deprecationReason != null;
}
