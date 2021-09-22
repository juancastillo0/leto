// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectType<Node>? _nodeGraphQlType;

/// Auto-generated from [Node].
GraphQLObjectType<Node> get nodeGraphQlType {
  if (_nodeGraphQlType != null) return _nodeGraphQlType!;

  _nodeGraphQlType = objectType('Node',
      isInterface: true,
      interfaces: [],
      description:
          'This defines a basic set of data for our Star Wars Schema.\n///\nThis data is hard coded for the sake of the demo, but you could imagine\nfetching this data from a backend service rather than from hardcoded\nJSON objects in a more complex demo.\nAn object with an ID');
  _nodeGraphQlType!.fields.addAll(
    [
      field('id', graphQLId.nonNull(),
          resolve: (obj, ctx) => obj.id,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return _nodeGraphQlType!;
}

final shipSerializer = SerializerValue<Ship>(
  fromJson: _$ShipFromJson,
  toJson: (m) => _$ShipToJson(m as Ship),
);
GraphQLObjectType<Ship>? _shipGraphQlType;

/// Auto-generated from [Ship].
GraphQLObjectType<Ship> get shipGraphQlType {
  if (_shipGraphQlType != null) return _shipGraphQlType!;

  _shipGraphQlType = objectType('Ship',
      isInterface: false,
      interfaces: [nodeGraphQlType],
      description: 'A ship in the Star Wars saga');
  _shipGraphQlType!.fields.addAll(
    [
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          inputs: [],
          description: 'The name of the ship.',
          deprecationReason: null),
      field('id', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.idResolve,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return _shipGraphQlType!;
}

final factionSerializer = SerializerValue<Faction>(
  fromJson: _$FactionFromJson,
  toJson: (m) => _$FactionToJson(m as Faction),
);
GraphQLObjectType<Faction>? _factionGraphQlType;

/// Auto-generated from [Faction].
GraphQLObjectType<Faction> get factionGraphQlType {
  if (_factionGraphQlType != null) return _factionGraphQlType!;

  _factionGraphQlType = objectType('Faction',
      isInterface: false,
      interfaces: [nodeGraphQlType],
      description: 'A faction in the Star Wars saga');
  _factionGraphQlType!.fields.addAll(
    [
      field('ships', connectionGraphQlType(shipGraphQlType.nonNull()).nonNull(),
          resolve: (obj, ctx) {
        final args = ctx.args;
        final argsArg = connectionArgumentsSerializer.fromJson(args);
        if (argsArg != null) {
          final argsValidationResult =
              validateConnectionArguments(argsArg as ConnectionArguments);
          if (argsValidationResult.hasErrors) {
            throw argsValidationResult;
          }
        }

        return obj.shipConnection(ctx, argsArg);
      },
          inputs: [...connectionArgumentsGraphQlType.inputFields],
          description: 'The ships used by the faction.',
          deprecationReason: null),
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          inputs: [],
          description: 'The name of the faction.',
          deprecationReason: null),
      field('id', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.idResolve,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return _factionGraphQlType!;
}

final connectionArgumentsSerializer = SerializerValue<ConnectionArguments>(
  fromJson: _$ConnectionArgumentsFromJson,
  toJson: (m) => _$ConnectionArgumentsToJson(m as ConnectionArguments),
);
GraphQLInputObjectType<ConnectionArguments>? _connectionArgumentsGraphQlType;

/// Auto-generated from [ConnectionArguments].
GraphQLInputObjectType<ConnectionArguments> get connectionArgumentsGraphQlType {
  if (_connectionArgumentsGraphQlType != null)
    return _connectionArgumentsGraphQlType!;

  _connectionArgumentsGraphQlType = inputObjectType('ConnectionArguments',
      description:
          'Returns a GraphQLFieldConfigArgumentMap appropriate to include on a field\nwhose return type is a connection type with forward pagination.');
  _connectionArgumentsGraphQlType!.inputFields.addAll(
    [
      inputField('before', graphQLString.coerceToInputObject(),
          description:
              'Returns the items in the list that come before the specified cursor.',
          deprecationReason: null),
      inputField('after', graphQLString.coerceToInputObject(),
          description:
              'Returns the items in the list that come after the specified cursor.',
          deprecationReason: null),
      inputField('first', graphQLInt.coerceToInputObject(),
          description: 'Returns the first n items from the list.',
          deprecationReason: null),
      inputField('last', graphQLInt.coerceToInputObject(),
          description: 'Returns the last n items from the list.',
          deprecationReason: null)
    ],
  );

  return _connectionArgumentsGraphQlType!;
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
  final Map<ConnectionArgumentsField, List<ValidationError>> errorsMap;

  List<ValidationError> get first => errorsMap[ConnectionArgumentsField.first]!;
  List<ValidationError> get last => errorsMap[ConnectionArgumentsField.last]!;
}

class ConnectionArgumentsValidation
    extends Validation<ConnectionArguments, ConnectionArgumentsField> {
  ConnectionArgumentsValidation(this.errorsMap, this.value, this.fields)
      : super(errorsMap);

  final Map<ConnectionArgumentsField, List<ValidationError>> errorsMap;

  final ConnectionArguments value;

  final ConnectionArgumentsValidationFields fields;
}

ConnectionArgumentsValidation validateConnectionArguments(
    ConnectionArguments value) {
  final errors = <ConnectionArgumentsField, List<ValidationError>>{};

  if (value.first == null)
    errors[ConnectionArgumentsField.first] = [];
  else
    errors[ConnectionArgumentsField.first] = [
      if (value.first! < 1)
        ValidationError(
          message: r'Should be at a minimum 1',
          errorCode: 'ValidateNum.min',
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
        ValidationError(
          message: r'Should be at a minimum 1',
          errorCode: 'ValidateNum.min',
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
