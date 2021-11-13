import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/rules/validate.dart';
import 'package:leto_schema/src/utilities/collect_fields.dart';

/// Subscriptions must only include a non-introspection field.
///
/// A GraphQL subscription is valid only if it contains a single root field and
/// that root field is not an introspection field.
///
/// See https://spec.graphql.org/draft/#sec-Single-root-field
Visitor singleFieldSubscriptionsRule(ValidationCtx context) {
  final visitor = TypedVisitor();
  visitor.add<OperationDefinitionNode>((node) {
    if (node.type == OperationType.subscription) {
      final schema = context.schema;
      final subscriptionType = schema.subscriptionType;
      if (subscriptionType != null) {
        final operationName = node.name?.value;
        final variableValues = <String, Object?>{};
        final document = context.document;
        final fields = collectFields(
          schema,
          fragmentsFromDocument(document),
          subscriptionType,
          node.selectionSet,
          variableValues,
        );
        if (fields.length > 1) {
          final extraFieldSelections = [
            ...fields.values.skip(1).expand((e) => e)
          ];
          context.reportError(
            GraphQLError(
              operationName != null
                  ? 'Subscription "$operationName" must select only one top level field.'
                  : 'Anonymous Subscription must select only one top level field.',
              locations: locationsFromFields(extraFieldSelections),
            ),
          );
        }
        for (final fieldNodes in fields.values) {
          final field = fieldNodes[0];
          final fieldName = field.name.value;
          if (fieldName.startsWith('__')) {
            context.reportError(
              GraphQLError(
                operationName != null
                    ? 'Subscription "${operationName}" must not select an introspection top level field.'
                    : 'Anonymous Subscription must not select an introspection top level field.',
                locations: locationsFromFields(fieldNodes),
              ),
            );
          }
        }
      }
    }
  });

  return visitor;
}

List<GraphQLErrorLocation> locationsFromFields(List<FieldNode> fieldNodes) {
  return List.of(
    fieldNodes.map(
      (e) => GraphQLErrorLocation.fromSourceLocation(
        (e.span ?? e.name.span)!.start,
      ),
    ),
  );
}
