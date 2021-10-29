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

  final __nodeGraphQLType = objectType<Node>('Node',
      isInterface: true,
      interfaces: [],
      description:
          'This defines a basic set of data for our Star Wars Schema.\n///\nThis data is hard coded for the sake of the demo, but you could imagine\nfetching this data from a backend service rather than from hardcoded\nJSON objects in a more complex demo.\nAn object with an ID');

  _nodeGraphQLType = __nodeGraphQLType;
  __nodeGraphQLType.fields.addAll(
    [field('id', graphQLId.nonNull(), resolve: (obj, ctx) => obj.id)],
  );

  return __nodeGraphQLType;
}

final shipSerializer = SerializerValue<Ship>(
  fromJson: (ctx, json) => Ship.fromJson(json), // _$ShipFromJson,
  // toJson: (m) => _$ShipToJson(m as Ship),
);

GraphQLObjectType<Ship>? _shipGraphQLType;

/// Auto-generated from [Ship].
GraphQLObjectType<Ship> get shipGraphQLType {
  final __name = 'Ship';
  if (_shipGraphQLType != null)
    return _shipGraphQLType! as GraphQLObjectType<Ship>;

  final __shipGraphQLType = objectType<Ship>('Ship',
      isInterface: false,
      interfaces: [nodeGraphQLType],
      description: 'A ship in the Star Wars saga');

  _shipGraphQLType = __shipGraphQLType;
  __shipGraphQLType.fields.addAll(
    [
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the ship.'),
      field('id', graphQLId.nonNull(), resolve: (obj, ctx) => obj.idResolve)
    ],
  );

  return __shipGraphQLType;
}

final factionSerializer = SerializerValue<Faction>(
  fromJson: (ctx, json) => Faction.fromJson(json), // _$FactionFromJson,
  // toJson: (m) => _$FactionToJson(m as Faction),
);

GraphQLObjectType<Faction>? _factionGraphQLType;

/// Auto-generated from [Faction].
GraphQLObjectType<Faction> get factionGraphQLType {
  final __name = 'Faction';
  if (_factionGraphQLType != null)
    return _factionGraphQLType! as GraphQLObjectType<Faction>;

  final __factionGraphQLType = objectType<Faction>('Faction',
      isInterface: false,
      interfaces: [nodeGraphQLType],
      description: 'A faction in the Star Wars saga');

  _factionGraphQLType = __factionGraphQLType;
  __factionGraphQLType.fields.addAll(
    [
      field('ships', connectionGraphQLType(shipGraphQLType.nonNull()).nonNull(),
          resolve: (obj, ctx) {
        final args = ctx.args;
        final argsArg =
            connectionArgumentsSerializer.fromJson(ctx.baseCtx.serdeCtx, args);
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
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the faction.'),
      field('id', graphQLId.nonNull(), resolve: (obj, ctx) => obj.idResolve)
    ],
  );

  return __factionGraphQLType;
}

final connectionArgumentsSerializer = SerializerValue<ConnectionArguments>(
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
      'ConnectionArguments',
      description:
          'Returns a GraphQLFieldConfigArgumentMap appropriate to include on a field\nwhose return type is a connection type with forward pagination.');

  _connectionArgumentsGraphQLType = __connectionArgumentsGraphQLType;
  __connectionArgumentsGraphQLType.fields.addAll(
    [
      inputField('before', graphQLString.coerceToInputObject(),
          description:
              'Returns the items in the list that come before the specified cursor.'),
      inputField('after', graphQLString.coerceToInputObject(),
          description:
              'Returns the items in the list that come after the specified cursor.'),
      inputField('first', graphQLInt.coerceToInputObject(),
          description: 'Returns the first n items from the list.'),
      inputField('last', graphQLInt.coerceToInputObject(),
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
