import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:graphql_generator/utils.dart';
import 'package:recase/recase.dart';

Future<List<UnionVarianInfo>> freezedFields(
  ClassElement clazz,
  BuildStep buildStep, {
  required bool isUnion,
}) async {
  final className = ReCase(clazz.name).pascalCase;
  return Future.wait(
      clazz.constructors.where(isFreezedVariantConstructor).map((con) async {
    return UnionVarianInfo(
      isInterface: isInterface(clazz),
      hasFrezzed: true,
      isUnion: isUnion,
      interfaces: getGraphqlInterfaces(clazz),
      typeName: isUnion
          ? con.redirectedConstructor?.returnType
                  .getDisplayString(withNullability: false) ??
              con.name
          : className,
      constructorName: isUnion
          ? con.name
          : con.redirectedConstructor?.returnType
                  .getDisplayString(withNullability: false) ??
              con.name,
      unionName: className,
      description: getDescription(con),
      deprecationReason: getDeprecationReason(con),
      fields: await Future.wait(
        con.parameters.map(
          (p) => fieldFromParam(p, buildStep),
        ),
      ),
    );
  }));
}

bool isFreezedVariantConstructor(ConstructorElement con) =>
    con.name != '_' && con.name != 'fromJson';

Future<FieldInfo> fieldFromParam(
  ParameterElement param,
  BuildStep buildStep,
) async {
  return FieldInfo(
    gqlType: inferType('', param.name, param.type),
    name: param.name,
    nonNullable: param.isNotOptional,
    description: await documentationOfParameter(param, buildStep),
    deprecationReason: getDeprecationReason(param),
  );
}

String serializerDefinitionCode(
  String typeName, {
  required bool hasFrezzed,
  String? constructorName,
}) {
  final _constructorName = constructorName ?? typeName;
  final prefix = hasFrezzed ? '_\$' : '_';
  return '''

final ${ReCase(typeName).camelCase}$serializerSuffix = SerializerValue<$typeName>(
  fromJson: $prefix\$${_constructorName}FromJson,
  toJson: (m) => $prefix\$${_constructorName}ToJson(m as ${hasFrezzed ? '_\$' : ''}$_constructorName),
);
''';
}

class UnionVarianInfo {
  final String typeName;
  final String constructorName;
  final String unionName;
  final String? description;
  final String? deprecationReason;
  final List<FieldInfo> fields;
  final bool isInterface;
  final List<Expression> interfaces;
  final bool hasFrezzed;
  final bool isUnion;

  const UnionVarianInfo({
    required this.typeName,
    required this.constructorName,
    required this.unionName,
    required this.fields,
    required this.description,
    required this.deprecationReason,
    required this.isInterface,
    required this.interfaces,
    required this.hasFrezzed,
    required this.isUnion,
  });

  Code serializer() {
    return Code(serializerDefinitionCode(
      typeName,
      hasFrezzed: hasFrezzed,
      constructorName: isUnion ? null : constructorName,
    ));
  }

  // String get typeName => name;
  String get fieldName => '${ReCase(typeName).camelCase}$graphqlTypeSuffix';

  Field field() {
    return Field(
      (b) => b
        ..name = fieldName
        ..docs.add('/// Auto-generated from [$typeName].')
        ..type = refer('GraphQLObjectType<$typeName>')
        ..modifier = FieldModifier.final$
        ..assignment = expression().code,
    );
  }

  String get unionKeyName =>
      '${ReCase(unionName).camelCase}$graphqlTypeSuffix$unionKeySuffix()';

  Expression expression() {
    return refer('objectType').call(
      [literalString(typeName)],
      {
        'fields': literalList(
          fields
              .map((e) => e.expression())
              .followedBy([if (isUnion) refer(unionKeyName)]),
        ),
        'isInterface': literalBool(isInterface),
        'interfaces': literalList(interfaces),
        'description': description == null || description!.isEmpty
            ? literalNull
            : literalString(description!),
        // 'deprecationReason': deprecationReason == null
        //     ? literalNull
        //     : literalString(deprecationReason!)
      },
    );
  }
}

class FieldInfo {
  final String name;
  final bool nonNullable;
  final Expression gqlType;
  final String? description;
  final String? deprecationReason;

  const FieldInfo({
    required this.name,
    required this.nonNullable,
    required this.gqlType,
    required this.description,
    required this.deprecationReason,
  });

  Expression expression() {
    return refer('field').call(
      [
        literalString(name),
        gqlType,
      ],
      {
        'resolve': Method(
          (m) => m
            ..requiredParameters.addAll([
              Parameter((p) => p..name = 'obj'),
              Parameter((p) => p..name = 'ctx'),
            ])
            ..body = Code('obj.$name')
            ..lambda = true,
        ).genericClosure,
        'description': description == null || description!.isEmpty
            ? literalNull
            : literalString(description!),
        'deprecationReason': deprecationReason == null
            ? literalNull
            : literalString(deprecationReason!)
      },
    );
  }
}
