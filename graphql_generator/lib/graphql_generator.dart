import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_generator/build_context.dart';
import 'package:graphql_generator/generator_models.dart';
import 'package:graphql_generator/utils.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

/// Generates GraphQL schemas, statically.
Builder graphQLBuilder(Object _) {
  return SharedPartBuilder([_GraphQLGenerator()], 'graphql_types');
}

const _jsonSerializableTypeChecker = TypeChecker.fromRuntime(JsonSerializable);
const _freezedTypeChecker = TypeChecker.fromRuntime(Freezed);

class _GraphQLGenerator extends GeneratorForAnnotation<GraphQLObjectDec> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is ClassElement) {
      try {
        final ctx = element.isEnum
            ? null
            : await buildContext(
                element,
                annotation,
                buildStep,
                buildStep.resolver,
                false, // TODO: serializableTypeChecker.hasAnnotationOf(element),
              );
        final lib =
            await buildSchemaLibrary(element, ctx, annotation, buildStep);
        return lib.accept(DartEmitter()).toString();
      } catch (e, s) {
        print('$e $s');
        return '/*$e $s*/';
      }
    } else {
      throw UnsupportedError('@GraphQLClass() is only supported on classes.');
    }
  }

  void _applyDescription(
    Map<String, Expression> named,
    Element element,
    String? docComment,
  ) {
    final docString = getDescription(element, docComment);
    if (docString != null) {
      named['description'] = literalString(docString);
    }
  }

  Future<Library> buildSchemaLibrary(
    ClassElement clazz,
    BuildContext? ctx,
    ConstantReader ann,
    BuildStep buildStep,
  ) async {
    final hasFrezzed = _freezedTypeChecker.hasAnnotationOfExact(clazz);

    if (hasFrezzed) {
      return generateFromFreezed(clazz, buildStep);
    } else if (clazz.isEnum) {
      return Library((b) {
        b.body.add(Field((b) {
          final args = <Expression>[literalString(clazz.name)];
          final values =
              clazz.fields.where((f) => f.isEnumConstant).map((f) => f.name);
          final named = <String, Expression>{};
          _applyDescription(named, clazz, clazz.documentationComment);
          args.add(
            literalConstMap(Map.fromEntries(
              values.map(
                (v) => MapEntry(
                  literalString(v),
                  refer('${clazz.name}.$v'),
                ),
              ),
            )),
          );

          b
            ..name = '${ReCase(clazz.name).camelCase}$graphqlTypeSuffix'
            ..docs.add('/// Auto-generated from [${clazz.name}].')
            ..type = TypeReference((b) => b
              ..symbol = 'GraphQLEnumType'
              ..types.add(refer(clazz.name)))
            ..modifier = FieldModifier.final$
            ..assignment = refer('enumType').call(args, named).code;
        }));
      });
    } else {
      final className = clazz.name;
      final redirectedName =
          clazz.constructors.firstWhere(isFreezedVariantConstructor).name;

      // TODO:
      // Also incorporate parent fields.
      // InterfaceType? search = clazz.thisType;
      // while (search != null &&
      //     !const TypeChecker.fromRuntime(Object).isExactlyType(search)) {
      //   for (final field in search.element.fields) {
      //     if (!ctxFields.any((f) => f.name == field.name)) {
      //       ctxFields.add(field);
      //     }
      //   }

      //   search = search.superclass;
      // }

      final classInfo = UnionVarianInfo(
        isInterface: isInterface(clazz),
        typeParams: clazz.typeParameters,
        hasFrezzed: false,
        isUnion: false,
        isInput: isInputType(clazz),
        interfaces: getGraphqlInterfaces(clazz),
        typeName: className,
        constructorName: redirectedName.isEmpty ? className : redirectedName,
        unionName: className,
        description: getDescription(clazz, clazz.documentationComment),
        deprecationReason: getDeprecationReason(clazz),
        fields: await Future.wait(
          fieldsFromClass(clazz, buildStep),
        ),
      );
      return Library((l) {
        l.body.add(classInfo.serializer());
        l.body.add(Code(classInfo.fieldCode()));
      });
    }
  }
}

Future<Library> generateFromFreezed(
  ClassElement clazz,
  BuildStep buildStep,
) async {
  final _fields = await freezedFields(
    clazz,
    buildStep,
  );

  return Library((l) {
    for (final variant in _fields) {
      l.body.add(variant.serializer());
      l.body.add(Code(variant.fieldCode()));
    }
    if (_fields.length == 1) {
      return;
    }

    final fieldName = '${ReCase(clazz.name).camelCase}$graphqlTypeSuffix';
    final typeName = clazz.name;

    l.body.add(Code('''
${serializerDefinitionCode(typeName, hasFrezzed: false)}

Map<String, Object?> _\$${typeName}ToJson($typeName instance) => instance.toJson();

GraphQLObjectField<String, String, P> $fieldName$unionKeySuffix<P extends $typeName>()
   => field(
  'runtimeType',
  enumTypeFromStrings('${typeName}Type', [
    ${_fields.map((e) => '"${e.constructorName}"').join(',')}
  ]),
);

GraphQLUnionType<$typeName>? _$fieldName;
GraphQLUnionType<$typeName> get $fieldName {
  return _$fieldName ??= GraphQLUnionType(
    '$typeName',
    [
      ${_fields.map((e) => e.fieldName).join(',')}
    ],
  );
}
'''));
  });
}
