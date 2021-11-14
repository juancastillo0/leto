import '../rules_prelude.dart';

const _variablesInAllowedPositionSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-All-Variable-Usages-are-Allowed',
  code: 'variablesInAllowedPosition',
);

/// Variables in allowed position
///
/// Variable usages must be compatible with the arguments they are passed to.
///
/// See https://spec.graphql.org/draft/#sec-All-Variable-Usages-are-Allowed
Visitor variablesInAllowedPositionRule(
  ValidationCtx context,
) {
  final visitor = TypedVisitor();
  var varDefMap = <String, VariableDefinitionNode>{};

  visitor.add<VariableDefinitionNode>((node) {
    varDefMap[node.variable.name.value] = node;
  });
  visitor.add<OperationDefinitionNode>((node) {
    varDefMap = {};
  }, leave: (operation) {
    final usages = context.getRecursiveVariableUsages(operation);

    for (final usage in usages) {
      final node = usage.node;
      final varName = node.name.value;
      final varDef = varDefMap[varName];
      if (varDef != null && usage.type != null) {
        // A var type is allowed if it is the same or more strict (e.g. is
        // a subtype of) than the expected type. It can be more strict if
        // the variable type is non-null when the expected type is nullable.
        // If both are list types, the variable item type can be more strict
        // than the expected item type (contravariant).
        final schema = context.schema;
        final varType = convertType(varDef.type, schema.typeMap);
        if (varType != null &&
            !allowedVariableUsage(
              schema,
              varType,
              varDef.defaultValue?.value,
              usage.type!,
              usage.defaultValue,
            )) {
          final varTypeStr = inspect(varType);
          final typeStr = inspect(usage.type!);
          context.reportError(
            GraphQLError(
              'Variable "\$${varName}" of type "${varTypeStr}" used'
              ' in position expecting type "${typeStr}".',
              locations: List.of(<Node?>[varDef, node, node.name]
                  .map((e) => e?.span == null
                      ? null
                      : GraphQLErrorLocation.fromSourceLocation(e!.span!.start))
                  .whereType<GraphQLErrorLocation>()),
              extensions: _variablesInAllowedPositionSpec.extensions(),
            ),
          );
        }
      }
    }
  });
  return visitor;
}

/// Returns true if the variable is allowed in the location it was found,
/// which includes considering if default values exist for either the variable
/// or the location at which it is located.
bool allowedVariableUsage(
  GraphQLSchema schema,
  GraphQLType varType,
  ValueNode? varDefaultValue,
  GraphQLType locationType,
  Object? locationDefaultValue,
) {
  if (locationType is GraphQLNonNullType && varType is! GraphQLNonNullType) {
    final hasNonNullVariableDefaultValue =
        varDefaultValue != null && varDefaultValue is! NullValueNode;
    final hasLocationDefaultValue = locationDefaultValue != null;
    if (!hasNonNullVariableDefaultValue && !hasLocationDefaultValue) {
      return false;
    }
    final nullableLocationType = locationType.ofType;
    return isTypeSubTypeOf(schema, varType, nullableLocationType);
  }
  return isTypeSubTypeOf(schema, varType, locationType);
}
