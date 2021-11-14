import '../rules_prelude.dart';

const _uniqueVariableNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Variable-Uniqueness',
  code: 'uniqueVariableNames',
);

/// Unique variable names
///
/// A GraphQL operation is only valid if all its variables are uniquely named.
/// 
/// See https://spec.graphql.org/draft/#sec-Variable-Uniqueness
Visitor uniqueVariableNamesRule(
  ValidationCtx context, // ASTValidationContext
) {
  return _Visitor(context);
}

class _Visitor extends SimpleVisitor<void> {
  final ValidationCtx context;

  _Visitor(this.context);

  @override
  void visitOperationDefinitionNode(OperationDefinitionNode operationNode) {
    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    final variableDefinitions = operationNode.variableDefinitions;

    final Map<String, List<VariableDefinitionNode>> seenVariableDefinitions =
        {};
    for (final e in variableDefinitions) {
      final l = seenVariableDefinitions.putIfAbsent(
        e.variable.name.value,
        () => [],
      );
      l.add(e);
    }

    for (final entry in seenVariableDefinitions.entries) {
      if (entry.value.length > 1) {
        context.reportError(
          GraphQLError(
            'There can be only one variable named "\$${entry.key}".',
            locations: entry.value
                .map((node) => GraphQLErrorLocation.fromSourceLocation(
                      node.variable.name.span!.start,
                    ))
                .toList(),
            extensions: _uniqueVariableNamesSpec.extensions(),
          ),
        );
      }
    }
  }
}
