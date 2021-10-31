part of leto_schema.src.schema;

/// Represents the result of asserting an input [value] against a [GraphQLType].
@immutable
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

  ValidationResult<T> mapValue<T>(T Function(Value) mapper) {
    if (successful) {
      return ValidationResult.ok(mapper(value as Value));
    } else {
      return ValidationResult.failure(errors);
    }
  }

  @override
  bool operator ==(Object? other) {
    return other is ValidationResult<Value> &&
        other.runtimeType == runtimeType &&
        other.successful == successful &&
        other.value == value &&
        const ListEquality<String>().equals(other.errors, errors);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash([successful, value, errors]);

  @override
  String toString() =>
      'ValidationResult(${successful ? 'value: $value' : 'errors: $errors'})';
}
