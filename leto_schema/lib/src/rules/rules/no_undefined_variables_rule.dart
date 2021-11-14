import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/utilities/predicates.dart';
import 'package:leto_schema/validate.dart';

/// No undefined variables
///
/// A GraphQL operation is only valid if all variables encountered, both directly
/// and via fragment spreads, are defined by that operation.
///
/// See https://spec.graphql.org/draft/#sec-All-Variable-Uses-Defined
Visitor noUndefinedVariablesRule(
  ValidationCtx context,
) {
  var variableNameDefined = <String, bool>{};
  final visitor = TypedVisitor();

  visitor.add<VariableDefinitionNode>((node) {
    variableNameDefined[node.variable.name.value] = true;
  });
  visitor.add<OperationDefinitionNode>(
    (node) {
      variableNameDefined = {};
    },
    leave: (operation) {
      final usages = context.getRecursiveVariableUsages(operation);

      for (final node in usages) {
        final varName = node.name.value;
        if (variableNameDefined[varName] != true) {
          context.reportError(
            GraphQLError(
              operation.name != null
                  ? 'Variable "\$${varName}" is not defined by operation "${operation.name.value}".'
                  : 'Variable "\$${varName}" is not defined.',
              [node, operation],
            ),
          );
        }
      }
    },
  );

  return visitor;
}
