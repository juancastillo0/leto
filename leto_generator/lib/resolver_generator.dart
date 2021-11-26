import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:leto_generator/config.dart';
import 'package:leto_generator/utils.dart';
import 'package:leto_schema/leto_schema.dart';
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
const _resolverTypeChecker = TypeChecker.fromRuntime(GraphQLResolver);
const _validationTypeChecker = TypeChecker.fromRuntime(Validation);
const _classResolverTypeChecker = TypeChecker.fromRuntime(ClassResolver);

bool isReqCtx(DartType type) =>
    const TypeChecker.fromRuntime(Ctx).isAssignableFromType(type);

class _GraphQLGenerator extends GeneratorForAnnotation<BaseGraphQLResolver> {
  final Config config;

  _GraphQLGenerator(this.config);

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final ctx = GeneratorCtx(buildStep: buildStep, config: config);
    if (element is! FunctionElement) {
      final classResolver = element is ClassElement
          ? _classResolverTypeChecker.firstAnnotationOfExact(element)
          : null;
      if (classResolver == null) {
        throw UnsupportedError(
            '@GraphQLResolver() is only supported on functions.');
      }

      return (await Future.wait((element as ClassElement)
              .methods
              .where((method) => _resolverTypeChecker.hasAnnotationOf(method))
              .map((e) => _buildForElement(ctx, e))))
          .join('\n');
    }

    return _buildForElement(ctx, element);
  }
}

