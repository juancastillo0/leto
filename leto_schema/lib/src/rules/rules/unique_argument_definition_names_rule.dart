import '../rules_prelude.dart';

const _uniqueArgumentDefinitionNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Argument-Uniqueness',
  code: 'uniqueArgumentDefinitionNames',
);

/// Unique argument definition names
///
/// A GraphQL Object or Interface type is only valid if all its fields have uniquely named arguments.
/// A GraphQL Directive is only valid if all its arguments are uniquely named.
///
/// See https://spec.graphql.org/draft/#sec-Argument-Uniqueness
Visitor uniqueArgumentDefinitionNamesRule(
  SDLValidationCtx context,
) {
  VisitBehavior? checkArgUniqueness(
    String parentName,
    List<InputValueDefinitionNode> argumentNodes,
  ) {
    final seenArgs = argumentNodes.groupListsBy((arg) => arg.name.value);

    for (final e in seenArgs.entries) {
      final argNodes = e.value;
      if (argNodes.length > 1) {
        context.reportError(
          GraphQLError(
            'Argument "${parentName}(${e.key}:)" can only be defined once.',
            locations: argNodes
                .map((node) => GraphQLErrorLocation.fromSourceLocation(
                      node.name.span!.start,
                    ))
                .toList(),
            extensions: _uniqueArgumentDefinitionNamesSpec.extensions(),
          ),
        );
      }
    }

    return VisitBehavior.skipTree;
  }

  VisitBehavior? checkArgUniquenessPerField({
    required NameNode name,
    List<FieldDefinitionNode>? fields,
  }) {
    final typeName = name.value;

    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    final fieldNodes = fields ?? [];

    for (final fieldDef in fieldNodes) {
      final fieldName = fieldDef.name.value;

      // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
      final argumentNodes = fieldDef.args;

      checkArgUniqueness('${typeName}.${fieldName}', argumentNodes);
    }

    return VisitBehavior.skipTree;
  }

  final visitor = TypedVisitor();
  visitor.add<DirectiveDefinitionNode>((directiveNode) {
    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    final argumentNodes = directiveNode.args;

    return checkArgUniqueness('@${directiveNode.name.value}', argumentNodes);
  });
  visitor.add<InterfaceTypeDefinitionNode>((node) =>
      checkArgUniquenessPerField(name: node.name, fields: node.fields));
  visitor.add<InterfaceTypeExtensionNode>((node) =>
      checkArgUniquenessPerField(name: node.name, fields: node.fields));
  visitor.add<ObjectTypeDefinitionNode>((node) =>
      checkArgUniquenessPerField(name: node.name, fields: node.fields));
  visitor.add<ObjectTypeExtensionNode>((node) =>
      checkArgUniquenessPerField(name: node.name, fields: node.fields));

  return visitor;
}
