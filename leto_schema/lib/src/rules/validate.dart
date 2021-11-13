import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/type_info.dart';

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
}

class _AbortValidationException implements Exception {}
