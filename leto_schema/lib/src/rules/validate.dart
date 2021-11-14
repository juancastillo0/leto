import 'package:gql/ast.dart';

import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/rules/known_argument_names_rule.dart';
import 'package:leto_schema/src/rules/rules/known_directive_rule.dart';
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
import 'package:leto_schema/src/rules/rules/variables_in_allowed_position_rule.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/utilities.dart';

import 'executable_rules.dart';
import 'validation_context.dart';

/// Return a visitor that executes document validations for a [ValidationCtx]
typedef ValidationRule = Visitor Function(ValidationCtx);

/// Default validations rules from the GraphQL specification
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
  // TODO: NoFragmentCyclesRule,
  uniqueVariableNamesRule,
  noUndefinedVariablesRule,
  noUnusedVariablesRule,
  knownDirectivesRule,
  uniqueDirectivesPerLocationRule,
  knownArgumentNamesRule,
  uniqueArgumentNamesRule,
  // TODO: ValuesOfCorrectType
  providedRequiredArgumentsRule,
  variablesInAllowedPositionRule,
  // TODO: OverlappingFieldsCanMerge
  uniqueInputFieldNamesRule,
];

const specifiedSDLRules = <ValidationRule>[
  // loneSchemaDefinitionRule,
  // uniqueOperationTypesRule,
  // uniqueTypeNamesRule,
  // uniqueEnumValueNamesRule,
  // uniqueFieldDefinitionNamesRule,
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
      _errors.add(error);
    },
  );

  final visitor = WithTypeInfoVisitor(
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
