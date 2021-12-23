// @example-start{custom-scalar-decimal}
import 'package:decimal/decimal.dart';
import 'package:leto_schema/leto_schema.dart';

export 'package:decimal/decimal.dart';

final decimalGraphQLType = GraphQLScalarTypeValue<Decimal, String>(
  name: 'Decimal',
  deserialize: (_, serialized) => decimalFromJson(serialized)!,
  serialize: (value) => decimalToJson(value)!,
  validate: (key, input) => (input is num || input is String) &&
          Decimal.tryParse(input.toString()) != null
      ? ValidationResult.ok(input.toString())
      : ValidationResult.failure(
          ['Expected $key to be a number or a numeric String.'],
        ),
  description: 'A number that allows computation without losing precision.',
  specifiedByURL: null,
);

Decimal? decimalFromJson(Object? value) =>
    value == null ? null : Decimal.parse(value as String);

String? decimalToJson(Decimal? value) => value?.toString();
// @example-end{custom-scalar-decimal}
