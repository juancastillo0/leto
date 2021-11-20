import '../rules_prelude.dart';

const _uniqueTypeNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Schema',
  code: 'uniqueTypeNames',
);

/// Unique type names
///
/// A GraphQL document is only valid if all defined types have unique names.
///
/// See https://spec.graphql.org/draft/#sec-Schema
Visitor uniqueTypeNamesRule(SDLValidationCtx context) {
  final knownTypeNames = <String, NameNode>{};
  final schema = context.schema;

  VisitBehavior? checkTypeName(TypeDefinitionNode node) {
    final typeName = node.name.value;

    if (schema?.getType(typeName) != null) {
      context.reportError(
        GraphQLError(
          'Type "${typeName}" already exists in the schema.'
          ' It cannot also be defined in this type definition.',
          locations: [
            GraphQLErrorLocation.fromSourceLocation(
              node.name.span!.start,
            ),
          ],
          extensions: _uniqueTypeNamesSpec.extensions(),
        ),
      );
      return null;
    }

    if (knownTypeNames[typeName] != null) {
      context.reportError(
        GraphQLError(
          'There can be only one type named "${typeName}".',
          locations: [
            GraphQLErrorLocation.fromSourceLocation(
              knownTypeNames[typeName]!.span!.start,
            ),
            GraphQLErrorLocation.fromSourceLocation(
              node.name.span!.start,
            ),
          ],
          extensions: _uniqueTypeNamesSpec.extensions(),
        ),
      );
    } else {
      knownTypeNames[typeName] = node.name;
    }

    return VisitBehavior.skipTree;
  }

  final visitor = TypedVisitor();

  visitor.add<ScalarTypeDefinitionNode>(checkTypeName);
  visitor.add<ObjectTypeDefinitionNode>(checkTypeName);
  visitor.add<InterfaceTypeDefinitionNode>(checkTypeName);
  visitor.add<UnionTypeDefinitionNode>(checkTypeName);
  visitor.add<EnumTypeDefinitionNode>(checkTypeName);
  visitor.add<InputObjectTypeDefinitionNode>(checkTypeName);

  return visitor;
}
