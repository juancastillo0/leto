import '../rules_prelude.dart';

const _uniqueDirectiveNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Schema',
  code: 'uniqueDirectiveNames',
);

/// Unique directive names
///
/// A GraphQL document is only valid if all defined directives
/// have unique names.
///
/// See https://spec.graphql.org/draft/#sec-Schema
Visitor uniqueDirectiveNamesRule(
  SDLValidationCtx context,
) {
  final knownDirectiveNames = <String, NameNode>{};
  final schema = context.schema;

  return TypedVisitor()
    ..add<DirectiveDefinitionNode>((node) {
      final directiveName = node.name.value;

      if (schema?.getDirective(directiveName) != null) {
        context.reportError(
          GraphQLError(
            'Directive "@${directiveName}" already exists in the schema.'
            ' It cannot be redefined.',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(node.name.span!.start),
            ],
            extensions: _uniqueDirectiveNamesSpec.extensions(),
          ),
        );
        return null;
      }

      final previous = knownDirectiveNames[directiveName];
      if (previous != null) {
        context.reportError(
          GraphQLError(
            'There can be only one directive named "@${directiveName}".',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(previous.span!.start),
              GraphQLErrorLocation.fromSourceLocation(node.name.span!.start),
            ],
            extensions: _uniqueDirectiveNamesSpec.extensions(),
          ),
        );
      } else {
        knownDirectiveNames[directiveName] = node.name;
      }

      return VisitBehavior.skipTree;
    });
}
