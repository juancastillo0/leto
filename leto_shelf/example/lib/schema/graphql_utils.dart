import 'package:shelf_graphql/shelf_graphql.dart';

GraphQLSchema mergeGraphQLSchemas(
  GraphQLSchema a,
  GraphQLSchema b, {
  String? rootQuery,
  String? rootMutation,
  String? rootSubscription,
}) {
  final queryFields = mergeObjectFields(
    a.queryType?.fields,
    b.queryType?.fields,
  ).values;
  final mutationFields = mergeObjectFields(
    a.mutationType?.fields,
    b.mutationType?.fields,
  ).values;
  final subscriptionFields = mergeObjectFields(
    a.subscriptionType?.fields,
    b.subscriptionType?.fields,
  ).values;

  return GraphQLSchema(
    serdeCtx: SerdeCtx()
      ..addAll(
        a.serdeCtx.map.values.followedBy(b.serdeCtx.map.values),
      ),
    queryType: queryFields.isEmpty
        ? null
        : objectType(
            rootQuery ?? a.queryType?.name ?? b.queryType?.name ?? 'Query',
            fields: queryFields,
          ),
    mutationType: mutationFields.isEmpty
        ? null
        : objectType(
            rootMutation ??
                a.mutationType?.name ??
                b.mutationType?.name ??
                'Mutation',
            fields: mutationFields,
          ),
    subscriptionType: subscriptionFields.isEmpty
        ? null
        : objectType(
            rootSubscription ??
                a.subscriptionType?.name ??
                b.subscriptionType?.name ??
                'Subscription',
            fields: subscriptionFields,
          ),
  );
}

GraphQLObjectType<T>? mergeObjectNullable<T>(
  GraphQLObjectType<T>? a,
  GraphQLObjectType<T>? b, {
  String? name,
  bool? isInterface,
}) {
  if (a == null || b == null) {
    return a ?? b;
  } else {
    return mergeObject(a, b, name: name, isInterface: isInterface);
  }
}

GraphQLObjectType<T> mergeObject<T>(
  GraphQLObjectType<T> a,
  GraphQLObjectType<T> b, {
  String? name,
  bool? isInterface,
}) {
  return objectType(
    name ?? a.name,
    interfaces: a.interfaces.followedBy(b.interfaces),
    description: a.description ?? b.description,
    fields: mergeObjectFields(a.fields, b.fields).values,
    isInterface: isInterface ?? (a.isInterface || b.isInterface),
  );
}

Map<String, GraphQLObjectField<Object?, Object?, T>> mergeObjectFields<T>(
  List<GraphQLObjectField<Object?, Object?, T>>? aFields,
  List<GraphQLObjectField<Object?, Object?, T>>? bFields,
) {
  final aFieldsMap = Map.fromEntries(
    (aFields ?? []).map((e) => MapEntry(e.name, e)),
  );
  final bFieldsMap = Map.fromEntries(
    (bFields ?? []).map((e) => MapEntry(e.name, e)),
  );

  final mergedFields = Map.fromEntries(
      aFieldsMap.keys.followedBy(bFieldsMap.keys).toSet().map((e) {
    final _a = aFieldsMap[e];
    final _b = bFieldsMap[e];

    if (_a == null || _b == null || _a == _b) {
      return MapEntry(e, (_a ?? _b)!);
    } else if (_a.type is GraphQLObjectType &&
        _b.type is GraphQLObjectType &&
        _b.type.generic == _a.type.generic) {
      return MapEntry(
        e,
        _a.type.generic.callWithType(
          <V>() => field<Object?, Object?, T>(
            e,
            mergeObject<V>(
              _a.type as GraphQLObjectType<V>,
              _b.type as GraphQLObjectType<V>,
            ),
          ),
        ),
      );
    } else {
      throw Exception("Couldn't merge $e $_a $_b");
    }
  }));
  return mergedFields;
}
