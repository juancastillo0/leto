import '../rules_prelude.dart';

const _loneSchemaDefinitionSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Schema',
  code: 'loneSchemaDefinition',
);

/// Lone Schema definition
///
/// A GraphQL document is only valid if it contains only one schema definition.
///
/// See https://spec.graphql.org/draft/#sec-Schema
Visitor loneSchemaDefinitionRule(
  SDLValidationCtx context,
) {
  final oldSchema = context.schema;
  final Object? alreadyDefined = oldSchema?.astNode ??
      oldSchema?.queryType ??
      oldSchema?.mutationType ??
      oldSchema?.subscriptionType;

  int schemaDefinitionsCount = 0;
  final visitor = TypedVisitor();
  visitor.add<SchemaDefinitionNode>((node) {
    if (alreadyDefined != null) {
      context.reportError(
        GraphQLError(
          'Cannot define a new schema within a schema extension.',
          locations: GraphQLErrorLocation.firstFromNodes([
            node,
            // TODO:
            node.operationTypes.firstOrNull?.type.name,
          ]),
          extensions: _loneSchemaDefinitionSpec.extensions(),
        ),
      );
      return;
    }

    if (schemaDefinitionsCount > 0) {
      context.reportError(
        GraphQLError(
          'Must provide only one schema definition.',
          locations: GraphQLErrorLocation.firstFromNodes([
            node,
            // TODO:
            node.operationTypes.firstOrNull?.type.name
          ]),
          extensions: _loneSchemaDefinitionSpec.extensions(),
        ),
      );
    }
    schemaDefinitionsCount++;
  });
  return visitor;
}
