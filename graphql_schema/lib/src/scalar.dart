part of graphql_schema.src.schema;

/// `true` or `false`.
final GraphQLScalarType<bool?, bool?> graphQLBoolean = _GraphQLBoolType();

/// A UTF‐8 character sequence.
final GraphQLScalarType<String?, String?> graphQLString =
    _GraphQLStringType._();

/// The ID scalar type represents a unique identifier, often used to re-fetch
/// an object or as the key for a cache.
///
/// The ID type is serialized in the same way as a String; however, defining it
///  as an ID signifies that it is not intended to be human‐readable.
final GraphQLScalarType<String?, String?> graphQLId =
    _GraphQLStringType._('ID');

/// A [DateTime], serialized as an ISO-8601 string.
final GraphQLScalarType<DateTime?, String?> graphQLDateValue =
    _GraphQLDateType._();

/// A Date [String], serialized as an ISO-8601 string.
final GraphQLScalarType<String?, String?> graphQLDate =
    _GraphQLIdentityType('Date', 'An ISO-8601 Date.', validateDateString);

/// A Date [String], serialized as an UNIX timestamp.
// final GraphQLScalarType<DateTime?, int?> graphQLTimestamp =
//  _GraphQLIdentityType('Timestamp', 'An UNIX timestamp.', validateDateString);

/// A signed 32‐bit integer.
final GraphQLScalarType<int?, int?> graphQLInt = _GraphQLNumType(
  'Int',
  'A signed 64-bit integer.',
  (x) => x is int?,
  'an integer',
);

/// A signed double-precision floating-point value.
final GraphQLScalarType<double?, double?> graphQLFloat = _GraphQLNumType(
  'Float',
  'A signed double-precision floating-point value.',
  (x) => x is double?,
  'a float',
);

abstract class GraphQLScalarType<Value, Serialized>
    extends GraphQLType<Value, Serialized>
    with _NonNullableMixin<Value, Serialized> {
  // const GraphQLScalarType();
}

class _GraphQLBoolType extends GraphQLScalarType<bool?, bool?> {
  // const _GraphQLBoolType();

  @override
  bool? serialize(bool? value) {
    return value;
  }

  @override
  String get name => 'Boolean';

  @override
  String get description => 'A boolean value; can be either true or false.';

  @override
  ValidationResult<bool?> validate(String key, Object? input) {
    if (input is bool?) return ValidationResult.ok(input);
    return ValidationResult.failure(['Expected "$key" to be a boolean.']);
  }

  @override
  bool? deserialize(SerdeCtx serdeCtx, bool? serialized) {
    return serialized;
  }

  @override
  GraphQLType<bool?, bool?> coerceToInputObject() => this;

  @override
  Iterable<Object?> get props => [];
}

class _GraphQLNumType<T extends num?> extends GraphQLScalarType<T, T> {
  @override
  final String name;
  @override
  final String description;
  final bool Function(Object x) verifier;
  final String expected;

  _GraphQLNumType(this.name, this.description, this.verifier, this.expected);

  @override
  ValidationResult<T> validate(String key, Object? input) {
    if (input != null && !verifier(input))
      return ValidationResult.failure(['Expected "$key" to be $expected.']);

    return ValidationResult.ok(input as T);
  }

  @override
  T deserialize(SerdeCtx serdeCtx, T serialized) {
    return serialized;
  }

  @override
  T serialize(T value) {
    return value;
  }

  @override
  GraphQLType<T, T> coerceToInputObject() => this;

  @override
  Iterable<Object?> get props => [];
}

class _GraphQLStringType extends GraphQLScalarType<String?, String?> {
  @override
  final String name;

  _GraphQLStringType._([this.name = 'String']);

  @override
  String get description => 'A character sequence.';

  @override
  String? serialize(String? value) => value;

  @override
  String? deserialize(SerdeCtx serdeCtx, String? serialized) => serialized;

  @override
  ValidationResult<String?> validate(String key, Object? input) =>
      input is String?
          ? ValidationResult.ok(input)
          : ValidationResult.failure(['Expected "$key" to be a string.']);

  @override
  GraphQLType<String?, String?> coerceToInputObject() => this;

  @override
  Iterable<Object?> get props => [];
}

class _GraphQLDateType extends GraphQLScalarType<DateTime?, String?>
    with _NonNullableMixin<DateTime?, String?> {
  _GraphQLDateType._();

  @override
  String get name => 'Date';

  @override
  String get description => 'An ISO-8601 Date.';

  @override
  String? serialize(DateTime? value) => value?.toIso8601String();

  @override
  DateTime? deserialize(SerdeCtx serdeCtx, String? serialized) =>
      serialized == null ? null : DateTime.parse(serialized);

  @override
  ValidationResult<String?> validate(String key, Object? input) {
    return validateDateString(key, input);
  }

  @override
  GraphQLType<DateTime?, String?> coerceToInputObject() => this;

  @override
  Iterable<Object?> get props => [];
}

ValidationResult<String?> validateDateString(String key, Object? input) {
  if (input is! String?)
    return ValidationResult<String>.failure(
        ['$key must be an ISO 8601-formatted date string.']);
  else if (input == null) return ValidationResult<String?>.ok(input);

  try {
    DateTime.parse(input);
    return ValidationResult<String?>.ok(input);
  } on FormatException {
    return ValidationResult<String?>.failure(
        ['$key must be an ISO 8601-formatted date string.']);
  }
}

class _GraphQLIdentityType<T> extends GraphQLScalarType<T, T>
    with _NonNullableMixin<T, T> {
  _GraphQLIdentityType(
    this.name,
    this.description,
    this._validate,
  );

  @override
  final String name;

  @override
  final String description;

  final ValidationResult<T> Function(String key, Object? input) _validate;

  @override
  T serialize(T value) => value;

  @override
  T deserialize(SerdeCtx serdeCtx, T serialized) => serialized;

  @override
  ValidationResult<T> validate(String key, Object? input) {
    return _validate(key, input);
  }

  @override
  GraphQLType<T, T> coerceToInputObject() => this;

  @override
  Iterable<Object?> get props => [name, description, _validate];
}
