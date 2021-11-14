import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/utilities/predicates.dart';
import 'package:leto_schema/validate.dart';

/// No unused variables
///
/// A GraphQL operation is only valid if all variables defined by an operation
/// are used, either directly or within a spread fragment.
///
/// See https://spec.graphql.org/draft/#sec-All-Variables-Used
Visitor noUnusedVariablesRule(ValidationCtx context) {
  final visitor = TypedVisitor();
  var variableDefs = <VariableDefinitionNode>[];

  visitor.add<VariableDefinitionNode>((def) {
    variableDefs.add(def);
  });
  visitor.add<OperationDefinitionNode>(
    (node) {
      variableDefs = [];
    },
    leave: (operation) {
      final variableNameUsed = <String, bool>{};
      final usages = context.getRecursiveVariableUsages(operation);

      for (final node in usages) {
        variableNameUsed[node.name.value] = true;
      }

      for (final variableDef in variableDefs) {
        final variableName = variableDef.variable.name.value;
        if (variableNameUsed[variableName] != true) {
          context.reportError(
            GraphQLError(
              operation.name != null
                  ? 'Variable "\$${variableName}" is never used in operation "${operation.name!.value}".'
                  : 'Variable "\$${variableName}" is never used.',
              variableDef,
            ),
          );
        }
      }
    },
  );

  return visitor;
}
