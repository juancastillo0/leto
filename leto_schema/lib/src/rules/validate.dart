import 'package:gql/ast.dart';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/rules/known_argument_names_rule.dart';
import 'package:leto_schema/src/rules/rules/known_directive_rule.dart';
import 'package:leto_schema/src/rules/rules/no_fragment_cycles_rule.dart';
import 'package:leto_schema/src/rules/rules/no_undefined_variables_rule.dart';
import 'package:leto_schema/src/rules/rules/no_unused_variables_rule.dart';
import 'package:leto_schema/src/rules/rules/possible_fragment_spreads_rule.dart';
import 'package:leto_schema/src/rules/rules/provide_required_arguments_rule.dart';
import 'package:leto_schema/src/rules/rules/scalar_leafs_rule.dart';
import 'package:leto_schema/src/rules/rules/single_field_subscription_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_argument_names_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_directive_per_location_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_input_field_name_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_variable_names_rule.dart';
import 'package:leto_schema/src/rules/rules/values_of_correct_type_rule.dart';
import 'package:leto_schema/src/rules/rules/variables_in_allowed_position_rule.dart';
import 'package:leto_schema/src/rules/type_info.dart';

import 'executable_rules.dart';
import 'validation_context.dart';

/// Return a visitor that executes document validations for a [ValidationCtx]
typedef ValidationRule = Visitor Function(ValidationCtx);

/// Default validation rules from the GraphQL specification
const specifiedRules = <ValidationRule>[
  // TODO: some are returning error when visiting, not by using reportError
  executableDefinitionsRule,
  uniqueOperationNamesRule,
  loneAnonymousOperationRule,
  singleFieldSubscriptionsRule,
  knownTypeNamesRule,
  fragmentsOnCompositeTypesRule,
  variablesAreInputTypesRule,
  scalarLeafsRule,
  fieldsOnCorrectTypeRule,
  knownFragmentNamesRule,
  noUnusedFragmentsRule,
  possibleFragmentSpreadsRule,
  noFragmentCyclesRule,
  uniqueVariableNamesRule,
  noUndefinedVariablesRule,
  noUnusedVariablesRule,
  knownDirectivesRule,
  uniqueDirectivesPerLocationRule,
  knownArgumentNamesRule,
  uniqueArgumentNamesRule,
  valuesOfCorrectTypeRule,
  providedRequiredArgumentsRule,
  variablesInAllowedPositionRule,
  // TODO: OverlappingFieldsCanMerge
  uniqueInputFieldNamesRule,
];

/// Default SDL validation rules from the GraphQL specification
const specifiedSDLRules = <ValidationRule>[
  // loneSchemaDefinitionRule,
  // uniqueOperationTypesRule,
  // uniqueTypeNamesRule,
  // uniqueEnumValueNamesRule,
  // uniqueFieldDefinitionNamesRule,
  // uniqueArgumentDefinitionNamesRule,
  // uniqueDirectiveNamesRule,
  knownTypeNamesRule,
  knownDirectivesRule,
  uniqueDirectivesPerLocationRule,
  // possibleTypeExtensionsRule,
  knownArgumentNamesOnDirectivesRule,
  uniqueArgumentNamesRule,
  uniqueInputFieldNamesRule,
  providedRequiredArgumentsOnDirectivesRule,
];

// LoneSchemaDefinitionRule-test.ts
// NoDeprecatedCustomRule-test.ts
// NoSchemaIntrospectionCustomRule-test.ts

/// Executes the default GraphQL validations for the given [document]
/// over the [schema].
///
/// [maxErrors] is the maximum number of errors returned in the validation.
List<GraphQLError> validateDocument(
  GraphQLSchema schema,
  DocumentNode document, {
  int maxErrors = 100,
  List<ValidationRule> rules = specifiedRules,
}) {
  final _errors = <GraphQLError>[];
  final typeInfo = TypeInfo(schema);
  late final WithTypeInfoVisitor visitor;
  final ctx = ValidationCtx(
    schema,
    document,
    typeInfo,
    onError: (error) {
      if (_errors.length >= maxErrors) {
        _errors.add(
          const GraphQLError(
            'Too many validation errors, error limit reached.'
            ' Validation aborted.',
          ),
        );
        throw _AbortValidationException();
      }
      if (error.locations.isEmpty) {
        _errors.add(GraphQLError(
          error.message,
          extensions: error.extensions,
          path: error.path,
          sourceError: error.sourceError,
          stackTrace: error.stackTrace,
          locations: GraphQLErrorLocation.firstFromNodes(
            visitor.ancestors.reversed,
          ),
        ));
      } else {
        _errors.add(error);
      }
    },
  );

  visitor = WithTypeInfoVisitor(
    typeInfo,
    visitors: rules.map((e) => e(ctx)).toList(),
    onAccept: (result) {
      if (result is List<GraphQLError>) {
        // TODO: these are returning error when visiting, not by using reportError
        result.forEach(ctx.reportError);
      }
    },
  );

  try {
    document.accept(visitor);
  } on _AbortValidationException catch (_) {}

  return _errors;
}

class _AbortValidationException implements Exception {}

ValidationRule? validationFromName(String name) {
  if (name.isEmpty) return null;
  final _rule = name.endsWith('Rule') ? '' : 'Rule';
  final _name =
      '${name.substring(0, 1).toLowerCase()}${name.substring(1)}$_rule';
  return _allValidationRules[_name];
}

const _allValidationRules = <String, ValidationRule>{
  'executableDefinitionsRule': executableDefinitionsRule,
  'uniqueOperationNamesRule': uniqueOperationNamesRule,
  'loneAnonymousOperationRule': loneAnonymousOperationRule,
  'singleFieldSubscriptionsRule': singleFieldSubscriptionsRule,
  'knownTypeNamesRule': knownTypeNamesRule,
  'fragmentsOnCompositeTypesRule': fragmentsOnCompositeTypesRule,
  'variablesAreInputTypesRule': variablesAreInputTypesRule,
  'scalarLeafsRule': scalarLeafsRule,
  'fieldsOnCorrectTypeRule': fieldsOnCorrectTypeRule,
  'knownFragmentNamesRule': knownFragmentNamesRule,
  'noUnusedFragmentsRule': noUnusedFragmentsRule,
  'possibleFragmentSpreadsRule': possibleFragmentSpreadsRule,
  'noFragmentCyclesRule': noFragmentCyclesRule,
  'uniqueVariableNamesRule': uniqueVariableNamesRule,
  'noUndefinedVariablesRule': noUndefinedVariablesRule,
  'noUnusedVariablesRule': noUnusedVariablesRule,
  'knownDirectivesRule': knownDirectivesRule,
  'uniqueDirectivesPerLocationRule': uniqueDirectivesPerLocationRule,
  'knownArgumentNamesRule': knownArgumentNamesRule,
  'valuesOfCorrectTypeRule': valuesOfCorrectTypeRule,
  'uniqueArgumentNamesRule': uniqueArgumentNamesRule,
  'providedRequiredArgumentsRule': providedRequiredArgumentsRule,
  'variablesInAllowedPositionRule': variablesInAllowedPositionRule,
  'uniqueInputFieldNamesRule': uniqueInputFieldNamesRule,
  'knownArgumentNamesOnDirectivesRule': knownArgumentNamesOnDirectivesRule,
  'providedRequiredArgumentsOnDirectivesRule':
      providedRequiredArgumentsOnDirectivesRule,
};
