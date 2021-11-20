import 'package:gql/ast.dart';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/utilities.dart';

class SDLValidationCtx {
  final GraphQLSchema? schema;
  final DocumentNode document;
  final void Function(GraphQLError) onError;

  late final Map<String, FragmentDefinitionNode> fragmentsMap =
      fragmentsFromDocument(document);

  final Map<OperationDefinitionNode, List<FragmentDefinitionNode>>
      _recursivelyReferencedFragments = {};

  final Map<SelectionSetNode, List<FragmentSpreadNode>> _fragmentSpreads = {};

  ///
  SDLValidationCtx({
    required this.schema,
    required this.document,
    required this.onError,
  });

  void reportError(GraphQLError error) {
    onError(error);
  }

  List<FragmentDefinitionNode> getRecursivelyReferencedFragments(
    OperationDefinitionNode operation,
  ) {
    var fragments = this._recursivelyReferencedFragments[operation];
    if (fragments == null) {
      fragments = [];
      final collectedNames = <String, bool>{};
      final nodesToVisit = <SelectionSetNode>[operation.selectionSet];
      while (nodesToVisit.length != 0) {
        final node = nodesToVisit.removeLast();
        for (final spread in this.getFragmentSpreads(node)) {
          final fragName = spread.name.value;
          if (collectedNames[fragName] != true) {
            collectedNames[fragName] = true;
            final fragment = this.fragmentsMap[fragName];
            if (fragment != null) {
              // @ts-expect-error FIXME: TS Conversion
              fragments.add(fragment);
              nodesToVisit.add(fragment.selectionSet);
            }
          }
        }
      }
      this._recursivelyReferencedFragments[operation] = fragments;
    }
    return fragments;
  }

  List<FragmentSpreadNode> getFragmentSpreads(
    SelectionSetNode node,
  ) {
    var spreads = _fragmentSpreads[node];
    if (spreads == null) {
      spreads = [];
      final setsToVisit = <SelectionSetNode>[node];
      while (setsToVisit.length != 0) {
        final set = setsToVisit.removeLast();
        for (final selection in set.selections) {
          if (selection is FragmentSpreadNode) {
            // @ts-expect-error FIXME: TS Conversion
            spreads.add(selection);
          } else if (selection.selectionSet != null) {
            setsToVisit.add(selection.selectionSet!);
          }
        }
      }
      _fragmentSpreads[node] = spreads;
    }
    return spreads;
  }
}

class ValidationCtx extends SDLValidationCtx {
  GraphQLSchema get schema => super.schema!;
  final TypeInfo typeInfo;

  final Map<ExecutableDefinitionNode, List<VariableUsage>> _variableUsages = {};

  final Map<OperationDefinitionNode, List<VariableUsage>>
      _recursiveVariableUsages = {};

  ///
  ValidationCtx(
    GraphQLSchema schema,
    DocumentNode document,
    this.typeInfo, {
    required void Function(GraphQLError) onError,
  }) : super(
          schema: schema,
          document: document,
          onError: onError,
        );

  List<VariableUsage> getVariableUsages(ExecutableDefinitionNode node) {
    var usages = _variableUsages[node];
    if (usages == null) {
      final newUsages = <VariableUsage>[];
      final typeInfo = TypeInfo(schema);

      final _visitor = TypedVisitor();
      _visitor.add<VariableDefinitionNode>(
        (_) => VisitBehavior.skipTree,
      );
      _visitor.add<VariableNode>((variable) {
        newUsages.add(VariableUsage(
          node: variable,
          type: typeInfo.getInputType(),
          defaultValue: typeInfo.getDefaultValue(),
        ));
      });
      node.accept(
        WithTypeInfoVisitor(typeInfo, visitors: [_visitor]),
      );
      usages = newUsages;
      _variableUsages[node] = usages;
    }
    return usages;
  }

  List<VariableUsage> getRecursiveVariableUsages(
    OperationDefinitionNode operation,
  ) {
    var usages = _recursiveVariableUsages[operation];
    if (usages == null) {
      usages = getVariableUsages(operation);
      for (final frag in getRecursivelyReferencedFragments(operation)) {
        usages.addAll(getVariableUsages(frag));
      }
      _recursiveVariableUsages[operation] = usages;
    }
    return usages;
  }
}

class VariableUsage {
  final VariableNode node;
  final GraphQLType? type;
  final Object? defaultValue;

  /// The position and information about a variable within
  /// a GraphQL document
  VariableUsage({
    required this.node,
    this.type,
    this.defaultValue,
  });
}
