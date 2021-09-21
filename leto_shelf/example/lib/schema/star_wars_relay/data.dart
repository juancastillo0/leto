import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/page_info.dart';
import 'package:valida/valida.dart';

part 'data.g.dart';

/// This defines a basic set of data for our Star Wars Schema.
///
/// This data is hard coded for the sake of the demo, but you could imagine
/// fetching this data from a backend service rather than from hardcoded
/// JSON objects in a more complex demo.

/// An object with an ID
@GraphQLClass()
abstract class Node {
  /// The id of the object.
  String get id;
}

class Edge<T extends Node> {
  final T node;
  final String cursor;

  const Edge({
    required this.node,
    required this.cursor,
  });
}

class Connection<T extends Node> {
  final List<Edge<T>> edges;
  final PageInfo pageInfo;

  const Connection({
    required this.edges,
    required this.pageInfo,
  });
}

GraphQLType<Edge<T>, Object> edgeGraphQlType<T extends Node>(
  GraphQLType<T, Object> type,
) {
  return objectType(
    '${type.name}Edge',
    fields: [
      type.field(
        'node',
        resolve: (obj, ctx) => obj.node,
      ),
      graphQLString.nonNull().field(
            'cursor',
            resolve: (obj, ctx) => obj.cursor,
          ),
    ],
  );
}

GraphQLType<Connection<T>, Object> connectionGraphQlType<T extends Node>(
  GraphQLType<T, Object> type,
) {
  return objectType(
    '${type.name}Connection',
    fields: [
      listOf(edgeGraphQlType(type)).field(
        'edges',
        resolve: (obj, ctx) => obj.edges,
      ),
      pageInfoGraphQLType.nonNull().field(
            'pageInfo',
            resolve: (obj, ctx) => obj.pageInfo,
          ),
    ],
  );
}

class ConnectionDefinitions<T extends Node> {
  final GraphQLType<Edge<T>, Object> edge;
  final GraphQLType<Connection<T>, Object> connection;

  const ConnectionDefinitions(this.edge, this.connection);
}

ConnectionDefinitions<T> connectionDefinitions<T extends Node>(
  GraphQLType<T, Object> type,
) {
  final edge = objectType<Edge<T>>(
    '${type.name}Edge',
    fields: [
      graphQLString.nonNull().field(
            'cursor',
            resolve: (obj, ctx) => obj.cursor,
          ),
      type.field(
        'node',
        resolve: (obj, ctx) => obj.node,
      ),
    ],
  );
  final connection = objectType<Connection<T>>(
    '${type.name}Connection',
    fields: [
      listOf(edge).field(
        'edges',
        resolve: (obj, ctx) => obj.edges,
      ),
      pageInfoGraphQLType.nonNull().field(
            'pageInfo',
            resolve: (obj, ctx) => obj.pageInfo,
          ),
    ],
  );
  return ConnectionDefinitions(
    edge,
    connection,
  );
}

final nodeField = nodeGraphQlType.field<Object>(
  'node',
  resolve: (_, ctx) {
    // TODO:
    final id = ctx.args['id']! as String;
  },
  inputs: [
    GraphQLFieldInput(
      'id',
      graphQLId.nonNull(),
    )
  ],
);

final shipConnection = connectionDefinitions(
  shipGraphQlType,
);

/// A ship in the Star Wars saga
@GraphQLClass()
@JsonSerializable()
class Ship implements Node {
  @override
  final String id;

  /// The name of the ship.
  final String name;

  const Ship({
    required this.id,
    required this.name,
  });

  factory Ship.fromJson(Map<String, Object?> json) => _$ShipFromJson(json);
  Map<String, Object?> toJson() => _$ShipToJson(this);
}

final allShips = [
  Ship(id: '1', name: 'X-Wing'),
  Ship(id: '2', name: 'Y-Wing'),
  Ship(id: '3', name: 'A-Wing'),

  // Yeah, technically it's Corellian. But it flew in the service of the rebels,
  // so for the purposes of this demo it's a rebel ship.
  Ship(id: '4', name: 'Millennium Falcon'),
  Ship(id: '5', name: 'Home One'),
  Ship(id: '6', name: 'TIE Fighter'),
  Ship(id: '7', name: 'TIE Interceptor'),
  Ship(id: '8', name: 'Executor'),
];

/// A faction in the Star Wars saga
@GraphQLClass()
@JsonSerializable()
class Faction implements Node {
  @override
  final String id;

  /// The name of the faction.
  final String name;

  /// The ships used by the faction.
  @GraphQLField(omit: true)
  final List<String> ships;

  const Faction({
    required this.id,
    required this.name,
    required this.ships,
  });

  factory Faction.fromJson(Map<String, Object?> json) =>
      _$FactionFromJson(json);
  Map<String, Object?> toJson() => _$FactionToJson(this);

