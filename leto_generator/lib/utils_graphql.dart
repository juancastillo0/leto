import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:leto_generator/config.dart';
import 'package:leto_generator/utils.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

const graphQLObjectTypeChecker = TypeChecker.fromRuntime(GraphQLObject);

String get serializerSuffix => 'Serializer';
String get graphqlTypeSuffix => 'GraphQLType';
String get unionKeySuffix => 'Discriminant';
String get graphQLFieldSuffix => 'GraphQLField';

bool isGraphQLObject(InterfaceType clazz) {
  InterfaceType? search = clazz;

  while (search != null) {
    if (graphQLObjectTypeChecker.hasAnnotationOf(search.element)) return true;
    search = search.superclass;
  }

  return false;
}

List<Expression> getGraphQLInterfaces(GeneratorCtx ctx, ClassElement clazz) {
  // if (isInputType(clazz)) {
  //   return [];
  // }
  final List<String> interfaces = getClassConfig(ctx, clazz)?.interfaces ?? [];
  final superType = clazz.supertype;

  String getInterfaceName(ClassElement element) {
    String name = element.name;
    name = name.startsWith('_') ? name.substring(1) : name;
    final rc = ReCase(name);
    return '${rc.camelCase}$graphqlTypeSuffix';
  }

  // Add interfaces
  return clazz.interfaces
      .where(isGraphQLObject)
      .map((c) => refer(getInterfaceName(c.element)))
      .followedBy(interfaces.map(refer))
      .followedBy(superType != null && isGraphQLObject(superType)
          ? [refer(getInterfaceName(superType.element))]
          : [])
      .toList();
}

GraphQLObject? getClassConfig(GeneratorCtx ctx, ClassElement clazz) {
  final annot = graphQLObjectTypeChecker.firstAnnotationOfExact(clazz);
  if (annot != null) {
    return GraphQLObject(
      interfaces: annot
          .getField('interfaces')!
          .toListValue()!
          .map((i) => i.toStringValue()!)
          .toList(),
      name: annot.getField('name')?.toStringValue(),
      nullableFields: annot.getField('nullableFields')?.toBoolValue() ??
          ctx.config.nullableFields,
      omitFields:
          annot.getField('omitFields')?.toBoolValue() ?? ctx.config.omitFields,
    );
  }
}

bool isInterface(ClassElement clazz) {
  return clazz.isAbstract;
}

bool isStreamOrAsyncStream(DartType type) {
  DartType _type = type;
  if (type is ParameterizedType &&
      type.typeArguments.isNotEmpty &&
      (type.isDartAsyncFuture || type.isDartAsyncFutureOr)) {
    _type = type.typeArguments[0];
  }
  return const TypeChecker.fromRuntime(Stream).isAssignableFromType(_type);
}

DartType? genericTypeWhenFutureOrStream(DartType type) {
  if (type is ParameterizedType &&
      type.typeArguments.isNotEmpty &&
      (type.isDartAsyncFuture ||
          type.isDartAsyncFutureOr ||
          const TypeChecker.fromRuntime(Stream).isAssignableFromType(type))) {
    return genericTypeWhenFutureOrStream(type.typeArguments[0]) ??
        type.typeArguments[0];
  }
  return null;
}

bool isInputType(Element elem) => inputTypeAnnotation(elem) != null;

GraphQLInput? inputTypeAnnotation(Element elem) {
  final _isInput =
      const TypeChecker.fromRuntime(GraphQLInput).firstAnnotationOfExact(elem);
  if (_isInput != null && (elem is! ClassElement || !hasFromJson(elem))) {
    throw Exception(
      'A class annotated with GraphQLInput'
      ' should have a fromJson static method or constructor.',
    );
  }
  return _isInput == null
      ? null
      : GraphQLInput(
          name: _isInput.getField('name')?.toStringValue(),
          constructor: _isInput.getField('constructor')?.toStringValue(),
          oneOf: _isInput.getField('oneOf')?.toBoolValue(),
        );
}

