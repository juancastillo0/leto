part of leto_schema.src.schema;

/// `true` or `false`.
final GraphQLScalarType<bool, bool> graphQLBoolean = _GraphQLBoolType();

/// A UTF‐8 character sequence.
final GraphQLScalarType<String, String> graphQLString = _GraphQLStringType._();

/// The ID scalar type represents a unique identifier, often used to re-fetch
/// an object or as the key for a cache.
///
/// The ID type is serialized in the same way as a String; however, defining it
///  as an ID signifies that it is not intended to be human‐readable.
final GraphQLScalarType<String, Object> graphQLId = _GraphQLIDType._();

/// A [DateTime], serialized as an ISO-8601 string.
final GraphQLScalarType<DateTime, String> graphQLDate = _GraphQLDateType._();

/// A [BigInt], serialized as an string.
final GraphQLScalarType<BigInt, String> graphQLBigInt = GraphQLScalarTypeValue(
  name: 'BigInt',
  description: 'An arbitrarily large integer.',
  serialize: (bigInt) => bigInt.toString(),
  deserialize: (_, input) => BigInt.parse(input),
  specifiedByURL: 'https://api.dart.dev/stable/dart-core/BigInt-class.html',
  validate: (key, input) => BigInt.tryParse(input.toString()) != null
      ? ValidationResult.ok(input.toString())
      : ValidationResult.failure(
          [
            'Expected "$key" to be a number or numeric string. Got invalid value $input.'
          ],
        ),
);

/// A [DateTime], serialized as an UNIX timestamp.
final GraphQLScalarType<DateTime, int> graphQLTimestamp =
    _GraphQLTimestampType._();

/// A signed integer.
final GraphQLScalarType<int, int> graphQLInt = _GraphQLNumType(
  'Int',
  'A signed integer.',
  'an integer',
  (input) => input is int ? input : null,
);

/// A signed double-precision floating-point value.
final GraphQLScalarType<double, double> graphQLFloat = _GraphQLNumType(
  'Float',
  'A signed double-precision floating-point value.',
  'a float',
  (input) => input.toDouble(),
);

/// A [GraphQLType] for [Uri] values.
final GraphQLScalarType<Uri, String> graphQLUri = GraphQLScalarTypeValue(
  name: 'Uri',
  description: 'A Uniform Resource Identifier (URI) is a compact sequence of'
      ' characters that identifies an abstract or physical resource.',
  serialize: (uri) => uri.toString(),
  deserialize: (_, input) => Uri.parse(input),
  specifiedByURL: 'https://datatracker.ietf.org/doc/html/rfc3986',
  validate: (key, input) => input is String && Uri.tryParse(input) != null
      ? ValidationResult.ok(input)
      : ValidationResult.failure(
          ['Expected "$key" to be a Uri. Got invalid value $input.'],
        ),
);

/// Whether [type] is one of the default [GraphQLScalarType] types
bool isSpecifiedScalarType(GraphQLType type) {
  return specifiedScalarNames.contains(type.name);
}

/// Names of all specified scalars
const specifiedScalarNames = [
  'String',
  'Int',
  'Float',
  'Boolean',
  'ID',
];

/// A [GraphQLType] without nested properties.
/// Can be used as an input type.
abstract class GraphQLScalarType<Value, Serialized>
    extends GraphQLNamedType<Value, Serialized>
    with _NonNullableMixin<Value, Serialized> {
  @override
  String get name;

  /// An url with the specification of this scalar type
  String? get specifiedByURL => null;

  @override
  GraphQLType<Value, Serialized> coerceToInputObject() => this;

  @override
  GraphQLTypeDefinitionExtra<ScalarTypeDefinitionNode, ScalarTypeExtensionNode>
      get extra => const GraphQLTypeDefinitionExtra.attach([]);
}

/// A [GraphQLType] without nested properties.
/// Can be used as an input type.
/// Utility for creating a [GraphQLScalarType], you can also extend it.
class GraphQLScalarTypeValue<Value, Serialized>
    extends GraphQLScalarType<Value, Serialized> {
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? specifiedByURL;

  final ValidationResult<Serialized> Function(String key, Object? input)
      _validate;
  final Serialized Function(Value value) _serialize;
  final Value Function(SerdeCtx serdeCtx, Serialized serialized) _deserialize;
  @override
  final GraphQLTypeDefinitionExtra<ScalarTypeDefinitionNode,
      ScalarTypeExtensionNode> extra;

  /// A [GraphQLType] without nested properties.
  /// Can be used as an input type.
  /// Utility for creating a [GraphQLScalarType], you can also extend it.
  GraphQLScalarTypeValue({
    required this.name,
    required this.description,
    required this.specifiedByURL,
    required ValidationResult<Serialized> Function(String key, Object? input)
        validate,
    required Serialized Function(Value value) serialize,
    required Value Function(SerdeCtx serdeCtx, Serialized serialized)
        deserialize,
    this.extra = const GraphQLTypeDefinitionExtra.attach([]),
  })  : _validate = validate,
        _serialize = serialize,
        _deserialize = deserialize;

  @override
  Value deserialize(SerdeCtx serdeCtx, Serialized serialized) {
    return _deserialize(serdeCtx, serialized);
  }

  @override
  Serialized serialize(Value value) {
    return _serialize(value);
  }

  @override
  ValidationResult<Serialized> validate(String key, Object? input) {
    return _validate(key, input);
  }
}

