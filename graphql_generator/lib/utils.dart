import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart' hide Expression;
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_generator/config.dart';
import 'package:graphql_generator/utils_graphql.dart';
import 'package:graphql_schema/graphql_schema.dart';
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
      clazz.methods.any((m) => m.name == 'fromJson');
}

bool generateSerializer(ClassElement clazz) {
  return !clazz.isAbstract &&
          jsonSerializableTypeChecker.hasAnnotationOfExact(clazz) ||
      hasFromJson(clazz) &&
          (freezedTypeChecker.hasAnnotationOfExact(clazz) ||
              isInputType(clazz));
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
    return GraphQLDocumentation(
      description: annot.getField('description')?.toString(),
      deprecationReason: annot.getField('deprecationReason')?.toString(),
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

// taken from https://github.com/rrousselGit/freezed/blob/be88e13288b9a5aaddc0e7d0e9ee570d20a8cccf/packages/freezed/lib/src/utils.dart
Future<String> documentationOfParameter(
  ParameterElement parameter,
  BuildStep buildStep,
) async {
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
      final result = library.session.getParsedLibraryByElement2(library)
          as ParsedLibraryResult?;

      return result!.getElementDeclaration(element)!.node;
    } on InconsistentAnalysisException {
      library = await buildStep.resolver.libraryFor(
        await buildStep.resolver.assetIdForElement(element.library!),
      );
    }
  }
}
