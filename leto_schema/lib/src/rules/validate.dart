import 'package:gql/ast.dart';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/rules/no_undefined_variables_rule.dart';
import 'package:leto_schema/src/rules/rules/possible_fragment_spread_rule.dart';
import 'package:leto_schema/src/rules/rules/scalar_leafs_rule.dart';
import 'package:leto_schema/src/rules/rules/single_field_subscription_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_variable_names_rule.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/utilities.dart';
import 'package:meta/meta.dart';

import 'executable_rules.dart';

/// Executes the default GraphQL validations for the given [document]
/// over the [schema].
///
/// [maxErrors] is the maximum number of errors returned in the validation.
List<GraphQLError> validateDocument(
  GraphQLSchema schema,
  DocumentNode document, {
  int maxErrors = 100,
}) {
  final typeInfo = TypeInfo(schema);
  final ctx = ValidationCtx(
    schema,
    document,
    typeInfo,
    maxErrors: maxErrors,
  );

  final visitor = WithTypeInfoVisitor(typeInfo, visitors: [
    // TODO: these are returning error when visiting, not by using reportError
    uniqueOperationNamesRule(ctx),
    loneAnonymousOperationRule(ctx),
    knownTypeNamesRule(ctx),
    fragmentsOnCompositeTypesRule(ctx),
    variablesAreInputTypesRule(ctx),
    scalarLeafsRule(ctx),
    knownFragmentNamesRule(ctx),
    //
    fieldsOnCorrectTypeRule(ctx),
    singleFieldSubscriptionsRule(ctx),
    possibleFragmentSpreadsRule(ctx),
    uniqueVariableNamesRule(ctx),
    // TODO: NoFragmentCyclesRule,
    noUndefinedVariablesRule(ctx),
  ], onAccept: (result) {
    if (result is List<GraphQLError>) {
      // TODO: these are returning error when visiting, not by using reportError
      result.forEach(ctx.reportError);
    }
  });

  try {
    document.accept(visitor);
  } on _AbortValidationException catch (_) {}

  return ctx._errors;
}

class ValidationCtx {
  final GraphQLSchema schema;
  final DocumentNode document;
  final TypeInfo typeInfo;
  final int maxErrors;

  late final Map<String, FragmentDefinitionNode> fragmentsMap =
      fragmentsFromDocument(document);

  final Map<NodeWithSelectionSet, List<VariableUsage>> _variableUsages = {};

  final Map<OperationDefinitionNode, List<VariableUsage>>
      _recursiveVariableUsages = {};

  final Map<OperationDefinitionNode, List<FragmentDefinitionNode>>
      _recursivelyReferencedFragments = {};

  final Map<SelectionSetNode, List<FragmentSpreadNode>> _fragmentSpreads = {};

  ///
  ValidationCtx(
    this.schema,
    this.document,
    this.typeInfo, {
    required this.maxErrors,
  });

  final List<GraphQLError> _errors = [];

  void reportError(GraphQLError error) {
    _errors.add(error);
    if (_errors.length >= maxErrors) {
      throw _AbortValidationException();
    }
  }

  List<VariableUsage> getVariableUsages(NodeWithSelectionSet node) {
    var usages = _variableUsages[node];
    if (usages == null) {
      final newUsages = <VariableUsage>[];
      final typeInfo = TypeInfo(schema);

      final _visitor = TypedVisitor();
      // TOOD:
      _visitor.add<VariableDefinitionNode>((_) => false);
      _visitor.add<VariableNode>((variable) {
        newUsages.add(VariableUsage(
          node: variable,
          type: typeInfo.getInputType(),
          defaultValue: typeInfo.getDefaultValue(),
        ));
      });
      node.node.accept(
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
      usages = getVariableUsages(NodeWithSelectionSet.operation(operation));
      for (final frag in getRecursivelyReferencedFragments(operation)) {
        usages = usages!
            .followedBy(getVariableUsages(NodeWithSelectionSet.fragment(frag)))
            .toList();
      }
      _recursiveVariableUsages[operation] = usages!;
    }
    return usages;
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

class _AbortValidationException implements Exception {}

@immutable
abstract class NodeWithSelectionSet {
  ///
  const NodeWithSelectionSet();

  Node get node;

  const factory NodeWithSelectionSet.operation(OperationDefinitionNode node) =
      _NodeWithSelectionSetOperationDefinition;
  const factory NodeWithSelectionSet.fragment(FragmentDefinitionNode node) =
      _NodeWithSelectionSetFragmentDefinition;

  @override
  bool operator ==(Object other) =>
      other is NodeWithSelectionSet && node == other.node;

  @override
  int get hashCode => node.hashCode;
}

class _NodeWithSelectionSetOperationDefinition extends NodeWithSelectionSet {
  @override
  final OperationDefinitionNode node;

  const _NodeWithSelectionSetOperationDefinition(this.node);
}

class _NodeWithSelectionSetFragmentDefinition extends NodeWithSelectionSet {
  @override
  final FragmentDefinitionNode node;

  const _NodeWithSelectionSetFragmentDefinition(this.node);
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