Expression inferType(
  List<CustomTypes> customTypes,
  Element typeElement,
  String name,
  DartType type, {
  bool? nullable,
  String? genericTypeName,
  Map<String, TypeParameterElement>? generics,
  bool isInput = false,
}) {
  final docs = getDocumentation(typeElement);
  if (docs?.typeName != null) {
    return refer(docs!.typeName!.toString());
  }
  // Next, check if this is the "id" field of a `Model`.
  // TODO: 1G make the id configurable, maybe with @key(fields: "") directive
  // if (const TypeChecker.fromRuntime(Model).isAssignableFromType(type) &&
  //     name == 'id') {
  //   return refer('graphQLId');
  // }

  final genericWhenAsync = genericTypeWhenFutureOrStream(type);
  if (genericWhenAsync != null) {
    return inferType(
      customTypes,
      typeElement,
      name,
      genericWhenAsync,
      generics: generics,
      isInput: isInput,
    );
  }
  final nonNullable = type.nullabilitySuffix == NullabilitySuffix.none;
  Expression _wrapNullability(Expression exp) =>
      nonNullable && nullable != true ? exp.property('nonNull').call([]) : exp;

  const primitive = {
    String: 'graphQLString',
    int: 'graphQLInt',
    double: 'graphQLFloat',
    bool: 'graphQLBoolean',
    DateTime: 'graphQLDate',
    Uri: 'graphQLUri',
    BigInt: 'graphQLBigInt',
  };

  // Check to see if it's a primitive type.
  for (final entry in primitive.entries) {
    if (type.element != null &&
        TypeChecker.fromRuntime(entry.key).isAssignableFrom(type.element!)) {
      if (entry.key == String && name == 'id') {
        return _wrapNullability(refer('graphQLId'));
      }
      return _wrapNullability(refer(entry.value));
    }
  }

  final typeName =
      type.getDisplayString(withNullability: false).split('<').first;
  final customType = customTypes.firstWhereOrNull((t) => t.name == typeName);
  if (customType != null) {
    return _wrapNullability(refer(customType.getter, customType.import));
  }

  Expression _wrapExpression(Expression exp) {
    if (type is InterfaceType && type.typeArguments.isNotEmpty) {
      // Generics
      return _wrapNullability(
        exp.call([
          ...type.typeArguments.map((e) {
            return inferType(
              customTypes,
              typeElement,
              name,
              e,
              generics: generics,
              isInput: isInput,
            );
          }),
        ], {
          if (genericTypeName != null) 'name': literalString(genericTypeName)
        }, [
          ...type.typeArguments.map(getReturnType).map(refer)
        ]),
      );
    }

    return _wrapNullability(exp);
  }

  final element = type.element;
  if (element is ClassElement) {
    final ExecutableElement? e =
        element.getGetter('graphQLType') ?? element.getMethod('graphQLType');
    if (e != null) {
      if (!e.isStatic) {
        throw Exception(
          'The getter or method "$typeName.graphQLType" should be static.',
        );
      }
      final prop = refer(typeName).property(e.name);
      return _wrapExpression(prop);
    }
  }

  final _inputSuffix = isInput &&
          type.element != null &&
          const TypeChecker.fromRuntime(GraphQLInput)
              .hasAnnotationOf(type.element!)
      ? 'Input'
      : '';

  // Next, check to see if it's a List.
  if (type is InterfaceType &&
      type.typeArguments.isNotEmpty &&
      const TypeChecker.fromRuntime(Iterable).isAssignableFromType(type)) {
    final arg = type.typeArguments[0];
    final inner = inferType(
      customTypes,
      typeElement,
      name,
      arg,
      generics: generics,
      isInput: isInput,
    );
    return _wrapNullability(inner.property('list').call([]));
  }

  final externalName =
      typeName.startsWith('_') ? typeName.substring(1) : typeName;

  // Firstly, check if it's a GraphQL class.
  if (type is! InterfaceType ||
      !const TypeChecker.fromRuntime(BaseGraphQLTypeDecorator)
          .hasAnnotationOf(type.element)) {
    if (type is TypeParameterType && generics != null) {
      final generic = generics[typeName];
      if (generic != null) {
        final isNonNull = nullable != true &&
            type.nullabilitySuffix == NullabilitySuffix.none &&
            generic.bound?.nullabilitySuffix == NullabilitySuffix.none;
        final nullability = isNonNull
            ? '.nonNull()'
            : type.nullabilitySuffix != NullabilitySuffix.none
                ? '.nullable()'
                : '';
        return refer(
          '${ReCase(externalName).camelCase}$graphqlTypeSuffix$nullability',
        );
      }
    }
    final _namePrefix = typeElement.enclosingElement is ClassElement
        ? '${typeElement.enclosingElement!.name!}.'
        : '';
    log.warning(
      'Cannot infer the GraphQLType for field $_namePrefix$name (type=$type).'
      ' Please annotate the Dart type, provide a $typeName.graphQLType'
      ' static getter or add the type to `build.yaml` "customTypes" property.',
    );
  }

  return _wrapExpression(
    refer('${ReCase(externalName).camelCase}$graphqlTypeSuffix$_inputSuffix'),
  );

  // Nothing else is allowed.
  // throw 'Cannot infer the GraphQL type for '
  //     'field $className.$name (type=$type).';
}

String getReturnType(DartType _retType) {
  // if (_retType is ParameterizedType && _retType.typeArguments.isNotEmpty) {
  //   // if (_retType.isDartCoreList) {
  //   //   final param = _retType.typeArguments.first;
  //   //   final _nullability =
  //   //       param.nullabilitySuffix == NullabilitySuffix.none ? '?' : '';
  //   //   return 'List<${getReturnType(param)}$_nullability>';
  //   // } else {

  //   return '${_retType.element!.name}'
  //       '<${_retType.typeArguments.map((t) => getReturnType(t)).join(',')}>';
  //   // }
  // }
  return _retType.getDisplayString(withNullability: true);
}
