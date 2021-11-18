library leto_schema.src.schema;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:gql/ast.dart'
    show
        DocumentNode,
        FieldNode,
        Node,
        OperationDefinitionNode,
        OperationType,
        SchemaDefinitionNode;
import 'package:leto_schema/src/rules/ast_node_enum.dart';
import 'package:leto_schema/src/utilities/fetch_all_types.dart'
    show fetchAllNamedTypes;
import 'package:leto_schema/src/utilities/predicates.dart';
import 'package:leto_schema/src/utilities/print_schema.dart';
import 'package:leto_schema/utilities.dart' show printSchema;
import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart' show Target, TargetKind;
import 'package:source_span/source_span.dart' show FileSpan, SourceLocation;

export 'package:gql/ast.dart'
    show DocumentNode, FieldNode, OperationDefinitionNode, OperationType;

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

/// The schema against which queries, mutations and subscriptions are executed.
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

  /// Serialization and de-serialization context for [GraphQLType]s.
  /// Contains functions for creating objects from serialized values.
  final SerdeCtx serdeCtx;

  /// The schema in Schema Definition Language (SDL) representation
  late final String schemaStr = printSchema(this);

  /// The schema as a `package:gql` parsed node
  // late final DocumentNode schemaNode = parseString(schemaStr);
  final SchemaDefinitionNode? astNode;

  /// Other [GraphQLType] that you want to have in the schema
  final List<GraphQLType> otherTypes;

  /// A Map from name to [GraphQLType].
  /// Contains all named types in the schema.
  final typeMap = <String, GraphQLType>{};

  /// Contains all named types in the schema.
  /// Same as `typeMap.values.toList()`.
  late final List<GraphQLType> allTypes = [
    ...typeMap.values.where((t) => !isIntrospectionType(t)),
    ...typeMap.values.where(isIntrospectionType),
  ];

  /// Returns the [GraphQLType] with the given [name]
  GraphQLType? getType(String name) => typeMap[name];

  /// A Map from name to [GraphQLDirective].
  final Map<String, GraphQLDirective> directiveMap = {};

  /// Returns the [GraphQLDirective] with the given [name]
  GraphQLDirective? getDirective(String name) => directiveMap[name];

  /// Returns the type for the given [operation] type
  GraphQLObjectType? getRootType(OperationType operation) {
    switch (operation) {
      case OperationType.mutation:
        return mutationType;
      case OperationType.query:
        return queryType;
      case OperationType.subscription:
        return subscriptionType;
    }
  }

  /// Returns all the [GraphQLObjectType] that implement a given abstract [type]
  List<GraphQLObjectType>? getPossibleTypes(GraphQLCompositeType type) {
    if (type is GraphQLUnionType) {
      return type.possibleTypes;
    } else if (type is GraphQLObjectType && type.isInterface) {
      return type.possibleTypes.where((obj) => !obj.isInterface).toList();
    }
  }

  final _subTypeMap = <String, Set<String>>{};

  /// Returns `true` if [maybeSubType] is a possible type of [abstractType]
  bool isSubType(
    GraphQLCompositeType abstractType,
    GraphQLObjectType maybeSubType,
  ) {
    if (!isAbstractType(abstractType)) return false;
    Set<String>? map = _subTypeMap[abstractType.name];
    if (map == null) {
      map = {};

      if (abstractType is GraphQLUnionType) {
        for (final type in abstractType.possibleTypes) {
          map.add(type.name);
        }
      } else if (abstractType is GraphQLObjectType) {
        final implementations = abstractType.possibleTypes;
        for (final type in implementations) {
          map.add(type.name);
        }
      }

      _subTypeMap[abstractType.name!] = map;
    }
    return map.contains(maybeSubType.name);
  }

  /// The schema against which queries, mutations
  /// and subscriptions are executed.
  ///
  /// throws [SameNameGraphQLTypeException] if there are different types
  /// with the same name.
  /// throws [UnnamedTypeException] if there are different types
  /// with the same name.
  /// throws [InvalidTypeNameException] if there is a type
  /// with an invalid name. All type names should match [typeNameRegExp].
  GraphQLSchema({
    this.queryType,
    this.mutationType,
    this.subscriptionType,
    this.description,
    this.otherTypes = const [],
    List<GraphQLDirective>? directives,
    SerdeCtx? serdeCtx,
    this.astNode,
  })  : serdeCtx = serdeCtx ?? SerdeCtx(),
        directives = directives ?? GraphQLDirective.specifiedDirectives {
    _collectTypes();
    _collectDirectives();
  }

  /// All [GraphQLType] names should match this regular expression
  static final typeNameRegExp = RegExp(r'^[a-zA-Z][_a-zA-Z0-9]*$');

  void _collectTypes() {
    final allNamedTypes = fetchAllNamedTypes(this);
    for (final type in allNamedTypes) {
      final name = type.name!;
      if (name.isEmpty) {
        throw UnnamedTypeException(this, type);
      } else if (!typeNameRegExp.hasMatch(name) && !isIntrospectionType(type)) {
        throw InvalidTypeNameException(this, type);
      }
      final prev = typeMap[name];
      if (prev == null) {
        typeMap[name] = type;
      } else if ((queryType == prev || queryType == type) &&
          (type is GraphQLObjectType && prev is GraphQLObjectType)) {
        // Don't throw exception if it's an introspected queryType
        final other = prev == queryType ? type : prev;
        final difference = queryType!.fields
            .map((e) => e.name)
            .toSet()
            .difference(other.fields.map((e) => e.name).toSet());
        if (difference.length == 2 &&
            const ['__type', '__schema'].every(difference.contains)) {
          typeMap[name] = other;
        } else {
          throw SameNameGraphQLTypeException(type, prev);
        }
      } else {
        throw SameNameGraphQLTypeException(type, prev);
      }
    }
  }

  void _collectDirectives() {
    for (final dir in directives) {
      final prev = directiveMap[dir.name];
      if (prev == null) {
        directiveMap[dir.name] = dir;
      } else if (prev != dir) {
        // TODO:
      }
    }
  }
}

