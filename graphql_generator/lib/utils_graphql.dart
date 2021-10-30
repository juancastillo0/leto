import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:graphql_generator/config.dart';
import 'package:graphql_generator/utils.dart';
import 'package:graphql_schema/graphql_schema.dart';
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

List<Expression> getGraphqlInterfaces(ClassElement clazz) {
  if (isInputType(clazz)) {
    return [];
  }
  final annot = graphQLClassTypeChecker.firstAnnotationOfExact(clazz);
  final List<String> interfaces = annot!
      .getField('interfaces')!
      .toListValue()!
      .map((i) => i.toStringValue()!)
      .toList();
  // Add interfaces
  return clazz.interfaces
      .where(isGraphQLClass)
      .map((c) {
        // TODO: serializableTypeChecker.hasAnnotationOf(c.element) &&
        final name = c.name!.startsWith('_') ? c.name!.substring(1) : c.name!;
        final rc = ReCase(name);
        return refer('${rc.camelCase}$graphqlTypeSuffix');
      })
      .followedBy(interfaces.map(refer))
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
}) {
  // Next, check if this is the "id" field of a `Model`.
  // TODO:
  // if (const TypeChecker.fromRuntime(Model).isAssignableFromType(type) &&
  //     name == 'id') {
  //   return refer('graphQLId');
  // }

  final genericWhenAsync = genericTypeWhenFutureOrStream(type);
  if (genericWhenAsync != null) {
    return inferType(customTypes, className, name, genericWhenAsync);
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
    final inner = inferType(customTypes, className, name, arg);
    return _wrapNullability(refer('listOf').call([inner]));
  } else if (type is InterfaceType && type.typeArguments.isNotEmpty) {
    return _wrapNullability(
      refer('${ReCase(type.element.name).camelCase}$graphqlTypeSuffix').call([
        ...type.typeArguments
            .map((e) => inferType(customTypes, className, name, e)),
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

  // Firstly, check if it's a GraphQL class.
  if (type is! InterfaceType ||
      (!isGraphQLClass(type) && !isInputType(type.element))) {
    log.warning('Cannot infer the GraphQL type for '
        'field $className.$name (type=$type).');
  }

  final externalName = // TODO: serializableTypeChecker.hasAnnotationOf(c.element) &&
      typeName.startsWith('_') ? typeName.substring(1) : typeName;
  return _wrapNullability(
    refer('${ReCase(externalName).camelCase}$graphqlTypeSuffix'),
  );

  // Nothing else is allowed.
  // throw 'Cannot infer the GraphQL type for '
  //     'field $className.$name (type=$type).';
}

String getReturnType(DartType _retType) {
  if (_retType is ParameterizedType && _retType.typeArguments.isNotEmpty) {
    if (_retType.isDartCoreList) {
      final param = _retType.typeArguments.first;
      final _nullability =
          param.nullabilitySuffix == NullabilitySuffix.none ? '?' : '';
      return 'List<${getReturnType(param)}$_nullability>';
    } else {
      return '${_retType.element!.name}'
          '<${_retType.typeArguments.map((t) => getReturnType(t)).join(',')}>';
    }
  }
  return _retType.getDisplayString(withNullability: true);
}
