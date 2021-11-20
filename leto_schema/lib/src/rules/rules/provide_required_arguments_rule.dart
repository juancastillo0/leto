import 'package:gql/language.dart' show printNode;

import '../rules_prelude.dart';

const _providedRequiredArgumentsSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Required-Arguments',
  code: 'providedRequiredArguments',
);

const _providedRequiredArgumentsOnDirectivesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Required-Arguments',
  code: 'providedRequiredArgumentsOnDirectives',
);

/// Provided required arguments
///
/// A field or directive is only valid if all required (non-null without a
/// default value) field arguments have been provided.
///
/// See https://spec.graphql.org/draft/#sec-Required-Arguments
Visitor providedRequiredArgumentsRule(
  ValidationCtx context,
) {
  final visitor = TypedVisitor();
  // eslint-disable-next-line new-cap
  visitor.mergeInPlace(providedRequiredArgumentsOnDirectivesRule(context));
  visitor.add<FieldNode>((_) {},
      // Validate on leave to allow for deeper errors to appear first.
      leave: (fieldNode) {
    final fieldDef = context.typeInfo.getFieldDef();
    if (fieldDef == null) {
      return VisitBehavior.skipTree;
    }

    final providedArgs =
        // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
        fieldNode.arguments.map((arg) => arg.name.value).toSet();
    for (final argDef in fieldDef.inputs) {
      if (!providedArgs.contains(argDef.name) && argDef.isRequired) {
        final argTypeStr = inspect(argDef.type);
        context.reportError(
          GraphQLError(
            'Field "${fieldDef.name}" argument "${argDef.name}" of type "${argTypeStr}" is required, but it was not provided.',
            locations: GraphQLErrorLocation.firstFromNodes(
                [fieldNode, fieldNode.name]),
            extensions: _providedRequiredArgumentsSpec.extensions(),
          ),
        );
      }
    }
  });

  return visitor;
}

/// @internal
TypedVisitor providedRequiredArgumentsOnDirectivesRule(
  SDLValidationCtx context,
) {
  final visitor = TypedVisitor();
  final requiredArgsMap = <String, Map<String, Object>>{};

  final schema = context.schema;
  final definedDirectives =
      schema?.directives ?? GraphQLDirective.specifiedDirectives;
  for (final directive in definedDirectives) {
    requiredArgsMap[directive.name] =
        directive.inputs.where((arg) => arg.isRequired).groupFoldBy(
              (element) => element.name,
              (previous, element) => previous ?? element,
            );
  }

  final astDefinitions =
      context.document.definitions.whereType<DirectiveDefinitionNode>();
  for (final def in astDefinitions) {
    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    final argNodes = def.args;

    requiredArgsMap[def.name.value] = argNodes
        .where(_isRequiredArgumentNode)
        .groupFoldBy((a) => a.name.value, (p, e) => p ?? e);
  }

  visitor.add<DirectiveNode>((_) {},
      // Validate on leave to allow for deeper errors to appear first.
      leave: (directiveNode) {
    final directiveName = directiveNode.name.value;
    final requiredArgs = requiredArgsMap[directiveName];
    if (requiredArgs != null) {
      // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
      final argNodes = directiveNode.arguments;
      final argNodeMap = argNodes.map((arg) => arg.name.value).toSet();
      for (final entry in requiredArgs.entries) {
        if (!argNodeMap.contains(entry.key)) {
          final arg = entry.value;
          final argType = arg is GraphQLFieldInput
              ? inspect(arg.type)
              : printNode((arg as InputValueDefinitionNode).type);
          context.reportError(
            GraphQLError(
              'Directive "@${directiveName}" argument "${entry.key}" of'
              ' type "${argType}" is required, but it was not provided.',
              locations: GraphQLErrorLocation.firstFromNodes(
                  [directiveNode, directiveNode.name]),
              extensions:
                  _providedRequiredArgumentsOnDirectivesSpec.extensions(),
            ),
          );
        }
      }
    }
  });
  return visitor;
}

bool _isRequiredArgumentNode(InputValueDefinitionNode arg) {
  return arg.type.isNonNull && arg.defaultValue == null;
}
