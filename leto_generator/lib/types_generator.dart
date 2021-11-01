import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:leto_generator/config.dart';
import 'package:leto_generator/generator_models.dart';
import 'package:leto_generator/utils.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

/// Generates GraphQL schemas, statically.
Builder graphQLBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [_GraphQLGenerator(Config.fromJson(options.config))],
    'graphql_types',
  );
}

class _GraphQLGenerator extends GeneratorForAnnotation<GraphQLObjectDec> {
  final Config config;

  _GraphQLGenerator(this.config);

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is ClassElement) {
      try {
        final ctx = GeneratorCtx(buildStep: buildStep, config: config);
        // element.isEnum
        //     ? null
        //     : await buildContext(
        //         element,
        //         annotation,
        //         buildStep,
        //         buildStep.resolver,
        //         false, // TODO: serializableTypeChecker.hasAnnotationOf(element),
        //       );
        final lib = await buildSchemaLibrary(element, ctx, annotation);
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
    GeneratorCtx ctx,
    ConstantReader ann,
  ) async {
    final hasFrezzed = freezedTypeChecker.hasAnnotationOfExact(clazz);
    final hasJsonAnnotation =
        jsonSerializableTypeChecker.hasAnnotationOf(clazz);

    if (hasFrezzed) {
      return generateFromFreezed(clazz, ctx);
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
        hasFromJson: hasFromJson(clazz),
        interfaces: getGraphQLInterfaces(ctx, clazz),
        typeName: className,
        constructorName: redirectedName.isEmpty ? className : redirectedName,
        unionName: className,
        description: getDescription(clazz, clazz.documentationComment),
        deprecationReason: getDeprecationReason(clazz),
        fields: await Future.wait(
          fieldsFromClass(clazz, ctx),
        ),
      );
      return Library((l) {
        // l.directives.addAll(
        //   ctx.config.customTypes.map((e) => Directive.import(e.import)),
        // );

        l.body.add(classInfo.serializer());
        l.body.add(Code(classInfo.fieldCode()));
      });
    }
  }
}

Future<Library> generateFromFreezed(
  ClassElement clazz,
  GeneratorCtx ctx,
) async {
  final variants = await freezedVariants(clazz, ctx);

  return Library((l) {
    // l.directives.addAll(
    //   ctx.config.customTypes.map((e) => Directive.import(e.import)),
    // );
    for (final variant in variants) {
      l.body.add(variant.serializer());
      l.body.add(Code(variant.fieldCode()));
    }
    if (variants.length == 1) {
      return;
    }

    final fieldName = '${ReCase(clazz.name).camelCase}$graphqlTypeSuffix';
    final typeName = clazz.name;

// Map<String, Object?> _\$${typeName}ToJson($typeName instance) => instance.toJson();

// GraphQLObjectField<String, String, P> $fieldName$unionKeySuffix<P extends $typeName>()
//    => field(
//   'runtimeType',
//   enumTypeFromStrings('${typeName}Type', [
//     ${variants.map((e) => '"${e.constructorName}"').join(',')}
//   ]),
// );

    l.body.add(Code('''
${hasFromJson(clazz) ? serializerDefinitionCode(typeName, hasFrezzed: false) : ''}

GraphQLUnionType<$typeName>? _$fieldName;
GraphQLUnionType<$typeName> get $fieldName {
  return _$fieldName ??= GraphQLUnionType(
    '$typeName',
    [
      ${variants.map((e) => e.fieldName).join(',')}
    ],
  );
}
'''));
  });
}
