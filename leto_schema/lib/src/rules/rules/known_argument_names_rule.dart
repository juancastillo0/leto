import 'package:gql/ast.dart' hide DirectiveLocation;
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/utilities/predicates.dart';
import 'package:leto_schema/validate.dart';

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

  // eslint-disable-next-line new-cap
  // ...KnownArgumentNamesOnDirectivesRule(context),
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
          argNode,
        ),
      );
    }
  });
  return visitor;
}

/**
 * @internal
 */
Visitor knownArgumentNamesOnDirectivesRule(
    ValidationCtx context // SDLValidationContext
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
    final argsNodes = def.args ?? [];

    directiveArgs[def.name.value] =
        argsNodes.map((arg) => arg.name.value).toSet();
  }

  visitor.add<DirectiveNode>((directiveNode) {
    final directiveName = directiveNode.name.value;
    final knownArgs = directiveArgs[directiveName];

    if (directiveNode.arguments != null && knownArgs != null) {
      for (final argNode in directiveNode.arguments) {
        final argName = argNode.name.value;
        if (!knownArgs.contains(argName)) {
          // final suggestions = suggestionList(argName, knownArgs);
          context.reportError(
            GraphQLError(
              'Unknown argument "${argName}" on directive "@${directiveName}".'
              //  + didYouMean(suggestions)
              ,
              argNode,
            ),
          );
        }
      }
    }

    return false;
  });
  return visitor;
}