  /// The ships used by the faction.
  @GraphQLField(name: 'ships')
  Connection<Ship> shipConnection(ReqCtx ctx, ConnectionArguments args) {
    final arr = ships
        .map(getShip)
        .whereType<Ship>()
        .mapIndexed((i, e) => Edge(cursor: '$i', node: e))
        .toList();
    return connectionFromEdges(arr, args);
  }
}

Connection<T> connectionFromEdges<T extends Node>(
  List<Edge<T>> array,
  ConnectionArguments args, {
  bool? hasPreviousPage,
  bool? hasNextPage,
}) {
  int startIndex = 0;
  int endIndex = array.length;

  if (args.after != null) {
    startIndex = array.indexWhere((e) => e.cursor == args.after) + 1;
  }
  if (args.before != null) {
    endIndex = array.indexWhere((e) => e.cursor == args.before);
    if (endIndex == -1) {
      endIndex = array.length;
    }
  }
  // Including a value for both first and last is strongly discouraged,
  // as it is likely to lead to confusing queries and results.
  // The PageInfo section goes into more detail here.
  if (args.first != null) {
    endIndex = min(endIndex, startIndex + args.first!);
  }
  if (args.last != null) {
    startIndex = max(startIndex, endIndex - args.last!);
  }

  final edges = array.sublist(startIndex, endIndex);
  return Connection(
    edges: edges,
    pageInfo: PageInfo(
      hasNextPage: (hasNextPage ?? false) || endIndex != array.length,
      hasPreviousPage: (hasPreviousPage ?? false) || startIndex != 0,
      startCursor: edges.isEmpty ? null : edges.first.cursor,
      endCursor: edges.isEmpty ? null : edges.last.cursor,
    ),
  );
}

/// Returns a GraphQLFieldConfigArgumentMap appropriate to include on a field
/// whose return type is a connection type with forward pagination.
// final forwardConnectionArgs = [
//   graphQLString.field<Object>(
//     'after',
//     description: 'Returns the items in the list that '
//         'come after the specified cursor.',
//   ),
//   graphQLInt.field<Object>(
//     'first',
//     description: 'Returns the first n items from the list.',
//   ),
// ];

// /// Returns a GraphQLFieldConfigArgumentMap appropriate to include on a field
// /// whose return type is a connection type with backward pagination.
// final backwardConnectionArgs = [
//   graphQLString.field<Object>(
//     'before',
//     description: 'Returns the items in the list that '
//         'come before the specified cursor.',
//   ),
//   graphQLInt.field<Object>(
//     'last',
//     description: 'Returns the last n items from the list.',
//   ),
// ];

// /// Returns a GraphQLFieldConfigArgumentMap appropriate to include on a field
// /// whose return type is a connection type with bidirectional pagination.
// final connectionArgs = [
//   ...forwardConnectionArgs,
//   ...backwardConnectionArgs,
// ];

@JsonSerializable()
@Validate()
@GraphQLInput()
class ConnectionArguments {
  /// Returns the items in the list that come before the specified cursor.
  final String? before;

  /// Returns the items in the list that come after the specified cursor.
  final String? after;

  /// Returns the first n items from the list.
  @ValidateNum(min: 1)
  final int? first;

  /// Returns the last n items from the list.
  @ValidateNum(min: 1)
  final int? last;

  const ConnectionArguments({
    this.before,
    this.after,
    this.first,
    this.last,
  });

  factory ConnectionArguments.fromJson(Map<String, Object?> json) =>
      _$ConnectionArgumentsFromJson(json);

  Map<String, Object?> toJson() => _$ConnectionArgumentsToJson(this);
}

/// Faction
final rebels = Faction(
  id: '1',
  name: 'Alliance to Restore the Republic',
  ships: ['1', '2', '3', '4', '5'],
);

/// Faction
final empire = Faction(
  id: '2',
  name: 'Galactic Empire',
  ships: ['6', '7', '8'],
);

/// List<Faction>
final allFactions = [rebels, empire];

int nextShip = 9;
Ship createShip(String shipName, String factionId) {
  final newShip = Ship(
    id: (nextShip++).toString(),
    name: shipName,
  );

  allShips.add(newShip);

  final faction = allFactions.firstWhereOrNull((obj) => obj.id == factionId);
  faction?.ships.add(newShip.id);
  return newShip;
}

Ship? getShip(String id) {
  return allShips.firstWhereOrNull((ship) => ship.id == id);
}

Faction? getFaction(String id) {
  return allFactions.firstWhereOrNull((faction) => faction.id == id);
}

Faction getRebels() {
  return rebels;
}

Faction getEmpire() {
  return empire;
}

