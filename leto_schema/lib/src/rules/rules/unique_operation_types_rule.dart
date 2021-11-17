import '../rules_prelude.dart';

const _uniqueOperationTypesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Schema',
  code: 'uniqueOperationTypes',
);

/// Unique operation types
///
/// A GraphQL document is only valid if it has only one type per operation.
///
/// See https://spec.graphql.org/draft/#sec-Schema
Visitor uniqueOperationTypesRule(
  SDLValidationCtx context,
) {
  final schema = context.schema;
  final definedOperationTypes = <OperationType, OperationTypeDefinitionNode>{};
  final Map<OperationType, Object?> existingOperationTypes = schema != null
      ? {
          OperationType.query: schema.queryType,
          OperationType.mutation: schema.mutationType,
          OperationType.subscription: schema.subscriptionType,
        }
      : {};

  VisitBehavior? checkOperationTypes(
    List<OperationTypeDefinitionNode> operationTypes,
  ) {
    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    final operationTypesNodes = operationTypes;

    for (final operationType in operationTypesNodes) {
      final operation = operationType.operation;
      final alreadyDefinedOperationType = definedOperationTypes[operation];
      final operationTypeName = operation.toString().split('.').last;

      if (existingOperationTypes[operation] != null) {
        context.reportError(
          GraphQLError(
            'Type for $operationTypeName already defined in the schema.'
            ' It cannot be redefined.',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(
                (operationType.span ?? operationType.type.name.span)!.start,
              ),
            ],
            extensions: _uniqueOperationTypesSpec.extensions(),
          ),
        );
      } else if (alreadyDefinedOperationType != null) {
        context.reportError(
          GraphQLError(
            'There can be only one $operationTypeName type in schema.',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(
                (alreadyDefinedOperationType.span ??
                        alreadyDefinedOperationType.type.name.span)!
                    .start,
              ),
              GraphQLErrorLocation.fromSourceLocation(
                (operationType.span ?? operationType.type.name.span)!.start,
              ),
            ],
            extensions: _uniqueOperationTypesSpec.extensions(),
          ),
        );
      } else {
        definedOperationTypes[operation] = operationType;
      }
    }

    return VisitBehavior.skipTree;
  }

  final visitor = TypedVisitor();
  visitor.add<SchemaDefinitionNode>(
    (node) => checkOperationTypes(node.operationTypes),
  );
  visitor.add<SchemaExtensionNode>(
    (node) => checkOperationTypes(node.operationTypes),
  );
  return visitor;
}
