import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart' hide Expression;
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leto_generator/config.dart';
import 'package:leto_generator/utils_graphql.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:source_gen/source_gen.dart';

export 'utils_graphql.dart';

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

String cleanDocumentation(String doc) {
  return doc.replaceAll(_docCommentRegExp, '').trim().replaceAll('\n', '\\n');
}

String? getDescription(
  Element element,
  String? docComment,
) {
  final docString = getDocumentation(element)?.description ?? docComment;

  return docString == null ? null : cleanDocumentation(docString);
}

GraphQLDocumentation? getDocumentation(Element element) {
  final annot = graphQLDocTypeChecker.firstAnnotationOfExact(element);
  if (annot != null) {
    final typeFunc = annot.getField('type')?.toFunctionValue()?.name;
    final typeName = annot.getField('typeName')?.toSymbolValue() ??
        (typeFunc == null ? null : '$typeFunc()');
    return GraphQLDocumentation(
      description: annot.getField('description')?.toStringValue(),
      deprecationReason: annot.getField('deprecationReason')?.toStringValue(),
      typeName: typeName == null ? null : Symbol(typeName),
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

// taken from https://github.com/rrousselGit/freezed/blob/be88e13288b9a5aaddc0e7d0e9ee570d20a8cccf/packages/freezed/lib/src/utils.dart
Future<String> documentationOfParameter(
  ParameterElement parameter,
  BuildStep buildStep,
) async {
  final doc = getDescription(parameter, parameter.documentationComment);
  if (doc != null) {
    return doc;
  }
  final builder = StringBuffer();

  final astNode = await tryGetAstNodeForElement(parameter, buildStep);

  for (Token? token = astNode.beginToken.precedingComments;
      token != null;
      token = token.next) {
    builder.writeln(token);
  }

  return cleanDocumentation(builder.toString());
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
