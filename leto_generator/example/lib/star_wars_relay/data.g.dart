// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectType<Node>? _nodeGraphQLType;

/// Auto-generated from [Node].
GraphQLObjectType<Node> get nodeGraphQLType {
  final __name = 'Node';
  if (_nodeGraphQLType != null)
    return _nodeGraphQLType! as GraphQLObjectType<Node>;

  final __nodeGraphQLType = objectType<Node>(__name,
      isInterface: true,
      interfaces: [],
      description:
          'This defines a basic set of data for our Star Wars Schema.\n///\nThis data is hard coded for the sake of the demo, but you could imagine\nfetching this data from a backend service rather than from hardcoded\nJSON objects in a more complex demo.\nAn object with an ID');

  _nodeGraphQLType = __nodeGraphQLType;
  __nodeGraphQLType.fields.addAll(
    [graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id)],
  );

  return __nodeGraphQLType;
}

final shipSerializer = SerializerValue<Ship>(
  key: "Ship",
  fromJson: (ctx, json) => Ship.fromJson(json), // _$ShipFromJson,
  // toJson: (m) => _$ShipToJson(m as Ship),
);

GraphQLObjectType<Ship>? _shipGraphQLType;

/// Auto-generated from [Ship].
GraphQLObjectType<Ship> get shipGraphQLType {
  final __name = 'Ship';
  if (_shipGraphQLType != null)
    return _shipGraphQLType! as GraphQLObjectType<Ship>;

  final __shipGraphQLType = objectType<Ship>(__name,
      isInterface: false,
      interfaces: [nodeGraphQLType],
      description: 'A ship in the Star Wars saga');

  _shipGraphQLType = __shipGraphQLType;
  __shipGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('name',
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the ship.'),
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.idResolve)
    ],
  );

  return __shipGraphQLType;
}

final factionSerializer = SerializerValue<Faction>(
  key: "Faction",
  fromJson: (ctx, json) => Faction.fromJson(json), // _$FactionFromJson,
  // toJson: (m) => _$FactionToJson(m as Faction),
);

GraphQLObjectType<Faction>? _factionGraphQLType;

/// Auto-generated from [Faction].
GraphQLObjectType<Faction> get factionGraphQLType {
  final __name = 'Faction';
  if (_factionGraphQLType != null)
    return _factionGraphQLType! as GraphQLObjectType<Faction>;

  final __factionGraphQLType = objectType<Faction>(__name,
      isInterface: false,
      interfaces: [nodeGraphQLType],
      description: 'A faction in the Star Wars saga');

  _factionGraphQLType = __factionGraphQLType;
  __factionGraphQLType.fields.addAll(
    [
      connectionGraphQLType<Ship>(shipGraphQLType.nonNull())
          .nonNull()
          .field('ships', resolve: (obj, ctx) {
        final args = ctx.args;
        final argsArg = connectionArgumentsSerializer.fromJson(
            ctx.executionCtx.schema.serdeCtx, args);
        if (argsArg != null) {
          final argsValidationResult =
              validateConnectionArguments(argsArg as ConnectionArguments);
          if (argsValidationResult.hasErrors) {
            throw argsValidationResult;
          }
        }

        return obj.shipConnection(ctx, argsArg);
      },
              inputs: [...connectionArgumentsGraphQLType.fields],
              description: 'The ships used by the faction.'),
      graphQLString.nonNull().field('name',
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the faction.'),
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.idResolve)
    ],
  );

  return __factionGraphQLType;
}

final connectionArgumentsSerializer = SerializerValue<ConnectionArguments>(
  key: "ConnectionArguments",
  fromJson: (ctx, json) =>
      ConnectionArguments.fromJson(json), // _$ConnectionArgumentsFromJson,
  // toJson: (m) => _$ConnectionArgumentsToJson(m as ConnectionArguments),
);

GraphQLInputObjectType<ConnectionArguments>? _connectionArgumentsGraphQLType;

