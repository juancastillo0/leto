// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _nodeGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Node>>((setValue) {
  final __name = 'Node';

  final __nodeGraphQLType = objectType<Node>(__name,
      isInterface: true,
      interfaces: [],
      description:
          'This defines a basic set of data for our Star Wars Schema.\n///\nThis data is hard coded for the sake of the demo, but you could imagine\nfetching this data from a backend service rather than from hardcoded\nJSON objects in a more complex demo.\nAn object with an ID');

  setValue(__nodeGraphQLType);
  __nodeGraphQLType.fields.addAll(
    [graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.id)],
  );

  return __nodeGraphQLType;
});

/// Auto-generated from [Node].
GraphQLObjectType<Node> get nodeGraphQLType => _nodeGraphQLType.value;

final shipSerializer = SerializerValue<Ship>(
  key: "Ship",
  fromJson: (ctx, json) => Ship.fromJson(json), // _$ShipFromJson,
  // toJson: (m) => _$ShipToJson(m as Ship),
);
final _shipGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Ship>>((setValue) {
  final __name = 'Ship';

  final __shipGraphQLType = objectType<Ship>(__name,
      isInterface: false,
      interfaces: [nodeGraphQLType],
      description: 'A ship in the Star Wars saga');

  setValue(__shipGraphQLType);
  __shipGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('name',
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the ship.'),
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.idResolve)
    ],
  );

  return __shipGraphQLType;
});

/// Auto-generated from [Ship].
GraphQLObjectType<Ship> get shipGraphQLType => _shipGraphQLType.value;

final factionSerializer = SerializerValue<Faction>(
  key: "Faction",
  fromJson: (ctx, json) => Faction.fromJson(json), // _$FactionFromJson,
  // toJson: (m) => _$FactionToJson(m as Faction),
);
final _factionGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<Faction>>((setValue) {
  final __name = 'Faction';

  final __factionGraphQLType = objectType<Faction>(__name,
      isInterface: false,
      interfaces: [nodeGraphQLType],
      description: 'A faction in the Star Wars saga');

  setValue(__factionGraphQLType);
  __factionGraphQLType.fields.addAll(
    [
      connectionGraphQLType<Ship>(shipGraphQLType.nonNull())
          .nonNull()
          .field('ships', resolve: (obj, ctx) {
        final args = ctx.args;
        final validationErrorMap = <String, List<ValidaError>>{};

        final argsArg = connectionArgumentsSerializer.fromJson(
            ctx.executionCtx.schema.serdeCtx, args);
        if (argsArg != null) {
          final argsValidationResult =
              validateConnectionArguments(argsArg as ConnectionArguments);
          if (argsValidationResult.hasErrors) {
            validationErrorMap.addAll(argsValidationResult.errorsMap
                .map((k, v) => MapEntry(k is Enum ? k.name : k.toString(), v)));
          }
        }

        if (validationErrorMap.isNotEmpty) {
          throw GraphQLError(
            'Input validation error',
            extensions: {
              'validaErrors': validationErrorMap,
            },
            sourceError: validationErrorMap,
          );
        }

        return obj.shipConnection(ctx, argsArg);
      },
              inputs: [...connectionArgumentsGraphQLTypeInput.fields],
              description: 'The ships used by the faction.'),
      graphQLString.nonNull().field('name',
          resolve: (obj, ctx) => obj.name,
          description: 'The name of the faction.'),
      graphQLId.nonNull().field('id', resolve: (obj, ctx) => obj.idResolve)
    ],
  );

  return __factionGraphQLType;
});

/// Auto-generated from [Faction].
GraphQLObjectType<Faction> get factionGraphQLType => _factionGraphQLType.value;

final connectionArgumentsSerializer = SerializerValue<ConnectionArguments>(
  key: "ConnectionArguments",
  fromJson: (ctx, json) => ConnectionArguments.fromJson(json), // _$$FromJson,
  // toJson: (m) => _$$ToJson(m as _$),
);
final _connectionArgumentsGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<ConnectionArguments>>(
        (setValue) {
  final __name = 'ConnectionArguments';

  final __connectionArgumentsGraphQLTypeInput =
      inputObjectType<ConnectionArguments>(__name);

  setValue(__connectionArgumentsGraphQLTypeInput);
  __connectionArgumentsGraphQLTypeInput.fields.addAll(
    [
      graphQLString.inputField('before',
          description:
              'Returns the items in the list that come before the specified cursor.'),
      graphQLString.inputField('after',
          description:
              'Returns the items in the list that come after the specified cursor.'),
      graphQLInt.inputField('first',
          description: 'Returns the first n items from the list.',
          attachments: [
            ValidaAttachment(ValidaNum(min: 1)),
          ]),
      graphQLInt.inputField('last',
          description: 'Returns the last n items from the list.',
          attachments: [
            ValidaAttachment(ValidaNum(min: 1)),
          ])
    ],
  );

  return __connectionArgumentsGraphQLTypeInput;
});

/// Auto-generated from [ConnectionArguments].
GraphQLInputObjectType<ConnectionArguments>
    get connectionArgumentsGraphQLTypeInput =>
        _connectionArgumentsGraphQLTypeInput.value;

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
  @override
  final Map<ConnectionArgumentsField, List<ValidaError>> errorsMap;
  @override
  final ConnectionArguments value;
  @override
  final ConnectionArgumentsValidationFields fields;

  /// Validates [value] and returns a [ConnectionArgumentsValidation] with the errors found as a result
  static ConnectionArgumentsValidation fromValue(ConnectionArguments value) {
    Object? _getProperty(String property) => spec.getField(value, property);

    final errors = <ConnectionArgumentsField, List<ValidaError>>{
      ...spec.fieldsMap.map(
        (key, field) => MapEntry(
          key,
          field.validate(key.name, _getProperty),
        ),
      )
    };
    errors.removeWhere((key, value) => value.isEmpty);
    return ConnectionArgumentsValidation(
        errors, value, ConnectionArgumentsValidationFields(errors));
  }

  static const spec = ValidaSpec(
    fieldsMap: {
      ConnectionArgumentsField.first: ValidaNum(min: 1),
      ConnectionArgumentsField.last: ValidaNum(min: 1),
    },
    getField: _getField,
  );

  static List<ValidaError> _globalValidate(ConnectionArguments value) => [];

  static Object? _getField(ConnectionArguments value, String field) {
    switch (field) {
      case 'first':
        return value.first;
      case 'last':
        return value.last;
      default:
        throw Exception();
    }
  }
}

@Deprecated('Use ConnectionArgumentsValidation.fromValue')
ConnectionArgumentsValidation validateConnectionArguments(
    ConnectionArguments value) {
  return ConnectionArgumentsValidation.fromValue(value);
}
