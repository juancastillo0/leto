library graphql_schema.src.schema;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:gql/ast.dart'
    show DocumentNode, FieldNode, OperationDefinitionNode;

import 'package:gql/language.dart' show parseString;
import 'package:graphql_schema/utilities.dart' show printSchema;
import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart' show Target, TargetKind;
import 'package:source_span/source_span.dart' show FileSpan, SourceLocation;

part 'argument.dart';
part 'decorators.dart';
part 'directive.dart';
part 'enum.dart';
part 'error.dart';
part 'field.dart';
part 'gen.dart';
part 'object_type.dart';
part 'req_ctx.dart';
part 'scalar.dart';
part 'serde_ctx.dart';
part 'type.dart';
part 'union.dart';
part 'validation_result.dart';

/// The schema against which queries, mutations, and subscriptions are executed.
class GraphQLSchema {
  /// The shape which all queries against the server must take.
  final GraphQLObjectType<Object?>? queryType;

  /// The shape required for any query that changes the state of the server.
  final GraphQLObjectType<Object?>? mutationType;

  /// A [GraphQLObjectType] describing the form of data sent to
  /// real-time subscribers.
  ///
  /// Note that as of August 4th, 2018 (when this text was written),
  /// subscriptions are not formalized in the GraphQL specification.
  /// Therefore, any GraphQL implementation can potentially implement
  /// subscriptions in its own way.
  final GraphQLObjectType<Object?>? subscriptionType;

  /// Optional description for the schema
  final String? description;

  /// Supported directives in this schema.
  ///
  /// Default: [GraphQLDirective.specifiedDirectives]
  final List<GraphQLDirective> directives;

  /// Serialization and deserialization context for [GraphQLType]
  final SerdeCtx serdeCtx;

  /// The schema in Schema Definition Language (SDL) representation
  late final String schemaStr = printSchema(this);

  /// The schema as a `package:gql` parsed node
  late final DocumentNode schemaNode = parseString(schemaStr);

  GraphQLSchema({
    this.queryType,
    this.mutationType,
    this.subscriptionType,
    this.description,
    List<GraphQLDirective>? directives,
    SerdeCtx? serdeCtx,
  })  : serdeCtx = serdeCtx ?? SerdeCtx(),
        directives = directives ?? GraphQLDirective.specifiedDirectives;
}

/// A default resolver that always returns `null`.
Object? resolveToNull(Object? _, Object? __) => null;
