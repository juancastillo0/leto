import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_generator/resolver_generator.dart';
import 'package:leto_generator/utils.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

Iterable<Future<FieldInfo>> fieldsFromClass(
  ClassElement clazz,
  GeneratorCtx ctx,
) {
  if (clazz.name == 'Object') {
    return [];
  }
  final generics = Map.fromEntries(
    clazz.typeParameters.map((e) => MapEntry(e.name, e)),
  );

  final config = getClassConfig(ctx, clazz);

  return [
    ...clazz.methods
        .where((method) => method.name != 'toJson' && method.name != 'fromJson')
        .map((m) => fieldFromElement(config, m, m.returnType, ctx, generics)),
    ...clazz.fields
        .map((m) => fieldFromElement(config, m, m.type, ctx, generics)),
    if (clazz.supertype != null)
      ...fieldsFromClass(clazz.supertype!.element, ctx),
    ...clazz.interfaces.expand((m) => fieldsFromClass(m.element, ctx)),
  ];
}

Future<List<UnionVarianInfo>> freezedVariants(
  ClassElement clazz,
  GeneratorCtx ctx,
) async {
  final isUnion =
      clazz.constructors.where(isFreezedVariantConstructor).length > 1;
  final className = ReCase(clazz.name).pascalCase;
  final _unionClassFields = fieldsFromClass(clazz, ctx);
  final classConfig = getClassConfig(ctx, clazz);

  return Future.wait(
      clazz.constructors.where(isFreezedVariantConstructor).map((con) async {
    final redirectedName = con.redirectedConstructor?.returnType
            .getDisplayString(withNullability: false) ??
        con.name;

    return UnionVarianInfo(
      isInterface: isInterface(clazz),
      typeParams: clazz.typeParameters,
      hasFrezzed: true,
      isUnion: isUnion,
      interfaces: getGraphQLInterfaces(ctx, clazz),
      hasFromJson: hasFromJson(clazz),
      classConfig: classConfig,
      typeName: isUnion ? redirectedName : className,
      constructorName: isUnion ? con.name : redirectedName,
      unionName: className,
      inputConfig: inputTypeAnnotation(clazz),
      description: getDescription(con, con.documentationComment),
      deprecationReason: getDeprecationReason(con),
      fields: await Future.wait(
        con.parameters
            .map((p) => fieldFromParam(ctx, classConfig, p))
            .followedBy(_unionClassFields),
      ),
    );
  }));
}