/// Base exception thrown on schema construction
class SchemaValidationException implements Exception {}

/// Thrown when a schema was constructed with an unnamed type
class UnnamedTypeException implements SchemaValidationException {
  /// The type with no name found in the schema
  final GraphQLType type;

  /// The schema that was being constructed when this exception was thrown
  final GraphQLSchema schema;

  /// Thrown when a schema was constructed with an unnamed type
  const UnnamedTypeException(this.schema, this.type);

  @override
  String toString() {
    return 'One of the provided types for building the'
        ' Schema is missing a name. '
        'GraphQLType(runtimeType: ${type.runtimeType},'
        ' description: ${type.description}.)';
  }
}

/// Thrown when a schema was constructed with a type with an invalid name
class InvalidTypeNameException implements SchemaValidationException {
  /// The type with an invalid name found in the schema
  final GraphQLType type;

  /// The schema that was being constructed when this exception was thrown
  final GraphQLSchema schema;

  /// Thrown when a schema was constructed with a type with an invalid name
  const InvalidTypeNameException(this.schema, this.type);

  @override
  String toString() {
    return 'One of the provided types for building the'
        ' Schema has an invalid name = $type.'
        ' All names should match: ${GraphQLSchema.typeNameRegExp.pattern}'
        '. GraphQLType(runtimeType: ${type.runtimeType},'
        ' description: ${type.description}.)';
  }
}

/// Thrown when a [GraphQLSchema] has at least two different
/// [GraphQLType]s with the same name.
class SameNameGraphQLTypeException implements SchemaValidationException {
  /// A type different from [type2] that shares it's name
  final GraphQLType type1;

  /// A type different from [type1] that shares it's name
  final GraphQLType type2;

  /// Thrown when a [GraphQLSchema] has at least two different
  /// [GraphQLType]s with the same name.
  SameNameGraphQLTypeException(this.type1, this.type2)
      : assert(type1.toString() == type2.toString());

  @override
  String toString() {
    return '''
Can't have multiple types with the same name: $type1.

Please reuse a previously created instance of the type.
If you need cyclic types, you can do the following:
```dart
GraphQLType? _type;
GraphQLType get type {
  if (_type != null) return _type!;
  __type = ...; // create the type
  _type = __type; // set the cached value

  // or __type.possibleTypes for unions
  __type.fields.addAll([
    ... // add fields with cyclic references
  ]);
  return __type;
}
```''';
  }
}
