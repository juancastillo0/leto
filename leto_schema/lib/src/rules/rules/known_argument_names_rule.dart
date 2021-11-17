import '../rules_prelude.dart';

const _knownArgumentNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Argument-Names',
  code: 'knownArgumentNames',
);

const _knownArgumentNamesOnDirectivesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Directives-Are-In-Valid-Locations',
  code: 'knownArgumentNamesOnDirectives',
);

/// Known argument names
///
/// A GraphQL field is only valid if all supplied arguments are defined by
/// that field.
///
/// See https://spec.graphql.org/draft/#sec-Argument-Names
/// See https://spec.graphql.org/draft/#sec-Directives-Are-In-Valid-Locations
Visitor knownArgumentNamesRule(ValidationCtx context) {
  final typeInfo = context.typeInfo;
  final visitor = TypedVisitor();

  visitor.mergeInPlace(knownArgumentNamesOnDirectivesRule(context));
  visitor.add<ArgumentNode>((argNode) {
    final argDef = typeInfo.getArgument();
    final fieldDef = typeInfo.getFieldDef();
    final parentType = typeInfo.getParentType();

    if (argDef == null && fieldDef != null && parentType != null) {
      final argName = argNode.name.value;
      final knownArgsNames = fieldDef.inputs.map((arg) => arg.name);
      // final suggestions = suggestionList(argName, knownArgsNames);
      context.reportError(
        GraphQLError(
          'Unknown argument "${argName}" on field "${parentType.name}.${fieldDef.name}".'
          // +    didYouMean(suggestions)
          ,
          locations: GraphQLErrorLocation.firstFromNodes(
            [argNode, argNode.name],
          ),
          extensions: _knownArgumentNamesSpec.extensions(),
        ),
      );
    }
  });
  return visitor;
}

/**
 * @internal
 */
TypedVisitor knownArgumentNamesOnDirectivesRule(
  SDLValidationCtx context,
) {
  final visitor = TypedVisitor();
  final directiveArgs = <String, Set<String>>{};

  final schema = context.schema;
  final definedDirectives =
      schema != null ? schema.directives : GraphQLDirective.specifiedDirectives;
  for (final directive in definedDirectives) {
    directiveArgs[directive.name] =
        directive.inputs.map((arg) => arg.name).toSet();
  }

  final astDefinitions =
      context.document.definitions.whereType<DirectiveDefinitionNode>();
  for (final def in astDefinitions) {
    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    final argsNodes = def.args;

    directiveArgs[def.name.value] =
        argsNodes.map((arg) => arg.name.value).toSet();
  }

  visitor.add<DirectiveNode>((directiveNode) {
    final directiveName = directiveNode.name.value;
    final knownArgs = directiveArgs[directiveName];

    if (knownArgs != null) {
      for (final argNode in directiveNode.arguments) {
        final argName = argNode.name.value;
        if (!knownArgs.contains(argName)) {
          // final suggestions = suggestionList(argName, knownArgs);
          context.reportError(
            GraphQLError(
              'Unknown argument "${argName}" on directive "@${directiveName}".'
              //  + didYouMean(suggestions)
              ,
              locations: GraphQLErrorLocation.firstFromNodes(
                [argNode, argNode.name],
              ),
              extensions: _knownArgumentNamesOnDirectivesSpec.extensions(),
            ),
          );
        }
      }
    }

    return VisitBehavior.skipTree;
  });
  return visitor;
}