GraphQLField getFieldAnnot(GraphQLClass? clazz, Element e) {
  const graphQLFieldTypeChecker = TypeChecker.fromRuntime(GraphQLField);
  DartObject? _annot;
  if (!graphQLFieldTypeChecker.hasAnnotationOf(e, throwOnUnresolved: false)) {
    if (e is FieldElement && e.getter != null) {
      return getFieldAnnot(clazz, e.getter!);
    } else if (e is ParameterElement) {
      _annot = e.metadata.firstWhereOrNull(
        (element) {
          final type = element.computeConstantValue()?.type;
          return type != null && graphQLFieldTypeChecker.isExactlyType(type);
        },
      )?.computeConstantValue();
      // if (_annot == null) {
      //   return const GraphQLField();
      // }
    }
  }
  final annot = graphQLFieldTypeChecker.firstAnnotationOf(
    e,
    throwOnUnresolved: false,
  );

  final name = annot?.getField('name')?.toStringValue();
  final omit = annot?.getField('omit')?.toBoolValue();
  final nullable = annot?.getField('nullable')?.toBoolValue();
  final type = annot?.getField('type')?.toStringValue();

  return GraphQLField(
    name: name,
    omit: omit ?? clazz?.omitFields,
    nullable: nullable ?? clazz?.nullableFields,
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

Future<FieldInfo> fieldFromElement(
  GraphQLClass? clazz,
  Element method,
  DartType type,
  GeneratorCtx ctx,
  Map<String, TypeParameterElement> generics,
) async {
  final annot = getFieldAnnot(clazz, method);
  return FieldInfo(
    gqlType: annot.type != null
        ? refer(annot.type!)
        : inferType(
            ctx.config.customTypes,
            method,
            method.name!,
            type,
            nullable: annot.nullable,
            generics: generics,
          ),
    name: annot.name ?? method.name!,
    defaultValueCode: getDefaultValue(method),
    getter: method is MethodElement
        ? await resolverFunctionBodyFromElement(ctx, method)
        : method.name!,
    inputs: method is MethodElement
        ? await inputsFromElement(ctx, method)
        : const [],
    isMethod: method is MethodElement,
    nonNullable: annot.nullable != true &&
        type.nullabilitySuffix == NullabilitySuffix.none,
    fieldAnnot: annot,
    description: getDescription(method, method.documentationComment),
    deprecationReason: getDeprecationReason(method),
  );
}

Future<FieldInfo> fieldFromParam(
  GeneratorCtx ctx,
  GraphQLClass? clazz,
  ParameterElement param,
) async {
  final annot = getFieldAnnot(clazz, param);

  return FieldInfo(
    gqlType: annot.type != null
        ? refer(annot.type!)
        : inferType(
            ctx.config.customTypes,
            param,
            param.name,
            param.type,
            nullable: annot.nullable,
          ),
    name: annot.name ?? param.name,
    defaultValueCode: getDefaultValue(param),
    getter: param.name,
    isMethod: false,
    inputs: [],
    nonNullable: annot.nullable != true && param.isNotOptional,
    fieldAnnot: annot,
    description: await documentationOfParameter(param, ctx.buildStep),
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
  key: "$typeName",
  fromJson: (ctx, json) => $typeName.fromJson(json), // $prefix\$${_constructorName}FromJson,
  // toJson: (m) => $prefix\$${_constructorName}ToJson(m as ${hasFrezzed ? '_\$' : ''}$_constructorName),
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
  final GraphQLClass? classConfig;
  final bool isInterface;
  final bool hasFromJson;
  final List<Expression> interfaces;
  final bool hasFrezzed;
  final GraphQLInput? inputConfig;
  bool get isInput => inputConfig != null;
  final bool isUnion;
  final List<TypeParameterElement> typeParams;

  const UnionVarianInfo({
    required this.typeName,
    required this.constructorName,
    required this.unionName,
    required this.fields,
    required this.classConfig,
    required this.description,
    required this.deprecationReason,
    required this.isInterface,
    required this.hasFromJson,
    required this.interfaces,
    required this.hasFrezzed,
    required this.inputConfig,
    required this.isUnion,
    required this.typeParams,
  });

  Code serializer() {
    return Code(
      isInterface || typeParams.isNotEmpty || !hasFromJson
          ? ''
          : serializerDefinitionCode(
              typeName,
              hasFrezzed: hasFrezzed,
              constructorName: isUnion ? null : constructorName,
            ),
    );
  }

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

  String _typeList({bool ext = false}) {
    return typeParams.isNotEmpty
        ? '<${typeParams.map((e) {
            final _e = ext && e.bound != null
                ? ' extends ${e.bound!.getDisplayString(withNullability: true)}'
                : '';

            return '${e.displayName}$_e';
          }).join(',')}>'
        : '';
  }

  String removeTrailingUnder(String value) =>
      value.startsWith('_') ? value.substring(1) : value;

  String fieldCode() {
    final hasTypeParams = typeParams.isNotEmpty;
    final _typeParamsStr = typeParams.map((e) {
      final _t = e.displayName;
      return 'GraphQLType<$_t, Object> ${ReCase(_t).camelCase}$graphqlTypeSuffix,';
    }).join();

    final _type =
        'GraphQL${isInput ? 'Input' : ''}ObjectType<$typeName${_typeList()}>';

    final _typeNoExt = 'GraphQL${isInput ? 'Input' : ''}ObjectType<$typeName>';
    final _cacheGetter = hasTypeParams ? '_$fieldName[__name]' : '_$fieldName';

    return '''
${hasTypeParams && hasFromJson ? 'final ${ReCase(typeName).camelCase}SerdeCtx = SerdeCtx();' : ''}
${hasTypeParams ? 'Map<String, $_typeNoExt> _$fieldName = {}' : '$_type? _$fieldName'};
/// Auto-generated from [$typeName].
$_type ${hasTypeParams ? '$fieldName${_typeList(ext: true)}($_typeParamsStr)' : 'get $fieldName'} {
  final __name = '$graphQLTypeName';
  if ($_cacheGetter != null) return $_cacheGetter! as $_type;

  final __$fieldName = ${expression().accept(DartEmitter())};
  ${hasTypeParams && hasFromJson ? '''
  ${ReCase(typeName).camelCase}SerdeCtx.add(
    SerializerValue<$typeName${_typeList()}>(
      fromJson: (ctx, json) => $typeName.fromJson(json, ${typeParams.map((p) => 'ctx.fromJson').join(',')}),
    ),
  );''' : ''}
  $_cacheGetter = __$fieldName;
  __$fieldName.fields.addAll(${literalList(
      () {
        // deduplicate field names
        final _names = <String>{};
        return fields
            .where((e) => _names.add(e.getter) && e.fieldAnnot.omit != true)
            .map((e) => e.expression(isInput: isInput));
      }(),
    ).accept(DartEmitter())},);

  return __$fieldName;
}
''';
  }

  String get graphQLTypeName =>
      '${classConfig?.name ?? inputConfig?.name ?? removeTrailingUnder(typeName)}${typeParams.map((t) {
        final _t = t.displayName;
        final ts = '${ReCase(_t).camelCase}$graphqlTypeSuffix';
        return '\${$ts.printableName}';
      }).join()}';

  String get unionKeyName =>
      '${ReCase(unionName).camelCase}$graphqlTypeSuffix$unionKeySuffix()';

  Expression expression() {
    return refer(
      isInput
          ? 'inputObjectType<$typeName${_typeList()}>'
          : 'objectType<$typeName${_typeList()}>',
    ).call(
      [refer('__name')],
      {
        if (!isInput) 'isInterface': literalBool(isInterface),
        if (!isInput) 'interfaces': literalList(interfaces),
        if (description != null && description!.isNotEmpty)
          'description': literalString(description!),
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
  final List<String> inputs;
  final String? description;
  final GraphQLField fieldAnnot;
  final String? deprecationReason;
  final String? defaultValueCode;

  const FieldInfo({
    required this.name,
    required this.getter,
    required this.isMethod,
    required this.defaultValueCode,
    required this.nonNullable,
    required this.gqlType,
    required this.inputs,
    required this.description,
    required this.deprecationReason,
    required this.fieldAnnot,
  });

  Expression expression({bool isInput = false}) {
    final _type =
        isInput ? gqlType.property('coerceToInputObject').call([]) : gqlType;
    return _type.property(isInput ? 'inputField' : 'field').call(
      [
        literalString(name),
      ],
      {
        if (!isInput)
          'resolve': Method(
            (m) => m
              ..requiredParameters.addAll([
                Parameter((p) => p..name = 'obj'),
                Parameter((p) => p..name = 'ctx'),
              ])
              ..body = Code(isMethod ? getter : 'obj.$getter')
              ..lambda = !isMethod,
          ).genericClosure,
        if (!isInput && inputs.isNotEmpty)
          'inputs': literalList(inputs.map(refer)),
        if (isInput && defaultValueCode != null)
          'defaultValue': refer(defaultValueCode!),
        if (description != null && description!.isNotEmpty)
          'description': literalString(description!),
        if (deprecationReason != null)
          'deprecationReason': literalString(deprecationReason!)
      },
    );
  }
}
