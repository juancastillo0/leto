import '../rules_prelude.dart';

const _noFragmentCyclesSpec = ErrorSpec(
  spec:
      'https://spec.graphql.org/draft/#sec-Fragment-spreads-must-not-form-cycles',
  code: 'noFragmentCycles',
);

/// No fragment cycles
///
/// The graph of fragment spreads must not form
/// any cycles including spreading itself.
/// Otherwise an operation could infinitely spread or
/// infinitely execute on cycles in the underlying data.
///
/// See https://spec.graphql.org/draft/#sec-Fragment-spreads-must-not-form-cycles
Visitor noFragmentCyclesRule(
  ValidationCtx context, //: ASTValidationContext,
) {
  // Tracks already visited fragments to maintain O(N) and to ensure that cycles
  // are not redundantly reported.
  final visitedFrags = <String>{};

  // Array of AST nodes used to produce meaningful errors
  final spreadPath = <FragmentSpreadNode>[];

  // Position in the spread path
  final spreadPathIndexByName = <String, int?>{};

  // This does a straight-forward DFS to find cycles.
  // It does not terminate when a cycle was found but continues to explore
  // the graph to find all possible cycles.
  void detectCycleRecursive(FragmentDefinitionNode fragment) {
    if (visitedFrags.contains(fragment.name.value)) {
      return;
    }

    final fragmentName = fragment.name.value;
    visitedFrags.add(fragmentName);

    final spreadNodes = context.getFragmentSpreads(fragment.selectionSet);
    if (spreadNodes.isEmpty) {
      return;
    }

    spreadPathIndexByName[fragmentName] = spreadPath.length;

    for (final spreadNode in spreadNodes) {
      final spreadName = spreadNode.name.value;
      final cycleIndex = spreadPathIndexByName[spreadName];

      spreadPath.add(spreadNode);
      if (cycleIndex == null) {
        final spreadFragment = context.fragmentsMap[spreadName];
        if (spreadFragment != null) {
          detectCycleRecursive(spreadFragment);
        }
      } else {
        final cyclePath = spreadPath.slice(cycleIndex);
        final viaPath =
            cyclePath.slice(0, -1).map((s) => '"${s.name.value}"').join(', ');

        context.reportError(
          GraphQLError(
            'Cannot spread fragment "${spreadName}" within itself' +
                (viaPath != '' ? ' via ${viaPath}.' : '.'),
            locations: [
              ...cyclePath.map(
                (e) => GraphQLErrorLocation.fromSourceLocation(
                  (e.span ?? e.name.span)!.start,
                ),
              )
            ],
            extensions: _noFragmentCyclesSpec.extensions(),
          ),
        );
      }
      spreadPath.removeLast();
    }

    spreadPathIndexByName[fragmentName] = null;
  }

  final visitor = TypedVisitor();

  visitor.add<OperationDefinitionNode>((_) => VisitBehavior.skipTree);
  visitor.add<FragmentDefinitionNode>((node) {
    detectCycleRecursive(node);
    return VisitBehavior.skipTree;
  });

  return visitor;
}