Future<String> _buildForElement(
  GeneratorCtx ctx,
  ExecutableElement element,
) async {
  try {
    final _dartEmitter = DartEmitter();

    final inputs = await inputsFromElement(ctx, element);

    final desc = getDescription(element, element.documentationComment);

    final funcDef = await resolverFunctionFromElement(ctx, element);

    final lib = Library((b) {
      final deprecationReason = getDeprecationReason(element);

      final _retType = genericTypeWhenFutureOrStream(element.returnType) ??
          element.returnType;

      final _returnType = getReturnType(_retType);
      final returnType = _returnType.endsWith('?')
          ? _returnType.substring(0, _returnType.length - 1)
          : _returnType;

      final resolverName = const TypeChecker.fromRuntime(GraphQLResolver)
          .firstAnnotationOf(element)
          ?.getField('name')
          ?.toStringValue();
      final genericTypeName = const TypeChecker.fromRuntime(GraphQLResolver)
          .firstAnnotationOf(element)
          ?.getField('genericTypeName')
          ?.toStringValue();

      final returnGqlType = inferType(
        ctx.config.customTypes,
        element,
        element.name,
        element.returnType,
        genericTypeName: genericTypeName,
      ).accept(_dartEmitter).toString();

      b.body.add(
        Field(
          (f) => f
            ..assignment = Code(
              '''
                field(
                  '${resolverName ?? element.name}', 
                  $returnGqlType,
                  ${desc == null ? '' : 'description: r"$desc",'}
                  $funcDef,
                  ${inputs.isEmpty ? '' : 'inputs: [${inputs.join(',')}],'}
                  ${deprecationReason == null ? '' : 'deprecationReason: r"$deprecationReason",'}
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
    return lib.accept(DartEmitter()).toString();
  } catch (e, s) {
    print('$e $s');

    return '/*$e $s*/';
  }
}

Future<List<String>> inputsFromElement(
  GeneratorCtx ctx,
  ExecutableElement element,
) async {
  final _dartEmitter = DartEmitter();
  final inputMaybe = await Future.wait(element.parameters.map((e) async {
    if (isReqCtx(e.type)) {
      return null;
    } else {
      final argInfo = argInfoFromElement(e);
      final type = inferType(
        ctx.config.customTypes,
        e,
        e.name,
        e.type,
        nullable: argInfo.inline,
      ).accept(_dartEmitter);

      if (argInfo.inline) {
        // TODO; Check e.type is InputType?
        return '...$type.fields';
      } else {
        final defaultValueCode = e.defaultValueCode ??
            argInfo.defaultCode ??
            argInfo.defaultFunc?.call() as String?;
        final defaultValue =
            defaultValueCode != null ? 'defaultValue: $defaultValueCode,' : '';

        final isInput = e.type.element != null && isInputType(e.type.element!);

        final docs = await documentationOfParameter(e, ctx.buildStep);
        return '$type${isInput ? '' : '.coerceToInputObject()'}.inputField('
            ' "${e.name}",'
            ' $defaultValue${docs.isEmpty ? '' : 'description: r"$docs",'})';
      }
    }
  }));
  return inputMaybe.whereType<String>().toList();
}

GraphQLArg argInfoFromElement(Element element) {
  final argAnnot =
      const TypeChecker.fromRuntime(GraphQLArg).firstAnnotationOfExact(element);
  final defaultFunc = argAnnot?.getField('defaultFunc')?.toFunctionValue();
  final argInfo = GraphQLArg(
    inline: argAnnot?.getField('inline')?.toBoolValue() ?? false,
    defaultCode: argAnnot?.getField('defaultCode')?.toStringValue(),
    defaultFunc: defaultFunc == null ? null : () => '${defaultFunc.name}()',
  );
  if (defaultFunc != null && argInfo.defaultCode != null) {
    throw Exception(
      "Can't specify both defaultFunc: $defaultFunc and"
      ' defaultCode: ${argInfo.defaultCode} in decorator GraphQLArg'
      ' for ${element.name}.',
    );
  }
  return argInfo;
}

Future<String> resolverFunctionBodyFromElement(
  GeneratorCtx ctx,
  ExecutableElement element,
) async {
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
          '${ReCase(typeName).camelCase}$serializerSuffix'
          '.fromJson(ctx.executionCtx.schema.serdeCtx, args);',
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

  final _call = '${element.name}(${params.join(',')})';

  final classResolver = await getClassResolver(ctx, element);
  final handlingFuture =
      element is MethodElement && classResolver?.instantiateCode != null;

  String _getter = element is MethodElement
      ? (classResolver?.instantiateCode ?? 'obj.')
      : '';
  if (handlingFuture) {
    final _resolverClassName = element.enclosingElement.name;
    _getter = 'final _call = ($_resolverClassName r) => r.$_call;\n'
        ' // ignore: unnecessary_non_null_assertion\n'
        ' final FutureOr<$_resolverClassName> _obj = $_getter;'
        ' if (_obj is Future<$_resolverClassName>) return _obj.then(_call);'
        ' else return _call(_obj);';
  }
  // if (handlingFuture) {
  //   _getter = 'return Future.value($_getter).then('
  //       ' (${element.enclosingElement.name} r) => r.$_call);';
  // }

  return '''
final args = ctx.args;
${validations.join('\n')}
${handlingFuture ? _getter : 'return $_getter$_call;'}
''';
}

Future<String> resolverFunctionFromElement(
  GeneratorCtx ctx,
  ExecutableElement element,
) async {
  final hasSubsAnnot =
      const TypeChecker.fromRuntime(Subscription).hasAnnotationOfExact(element);
  final isStream = isStreamOrAsyncStream(element.returnType);

  if (hasSubsAnnot && !isStream || isStream && !hasSubsAnnot) {
    print('$element should return a Stream to be a Subscription.');
  }

  final body = await resolverFunctionBodyFromElement(ctx, element);
  return '''
${isStream ? 'subscribe' : 'resolve'}: (obj, ctx) {
  $body
}
''';
}

Future<ClassResolver?> getClassResolver(
  GeneratorCtx ctx,
  ExecutableElement element,
) async {
  final classAnnot = _classResolverTypeChecker
      .firstAnnotationOfExact(element.enclosingElement);

  String? instantiateCode = classAnnot == null
      ? null
      : classAnnot.getField('instantiateCode')?.toStringValue() ??
          ctx.config.instantiateCode;
  if (classAnnot != null && instantiateCode == null) {
    final parent = element.enclosingElement as ClassElement;
    final ref = parent.getGetter('ref');
    if (ref == null) {
      throw Exception('');
    } else if (!ref.isStatic) {
      throw Exception('');
    } else if (!const TypeChecker.fromRuntime(BaseRef)
        .isAssignableFromType(ref.returnType)) {
      throw Exception('');
    }
    instantiateCode = '${parent.name}.${ref.name}.get(ctx)!';
  }
  if (instantiateCode != null) {
    instantiateCode = instantiateCode.replaceAll(
      '{{name}}',
      element.enclosingElement.name!,
    );
  }

  return classAnnot == null
      ? null
      : ClassResolver(
          fieldName: classAnnot.getField('fieldName')?.toStringValue(),
          instantiateCode: instantiateCode,
        );
}



// ExecutableElement? constructor = parent.getNamedConstructor('fromCtx') ??
//     parent.lookUpMethod(
//       'fromCtx',
//       await ctx.buildStep.inputLibrary,
//     ) ??
//     parent.getGetter('fromCtx');
// if (constructor == null) {
//   throw Exception('');
// } else if (constructor is! ConstructorElement && !constructor.isStatic) {
//   throw Exception('');
// } else if (constructor.parameters.length > 1) {
//   throw Exception('');
// }

// if (constructor is PropertyAccessorElement &&
//     constructor.returnType.isDartCoreFunction) {
//   constructor = constructor.returnType.element! as ExecutableElement;
// }

// final param = constructor.parameters.firstOrNull;
// if (param != null &&
//     !const TypeChecker.fromRuntime(GlobalsHolder)
//         .isAssignableFromType(param.type)) {
//   throw Exception(param.type.getDisplayString(withNullability: false));
// }

// final _exec = param != null
//     ? '(ctx)'
//     : constructor is PropertyAccessorElement &&
//             !constructor.returnType.isDartCoreFunction
//         ? ''
//         : '()';
// instantiateCode = '${parent.name}.${constructor.name}$_exec';