import 'dart:async';
import 'dart:mirrors';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart' show IterableExtension;
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
        /*
         */
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
    final classType = clazz.thisType.getDisplayString(withNullability: false);

    if (hasFrezzed) {
      return generateFromFreezed(clazz, buildStep);
    } else if (clazz.isEnum) {
      return Library((b) {
        b.body.add(Field((b) {
          // enumTypeFromStrings(String name, List<String> values, {String description})
          final args = <Expression>[literalString(clazz.name)];
          final values =
              clazz.fields.where((f) => f.isEnumConstant).map((f) => f.name);
          final named = <String, Expression>{};
          _applyDescription(named, clazz, clazz.documentationComment);
          args.add(literalConstList(values.map(literalString).toList()));

          b
            ..name = '${ReCase(clazz.name).camelCase}$graphqlTypeSuffix'
            ..docs.add('/// Auto-generated from [${clazz.name}].')
            ..type = TypeReference((b) => b
              ..symbol = 'GraphQLEnumType'
              ..types.add(refer('String')))
            ..modifier = FieldModifier.final$
            ..assignment = refer('enumTypeFromStrings').call(args, named).code;
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
    // return Library((b) {
    //   // Generate a top-level xGraphQLType object
    //   b.body.add(
    //     Code(serializerDefinitionCode(classType, hasFrezzed: hasFrezzed)),
    //   );

    //   b.body.add(Field((b) {
    //     final args = <Expression>[literalString(ctx!.modelClassName)];
    //     final named = <String, Expression>{
    //       'isInterface': literalBool(isInterface(clazz))
    //     };

    //     // Add documentation
    //     _applyDescription(named, clazz, clazz.documentationComment);

    //     // Add interfaces
    //     named['interfaces'] = literalList(getGraphqlInterfaces(clazz));

    //     // Add fields
    //     final ctxFields = ctx.fields.toList();

    //     // Also incorporate parent fields.
    //     InterfaceType? search = clazz.thisType;
    //     while (search != null &&
    //         !const TypeChecker.fromRuntime(Object).isExactlyType(search)) {
    //       for (final field in search.element.fields) {
    //         if (!ctxFields.any((f) => f.name == field.name)) {
    //           ctxFields.add(field);
    //         }
    //       }

    //       search = search.superclass;
    //     }

    //     final fields = <Expression>[];
    //     for (final field in ctxFields) {
    //       final named = <String, Expression>{};
    //       final originalField =
    //           clazz.fields.firstWhereOrNull((f) => f.name == field.name);

    //       // Check if it is deprecated.
    //       final depEl = originalField?.getter ?? originalField ?? field;
    //       final depAnn = getDeprecationReason(depEl);
    //       if (depAnn != null) {
    //         named['deprecationReason'] = literalString(depAnn);
    //       }

    //       // Description finder...
    //       _applyDescription(
    //         named,
    //         originalField?.getter ?? originalField ?? field,
    //         originalField?.getter?.documentationComment ??
    //             originalField?.documentationComment,
    //       );

    //       // Pick the type.
    //       final doc = graphQLDocTypeChecker.firstAnnotationOf(depEl);
    //       Expression? type;
    //       if (doc != null) {
    //         final cr = ConstantReader(doc);
    //         final typeName = cr.peek('typeName')?.symbolValue;
    //         if (typeName != null) type = refer(MirrorSystem.getName(typeName));
    //       }
    //       named['resolve'] = Method(
    //         (m) => m
    //           ..requiredParameters.addAll([
    //             Parameter((p) => p..name = 'obj'),
    //             Parameter((p) => p..name = 'ctx'),
    //           ])
    //           ..body = Code(
    //             'obj.${ctx.resolveFieldName(field.name)}',
    //           )
    //           ..lambda = true,
    //       ).genericClosure;

    //       fields.add(
    //         refer('field').call([
    //           literalString(ctx.resolveFieldName(field.name)!),
    //           type ??= inferType(clazz.name, field.name, field.type)
    //         ], named),
    //       );
    //     }
    //     named['fields'] = literalList(fields);

    //     b
    //       ..name = '${ctx.modelClassNameRecase.camelCase}$graphqlTypeSuffix'
    //       ..docs.add('/// Auto-generated from [${ctx.modelClassName}].')
    //       ..type = refer('GraphQLObjectType<${clazz.name}>')
    //       ..modifier = FieldModifier.final$
    //       ..assignment = refer('objectType').call(args, named).code;
    //   }));
    // });
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
