import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:graphql_generator/resolver_generator.dart';
import 'package:graphql_generator/utils.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

Future<List<UnionVarianInfo>> freezedFields(
  ClassElement clazz,
  BuildStep buildStep, {
  required bool isUnion,
}) async {
  final className = ReCase(clazz.name).pascalCase;
  final _unionClassFields = clazz.methods
      .map((m) => fieldFromElement(m, m.returnType))
      .followedBy(clazz.fields.map((m) => fieldFromElement(m, m.type)));

  return Future.wait(
      clazz.constructors.where(isFreezedVariantConstructor).map((con) async {
    final redirectedName = con.redirectedConstructor?.returnType
            .getDisplayString(withNullability: false) ??
        con.name;

    return UnionVarianInfo(
      isInterface: isInterface(clazz),
      hasFrezzed: true,
      isUnion: isUnion,
      interfaces: getGraphqlInterfaces(clazz),
      typeName: isUnion ? redirectedName : className,
      constructorName: isUnion ? con.name : redirectedName,
      unionName: className,
      description: getDescription(con, con.documentationComment),
      deprecationReason: getDeprecationReason(con),
      fields: await Future.wait(
        con.parameters
            .map((p) => fieldFromParam(p, buildStep))
            .followedBy(_unionClassFields),
      ),
    );
  }));
}

GraphQLField getFieldAnnot(Element e) {
  const graphQLFieldTypeChecker = TypeChecker.fromRuntime(GraphQLField);
  DartObject? _annot;
  if (!graphQLFieldTypeChecker.hasAnnotationOf(e, throwOnUnresolved: false)) {
    if (e is FieldElement && e.getter != null) {
      return getFieldAnnot(e.getter!);
    } else if (e is ParameterElement) {
      _annot = e.metadata.firstWhereOrNull(
        (element) {
          final type = element.computeConstantValue()?.type;
          return type != null && graphQLFieldTypeChecker.isExactlyType(type);
        },
      )?.computeConstantValue();
    }
    if (_annot == null) {
      return const GraphQLField();
    }
  }
  final annot = graphQLFieldTypeChecker.firstAnnotationOf(
    e,
    throwOnUnresolved: false,
  )!;

  final name = annot.getField('name')?.toStringValue();
  final omit = annot.getField('omit')?.toBoolValue();
  final nullable = annot.getField('nullable')?.toBoolValue();
  final type = annot.getField('type')?.toStringValue();

  return GraphQLField(
    name: name,
    omit: omit,
    nullable: nullable,
    type: type,
  );
}

bool isFreezedVariantConstructor(ConstructorElement con) =>
    con.name != '_' && con.name != 'fromJson';

// Future<FieldInfo> fieldFromMethod(MethodElement method) async {
//   final annot = getFieldAnnot(method);
//   return FieldInfo(
//     gqlType: inferType('', method.name, method.type),
//     name: annot.name ?? method.name,
//     nonNullable: annot.nullable != true &&
//         method.returnType.nullabilitySuffix == NullabilitySuffix.none,
//     fieldAnnot: annot,
//     description: getDescription(method),
//     deprecationReason: getDeprecationReason(method),
//   );
// }

Future<FieldInfo> fieldFromElement(Element method, DartType type) async {
  final annot = getFieldAnnot(method);
  return FieldInfo(
    gqlType: annot.type != null
        ? refer(annot.type!)
        : inferType('', method.name!, type, nullable: annot.nullable),
    name: annot.name ?? method.name!,
    getter: method is MethodElement
        ? resolverFunctionBodyFromElement(method)
        : method.name!,
    isMethod: method is MethodElement,
    nonNullable: annot.nullable != true &&
        type.nullabilitySuffix == NullabilitySuffix.none,
    fieldAnnot: annot,
    description: getDescription(method, method.documentationComment),
    deprecationReason: getDeprecationReason(method),
  );
}

Future<FieldInfo> fieldFromParam(
  ParameterElement param,
  BuildStep buildStep,
) async {
  final annot = getFieldAnnot(param);
  return FieldInfo(
    gqlType: annot.type != null
        ? refer(annot.type!)
        : inferType('', param.name, param.type, nullable: annot.nullable),
    name: annot.name ?? param.name,
    getter: param.name,
    isMethod: false,
    nonNullable: annot.nullable != true && param.isNotOptional,
    fieldAnnot: annot,
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

  // Field field() {
  //   return Field(
  //     (b) => b
  //       ..name = fieldName
  //       ..docs.add('/// Auto-generated from [$typeName].')
  //       ..type = refer('GraphQLObjectType<$typeName>')
  //       ..modifier = FieldModifier.final$
  //       ..assignment = expression().code,
  //   );
  // }

  String fieldCode() {
    return '''
GraphQLObjectType<$typeName>? _$fieldName;
/// Auto-generated from [$typeName].
GraphQLObjectType<$typeName> get $fieldName {
  if (_$fieldName != null) return _$fieldName!;

  _$fieldName = ${expression().accept(DartEmitter())};
  _$fieldName!.fields.addAll(${literalList(
      fields
          .where((e) => e.fieldAnnot.omit != true)
          .map((e) => e.expression())
          .followedBy([if (isUnion) refer(unionKeyName)]),
    ).accept(DartEmitter())},);

  return _$fieldName!;
}
''';
  }

  String get unionKeyName =>
      '${ReCase(unionName).camelCase}$graphqlTypeSuffix$unionKeySuffix()';

  Expression expression() {
    return refer('objectType').call(
      [literalString(typeName)],
      {
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
  final String getter;
  final bool isMethod;
  final bool nonNullable;
  final Expression gqlType;
  final String? description;
  final GraphQLField fieldAnnot;
  final String? deprecationReason;

  const FieldInfo({
    required this.name,
    required this.getter,
    required this.isMethod,
    required this.nonNullable,
    required this.gqlType,
    required this.description,
    required this.deprecationReason,
    required this.fieldAnnot,
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
            ..body = Code(isMethod ? getter : 'obj.$getter')
            ..lambda = !isMethod,
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
