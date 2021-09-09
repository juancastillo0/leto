import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

const graphQLClassTypeChecker = TypeChecker.fromRuntime(GraphQLClass);

String get serializerSuffix => 'Serializer';
String get graphqlTypeSuffix => 'GraphQlType';
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
  // Add interfaces
  return clazz.interfaces.where(isGraphQLClass).map((c) {
    // TODO: serializableTypeChecker.hasAnnotationOf(c.element) &&
    final name = c.name!.startsWith('_') ? c.name!.substring(1) : c.name!;
    final rc = ReCase(name);
    return refer('${rc.camelCase}$graphqlTypeSuffix');
  }).toList();
}

bool isInterface(ClassElement clazz) {
  //TODO: && !serializableTypeChecker.hasAnnotationOf(clazz);
  return clazz.isAbstract;
}

Expression inferType(String className, String name, DartType type) {
  // Next, check if this is the "id" field of a `Model`.
  // TODO:
  // if (const TypeChecker.fromRuntime(Model).isAssignableFromType(type) &&
  //     name == 'id') {
  //   return refer('graphQLId');
  // }

  final nonNullable = type.nullabilitySuffix == NullabilitySuffix.none;
  Expression _wrapNullability(Expression exp) =>
      nonNullable ? exp.property('nonNullable').call([]) : exp;

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
      return _wrapNullability(refer(entry.value));
    }
  }

  // Next, check to see if it's a List.
  if (type is InterfaceType &&
      type.typeArguments.isNotEmpty &&
      const TypeChecker.fromRuntime(Iterable).isAssignableFromType(type)) {
    final arg = type.typeArguments[0];
    final inner = inferType(className, name, arg);
    return _wrapNullability(refer('listOf').call([inner]));
  }

  final typeName = type.getDisplayString(withNullability: false);
  // Firstly, check if it's a GraphQL class.
  if (type is! InterfaceType || !isGraphQLClass(type)) {
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
