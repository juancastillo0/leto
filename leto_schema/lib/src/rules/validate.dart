import 'package:gql/ast.dart';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/rules/known_argument_names_rule.dart';
import 'package:leto_schema/src/rules/rules/known_directive_rule.dart';
import 'package:leto_schema/src/rules/rules/lone_schema_definition_rule.dart';
import 'package:leto_schema/src/rules/rules/no_fragment_cycles_rule.dart';
import 'package:leto_schema/src/rules/rules/no_undefined_variables_rule.dart';
import 'package:leto_schema/src/rules/rules/no_unused_variables_rule.dart';
import 'package:leto_schema/src/rules/rules/overlapping_fields_can_be_merged.dart';
import 'package:leto_schema/src/rules/rules/possible_fragment_spreads_rule.dart';
import 'package:leto_schema/src/rules/rules/possible_type_extensions_rule.dart';
import 'package:leto_schema/src/rules/rules/provide_required_arguments_rule.dart';
import 'package:leto_schema/src/rules/rules/scalar_leafs_rule.dart';
import 'package:leto_schema/src/rules/rules/single_field_subscription_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_argument_definition_names_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_argument_names_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_directive_names_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_directive_per_location_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_enum_value_names_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_field_definition_names_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_input_field_name_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_operation_types_rule.dart';
import 'package:leto_schema/src/rules/rules/unique_type_names_rules.dart';
import 'package:leto_schema/src/rules/rules/unique_variable_names_rule.dart';
import 'package:leto_schema/src/rules/rules/values_of_correct_type_rule.dart';
import 'package:leto_schema/src/rules/rules/variables_in_allowed_position_rule.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';

import 'executable_rules.dart';
import 'validation_context.dart';

/// Return a visitor that executes document validations for a [ValidationCtx]
typedef ValidationRule = Visitor Function(ValidationCtx);

/// Return a visitor that executes schema document
/// validations for a [SDLValidationRule]
typedef SDLValidationRule = Visitor Function(SDLValidationCtx);

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
  uniqueFragmentNamesRule,
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
  overlappingFieldsCanBeMergedRule,
  uniqueInputFieldNamesRule,
];

/// Default schema validation rules from the GraphQL specification
const specifiedSDLRules = <SDLValidationRule>[
  loneSchemaDefinitionRule,
  uniqueOperationTypesRule,
  uniqueTypeNamesRule,
  uniqueEnumValueNamesRule,
  uniqueFieldDefinitionNamesRule,
  uniqueArgumentDefinitionNamesRule,
  uniqueDirectiveNamesRule,
  knownTypeNamesRule,
  knownDirectivesRule,
  uniqueDirectivesPerLocationRule,
  possibleTypeExtensionsRule,
  knownArgumentNamesOnDirectivesRule,
  uniqueArgumentNamesRule,
  uniqueInputFieldNamesRule,
  providedRequiredArgumentsOnDirectivesRule,
];

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

/// Executes GraphQL schema validations for the given [document]
/// with an optional base [schemaToExtend].
///
/// If [schemaToExtend] is non null, [document] will be interpreted
/// as a schema extension.
List<GraphQLError> validateSDL(
  DocumentNode document, {
  GraphQLSchema? schemaToExtend,
  List<SDLValidationRule> rules = specifiedSDLRules,
}) {
  final errors = <GraphQLError>[];
  final ctx = SDLValidationCtx(
    schema: schemaToExtend,
    document: document,
    onError: errors.add,
  );
  final visitor = ParallelVisitor(
    visitors: rules.map((e) => e(ctx)).toList(),
    onAccept: (obj) {
      if (obj is List<GraphQLError>) {
        errors.addAll(obj);
      }
    },
  );
  document.accept(visitor);
  return errors;
}

class _AbortValidationException implements Exception {}

/// Returns the provided [ValidationRule] with the given [name], if any
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
  'loneSchemaDefinitionRule': loneSchemaDefinitionRule,
  'uniqueOperationTypesRule': uniqueOperationTypesRule,
  'uniqueTypeNamesRule': uniqueTypeNamesRule,
  'uniqueEnumValueNamesRule': uniqueEnumValueNamesRule,
  'uniqueFieldDefinitionNamesRule': uniqueFieldDefinitionNamesRule,
  'uniqueArgumentDefinitionNamesRule': uniqueArgumentDefinitionNamesRule,
  'uniqueDirectiveNamesRule': uniqueDirectiveNamesRule,
  'knownTypeNamesRule': knownTypeNamesRule,
  'fragmentsOnCompositeTypesRule': fragmentsOnCompositeTypesRule,
  'variablesAreInputTypesRule': variablesAreInputTypesRule,
  'scalarLeafsRule': scalarLeafsRule,
  'fieldsOnCorrectTypeRule': fieldsOnCorrectTypeRule,
  'uniqueFragmentNamesRule': uniqueFragmentNamesRule,
  'knownFragmentNamesRule': knownFragmentNamesRule,
  'noUnusedFragmentsRule': noUnusedFragmentsRule,
  'possibleFragmentSpreadsRule': possibleFragmentSpreadsRule,
  'noFragmentCyclesRule': noFragmentCyclesRule,
  'uniqueVariableNamesRule': uniqueVariableNamesRule,
  'noUndefinedVariablesRule': noUndefinedVariablesRule,
  'noUnusedVariablesRule': noUnusedVariablesRule,
  'knownDirectivesRule': knownDirectivesRule,
  'uniqueDirectivesPerLocationRule': uniqueDirectivesPerLocationRule,
  'possibleTypeExtensionsRule': possibleTypeExtensionsRule,
  'knownArgumentNamesRule': knownArgumentNamesRule,
  'valuesOfCorrectTypeRule': valuesOfCorrectTypeRule,
  'uniqueArgumentNamesRule': uniqueArgumentNamesRule,
  'providedRequiredArgumentsRule': providedRequiredArgumentsRule,
  'variablesInAllowedPositionRule': variablesInAllowedPositionRule,
  'overlappingFieldsCanBeMergedRule': overlappingFieldsCanBeMergedRule,
  'uniqueInputFieldNamesRule': uniqueInputFieldNamesRule,
  'knownArgumentNamesOnDirectivesRule': knownArgumentNamesOnDirectivesRule,
  'providedRequiredArgumentsOnDirectivesRule':
      providedRequiredArgumentsOnDirectivesRule,
};