/// Auto-generated from [ConnectionArguments].
GraphQLInputObjectType<ConnectionArguments> get connectionArgumentsGraphQLType {
  final __name = 'ConnectionArguments';
  if (_connectionArgumentsGraphQLType != null)
    return _connectionArgumentsGraphQLType!
        as GraphQLInputObjectType<ConnectionArguments>;

  final __connectionArgumentsGraphQLType = inputObjectType<ConnectionArguments>(
      __name,
      description:
          'Returns a GraphQLFieldConfigArgumentMap appropriate to include on a field\nwhose return type is a connection type with forward pagination.');

  _connectionArgumentsGraphQLType = __connectionArgumentsGraphQLType;
  __connectionArgumentsGraphQLType.fields.addAll(
    [
      graphQLString.coerceToInputObject().inputField('before',
          description:
              'Returns the items in the list that come before the specified cursor.'),
      graphQLString.coerceToInputObject().inputField('after',
          description:
              'Returns the items in the list that come after the specified cursor.'),
      graphQLInt.coerceToInputObject().inputField('first',
          description: 'Returns the first n items from the list.'),
      graphQLInt.coerceToInputObject().inputField('last',
          description: 'Returns the last n items from the list.')
    ],
  );

  return __connectionArgumentsGraphQLType;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ship _$ShipFromJson(Map<String, dynamic> json) => Ship(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ShipToJson(Ship instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Faction _$FactionFromJson(Map<String, dynamic> json) => Faction(
      id: json['id'] as String,
      name: json['name'] as String,
      ships: (json['ships'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FactionToJson(Faction instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ships': instance.ships,
    };

ConnectionArguments _$ConnectionArgumentsFromJson(Map<String, dynamic> json) =>
    ConnectionArguments(
      before: json['before'] as String?,
      after: json['after'] as String?,
      first: json['first'] as int?,
      last: json['last'] as int?,
    );

Map<String, dynamic> _$ConnectionArgumentsToJson(
        ConnectionArguments instance) =>
    <String, dynamic>{
      'before': instance.before,
      'after': instance.after,
      'first': instance.first,
      'last': instance.last,
    };

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

enum ConnectionArgumentsField {
  first,
  last,
}

class ConnectionArgumentsValidationFields {
  const ConnectionArgumentsValidationFields(this.errorsMap);
  final Map<ConnectionArgumentsField, List<ValidaError>> errorsMap;

  List<ValidaError> get first => errorsMap[ConnectionArgumentsField.first]!;
  List<ValidaError> get last => errorsMap[ConnectionArgumentsField.last]!;
}

class ConnectionArgumentsValidation
    extends Validation<ConnectionArguments, ConnectionArgumentsField> {
  ConnectionArgumentsValidation(this.errorsMap, this.value, this.fields)
      : super(errorsMap);

  final Map<ConnectionArgumentsField, List<ValidaError>> errorsMap;

  final ConnectionArguments value;

  final ConnectionArgumentsValidationFields fields;
}

ConnectionArgumentsValidation validateConnectionArguments(
    ConnectionArguments value) {
  final errors = <ConnectionArgumentsField, List<ValidaError>>{};

  if (value.first == null)
    errors[ConnectionArgumentsField.first] = [];
  else
    errors[ConnectionArgumentsField.first] = [
      if (value.first! < 1)
        ValidaError(
          message: r'Should be at a minimum 1',
          errorCode: 'ValidaNum.min',
          property: 'first',
          validationParam: 1,
          value: value.first!,
        )
    ];
  if (value.last == null)
    errors[ConnectionArgumentsField.last] = [];
  else
    errors[ConnectionArgumentsField.last] = [
      if (value.last! < 1)
        ValidaError(
          message: r'Should be at a minimum 1',
          errorCode: 'ValidaNum.min',
          property: 'last',
          validationParam: 1,
          value: value.last!,
        )
    ];

  return ConnectionArgumentsValidation(
    errors,
    value,
    ConnectionArgumentsValidationFields(errors),
  );
}
