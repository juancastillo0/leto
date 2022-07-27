import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart' hide Expression;
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_generator/config.dart';
import 'package:leto_generator/resolver_generator.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:source_gen/source_gen.dart';
import 'package:valida/valida.dart';

export 'utils_graphql.dart';

// [WARNING] leto_generator:graphql_types on lib/chat_room/chat_table.dart:
// Cannot infer the GraphQL type for field listFromJson.json (type=Object?).
// Generics

final _docCommentRegExp = RegExp('(^/// )|(^// )', multiLine: true);
const graphQLDocTypeChecker = TypeChecker.fromRuntime(GraphQLDocumentation);
const jsonSerializableTypeChecker = TypeChecker.fromRuntime(JsonSerializable);
const freezedTypeChecker = TypeChecker.fromRuntime(Freezed);

class GeneratorCtx {
  final Config config;
  final BuildStep buildStep;

  GeneratorCtx({
    required this.config,
    required this.buildStep,
  });
}

bool hasFromJson(ClassElement clazz) {
  return clazz.constructors.any((f) => f.name == 'fromJson') ||
      clazz.methods.any((m) => m.isStatic && m.name == 'fromJson');
}

bool generateSerializer(ClassElement clazz) {
  return hasFromJson(clazz);
}

String _escapeDescription(String doc) {
  return doc
      .replaceAll('\n', '\\n')
      .replaceAll(r'$', r'\$')
      // .replaceAll('"', '\\"')
      .replaceAll("'", "\\'");
}

String _cleanDocComment(String doc) {
  final rawValue = doc.replaceAll(_docCommentRegExp, '').trim();
  return _escapeDescription(rawValue);
}

String? getDescription(
  Element element,
  String? docComment,
) {
  final description = getDocumentation(element)?.description;
  if (description != null) {
    return _escapeDescription(description);
  }

  return docComment == null ? null : _cleanDocComment(docComment);
}

GraphQLDocumentation? getDocumentation(Element element) {
  final annot = graphQLDocTypeChecker.firstAnnotationOfExact(element);

  if (annot != null) {
    final typeFunc = annot.getField('type')?.toFunctionValue();
    final _typeName = annot.getField('typeName')?.toStringValue();
    if (typeFunc != null && _typeName != null) {
      throw Exception(
        "Can't have both type $typeFunc and typeName $_typeName set"
        ' in $GraphQLDocumentation, please use only one of them.',
      );
    }
    final _typeFunc =
        typeFunc == null ? null : executeCodeForExecutable(typeFunc);
    return GraphQLDocumentation(
      description: annot.getField('description')?.toStringValue(),
      deprecationReason: annot.getField('deprecationReason')?.toStringValue(),
      typeName: _typeName ?? _typeFunc,
    );
  }
}

String? getDeprecationReason(Element element) {
  final doc = getDocumentation(element);
  if (doc?.deprecationReason != null) {
    return doc?.deprecationReason;
  }
  final depAnn =
      const TypeChecker.fromRuntime(Deprecated).firstAnnotationOf(element);
  if (depAnn != null) {
    final dep = ConstantReader(depAnn);
    final reason =
        dep.peek('message')?.stringValue ?? 'Expires: ${deprecated.message}.';
    return reason;
  }
}

String? getDefaultValue(Element elem) {
  if (elem is ParameterElement && elem.defaultValueCode != null) {
    return elem.defaultValueCode;
  }
  final argAnnot = argInfoFromElement(elem);
  if (argAnnot.defaultCode != null) {
    return argAnnot.defaultCode;
  }

  final annotDefault = const TypeChecker.fromRuntime(Default)
      .firstAnnotationOfExact(elem)
      ?.getField('defaultValue');
  final annotJsonKey = const TypeChecker.fromRuntime(JsonKey)
      .firstAnnotationOfExact(elem)
      ?.getField('defaultValue');

  final annot = annotDefault ?? annotJsonKey;
  if (annot != null) {
    return dartObjectToString(annot);
  }
}

