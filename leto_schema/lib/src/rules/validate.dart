import 'package:gql/ast.dart';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/rules/known_argument_names_rule.dart';
import 'package:leto_schema/src/rules/rules/known_directive_rule.dart';
import 'package:leto_schema/src/rules/rules/no_undefined_variables_rule.dart';
import 'package:leto_schema/src/rules/rules/no_unused_variables_rule.dart';
import 'package:leto_schema/src/rules/rules/possible_fragment_spread_rule.dart';
import 'package:leto_schema/src/rules/rules/provide_required_arguments_rule.dart';
import 'package:leto_schema/src/rules/rules/scalar_leafs_rule.dart';
import 'package:leto_schema/src/rules/rules/single_field_subscription_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_argument_names_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_directive_per_location_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_input_field_name_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_variable_names_rule.dart';
import 'package:leto_schema/src/rules/rules/variables_in_allowed_position_rule.dart';
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
    // TODO: some are returning error when visiting, not by using reportError
    executableDefinitionsRule(ctx),
    uniqueOperationNamesRule(ctx),
    loneAnonymousOperationRule(ctx),
    singleFieldSubscriptionsRule(ctx),
    knownTypeNamesRule(ctx),
    fragmentsOnCompositeTypesRule(ctx),
    variablesAreInputTypesRule(ctx),
    scalarLeafsRule(ctx),
    fieldsOnCorrectTypeRule(ctx),
    knownFragmentNamesRule(ctx),
    noUnusedFragmentsRule(ctx),
    possibleFragmentSpreadsRule(ctx),
    // TODO: NoFragmentCyclesRule,
    uniqueVariableNamesRule(ctx),
    noUndefinedVariablesRule(ctx),
    noUnusedVariablesRule(ctx),
    knownDirectivesRule(ctx),
    uniqueDirectivesPerLocationRule(ctx),
    knownArgumentNamesRule(ctx),
    uniqueArgumentNamesRule(ctx),
    // TODO: ValuesOfCorrectType
    providedRequiredArgumentsRule(ctx),
    variablesInAllowedPositionRule(ctx),
    // TODO: OverlappingFieldsCanMerge
    uniqueInputFieldNamesRule(ctx),
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

  final Map<ExecutableDefinitionNode, List<VariableUsage>> _variableUsages = {};

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

  List<VariableUsage> getVariableUsages(ExecutableDefinitionNode node) {
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
        usages = usages!.followedBy(getVariableUsages(frag)).toList();
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
