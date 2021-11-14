import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/utilities/predicates.dart';
import 'package:leto_schema/validate.dart';

/// Unique directive names per location
///
/// A GraphQL document is only valid if all non-repeatable directives at
/// a given location are uniquely named.
///
/// See https://spec.graphql.org/draft/#sec-Directives-Are-Unique-Per-Location
Visitor uniqueDirectivesPerLocationRule(
  ValidationCtx context // SDLValidationContext,
) {
  final visitor = TypedVisitor();
  final uniqueDirectiveMap = {};

  final schema = context.schema;
  final definedDirectives = schema != null
    ? schema.directives
    : GraphQLDirective.specifiedDirectives;
  for (final directive in definedDirectives) {
    uniqueDirectiveMap[directive.name] = !directive.isRepeatable;
  }

  final astDefinitions = context.document.definitions.whereType<DirectiveDefinitionNode>();
  for (final def in astDefinitions) {
      uniqueDirectiveMap[def.name.value] = !def.repeatable;
    
  }

  final schemaDirectives = <String, Map<String, Object?>>{};
  final typeDirectivesMap = <String, Map<String, Object?>>{};

  visitor.add<Node>(
    // Many different AST nodes may contain directives. Rather than listing
    // them all, just listen for entering any node, and check to see if it
    // defines any directives.
    (node) {
      if (!('directives' in node) || !node.directives) {
        return;
      }

      var seenDirectives;
      if (
        node.kind == Kind.SCHEMA_DEFINITION ||
        node.kind == Kind.SCHEMA_EXTENSION
      ) {

        seenDirectives = schemaDirectives;
      } else if (isTypeDefinitionNode(node) || isTypeExtensionNode(node)) {
        final typeName = node.name.value;
        seenDirectives = typeDirectivesMap[typeName];
        if (seenDirectives == null) {
          typeDirectivesMap[typeName] = seenDirectives = {};
        }
      } else {
        seenDirectives = {};
      }

      for (final directive in node.directives) {
        final directiveName = directive.name.value;

        if (uniqueDirectiveMap[directiveName] != null) {
          if (seenDirectives[directiveName] != null) {
            context.reportError(
               GraphQLError(
                'The directive "@${directiveName}" can only be used once at this location.',
                [seenDirectives[directiveName], directive],
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