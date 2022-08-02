import 'package:gql/ast.dart' hide DirectiveLocation;
import 'package:gql/language.dart' as gql;
import 'package:leto_schema/src/schema.dart';
import 'package:leto_schema/src/validate/validate.dart';
import 'package:leto_schema/src/validate/validate_schema.dart';

/// Specifies that a given Object can be identified by the fields
/// passed as argument to the directive
///
/// It is repeatable, there can be multiple keys per Object.
///
/// The following example shows an Object that can be identified by two keys,
/// the "id" field and the combination "type" and "nested.value" fields.
/// ```graphql
/// type Model @key(fields: "id") @key(fields: "type nested { value } ") {
///   id: String!
///   type: String!
///   nested {
///     value: int!
///   }
/// }
/// ```
final graphQLKeyDirective = GraphQLDirective(
  name: 'key',
  description: 'Specifies that a given object can be identified by the fields'
      ' passed as argument to the directive.',
  locations: [DirectiveLocation.OBJECT],
  isRepeatable: true,
  inputs: [
    GraphQLFieldInput<String, String>(
      'fields',
      graphQLString.nonNull(),
      description: 'The fields which, when combined, form a'
          ' global key for the annotated GraphQLObject.',
    ),
  ],
);

/// An attachment for [graphQLKeyDirective] that specifies that a given
/// object can be identified by the fields passed as argument
/// to the directive.

class KeyAttachment implements ToDirectiveValue, AttachmentWithValidation {
  /// The fields which, when combined, form a global key
  /// for the annotated GraphQLObject.
  final String fields;

  /// An attachment for [graphQLKeyDirective] that specifies that a given
  /// object can be identified by the fields passed as argument
  /// to the directive.
  const KeyAttachment(this.fields);

  @override
  DirectiveNode get directiveValue {
    return DirectiveNode(
      name: const NameNode(value: 'key'),
      arguments: [
        ArgumentNode(
          name: const NameNode(value: 'fields'),
          value: StringValueNode(
            value: fields,
            isBlock: false,
          ),
        ),
      ],
    );
  }

  @override
  GraphQLDirective get directiveDefinition => graphQLKeyDirective;

  @override
  void validateElement(
    SchemaValidationContext context,
    GraphQLElement element,
  ) {
    if (element is! GraphQLObjectType) {
      context.reportError(
        'KeyAttachment should only be used in $GraphQLObjectType.'
        ' Was used in $element.',
        [],
      );
    }
    try {
      final document =
          gql.parseString('fragment F on ${element.name} {$fields}');

      final errors = validateDocument(context.schema, document);
      for (final e in errors
          .where((error) => error.message != 'Fragment "F" is never used.')) {
        context.reportError(
          'KeyAttachment(fields: "$fields") error for'
          ' element ${element.name}. ${e.message}',
          [],
        );
      }
    } catch (_) {
      context.reportError(
        'KeyAttachment.fields should be a selection'
        ' set of the annotated Object. Found $fields'
        ' for element ${element.name}.',
        [],
      );
    }
  }

  @override
  String toString() {
    return 'KeyAttachment(fields: $fields)';
  }
}
