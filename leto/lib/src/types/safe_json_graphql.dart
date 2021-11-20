import 'package:leto_schema/leto_schema.dart';

import 'safe_json.dart';

/// The canonical [Json] [GraphQLType] instance.
final GraphQLJsonType jsonGraphQLType = GraphQLJsonType();

/// A [GraphQLJsonType] represents a valid json object
class GraphQLJsonType extends GraphQLScalarType<Json, Object?> {
  @override
  String get name => 'Json';

  @override
  String get description => 'Represents a JSON value.';

  @override
  GraphQLType<Json, Object?> coerceToInputObject() => this;

  @override
  Json deserialize(SerdeCtx serdeCtx, Object? serialized) =>
      Json.fromJson(serialized);

  @override
  Object? serialize(Json value) => value.toJson();

  @override
  ValidationResult<Object?> validate(String key, Object? input) {
    final result = Json.fromJsonChecked(input, isRoot: true, getter: key);
    if (result.isOk()) {
      return ValidationResult.ok(input);
    }
    return ValidationResult.failure(
        ['Expected "$key" to be an Json. ${result.unwrapErr()}']);
  }
}
