import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:graphql_generator/config.dart';
import 'package:graphql_generator/utils.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';
import 'package:valida/valida.dart';

/// Generates GraphQL schemas, statically.
Builder graphQLResolverBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [_GraphQLGenerator(Config.fromJson(options.config))],
    'graphql_resolvers',
  );
}

const _validateTypeChecker = TypeChecker.fromRuntime(Valida);
const _validationTypeChecker = TypeChecker.fromRuntime(Validation);

bool isReqCtx(DartType type) =>
    const TypeChecker.fromRuntime(ReqCtx).isAssignableFromType(type);

class _GraphQLGenerator extends GeneratorForAnnotation<GqlResolver> {
  final Config config;

  _GraphQLGenerator(this.config);

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
      final ctx = GeneratorCtx(buildStep: buildStep, config: config);

      final inputs = await inputsFromElement(ctx, element);

      final desc = getDescription(element, element.documentationComment);

      final lib = Library((b) {
        final deprecationReasons = const TypeChecker.fromRuntime(Deprecated)
            .annotationsOf(element, throwOnUnresolved: false);

        final deprecationReason = deprecationReasons.isEmpty
            ? 'null'
            : '"${deprecationReasons.map((e) {
                return e.getField('message')!.toStringValue();
              }).join('.\n')}"';

        final _retType = genericTypeWhenFutureOrStream(element.returnType) ??
            element.returnType;
        String returnType = _retType.getDisplayString(withNullability: false);
        if (_retType.isDartCoreList && returnType.endsWith('>')) {
          // TODO: probably not the best way of getting a list with its
          // type param nullable
          returnType = '${returnType.substring(0, returnType.length - 1)}?>';
        }

        final returnGqlType = inferType(
          config.customTypes,
          element.name,
          element.name,
          element.returnType,
        ).accept(_dartEmitter).toString();

        final funcDef = resolverFunctionFromElement(element);

        b.body.add(
          Field(
            (f) => f
              ..assignment = Code(
                '''
                field(
                  '${element.name}', 
                  $returnGqlType as GraphQLType<$returnType, Object>,
                  description: ${desc == null ? 'null' : 'r"$desc"'},
                  $funcDef,
                  ${inputs.isEmpty ? '' : 'inputs: [${inputs.join(',')}],'}
                  deprecationReason: $deprecationReason,
                  )
                 ''',
              )
              ..name = '${element.name}$graphQLFieldSuffix'
              ..type = refer(
                'GraphQLObjectField<$returnType, Object, Object>',
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

Future<List<String>> inputsFromElement(
  GeneratorCtx ctx,
  ExecutableElement element,
) async {
  final _dartEmitter = DartEmitter();
  final inputMaybe = await Future.wait(element.parameters.map((e) async {
    final argInfo = argInfoFromElement(e);
    final type = inferType(
      ctx.config.customTypes,
      element.name,
      e.name,
      e.type,
      nullable: argInfo.inline,
    ).accept(_dartEmitter);

    if (isReqCtx(e.type)) {
      return null;
    } else if (argInfo.inline) {
      // TODO; Check e.type is InputType?
      return '...$type.fields';
    } else {
      final defaultValue =
          e.hasDefaultValue ? 'defaultValue: ${e.defaultValueCode},' : '';

      final isInput = e.type.element != null && isInputType(e.type.element!);

      final docs = await documentationOfParameter(e, ctx.buildStep);
      return 'GraphQLFieldInput("${e.name}", $type${isInput ? '' : '.coerceToInputObject()'},'
          ' $defaultValue${docs.isEmpty ? '' : 'description: r"$docs",'})';
    }
  }));
  return inputMaybe.whereType<String>().toList();
}

GraphQLArg argInfoFromElement(Element element) {
  final argAnnot =
      const TypeChecker.fromRuntime(GraphQLArg).firstAnnotationOfExact(element);
  final argInfo = GraphQLArg(
    inline: argAnnot?.getField('inline')?.toBoolValue() ?? false,
  );
  return argInfo;
}

String resolverFunctionBodyFromElement(ExecutableElement element) {
  bool _hasValidation(Element? element) =>
      element != null && _validateTypeChecker.hasAnnotationOfExact(element);
  bool _isValidation(Element? element) =>
      element != null && _validationTypeChecker.isAssignableFrom(element);

  final validationsInParams = <ParameterElement>[];
  final validations = <String>[];
  final params = <String>[];
  for (final e in element.parameters) {
    if (isReqCtx(e.type)) {
      const value = 'ctx';
      params.add(e.isPositional ? value : '${e.name}:$value');
    } else {
      final type = e.type.getDisplayString(withNullability: true);
      final typeName = e.type.getDisplayString(withNullability: false);
      final argInfo = argInfoFromElement(e);
      final value =
          argInfo.inline ? '${e.name}Arg' : '(args["${e.name}"] as $type)';
      if (argInfo.inline) {
        // TODO: support generics
        validations.add(
          'final $value = '
          '${ReCase(typeName).camelCase}$serializerSuffix.fromJson(ctx.baseCtx.serdeCtx, args);',
        );
      }
      if (_isValidation(e.type.element)) {
        // TODO: pass validation resot in param (don't throw on validation errorπ)
        validationsInParams.add(e);
      }

      params.add(e.isPositional ? value : '${e.name}:$value');
      final hasValidation = _hasValidation(e.type.element);
      if (hasValidation) {
        final resultName = '${e.name}ValidationResult';

        validations.add('''
if ($value != null) {
  final $resultName = validate$typeName($value as $typeName);
  if ($resultName.hasErrors) {
    throw $resultName;
  }
}
''');
      }
    }
  }

  return '''
final args = ctx.args;
${validations.join('\n')}
return ${element is MethodElement ? 'obj.' : ''}${element.name}(${params.join(',')});
''';
}

String resolverFunctionFromElement(ExecutableElement element) {
  final hasSubsAnnot =
      const TypeChecker.fromRuntime(Subscription).hasAnnotationOfExact(element);
  final isStream = isStreamOrAsyncStream(element.returnType);

  if (hasSubsAnnot && !isStream || isStream && !hasSubsAnnot) {
    print('$element should return a stream to be a Subscription.');
  }

  final body = resolverFunctionBodyFromElement(element);
  return '''
${isStream ? 'subscribe' : 'resolve'}: (obj, ctx) {
  $body
}
''';
}