/// This is the type that will be the root of our query, and the
/// entry point into our schema.
///
/// This implements the following type system shorthand:
///   type Query {
///     rebels: Faction
///     empire: Faction
///     node(id: String!): Node
///   }
final queryType = objectType<Object>(
  'Queries',
  fields: [
    factionGraphQlType.field(
      'rebels',
      resolve: (_, ctx) => getRebels(),
    ),
    factionGraphQlType.field(
      'empire',
      resolve: (_, ctx) => getEmpire(),
    ),
    nodeField,
  ],
);

class MutationConfig<V extends MutationPayload> {
  final String fieldName;
  final String name;
  final String? deprecationReason;
  final String? description;
  // final GraphQLFieldExtensions<any, any>? extensions;
  final List<GraphQLInputObjectField<Object, Object>> inputFields;
  final List<GraphQLObjectField<Object, Object, V>> outputFields;
  final FutureOr<V?> Function(MutationValue<Map<String, Object?>>, ReqCtx)
      mutateAndGetPayload;

  MutationConfig({
    required this.fieldName,
    required this.name,
    this.deprecationReason,
    this.description,
    required this.inputFields,
    required this.outputFields,
    required this.mutateAndGetPayload,
  });
}

abstract class MutationPayload {
  String? get clientMutationId;
}

class MutationValue<T> implements MutationPayload {
  @override
  final String? clientMutationId;
  final T value;

  MutationValue(this.clientMutationId, this.value);
}

/// Returns a GraphQLFieldConfig for the mutation described by the
/// provided MutationConfig.
GraphQLObjectField<V, Map<String, dynamic>, Object>
    mutationWithClientMutationId<V extends MutationPayload>(
  MutationConfig<V> config,
) {
  final inputType = GraphQLInputObjectType<MutationValue<Map<String, Object?>>>(
    '${config.name}Input',
    inputFields: [
      ...config.inputFields,
      GraphQLInputObjectField('clientMutationId', graphQLString),
    ],
    customDeserialize: (map) => MutationValue(
      map.remove('clientMutationId') as String?,
      map,
    ),
  );

  final outputType = objectType<V>(
    '${config.name}Payload',
    fields: [
      ...config.outputFields,
      graphQLString.field(
        'clientMutationId',
        resolve: (payload, v) => payload.clientMutationId,
      ),
    ],
  );

  return outputType.field(
    config.fieldName,
    description: config.description,
    deprecationReason: config.deprecationReason,
    // extensions: config.extensions,
    inputs: [GraphQLFieldInput('input', inputType.nonNull())],
    resolve: (_, ctx) {
      final input = ctx.args['input']! as MutationValue<Map<String, Object?>>;
      return config.mutateAndGetPayload(input, ctx);
      // return MutationInput(input.clientMutationId, payload);
    },
  );
}

/// This will return a GraphQLFieldConfig for our ship
/// mutation.
///
/// It creates these two types implicitly:
///   input IntroduceShipInput {
///     clientMutationId: string
///     shipName: string!
///     factionId: ID!
///   }
///
///   type IntroduceShipPayload {
///     clientMutationId: string
///     ship: Ship
///     faction: Faction
///   }
final shipMutation =
    mutationWithClientMutationId(MutationConfig<ShipMutationPayload>(
  fieldName: 'introduceShip',
  name: 'IntroduceShip',
  inputFields: [
    inputField('shipName', graphQLString.nonNull()),
    inputField('factionId', graphQLId.nonNull()),
  ],
  outputFields: [
    shipGraphQlType.field(
      'ship',
      resolve: (payload, _) => getShip(payload.shipId),
    ),
    factionGraphQlType.field(
      'faction',
      resolve: (payload, _) => getFaction(payload.factionId),
    ),
  ],
  mutateAndGetPayload: (input, ctx) {
    final factionId = input.value['factionId']! as String;
    final newShip = createShip(
      input.value['shipName']! as String,
      factionId,
    );
    return ShipMutationPayload(
      shipId: newShip.id,
      factionId: factionId,
      clientMutationId: input.clientMutationId,
    );
  },
));

class ShipMutationPayload implements MutationPayload {
  final String shipId;
  final String factionId;
  @override
  final String? clientMutationId;

  ShipMutationPayload({
    required this.shipId,
    required this.factionId,
    required this.clientMutationId,
  });
}

/// This is the type that will be the root of our mutations, and the
/// entry point into performing writes in our schema.
///
/// This implements the following type system shorthand:
///   type Mutation {
///     introduceShip(input IntroduceShipInput!): IntroduceShipPayload
///   }
final mutationType = objectType(
  'Mutation',
  fields: [
    shipMutation,
  ],
);

/// Finally, we construct our schema (whose starting query type is the query
/// type we defined above) and export it.
final relayStarWarsSchema = GraphQLSchema(
  queryType: queryType,
  mutationType: mutationType,
);
