part of leto_schema.src.schema;

/// Represents the result of asserting an input [value] against a [GraphQLType].
class ValidationResult<Value> {
  /// `true` if there were no errors during validation.
  final bool successful;

  /// The input value passed to whatever caller invoked validation.
  final Value? value;

  /// A list of errors that caused validation to fail.
  final List<String> errors;

  const ValidationResult.ok(Value _value)
      : errors = const [],
        value = _value,
        successful = true;

  const ValidationResult.failure(this.errors)
      : value = null,
        successful = false;

  @override
  String toString() =>
      'ValidationResult(${successful ? 'value: $value' : 'errors: $errors'})';
}
