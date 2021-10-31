import 'package:leto_schema/leto_schema.dart';

List<GraphQLType> fetchAllTypes(
  GraphQLSchema schema,
  List<GraphQLType> specifiedTypes,
) {
  final data = <GraphQLType>{
    if (schema.queryType != null) schema.queryType!,
    if (schema.mutationType != null) schema.mutationType!,
    if (schema.subscriptionType != null) schema.subscriptionType!,
  }..addAll(specifiedTypes);

  return CollectTypes(data).types.toList();
}

class CollectTypes {
  Set<GraphQLType> traversedTypes = {};

  Set<GraphQLType> get types => traversedTypes;

  CollectTypes(Iterable<GraphQLType> types) {
    types.forEach(_fetchAllTypesFromType);
  }

  CollectTypes.fromRootObject(GraphQLObjectType type) {
    _fetchAllTypesFromObject(type);
  }

  void _fetchAllTypesFromObject(GraphQLObjectType objectType) {
    if (traversedTypes.contains(objectType)) {
      return;
    }

    traversedTypes.add(objectType);

    for (final field in objectType.fields) {
      final type = field.type;
      if (type is GraphQLObjectType) {
        _fetchAllTypesFromObject(type);
      } else if (type is GraphQLInputObjectType) {
        for (final v in type.fields) {
          _fetchAllTypesFromType(v.type);
        }
      } else {
        _fetchAllTypesFromType(type);
      }

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

  void _fetchAllTypesFromType(GraphQLType _type) {
    final type = _type;
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
          _fetchAllTypesFromType(t);
        }
      },
    );
  }
}
