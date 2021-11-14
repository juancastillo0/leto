import 'package:gql/ast.dart' hide DirectiveLocation;
import 'package:leto_schema/leto_schema.dart' ;
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/utilities/predicates.dart';
import 'package:leto_schema/validate.dart';

/// Provided required arguments
///
/// A field or directive is only valid if all required (non-null without a
/// default value) field arguments have been provided.
Visitor providedRequiredArgumentsRule(
  ValidationCtx context,
) {
  final visitor = TypedVisitor();
    // eslint-disable-next-line new-cap
    // ...ProvidedRequiredArgumentsOnDirectivesRule(context),
    visitor.add<FieldNode>((_) {},
      // Validate on leave to allow for deeper errors to appear first.
      leave: (fieldNode) {
        final fieldDef = context.typeInfo.getFieldDef();
        if (fieldDef == null) {
          return false;
        }

        final providedArgs = 
          // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
          fieldNode.arguments.map((arg) => arg.name.value).toSet()
        ;
        for (final argDef in fieldDef.inputs) {
          if (!providedArgs.contains(argDef.name) && isRequiredArgument(argDef)) {
            final argTypeStr = inspect(argDef.type);
            context.reportError(
               GraphQLError(
                'Field "${fieldDef.name}" argument "${argDef.name}" of type "${argTypeStr}" is required, but it was not provided.',
                fieldNode,
              ),
            );
          }
        }
      });

      return visitor;
}

/// @internal
Visitor providedRequiredArgumentsOnDirectivesRule(
  ValidationCtx context // SDLValidationContext,
) {
  final visitor = TypedVisitor();
  final requiredArgsMap = <String, Map<String, GraphQLArgument | InputValueDefinitionNode>>{};

  final schema = context.schema;
  final definedDirectives = schema?.directives ?? GraphQLDirective.specifiedDirectives;
  for (final directive in definedDirectives) {
    requiredArgsMap[directive.name] = keyMap(
      directive.args.filter(isRequiredArgument),
      (arg) => arg.name,
    );
  }

  final astDefinitions = context.document.definitions.whereType<DirectiveDefinitionNode>();
  for (final def in astDefinitions) {
    
      // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
      final argNodes = def.args ?? [];

      requiredArgsMap[def.name.value] = keyMap(
        argNodes.filter(isRequiredArgumentNode),
        (arg) => arg.name.value,
      );
    
  }

  visitor.add<DirectiveNode>((_){},
      // Validate on leave to allow for deeper errors to appear first.
      leave: (directiveNode) {
        final directiveName = directiveNode.name.value;
        final requiredArgs = requiredArgsMap[directiveName];
        if (requiredArgs != null) {
          // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
          final argNodes = directiveNode.arguments ?? [];
          final argNodeMap = argNodes.map((arg) => arg.name.value).toSet();
          for (final entry in requiredArgs.entries) {
            if (!argNodeMap.contains(entry.key)) {
              final argType = isType(entry.value.type)
                ? inspect(entry.value.type)
                : print(entry.value.type);
              context.reportError(
               GraphQLError(
                  'Directive "@${directiveName}" argument "${entry.key}" of type "${argType}" is required, but it was not provided.',
                  directiveNode,
                ),
              );
            }
          }
        }
      });
      return visitor;
}

bool isRequiredArgumentNode(InputValueDefinitionNode arg) {
  return arg.type.isNonNull && arg.defaultValue == null;
}