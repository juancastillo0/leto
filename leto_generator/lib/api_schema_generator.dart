import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart' show DartFormatter;
import 'package:glob/glob.dart' show Glob;
import 'package:leto_generator/utils.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

/// https://github.com/dart-lang/build/blob/master/docs/writing_an_aggregate_builder.md

Builder graphQLApiSchemaBuilder(BuilderOptions options) =>
    ValidatorsLibGenerator(options);

class ValidatorsLibGenerator implements Builder {
  final BuilderOptions options;

  ValidatorsLibGenerator(this.options);

  static String get basePath => 'lib';
  // static List<String> get basePaths => ['lib', 'example'];

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      r'$lib$': ['graphql_api.schema.dart']
      // r'$package$': [
      //   ...basePaths.map((basePath) => '$basePath/graphql_api.schema.dart')
      // ]
    };
  }

  static AssetId _allFileOutput(String basePath, BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      p.join(basePath, 'graphql_api.schema.dart'),
    );
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    // for (final basePath in basePaths) {
    final allClasses = <ClassElement>[];
    final allResolvers = <Type, List<Element>>{
      Query: [],
      Mutation: [],
      Subscription: [],
    };
    await for (final input in buildStep.findAssets(Glob('$basePath/**.dart'))) {
      final LibraryReader reader;
      try {
        final library = await buildStep.resolver.libraryFor(input);
        reader = LibraryReader(library);
      } on NonLibraryAssetException catch (_) {
        continue;
      }
      final classResolversMethods = reader.allElements
          .whereType<ClassElement>()
          .where((element) => const TypeChecker.fromRuntime(ClassResolver)
              .hasAnnotationOf(element))
          .expand((e) => e.methods);

      for (final e in [Query, Mutation, Subscription]) {
        final typeChecker = TypeChecker.fromRuntime(e);
        allResolvers[e]!.addAll(
          reader.allElements.where((w) => typeChecker.hasAnnotationOfExact(w)),
        );
        allResolvers[e]!.addAll(classResolversMethods
            .where((e) => typeChecker.hasAnnotationOfExact(e)));
      }
      allClasses.addAll(
        reader.classes.where(
          (element) => const TypeChecker.fromRuntime(BaseGraphQLTypeDecorator)
              .hasAnnotationOf(element),
        ),
      );
    }

    try {
      final _serializers = allClasses
          .where(
            (element) {
              return element.typeParameters.isEmpty &&
                  generateSerializer(element);
            },
          )
          .map((e) {
            final typeName =
                e.thisType.getDisplayString(withNullability: false);
            return '${ReCase(typeName).camelCase}$serializerSuffix,';
          })
          .toSet()
          .join();
      final _genericSerializersCtx = allClasses
          .where(
            (element) =>
                element.typeParameters.isNotEmpty &&
                generateSerializer(element),
          )
          .map((e) {
            final typeName = e.displayName;
            return '${ReCase(typeName).camelCase}SerdeCtx,';
          })
          .toSet()
          .join();

      Iterable<String> _resolverStr(Type type) {
        return allResolvers[type]!
            .map((e) => '${e.name}$graphQLFieldSuffix,')
            .toSet();
      }

      final queries = _resolverStr(Query);
      final mutations = _resolverStr(Mutation);
      final subscriptions = _resolverStr(Subscription);
      final allElements =
          allResolvers.values.expand((el) => el).followedBy(allClasses);

      String out = '''
// ignore: depend_on_referenced_packages
import 'package:leto_schema/leto_schema.dart';
${allElements.map((e) => "import '${cleanImport(basePath, e.source!.uri)}';").toSet().join()}

GraphQLSchema recreateGraphQLApiSchema() {
  HotReloadableDefinition.incrementCounter();
  _graphqlApiSchema = null;
  return graphqlApiSchema;
}

GraphQLSchema? _graphqlApiSchema;
GraphQLSchema get graphqlApiSchema => _graphqlApiSchema ??= GraphQLSchema(
  serdeCtx: SerdeCtx()..addAll([$_serializers])..children.addAll([$_genericSerializersCtx]),
  queryType: objectType(
    'Query',
    fields: [${queries.join()}],
  ),
  ${mutations.isEmpty ? '' : '''
  mutationType: objectType(
    'Mutation',
    fields: [${mutations.join()}],
  ),
  '''}
  ${subscriptions.isEmpty ? '' : '''
  subscriptionType: objectType(
    'Subscription',
    fields: [${subscriptions.join()}],
  ),
  '''}
);

''';
      try {
        out = DartFormatter().format(out);
      } catch (_) {}

      await buildStep.writeAsString(_allFileOutput(basePath, buildStep), out);
    } catch (e, s) {
      print('$e $s');
    }
    // }
  }
}

String cleanImport(String basePath, Uri uri) {
  final str = uri.toString();
  if (str.startsWith('asset')) {
    return str.substring(
      // + 1 for last '/'
      str.indexOf(basePath) + basePath.length + 1,
    );
  } else {
    return str;
  }
}
