import 'package:gql/language.dart' show printNode;
import 'package:leto_schema/leto_schema.dart' show DocumentNode, GraphQLSchema;
import 'package:leto_schema/utilities.dart' show buildSchema, printSchema;
import 'package:meta/meta.dart';

/// Extends a [schema] with an SDL [document]
@experimental
GraphQLSchema extendSchema(GraphQLSchema schema, DocumentNode document) {
  final schemaStr = printSchema(schema);
  final documentStr = printNode(document);

  final combinedStr = '$schemaStr\n\n$documentStr';

  return buildSchema(combinedStr);
}