String? getAttachments(Element element) {
  // final annotDefault = const TypeChecker.fromRuntime(Attach)
  //     .annotationsOf(element).expand((e) => e.toListValue()?.map((e) => e.));
  String fieldAnnotations = '';
  if (element is ParameterElement &&
      element.enclosingElement is ConstructorElement) {
    final constructor = element.enclosingElement! as ConstructorElement;
    final field = constructor.enclosingElement.getField(element.name);
    if (field != null && field.type.element == element.type.element) {
      fieldAnnotations = getAttachments(field) ?? '';
      if (fieldAnnotations.isNotEmpty) {
        fieldAnnotations = fieldAnnotations.substring(
          1,
          fieldAnnotations.length - 1,
        );
      }
    }
  }
// ignore: prefer_interpolation_to_compose_strings
  final str = '[' +
      const TypeChecker.fromRuntime(AttachFn)
          .annotationsOf(element)
          .map((e) {
            final fun = e.getField('attachments')?.toFunctionValue();
            return fun == null ? null : executeCodeForExecutable(fun);
          })
          .whereType<String>()
          .map((e) => '...$e,')
          .join() +
      (() {
        // TODO: ValidaNested.overrideValidation
        final e = element.metadata.firstWhereOrNull(
          (element) => const TypeChecker.fromRuntime(ValidaField)
              .isAssignableFromType(element.computeConstantValue()!.type!),
        );
        if (e == null) return '';
        final _validaAnnot = getSourceCodeAnnotation(e);
        return 'ValidaAttachment($_validaAnnot),';
      }()) +
      fieldAnnotations +
      ']';
  return str.length > 2 ? str : null;
}

String getSourceCodeAnnotation(ElementAnnotation e) {
  final s = e as ElementAnnotationImpl;
  return s.annotationAst.toString().substring(1);
}

// taken from https://github.com/rrousselGit/freezed/blob/be88e13288b9a5aaddc0e7d0e9ee570d20a8cccf/packages/freezed/lib/src/utils.dart
Future<String> documentationOfParameter(
  ParameterElement parameter,
  BuildStep buildStep,
) async {
  final doc = getDescription(parameter, parameter.documentationComment);
  if (doc != null) {
    return doc;
  }

  try {
    final builder = StringBuffer();
    final astNode = await tryGetAstNodeForElement(parameter, buildStep);

    for (Token? token = astNode.beginToken.precedingComments;
        token != null;
        token = token.next) {
      builder.writeln(token);
    }
    final comm = builder.toString();
    if (comm.trim().isNotEmpty) return _cleanDocComment(comm);
  } catch (_) {}

  final parent = parameter.enclosingElement;
  if (parent is ConstructorElement) {
    final field = parent.enclosingElement.getField(parameter.name);
    if (field != null && field.documentationComment != null) {
      return _cleanDocComment(field.documentationComment!);
    }
  }
  return '';
}

Future<AstNode> tryGetAstNodeForElement(
  Element element,
  BuildStep buildStep,
) async {
  var library = element.library!;

  while (true) {
    try {
      final result = library.session.getParsedLibraryByElement(library)
          as ParsedLibraryResult?;

      return result!.getElementDeclaration(element)!.node;
    } on InconsistentAnalysisException {
      library = await buildStep.resolver.libraryFor(
        await buildStep.resolver.assetIdForElement(element.library!),
      );
    }
  }
}

/// taken from https://github.com/angel-dart-archive/serialize/blob/be6a3669cca34cd83d189a1169edf6f381101cd8/angel_serialize_generator/lib/angel_serialize_generator.dart#L77
/// check https://github.com/google/json_serializable.dart/blob/d2fe5141a333e2109fd1511e1520bc13374a63e9/json_serializable/lib/src/json_key_utils.dart#L44
String dartObjectToString(DartObject v) {
  final type = v.type;
  if (v.isNull) return 'null';
  if (v.toBoolValue() != null) return v.toBoolValue().toString();
  if (v.toIntValue() != null) return v.toIntValue().toString();
  if (v.toDoubleValue() != null) return v.toDoubleValue().toString();
  if (v.toSymbolValue() != null) return '#' + v.toSymbolValue()!;
  if (v.toTypeValue() != null)
    return v.toTypeValue()!.getDisplayString(withNullability: true);
  if (v.toListValue() != null) {
    return 'const [${v.toListValue()!.map(dartObjectToString).join(', ')}]';
  }
  if (v.toMapValue() != null) {
    return 'const {${v.toMapValue()!.entries.map((entry) {
      final k = dartObjectToString(entry.key!);
      final v = dartObjectToString(entry.value!);
      return '$k: $v';
    }).join(', ')}}';
  }
  if (v.toStringValue() != null) {
    return literalString(v.toStringValue()!).accept(DartEmitter()).toString();
  }
  if (type is InterfaceType && type.element.isEnum) {
    // Find the index of the enum, then find the member.
    for (final field in type.element.fields) {
      if (field.isEnumConstant && field.isStatic) {
        final value = type.element.getField(field.name)!.computeConstantValue();
        if (value == v) {
          return '${type.name}.${field.name}';
        }
      }
    }
  }

  throw ArgumentError(v.toString());
}
