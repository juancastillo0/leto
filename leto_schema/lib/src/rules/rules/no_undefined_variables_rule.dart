import '../rules_prelude.dart';

const _noUndefinedVariablesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-All-Variable-Uses-Defined',
  code: 'noUndefinedVariables',
);

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

      for (final usage in usages) {
        final node = usage.node;
        final varName = node.name.value;
        if (variableNameDefined[varName] != true) {
          context.reportError(
            GraphQLError(
              operation.name != null
                  ? 'Variable "\$${varName}" is not defined by operation "${operation.name!.value}".'
                  : 'Variable "\$${varName}" is not defined.',
              locations: [
                ...GraphQLErrorLocation.firstFromNodes([node, node.name]),
                ...GraphQLErrorLocation.firstFromNodes(
                    [operation, operation.name])
              ],
              extensions: _noUndefinedVariablesSpec.extensions(),
            ),
          );
        }
      }
    },
  );

  return visitor;
}
