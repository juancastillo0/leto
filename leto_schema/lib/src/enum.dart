part of leto_schema.src.schema;

/// Shorthand for building a [GraphQLEnumType].
GraphQLEnumType<Value> enumType<Value>(
  String name,
  Map<String, Value> values, {
  String? description,
}) {
  return GraphQLEnumType(
    name,
    values.entries.map((e) => GraphQLEnumValue(e.key, e.value)).toList(),
    description: description,
  );
}

/// Shorthand for building a [GraphQLEnumType] where all the possible values
/// are mapped to Dart strings.
GraphQLEnumType<String> enumTypeFromStrings(
  String name,
  List<String> values, {
  String? description,
}) {
  return GraphQLEnumType<String>(
    name,
    values.map((s) => GraphQLEnumValue(s, s)).toList(),
    description: description,
  );
}

/// A [GraphQLType] with only a predetermined number of possible values.
///
/// Though these are serialized as strings, they carry
/// special meaning with a type system.
class GraphQLEnumType<Value> extends GraphQLType<Value, String>
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

  GraphQLEnumType(this.name, this.values, {this.description});

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
          ['The enum "$name" does not accept null values.']);
    }
    final value = values.firstWhereOrNull((v) => v.name == input);
    if (value == null) {
      return ValidationResult<String>.failure(
          ['"$input" is not a valid value for the enum "$name".']);
    }

    return ValidationResult<String>.ok(value.name);
  }

  @override
  Iterable<Object?> get props => [name, description, values];

  @override
  GraphQLType<Value, String> coerceToInputObject() => this;
}

/// Enum value parsed from the ast.
/// Useful for distinguishing between enum and string values.
class EnumValue {
  final String value;
  const EnumValue(this.value);

  @override
  String toString() => 'EnumValue($value)';
}

/// A known value of a [GraphQLEnumType].
///
/// In practice, you might not directly call this constructor very often.
@immutable
class GraphQLEnumValue<Value> {
  /// The name of this value.
  final String name;

  /// The Dart value associated with enum values bearing the given [name].
  final Value value;

  /// An optional description of this value; useful for tools like GraphiQL.
  final String? description;

  /// The reason, if any, that this value was deprecated,
  /// if it indeed is deprecated.
  final String? deprecationReason;

  const GraphQLEnumValue(
    this.name,
    this.value, {
    this.description,
    this.deprecationReason,
  });

  /// Returns `true` if this value has a [deprecationReason].
  bool get isDeprecated => deprecationReason != null;

  @override
  bool operator ==(Object other) =>
      other is GraphQLEnumValue &&
      other.runtimeType == runtimeType &&
      other.name == name &&
      other.value == value &&
      other.description == description &&
      other.deprecationReason == deprecationReason;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      name.hashCode ^
      value.hashCode ^
      description.hashCode ^
      deprecationReason.hashCode;
}
