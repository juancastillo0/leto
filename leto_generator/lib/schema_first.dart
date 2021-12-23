import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart' show Glob;
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';

const primitiveGraphQLToDart = {
  'String': 'String',
  'Boolean': 'bool',
  'ID': 'String',
  'Int': 'int',
  'Float': 'double',
  'Date': 'DateTime',
  'Uri': 'Uri',
  'Json': 'Json',
};

String graphQLToDartType(
  GraphQLType type, {
  bool nullable = true,
}) {
  final n = nullable && type is! GraphQLNonNullType ? '?' : '';
  if (type is GraphQLListType) {
    return 'List<${graphQLToDartType(type.ofType)}>$n';
  } else if (type is GraphQLNonNullType) {
    return graphQLToDartType(type.ofType, nullable: false);
  } else if (primitiveGraphQLToDart.containsKey(type.name)) {
    return '${primitiveGraphQLToDart[type.name]}$n';
  } else {
    return '${type.name}$n';
  }
}

String _inputs(List<GraphQLFieldInput> inputs) {
  if (inputs.isEmpty) return '';
  return '{${inputs.map((e) => '${e.type.isNonNullable ? 'required ' : ''} ${graphQLToDartType(e.type)} ${e.name}').join(',')},}';
}

Future<String> fromSchemaFile(BuildStep buildStep) async {
  final List<String> values = [];
  await for (final input in buildStep.findAssets(Glob('lib/**.graphql'))) {
    final schemaStr = await buildStep.readAsString(input);
    final schema = buildSchema(schemaStr);

    final queryType = schema.queryType;

    for (final t in schema.allTypes) {
      t.whenNamed(
        enum_: (t) {
          values.add('''
enum ${t.name} {
  ${t.values.map((e) => '${e.name},').join('\n  ')}
}''');
        },
        scalar: (t) {},
        object: (t) {},
        input: (t) {
          values.add('''
@JsonSerializable()
class ${t.name} {
  ${t.fields.map((e) => 'final ${graphQLToDartType(e.type)} ${e.name};').join('\n  ')}
  const ${t.name}({
    ${t.fields.map((e) => '${e.type.isNonNullable ? 'required ' : ''}this.${e.name},').join('\n  ')}
  });

  factory ${t.name}.fromJson(Map<String, Object?> json) => _\$${t.name}FromJson(json);
  Map<String, Object?> toJson() => _\$${t.name}ToJson(this);
}''');
        },
        union: (t) {
          values.add('''
@freezed
class ${t.name} {
  ${t.possibleTypes.map((variant) {
            return '''
const factory ${t.name}.${variant.name}({
  ${variant.fields.map((e) => '${e.type.isNonNullable ? 'required ' : ''} ${graphQLToDartType(e.type)} ${e.name},').join('\n  ')}
}) = _${variant.name};
''';
          }).join('\n')}
  
}''');
        },
      );
    }

    if (queryType != null) {
      values.add('abstract class Query {');
      for (final field in queryType.fields) {
        values.add(
          '${graphQLToDartType(field.type)} ${field.name}(${_inputs(field.inputs)});',
        );
      }
      values.add('}');
    }
  }
  return values.join('\n\n');
}
