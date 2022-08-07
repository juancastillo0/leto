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

bool isReqCtx(DartType type) {
  return type.element != null &&
      const TypeChecker.fromRuntime(Ctx).isAssignableFrom(type.element!);
}

class _GraphQLGenerator
    extends GeneratorForAnnotation<BaseGraphQLResolverDecorator> {
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
    final funcDef = await resolverFunctionFromElement(ctx, element);

    final lib = Library((b) {
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

      final deprecationReason = getDeprecationReason(element);
      final description = getDescription(element, element.documentationComment);
      final attachments = getAttachments(element);
      final returnType = (genericTypeWhenFutureOrStream(element.returnType) ??
              element.returnType)
          .getDisplayString(withNullability: true);

      b.body.add(Code('''
GraphQLObjectField<$returnType, Object?, Object?> get 
  ${element.name}$graphQLFieldSuffix => _${element.name}$graphQLFieldSuffix.value;
'''));

      b.body.add(
        Field(
          (f) => f
            ..assignment = Code(
              '''
                HotReloadableDefinition<GraphQLObjectField<$returnType, Object?, Object?>>(
                (setValue) => setValue($returnGqlType.field<Object?>(
                  '${resolverName ?? element.name}',
                  $funcDef,
                  ${description == null ? '' : "description: '$description',"}
                  ${deprecationReason == null ? '' : "deprecationReason: '$deprecationReason',"}
                  ${attachments == null ? '' : 'attachments: $attachments'}
                  ))${inputs.isEmpty ? '' : '..inputs.addAll([${inputs.join(',')}])'}
                )
                 ''',
            )
            ..name = '_${element.name}$graphQLFieldSuffix'
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
  final inputMaybe =
      await Future.wait<String?>(element.parameters.map((e) async {
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
        isInput: true,
      ).accept(_dartEmitter).toString();

      if (argInfo.inline) {
        // TODO: 2G Check e.type is InputType?
        return '...$type.fields';
      } else {
        final defaultValueCode = e.defaultValueCode ??
            argInfo.defaultCode ??
            argInfo.defaultFunc?.call() as String?;
        // final isInput = e.type.element != null && isInputType(e.type.element!);
        final description = await documentationOfParameter(e, ctx.buildStep);
        // TODO: 1T test
        final deprecationReason = getDeprecationReason(e);
        final attachments = getAttachments(e);
        return refer(type)
            .property('inputField')
            .call(
              [literalString(e.name)],
              {
                if (defaultValueCode != null)
                  'defaultValue': refer(defaultValueCode),
                if (description.isNotEmpty)
                  'description': refer("'$description'"),
                if (deprecationReason != null)
                  'deprecationReason': literalString(deprecationReason),
                if (attachments != null) 'attachments': refer(attachments)
              },
            )
            .accept(_dartEmitter)
            .toString();
      }
    }
  }));
  return inputMaybe.whereType<String>().toList();
}

GraphQLArg argInfoFromElement(Element element) {
  final argAnnot =
      const TypeChecker.fromRuntime(GraphQLArg).firstAnnotationOfExact(element);
  final defaultFunc = argAnnot?.getField('defaultFunc')?.toFunctionValue();
  final defaultCode = argAnnot?.getField('defaultCode')?.toStringValue();
  if (defaultFunc != null && defaultCode != null) {
    throw Exception(
      "Can't specify both defaultFunc: $defaultFunc and"
      ' defaultCode: $defaultCode in decorator GraphQLArg'
      ' for ${element.name}.',
    );
  }
  final String? _defaultFunc =
      defaultFunc != null ? executeCodeForExecutable(defaultFunc) : null;

  final argInfo = GraphQLArg(
    inline: argAnnot?.getField('inline')?.toBoolValue(),
    defaultCode: defaultCode ?? _defaultFunc,
    defaultFunc: null,
  );
  return argInfo;
}

String executeCodeForExecutable(ExecutableElement elem) {
  final parent = elem.enclosingElement;
  final prefix =
      elem.isStatic && parent is ClassElement ? '${parent.name}.' : '';
  return '$prefix${elem.name}()';
}

int _orderForParameter(ParameterElement a) {
  if (a.isRequiredPositional) return 0;
  if (a.isOptionalPositional) return 1;
  if (a.isRequiredNamed) return 2;
  return 3;
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

  String validationErrorMapAddAll(String validation) {
    return 'validationErrorMap.addAll($validation.errorsMap.map((k, v) =>'
        ' MapEntry(k is Enum ? k.name : k.toString(), v))..removeWhere'
        ' ((k, v) => v.isEmpty) );';
  }

  final hasFunctionValidation = _hasValidation(element);
  if (hasFunctionValidation) {
    final firstIndex = element.name.replaceFirstMapped(
      RegExp('[a-zA-Z0-9]'),
      (match) => match.input.substring(match.start, match.end).toUpperCase(),
    );
    final className = '${firstIndex}Args';

    final params = [...element.parameters]
      ..sort((a, b) => _orderForParameter(a) - _orderForParameter(b));

    validations.add(
      'final _validation = $className(${params.map((e) {
        final type = e.type.getDisplayString(withNullability: true);
        final getter =
            isReqCtx(e.type) ? 'ctx' : '(args["${e.name}"] as $type)';
        return '${e.isNamed ? '${e.name}:' : ''}$getter';
      }).join(',')}).validate();'
      '${validationErrorMapAddAll('_validation')}',
    );
  }
  bool makeGlobalValidation = hasFunctionValidation;
  final params = <String>[];
  for (final e in element.parameters) {
    final argName = e.name;
    if (isReqCtx(e.type)) {
      const value = 'ctx';
      params.add(e.isPositional ? value : '${argName}:$value');
    } else {
      final type = e.type.getDisplayString(withNullability: true);
      final typeName = e.type.getDisplayString(withNullability: false);
      final argInfo = argInfoFromElement(e);
      final value =
          argInfo.inline ? '${argName}Arg' : '(args["${argName}"] as $type)';
      if (argInfo.inline) {
        // TODO: 2G support generics
        validations.add(
          'final $value = '
          '${ReCase(typeName).camelCase}$serializerSuffix'
          '.fromJson(ctx.executionCtx.schema.serdeCtx, args);',
        );
      }
      if (_isValidation(e.type.element)) {
        // TODO: 2G pass validation resot in param (don't throw on validation errorπ)
        validationsInParams.add(e);
      }

      params.add(e.isPositional ? value : '${argName}:$value');

      if (!hasFunctionValidation && _hasValidation(e.type.element)) {
        makeGlobalValidation = true;
        final resultName = '${argName}ValidationResult';
        final _addToMap = argInfo.inline
            ? validationErrorMapAddAll(resultName)
            : "validationErrorMap['${argName}'] = [$resultName.toError(property: '${argName}')!];";
        validations.add('''
if ($value != null) {
  final $resultName = ${typeName}Validation.fromValue($value as $typeName);
  if ($resultName.hasErrors) {
    $_addToMap
  }
}
''');
      }
    }
  }
  if (makeGlobalValidation) {
    validations.insert(0, '''
final validationErrorMap = <String, List<ValidaError>>{};
''');
    validations.add('''
if (validationErrorMap.isNotEmpty) {
  throw GraphQLError(
    'Input validation error',
    extensions: {
      'validaErrors': validationErrorMap,
    },
    sourceError: validationErrorMap,
  );
}
''');
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
        ' final FutureOr<$_resolverClassName> _obj = \n// ignore: unnecessary_non_null_assertion\n$_getter;'
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
    throw Exception('$element should return a Stream to be a Subscription.');
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
      throw Exception(
        'You should provide a way to access an'
        ' instance of $ClassResolver ${parent.name}.',
      );
    } else if (!ref.isStatic) {
      throw Exception(
        'Getter "ref" of $ClassResolver ${parent.name} should be static.',
      );
    } else if (!const TypeChecker.fromRuntime(ScopedRef)
        .isAssignableFromType(ref.returnType)) {
      throw Exception(
        'Getter "ref" of $ClassResolver ${parent.name} should return a $ScopedRef.',
      );
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
//     !const TypeChecker.fromRuntime(ScopedHolder)
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
