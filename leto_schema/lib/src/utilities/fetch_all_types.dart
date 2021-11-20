import 'package:leto_schema/introspection.dart';
import 'package:leto_schema/leto_schema.dart';

/// Returns a Set of all named types in the [schema]
Set<GraphQLNamedType> fetchAllNamedTypes(GraphQLSchema schema) {
  final data = <GraphQLType>[
    ...schema.otherTypes,
    if (schema.queryType != null) schema.queryType!,
    if (schema.mutationType != null) schema.mutationType!,
    if (schema.subscriptionType != null) schema.subscriptionType!,
    ...schema.directives.expand(
      (directive) => directive.inputs.map((e) => e.type),
    ),
    schemaGraphQLType,
  ];

  return CollectTypes(data).traversedTypes;
}

class CollectTypes {
  /// The set of types collected at this point
  final traversedTypes = <GraphQLNamedType>{};

  /// Collects all named types from [types]
  CollectTypes(Iterable<GraphQLType> types) {
    types.forEach(_fetchAllTypesFromType);
  }

  /// Collects all named types from [type]
  CollectTypes.fromRootObject(GraphQLObjectType type) {
    _fetchAllTypesFromObject(type);
  }

  void _fetchAllTypesFromObject(GraphQLObjectType objectType) {
    if (traversedTypes.contains(objectType)) {
      return;
    }

    traversedTypes.add(objectType);

    for (final field in objectType.fields) {
      _fetchAllTypesFromType(field.type);
      for (final input in field.inputs) {
        _fetchAllTypesFromType(input.type);
      }
    }

    for (final i in objectType.interfaces) {
      _fetchAllTypesFromObject(i);
    }
    for (final pt in objectType.possibleTypes) {
      _fetchAllTypesFromObject(pt);
    }
  }

  void _fetchAllTypesFromType(GraphQLType type) {
    if (traversedTypes.contains(type)) {
      return;
    }

    type.when(
      enum_: (type) => traversedTypes.add(type),
      scalar: (type) => traversedTypes.add(type),
      object: _fetchAllTypesFromObject,
      list: (type) => _fetchAllTypesFromType(type.ofType),
      nonNullable: (type) => _fetchAllTypesFromType(type.ofType),
      input: (type) {
        traversedTypes.add(type);
        for (final v in type.fields) {
          _fetchAllTypesFromType(v.type);
        }
      },
      union: (type) {
        traversedTypes.add(type);
        for (final t in type.possibleTypes) {
          _fetchAllTypesFromObject(t);
        }
      },
    );
  }
}
