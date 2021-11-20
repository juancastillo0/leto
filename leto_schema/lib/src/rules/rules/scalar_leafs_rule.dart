import '../rules_prelude.dart';

const _scalarLeafsSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Leaf-Field-Selections',
  code: 'scalarLeafs',
);

/// Scalar leafs
///
/// A GraphQL document is valid only if all leaf fields (fields without
/// sub selections) are of scalar or enum types.
///
/// See https://spec.graphql.org/draft/#sec-Leaf-Field-Selections
Visitor scalarLeafsRule(ValidationCtx context) {
  final visitor = TypedVisitor();
  final typeInfo = context.typeInfo;

  visitor.add<FieldNode>((node) {
    final type = typeInfo.getType();
    final selectionSet = node.selectionSet;
    if (type != null) {
      if (isLeafType(getNamedType(type))) {
        if (selectionSet != null) {
          final fieldName = node.name.value;
          final typeStr = inspect(type);
          context.reportError(
            GraphQLError(
              'Field "${fieldName}" must not have a selection since'
              ' type "${typeStr}" has no subfields.',
              locations: GraphQLErrorLocation.firstFromNodes([node, node.name]),
              extensions: _scalarLeafsSpec.extensions(),
            ),
          );
        }
      } else if (selectionSet == null) {
        final fieldName = node.name.value;
        final typeStr = inspect(type);
        context.reportError(
          GraphQLError(
            'Field "${fieldName}" of type "${typeStr}" must have a selection'
            ' of subfields. Did you mean "${fieldName} { ... }"?',
            locations: GraphQLErrorLocation.firstFromNodes([node, node.name]),
            extensions: _scalarLeafsSpec.extensions(),
          ),
        );
      }
    }
  });

  return visitor;
}
