import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:formgen/formgen.dart';
import 'package:graphql_generator/utils.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:source_gen/source_gen.dart';

/// Generates GraphQL schemas, statically.
Builder graphQLResolverBuilder(Object _) {
  return SharedPartBuilder([_GraphQLGenerator()], 'graphql_resolvers');
}

const _validateTypeChecker = TypeChecker.fromRuntime(Validate);
const _validationTypeChecker = TypeChecker.fromRuntime(Validation);

class _GraphQLGenerator extends GeneratorForAnnotation<GqlResolver> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! FunctionElement) {
      throw UnsupportedError('@GqlResolver() is only supported on functions.');
    }
    try {
      final _dartEmitter = DartEmitter();

      bool _isReqCtx(DartType type) =>
          const TypeChecker.fromRuntime(ReqCtx).isAssignableFromType(type);

      final inputs = (await Future.wait(element.parameters.map((e) async {
        if (_isReqCtx(e.type)) {
          return null;
        } else {
          final type =
              inferType(element.name, e.name, e.type).accept(_dartEmitter);
          final defaultValue =
              e.hasDefaultValue ? 'defaultValue: ${e.defaultValueCode},' : '';

          final docs = await documentationOfParameter(e, buildStep);
          return 'GraphQLFieldInput("${e.name}", $type.coerceToInputObject(),'
              ' $defaultValue${docs.isEmpty ? '' : 'description: r"$docs",'})';
        }
      })))
          .whereType<String>();

      final desc = getDescription(element, element.documentationComment);

      bool _hasValidation(Element? element) =>
          element != null && _validateTypeChecker.hasAnnotationOfExact(element);
      bool _isValidation(Element? element) =>
          element != null && _validationTypeChecker.isAssignableFrom(element);

      final validationsInParams = <ParameterElement>[];

      final params = element.parameters.map((e) {
        if (_isReqCtx(e.type)) {
          const value = 'ctx';
          return e.isPositional ? value : '${e.name}:$value';
        } else {
          final type = e.type.getDisplayString(withNullability: true);
          final value = 'args["${e.name}"] as $type';

          if (_isValidation(e.type.element)) {
            validationsInParams.add(e);
          }

          return e.isPositional ? value : '${e.name}:$value';
        }
      }).join(',');

      final validations = element.parameters.map((e) {
        final hasValidation = _hasValidation(e.type.element);
        if (!hasValidation) {
          return null;
        }

        final resultName = '${e.name}ValidationResult';
        // TODO: reuse from params
        final type = e.type.getDisplayString(withNullability: true);
        final typeName = e.type.getDisplayString(withNullability: false);
        final value = 'args["${e.name}"] as $type';

        return '''
          final $resultName = validate$typeName($value);
          if ($resultName.hasErrors) {
            throw $resultName;
          }
          ''';
      }).whereType<String>();

      final lib = Library((b) {
        final deprecationReasons = const TypeChecker.fromRuntime(Deprecated)
            .annotationsOf(element, throwOnUnresolved: false);

        final deprecationReason = deprecationReasons.isEmpty
            ? 'null'
            : '"${deprecationReasons.map((e) {
                return e.getField('message')!.toStringValue();
              }).join('.\n')}"';

        final returnType =
            element.returnType.getDisplayString(withNullability: false);
        final returnGqlType =
            inferType(element.name, element.name, element.returnType)
                .accept(_dartEmitter)
                .toString();

        b.body.add(
          Field(
            (f) => f
              ..assignment = Code(
                '''
                field(
                  '${element.name}', 
                  $returnGqlType,
                  description: ${desc == null ? 'null' : 'r"$desc"'},
                  resolve: (obj, ctx) {
                    final args = ctx.args;
                    ${validations.join('\n')}
                    return ${element.name}($params);
                  },
                  ${inputs.isEmpty ? '' : 'inputs: [${inputs.join(',')}],'}
                  deprecationReason: $deprecationReason,
                  )
                 ''',
              )
              ..name = '${element.name}$graphQLFieldSuffix'
              ..type = refer(
                'GraphQLObjectField<$returnType, Object?, void>',
              )
              ..modifier = FieldModifier.final$,
          ),
        );
      });
      return lib.accept(_dartEmitter).toString();
    } catch (e, s) {
      print('$e $s');

      return '/*$e $s*/';
    }
  }
}
