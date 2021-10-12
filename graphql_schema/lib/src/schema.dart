library graphql_schema.src.schema;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:gql/ast.dart'
    show DocumentNode, FieldNode, OperationDefinitionNode;

import 'package:gql/ast.dart' as ast;
import 'package:gql/language.dart' show printNode, parseString;
import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';
import 'package:source_span/source_span.dart';

part 'argument.dart';
part 'decorators.dart';
part 'directive.dart';
part 'enum.dart';
part 'error.dart';
part 'field.dart';
part 'gen.dart';
part 'object_type.dart';
part 'print_schema.dart';
part 'req_ctx.dart';
part 'scalar.dart';
part 'serde_ctx.dart';
part 'type.dart';
part 'union.dart';
part 'validation_result.dart';

/// The schema against which queries, mutations, and subscriptions are executed.
class GraphQLSchema {
  /// The shape which all queries against the backend must take.
  final GraphQLObjectType<Object>? queryType;

  /// The shape required for any query that changes the state of the backend.
  final GraphQLObjectType<Object>? mutationType;

  /// A [GraphQLObjectType] describing the form of data sent to
  /// real-time subscribers.
  ///
  /// Note that as of August 4th, 2018 (when this text was written),
  /// subscriptions are not formalized in the GraphQL specification.
  /// Therefore, any GraphQL implementation can potentially implement
  /// subscriptions in its own way.
  final GraphQLObjectType<Object>? subscriptionType;

  final String? description;

  final List<GraphQLDirective> directives;

  final SerdeCtx serdeCtx;

  late final String schemaStr = printSchema(this);

  late final DocumentNode schemaNode = parseString(schemaStr);

  GraphQLSchema({
    this.queryType,
    this.mutationType,
    this.subscriptionType,
    this.description,
    List<GraphQLDirective>? directives,
    SerdeCtx? serdeCtx,
  })  : serdeCtx = serdeCtx ?? SerdeCtx(),
        directives = directives ?? GraphQLDirective.specifiedDirectives
  // ,assert(
  //   subscriptionType == null ||
  //       subscriptionType.fields
  //           .every((f) => f.subscribe != null || f.resolve != null),
  // )
  ;
}

/// A default resolver that always returns `null`.
Object? resolveToNull(Object? _, Object? __) => null;