class _GraphQLBoolType extends GraphQLScalarType<bool, bool> {
  @override
  bool serialize(bool value) {
    return value;
  }

  @override
  String get name => 'Boolean';

  @override
  String get description => 'A boolean value; can be either true or false.';

  @override
  ValidationResult<bool> validate(String key, Object? input) {
    if (input is bool) return ValidationResult.ok(input);
    return ValidationResult.failure(
        ['Expected "$key" to be a boolean. Got invalid value $input.']);
  }

  @override
  bool deserialize(SerdeCtx serdeCtx, bool serialized) {
    return serialized;
  }
}

class _GraphQLNumType<T extends num> extends GraphQLScalarType<T, T> {
  @override
  final String name;
  @override
  final String description;
  final String expected;
  final T? Function(num) castNum;

  _GraphQLNumType(
    this.name,
    this.description,
    this.expected,
    this.castNum,
  );

  @override
  ValidationResult<T> validate(String key, Object? input) {
    if (input is num) {
      final value = castNum(input);
      if (value != null) {
        return ValidationResult.ok(value);
      }
    }

    return ValidationResult.failure(
        ['Expected "$key" to be $expected. Got invalid value $input.']);
  }

  @override
  T deserialize(SerdeCtx serdeCtx, num serialized) {
    return castNum(serialized)!;
  }

  @override
  T serialize(num value) {
    return castNum(value)!;
  }
}

class _GraphQLStringType extends GraphQLScalarType<String, String> {
  @override
  final String name;

  _GraphQLStringType._([this.name = 'String']);

  @override
  String get description => 'A character sequence.';

  @override
  String serialize(String value) => value;

  @override
  String deserialize(SerdeCtx serdeCtx, String serialized) => serialized;

  @override
  ValidationResult<String> validate(String key, Object? input) =>
      input is String
          ? ValidationResult.ok(input)
          : ValidationResult.failure(
              ['Expected "$key" to be a string. Got invalid value $input.']);
}

class _GraphQLIDType extends GraphQLScalarType<String, Object> {
  @override
  String get name => 'ID';

  _GraphQLIDType._();

  @override
  String get description =>
      'The `ID` scalar type represents a unique identifier,'
      ' often used to refetch an object or as key for a cache.'
      ' The ID type appears in a JSON response as a String; however,'
      ' it is not intended to be human-readable. When expected'
      ' as an input type, any string (such as `"4"`) or integer (such as `4`)'
      ' input value will be accepted as an ID.';

  @override
  Object serialize(String value) => value;

  @override
  String deserialize(SerdeCtx serdeCtx, Object serialized) =>
      serialized.toString();

  @override
  ValidationResult<Object> validate(String key, Object? input) =>
      input is int || input is String
          ? ValidationResult.ok(input!)
          : ValidationResult.failure(
              [
                // ignore: lines_longer_than_80_chars
                'Expected "$key" to be a ID, string or int. Got invalid value $input.'
              ],
            );
}

class _GraphQLDateType extends GraphQLScalarType<DateTime, String>
    with _NonNullableMixin<DateTime, String> {
  _GraphQLDateType._();

  @override
  String get name => 'Date';

  @override
  String get description => 'An ISO-8601 Date.';

  @override
  String serialize(DateTime value) => value.toIso8601String();

  @override
  DateTime deserialize(SerdeCtx serdeCtx, String serialized) =>
      DateTime.parse(serialized);

  @override
  ValidationResult<String> validate(String key, Object? input) {
    return _validateDateString(key, input);
  }
}

ValidationResult<String> _validateDateString(String key, Object? input) {
  if (input is! String) {
    return ValidationResult<String>.failure(
        ['$key must be an ISO 8601-formatted date string.']);
  }
  try {
    DateTime.parse(input);
    return ValidationResult.ok(input);
  } on FormatException {
    return ValidationResult.failure(
        ['$key must be an ISO 8601-formatted date string.']);
  }
}

class _GraphQLTimestampType extends GraphQLScalarType<DateTime, int>
    with _NonNullableMixin<DateTime, int> {
  _GraphQLTimestampType._();

  @override
  String get name => 'Timestamp';

  @override
  String get description => 'An UNIX timestamp.';

  @override
  int serialize(DateTime value) => value.millisecondsSinceEpoch;

  @override
  DateTime deserialize(SerdeCtx serdeCtx, int serialized) =>
      DateTime.fromMillisecondsSinceEpoch(serialized);

  @override
  ValidationResult<int> validate(String key, Object? input) {
    Object? value = input;
    if (value is String) {
      value = int.tryParse(value);
    }
    final err =
        ValidationResult<int>.failure(['$key must be an UNIX timestamp.']);
    if (value is! int) {
      return err;
    }
    try {
      DateTime.fromMillisecondsSinceEpoch(value);
      return ValidationResult.ok(value);
    } catch (_) {
      return err;
    }
  }
}
