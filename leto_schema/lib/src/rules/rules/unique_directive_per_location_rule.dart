import '../rules_prelude.dart';

const _uniqueDirectivesPerLocationSpec = ErrorSpec(
  spec:
      'https://spec.graphql.org/draft/#sec-Directives-Are-Unique-Per-Location',
  code: 'uniqueDirectivesPerLocation',
);

/// Unique directive names per location
///
/// A GraphQL document is only valid if all non-repeatable directives at
/// a given location are uniquely named.
///
/// See https://spec.graphql.org/draft/#sec-Directives-Are-Unique-Per-Location
Visitor uniqueDirectivesPerLocationRule(
  ValidationCtx context, // SDLValidationContext,
) {
  final visitor = TypedVisitor();
  final uniqueDirectiveMap = <String, bool>{};

  final schema = context.schema;
  final definedDirectives =
      schema != null ? schema.directives : GraphQLDirective.specifiedDirectives;
  for (final directive in definedDirectives) {
    uniqueDirectiveMap[directive.name] = !directive.isRepeatable;
  }

  final astDefinitions =
      context.document.definitions.whereType<DirectiveDefinitionNode>();
  for (final def in astDefinitions) {
    uniqueDirectiveMap[def.name.value] = !def.repeatable;
  }

  final schemaDirectives = <String, DirectiveNode>{};
  final typeDirectivesMap = <String, Map<String, DirectiveNode>>{};

  visitor.add<Node>(
      // Many different AST nodes may contain directives. Rather than listing
      // them all, just listen for entering any node, and check to see if it
      // defines any directives.
      (node) {
    List<DirectiveNode>? directives;
    try {
      directives = (node as dynamic).directives as List<DirectiveNode>;
    } catch (_) {}
    if (directives == null) {
      return;
    }

    Map<String, DirectiveNode>? seenDirectives;
    if (node is SchemaDefinitionNode || node is SchemaExtensionNode) {
      seenDirectives = schemaDirectives;
    } else if (node is TypeDefinitionNode || node is TypeExtensionNode) {
      final typeName = (node is TypeDefinitionNode
              ? node.name
              : (node as TypeExtensionNode).name)
          .value;
      seenDirectives = typeDirectivesMap[typeName];
      if (seenDirectives == null) {
        typeDirectivesMap[typeName] = seenDirectives = {};
      }
    } else {
      seenDirectives = {};
    }

    for (final directive in directives) {
      final directiveName = directive.name.value;

      if (uniqueDirectiveMap[directiveName] != null) {
        if (seenDirectives[directiveName] != null) {
          context.reportError(
            GraphQLError(
              'The directive "@${directiveName}" can only be used once at this location.',
              locations: List.of(
                [
                  seenDirectives[directiveName],
                  seenDirectives[directiveName]?.name,
                  directive,
                  directive.name
                ]
                    .map(
                      (e) => e?.span?.start == null
                          ? null
                          : GraphQLErrorLocation.fromSourceLocation(
                              e!.span!.start),
                    )
                    .whereType(),
              ),
              extensions: _uniqueDirectivesPerLocationSpec.extensions(),
            ),
          );
        } else {
          seenDirectives[directiveName] = directive;
        }
      }
    }
  });
  return visitor;
}
