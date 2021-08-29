import 'dart:async';
import 'dart:mirrors';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:angel_model/angel_model.dart';
import 'package:angel_serialize_generator/build_context.dart';
import 'package:angel_serialize_generator/context.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:graphql_schema/graphql_schema.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

/// Generates GraphQL schemas, statically.
Builder graphQLBuilder(Object _) {
  return SharedPartBuilder([_GraphQLGenerator()], 'graphql_generator');
}

final _docComment = RegExp(r'^/// ', multiLine: true);
const _graphQLDoc = TypeChecker.fromRuntime(GraphQLDocumentation);
const _graphQLClassTypeChecker = TypeChecker.fromRuntime(GraphQLClass);

class _GraphQLGenerator extends GeneratorForAnnotation<GraphQLClass> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is ClassElement) {
      final ctx = element.isEnum
          ? null
          : await buildContext(
              element,
              annotation,
              buildStep,
              buildStep.resolver,
              serializableTypeChecker.hasAnnotationOf(element),
            );
      final lib = buildSchemaLibrary(element, ctx, annotation);
      return lib.accept(DartEmitter()).toString();
    } else {
      throw UnsupportedError('@GraphQLClass() is only supported on classes.');
    }
  }

  bool isInterface(ClassElement clazz) {
    return clazz.isAbstract && !serializableTypeChecker.hasAnnotationOf(clazz);
  }

  bool _isGraphQLClass(InterfaceType clazz) {
    InterfaceType search = clazz;

    while (search != null) {
      if (_graphQLClassTypeChecker.hasAnnotationOf(search.element)) return true;
      search = search.superclass;
    }

    return false;
  }

  Expression _inferType(String className, String name, DartType type) {
    // Firstly, check if it's a GraphQL class.
    if (type is InterfaceType && _isGraphQLClass(type)) {
      final c = type;
      final name = serializableTypeChecker.hasAnnotationOf(c.element) &&
              c.name.startsWith('_')
          ? c.name.substring(1)
          : c.name;
      final rc = ReCase(name);
      return refer('${rc.camelCase}GraphQLType');
    }

    // Next, check if this is the "id" field of a `Model`.
    if (const TypeChecker.fromRuntime(Model).isAssignableFromType(type) &&
        name == 'id') {
      return refer('graphQLId');
    }

    final primitive = {
      String: 'graphQLString',
      int: 'graphQLInt',
      double: 'graphQLFloat',
      bool: 'graphQLBoolean',
      DateTime: 'graphQLDate'
    };

    // Check to see if it's a primitive type.
    for (final entry in primitive.entries) {
      if (TypeChecker.fromRuntime(entry.key).isAssignableFromType(type)) {
        return refer(entry.value);
      }
    }

    // Next, check to see if it's a List.
    if (type is InterfaceType &&
        type.typeArguments.isNotEmpty &&
        const TypeChecker.fromRuntime(Iterable).isAssignableFromType(type)) {
      final arg = type.typeArguments[0];
      final inner = _inferType(className, name, arg);
      return refer('listOf').call([inner]);
    }

    // Nothing else is allowed.
    throw 'Cannot infer the GraphQL type for '
        'field $className.$name (type=$type).';
  }

  void _applyDescription(
      Map<String, Expression> named, Element element, String docComment) {
    String docString = docComment;

    if (docString == null && _graphQLDoc.hasAnnotationOf(element)) {
      final ann = _graphQLDoc.firstAnnotationOf(element);
      final cr = ConstantReader(ann);
      docString = cr.peek('description')?.stringValue;
    }

    if (docString != null) {
      named['description'] = literalString(
          docString.replaceAll(_docComment, '').replaceAll('\n', '\\n'));
    }
  }

  Library buildSchemaLibrary(
      ClassElement clazz, BuildContext ctx, ConstantReader ann) {
    return Library((b) {
      // Generate a top-level xGraphQLType object

      if (clazz.isEnum) {
        b.body.add(Field((b) {
          // enumTypeFromStrings(String name, List<String> values, {String description}
          final args = <Expression>[literalString(clazz.name)];
          final values =
              clazz.fields.where((f) => f.isEnumConstant).map((f) => f.name);
          final named = <String, Expression>{};
          _applyDescription(named, clazz, clazz.documentationComment);
          args.add(literalConstList(values.map(literalString).toList()));

          b
            ..name = '${ReCase(clazz.name).camelCase}GraphQLType'
            ..docs.add('/// Auto-generated from [${clazz.name}].')
            ..type = TypeReference((b) => b
              ..symbol = 'GraphQLEnumType'
              ..types.add(refer('String')))
            ..modifier = FieldModifier.final$
            ..assignment = refer('enumTypeFromStrings').call(args, named).code;
        }));
      } else {
        b.body.add(Field((b) {
          final args = <Expression>[literalString(ctx.modelClassName)];
          final named = <String, Expression>{
            'isInterface': literalBool(isInterface(clazz))
          };

          // Add documentation
          _applyDescription(named, clazz, clazz.documentationComment);

          // Add interfaces
          final interfaces = clazz.interfaces.where(_isGraphQLClass).map((c) {
            final name = serializableTypeChecker.hasAnnotationOf(c.element) &&
                    c.name.startsWith('_')
                ? c.name.substring(1)
                : c.name;
            final rc = ReCase(name);
            return refer('${rc.camelCase}GraphQLType');
          });
          named['interfaces'] = literalList(interfaces);

          // Add fields
          final ctxFields = ctx.fields.toList();

          // Also incorporate parent fields.
          InterfaceType search = clazz.type;
          while (search != null &&
              !const TypeChecker.fromRuntime(Object).isExactlyType(search)) {
            for (final field in search.element.fields) {
              if (!ctxFields.any((f) => f.name == field.name)) {
                ctxFields.add(field);
              }
            }

            search = search.superclass;
          }

          final fields = <Expression>[];
          for (final field in ctxFields) {
            final named = <String, Expression>{};
            final originalField = clazz.fields
                .firstWhere((f) => f.name == field.name, orElse: () => null);

            // Check if it is deprecated.
            final depEl = originalField?.getter ?? originalField ?? field;
            final depAnn = const TypeChecker.fromRuntime(Deprecated)
                .firstAnnotationOf(depEl);
            if (depAnn != null) {
              final dep = ConstantReader(depAnn);
              final reason = dep.peek('messages')?.stringValue ??
                  dep.peek('expires')?.stringValue ??
                  'Expires: ${deprecated.message}.';
              named['deprecationReason'] = literalString(reason);
            }

            // Description finder...
            _applyDescription(
                named,
                originalField?.getter ?? originalField ?? field,
                originalField?.getter?.documentationComment ??
                    originalField?.documentationComment);

            // Pick the type.
            final doc = _graphQLDoc.firstAnnotationOf(depEl);
            Expression type;
            if (doc != null) {
              final cr = ConstantReader(doc);
              final typeName = cr.peek('typeName')?.symbolValue;
              if (typeName != null)
                type = refer(MirrorSystem.getName(typeName));
            }

            fields.add(refer('field').call([
              literalString(ctx.resolveFieldName(field.name)),
              type ??= _inferType(clazz.name, field.name, field.type)
            ], named));
          }
          named['fields'] = literalList(fields);

          b
            ..name = '${ctx.modelClassNameRecase.camelCase}GraphQLType'
            ..docs.add('/// Auto-generated from [${ctx.modelClassName}].')
            ..type = refer('GraphQLObjectType')
            ..modifier = FieldModifier.final$
            ..assignment = refer('objectType').call(args, named).code;
        }));
      }
    });
  }
}
