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

const graphQLClassTypeChecker = TypeChecker.fromRuntime(GraphQLClass);

String get serializerSuffix => 'Serializer';
String get graphqlTypeSuffix => 'GraphQLType';
String get unionKeySuffix => 'Discriminant';
String get graphQLFieldSuffix => 'GraphQLField';

bool isGraphQLClass(InterfaceType clazz) {
  InterfaceType? search = clazz;

  while (search != null) {
    if (graphQLClassTypeChecker.hasAnnotationOf(search.element)) return true;
    search = search.superclass;
  }

  return false;
}

List<Expression> getGraphQLInterfaces(GeneratorCtx ctx, ClassElement clazz) {
  if (isInputType(clazz)) {
    return [];
  }
  final annot = graphQLClassTypeChecker.firstAnnotationOfExact(clazz);
  final List<String> interfaces = annot!
      .getField('interfaces')!
      .toListValue()!
      .map((i) => i.toStringValue()!)
      .toList();
  final superType = clazz.supertype;

  String getInterfaceName(ClassElement element) {
    String name = element.name;
    name = name.startsWith('_') ? name.substring(1) : name;
    final rc = ReCase(name);
    return '${rc.camelCase}$graphqlTypeSuffix';
  }

  // Add interfaces
  return clazz.interfaces
      .where(isGraphQLClass)
      .map((c) => refer(getInterfaceName(c.element)))
      .followedBy(interfaces.map(refer))
      .followedBy(superType != null && isGraphQLClass(superType)
          ? [refer(getInterfaceName(superType.element))]
          : [])
      .toList();
}

bool isInterface(ClassElement clazz) {
  // TODO: && !serializableTypeChecker.hasAnnotationOf(clazz);
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

bool isInputType(Element elem) {
  final _isInput =
      const TypeChecker.fromRuntime(GraphQLInput).hasAnnotationOfExact(elem);
  if (_isInput && (elem is! ClassElement || !hasFromJson(elem))) {
    throw Exception(
      'A class annotated with GraphQLInput'
      ' should have a fromJson static method or constructor.',
    );
  }
  return _isInput;
}

Expression inferType(
  List<CustomTypes> customTypes,
  String className,
  String name,
  DartType type, {
  bool? nullable,
  String? genericTypeName,
  Map<String, TypeParameterElement>? generics,
}) {
  // Next, check if this is the "id" field of a `Model`.
  // TODO:
  // if (const TypeChecker.fromRuntime(Model).isAssignableFromType(type) &&
  //     name == 'id') {
  //   return refer('graphQLId');
  // }

  final genericWhenAsync = genericTypeWhenFutureOrStream(type);
  if (genericWhenAsync != null) {
    return inferType(
      customTypes,
      className,
      name,
      genericWhenAsync,
      generics: generics,
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
  };

  // Check to see if it's a primitive type.
  for (final entry in primitive.entries) {
    if (TypeChecker.fromRuntime(entry.key).isAssignableFromType(type)) {
      if (entry.key == String && name == 'id') {
        return _wrapNullability(refer('graphQLId'));
      }
      return _wrapNullability(refer(entry.value));
    }
  }

  // Next, check to see if it's a List.
  if (type is InterfaceType &&
      type.typeArguments.isNotEmpty &&
      const TypeChecker.fromRuntime(Iterable).isAssignableFromType(type)) {
    final arg = type.typeArguments[0];
    final inner = inferType(
      customTypes,
      className,
      name,
      arg,
      generics: generics,
    );
    return _wrapNullability(inner.property('list').call([]));
  } else if (type is InterfaceType && type.typeArguments.isNotEmpty) {
    return _wrapNullability(
      refer('${ReCase(type.element.name).camelCase}$graphqlTypeSuffix').call([
        ...type.typeArguments.map((e) {
          return inferType(
            customTypes,
            className,
            name,
            e,
            generics: generics,
          );
        }),
      ], {
        if (genericTypeName != null) 'name': literalString(genericTypeName)
      }, [
        ...type.typeArguments.map(getReturnType).map(refer)
      ]),
    );
  }

  final typeName = type.getDisplayString(withNullability: false);
  final customType = customTypes.firstWhereOrNull((t) => t.name == typeName);
  if (customType != null) {
    return _wrapNullability(refer(customType.getter, customType.import));
  }

  final externalName = // TODO: serializableTypeChecker.hasAnnotationOf(c.element) &&
      typeName.startsWith('_') ? typeName.substring(1) : typeName;

  // Firstly, check if it's a GraphQL class.
  if (type is! InterfaceType ||
      (!isGraphQLClass(type) && !isInputType(type.element))) {
    if (type is TypeParameterType && generics != null) {
      final generic = generics[typeName];
      if (generic != null) {
        final isNonNull = nullable != true &&
            type.nullabilitySuffix == NullabilitySuffix.none &&
            generic.bound?.nullabilitySuffix == NullabilitySuffix.none;
        final nullability = isNonNull ? '.nonNull()' : '';
        return refer(
          '${ReCase(externalName).camelCase}$graphqlTypeSuffix$nullability',
        );
      }
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
        if (e is MethodElement) {
          // TODO: generics
          return _wrapNullability(prop.call([]));
        }
        return _wrapNullability(prop);
      }
    }

    log.warning('Cannot infer the GraphQL type for '
        'field $className.$name (type=$type).');
  }
  return _wrapNullability(
    refer('${ReCase(externalName).camelCase}$graphqlTypeSuffix'),
  );

  // Nothing else is allowed.
  // throw 'Cannot infer the GraphQL type for '
  //     'field $className.$name (type=$type).';
}

String getReturnType(DartType _retType) {
  if (_retType is ParameterizedType && _retType.typeArguments.isNotEmpty) {
    // if (_retType.isDartCoreList) {
    //   final param = _retType.typeArguments.first;
    //   final _nullability =
    //       param.nullabilitySuffix == NullabilitySuffix.none ? '?' : '';
    //   return 'List<${getReturnType(param)}$_nullability>';
    // } else {
    return '${_retType.element!.name}'
        '<${_retType.typeArguments.map((t) => getReturnType(t)).join(',')}>';
    // }
  }
  return _retType.getDisplayString(withNullability: true);
}
