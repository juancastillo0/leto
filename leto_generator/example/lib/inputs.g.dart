// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inputs.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<int, Object, Object> testInputGenGraphQLField = field(
  'testInputGen',
  graphQLInt.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return testInputGen((args["input"] as InputGen<int>));
  },
  inputs: [
    GraphQLFieldInput(
      "input",
      inputGenGraphQLType<int>(graphQLInt.nonNull()).nonNull(),
    )
  ],
);

final GraphQLObjectField<String, Object, Object>
    queryMultipleParamsGraphQLField = field(
  'queryMultipleParams',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return queryMultipleParams((args["serde"] as InputJsonSerde?),
        serdeReq: (args["serdeReq"] as InputJsonSerde),
        defTwo: (args["defTwo"] as int),
        mInput: (args["mInput"] as InputM?),
        gen: (args["gen"] as InputGen<InputJsonSerde?>));
  },
  inputs: [
    GraphQLFieldInput(
      "serde",
      inputJsonSerdeGraphQLType,
    ),
    GraphQLFieldInput(
      "serdeReq",
      inputJsonSerdeGraphQLType.nonNull(),
    ),
    GraphQLFieldInput(
      "defTwo",
      graphQLInt.nonNull().coerceToInputObject(),
      defaultValue: 2,
    ),
    GraphQLFieldInput(
      "mInput",
      inputMGraphQLType,
    ),
    GraphQLFieldInput(
      "gen",
      inputGenGraphQLType<InputJsonSerde?>(inputJsonSerdeGraphQLType).nonNull(),
    )
  ],
);

final GraphQLObjectField<String, Object, Object>
    mutationMultipleParamsOptionalPosGraphQLField = field(
  'mutationMultipleParamsOptionalPos',
  graphQLString.nonNull(),
  resolve: (obj, ctx) {
    final args = ctx.args;

    return mutationMultipleParamsOptionalPos(
        (args["serde"] as InputJsonSerde?),
        (args["defTwo"] as int),
        (args["gen"] as InputGen<List<InputJsonSerde>?>?),
        (args["gen2"] as InputGen2<String, List<List<int>?>>?));
  },
  inputs: [
    GraphQLFieldInput(
      "serde",
      inputJsonSerdeGraphQLType,
    ),
    GraphQLFieldInput(
      "defTwo",
      graphQLInt.nonNull().coerceToInputObject(),
      defaultValue: 2,
    ),
    GraphQLFieldInput(
      "gen",
      inputGenGraphQLType<List<InputJsonSerde>?>(
          inputJsonSerdeGraphQLType.nonNull().list()),
    ),
    GraphQLFieldInput(
      "gen2",
      inputGen2GraphQLType<String, List<List<int>?>>(graphQLString.nonNull(),
          graphQLInt.nonNull().list().list().nonNull()),
    )
  ],
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final inputMSerializer = SerializerValue<InputM>(
  fromJson: (ctx, json) => InputM.fromJson(json), // _$InputMFromJson,
  // toJson: (m) => _$InputMToJson(m as InputM),
);

GraphQLInputObjectType<InputM>? _inputMGraphQLType;

/// Auto-generated from [InputM].
GraphQLInputObjectType<InputM> get inputMGraphQLType {
  final __name = 'InputM';
  if (_inputMGraphQLType != null)
    return _inputMGraphQLType! as GraphQLInputObjectType<InputM>;

  final __inputMGraphQLType = inputObjectType<InputM>('InputM');

  _inputMGraphQLType = __inputMGraphQLType;
  __inputMGraphQLType.fields.addAll(
    [
      inputField('name', graphQLString.nonNull().coerceToInputObject()),
      inputField('date', graphQLDate.coerceToInputObject()),
      inputField(
          'ints', graphQLInt.nonNull().list().nonNull().coerceToInputObject()),
      inputField('nested',
          inputMNGraphQLType.nonNull().list().nonNull().coerceToInputObject()),
      inputField('nestedNullItem',
          inputMNGraphQLType.list().nonNull().coerceToInputObject()),
      inputField('nestedNullItemNull',
          inputMNGraphQLType.list().coerceToInputObject()),
      inputField('nestedNull',
          inputMNGraphQLType.nonNull().list().coerceToInputObject())
    ],
  );

  return __inputMGraphQLType;
}

final inputMNSerializer = SerializerValue<InputMN>(
  fromJson: (ctx, json) => InputMN.fromJson(json), // _$InputMNFromJson,
  // toJson: (m) => _$InputMNToJson(m as InputMN),
);

GraphQLInputObjectType<InputMN>? _inputMNGraphQLType;

/// Auto-generated from [InputMN].
GraphQLInputObjectType<InputMN> get inputMNGraphQLType {
  final __name = 'InputMN';
  if (_inputMNGraphQLType != null)
    return _inputMNGraphQLType! as GraphQLInputObjectType<InputMN>;

  final __inputMNGraphQLType = inputObjectType<InputMN>('InputMN');

  _inputMNGraphQLType = __inputMNGraphQLType;
  __inputMNGraphQLType.fields.addAll(
    [
      inputField('name', graphQLString.nonNull().coerceToInputObject()),
      inputField('parent', inputMGraphQLType.coerceToInputObject())
    ],
  );

  return __inputMNGraphQLType;
}

final inputJsonSerdeSerializer = SerializerValue<InputJsonSerde>(
  fromJson: (ctx, json) =>
      InputJsonSerde.fromJson(json), // _$InputJsonSerdeFromJson,
  // toJson: (m) => _$InputJsonSerdeToJson(m as InputJsonSerde),
);

GraphQLInputObjectType<InputJsonSerde>? _inputJsonSerdeGraphQLType;

/// Auto-generated from [InputJsonSerde].
GraphQLInputObjectType<InputJsonSerde> get inputJsonSerdeGraphQLType {
  final __name = 'InputJsonSerde';
  if (_inputJsonSerdeGraphQLType != null)
    return _inputJsonSerdeGraphQLType!
        as GraphQLInputObjectType<InputJsonSerde>;

  final __inputJsonSerdeGraphQLType =
      inputObjectType<InputJsonSerde>('InputJsonSerde');

  _inputJsonSerdeGraphQLType = __inputJsonSerdeGraphQLType;
  __inputJsonSerdeGraphQLType.fields.addAll(
    [
      inputField('name', graphQLString.nonNull().coerceToInputObject()),
      inputField('parent', inputMGraphQLType.coerceToInputObject()),
      inputField(
          'inputGenM',
          inputGenGraphQLType<InputM>(inputMGraphQLType.nonNull())
              .coerceToInputObject()),
      inputField('inputGenMNull',
          inputGenGraphQLType<InputM?>(inputMGraphQLType).coerceToInputObject())
    ],
  );

  return __inputJsonSerdeGraphQLType;
}

final inputGenSerdeCtx = SerdeCtx();
Map<String, GraphQLInputObjectType<InputGen>> _inputGenGraphQLType = {};

/// Auto-generated from [InputGen].
GraphQLInputObjectType<InputGen<T>> inputGenGraphQLType<T>(
  GraphQLType<T, Object> tGraphQLType,
) {
  final __name = 'InputGen${tGraphQLType.printableName}';
  if (_inputGenGraphQLType[__name] != null)
    return _inputGenGraphQLType[__name]! as GraphQLInputObjectType<InputGen<T>>;

  final __inputGenGraphQLType =
      inputObjectType<InputGen<T>>('InputGen${tGraphQLType.printableName}');
  inputGenSerdeCtx.add(
    SerializerValue<InputGen<T>>(
      fromJson: (ctx, json) => InputGen.fromJson(json, ctx.fromJson),
    ),
  );
  _inputGenGraphQLType[__name] = __inputGenGraphQLType;
  __inputGenGraphQLType.fields.addAll(
    [
      inputField('name', graphQLString.nonNull().coerceToInputObject()),
      inputField('generic', tGraphQLType.coerceToInputObject())
    ],
  );

  return __inputGenGraphQLType;
}

final inputGen2SerdeCtx = SerdeCtx();
Map<String, GraphQLInputObjectType<InputGen2>> _inputGen2GraphQLType = {};

/// Auto-generated from [InputGen2].
GraphQLInputObjectType<InputGen2<T, O>>
    inputGen2GraphQLType<T, O extends Object>(
  GraphQLType<T, Object> tGraphQLType,
  GraphQLType<O, Object> oGraphQLType,
) {
  final __name =
      'InputGen2${tGraphQLType.printableName}${oGraphQLType.printableName}';
  if (_inputGen2GraphQLType[__name] != null)
    return _inputGen2GraphQLType[__name]!
        as GraphQLInputObjectType<InputGen2<T, O>>;

  final __inputGen2GraphQLType = inputObjectType<InputGen2<T, O>>(
      'InputGen2${tGraphQLType.printableName}${oGraphQLType.printableName}');
  inputGen2SerdeCtx.add(
    SerializerValue<InputGen2<T, O>>(
      fromJson: (ctx, json) =>
          InputGen2.fromJson(json, ctx.fromJson, ctx.fromJson),
    ),
  );
  _inputGen2GraphQLType[__name] = __inputGen2GraphQLType;
  __inputGen2GraphQLType.fields.addAll(
    [
      inputField('name', graphQLString.nonNull().coerceToInputObject()),
      inputField('generic', tGraphQLType.coerceToInputObject()),
      inputField('value', oGraphQLType.nonNull().coerceToInputObject()),
      inputField('listValue',
          oGraphQLType.nonNull().list().nonNull().coerceToInputObject())
    ],
  );

  return __inputGen2GraphQLType;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputM _$InputMFromJson(Map<String, dynamic> json) => InputM(
      name: json['name'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      ints: (json['ints'] as List<dynamic>).map((e) => e as int).toList(),
      nested: (json['nested'] as List<dynamic>)
          .map((e) => InputMN.fromJson(e as Map<String, dynamic>))
          .toList(),
      nestedNullItem: (json['nestedNullItem'] as List<dynamic>)
          .map((e) =>
              e == null ? null : InputMN.fromJson(e as Map<String, dynamic>))
          .toList(),
      nestedNullItemNull: (json['nestedNullItemNull'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : InputMN.fromJson(e as Map<String, dynamic>))
          .toList(),
      nestedNull: (json['nestedNull'] as List<dynamic>?)
          ?.map((e) => InputMN.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InputMToJson(InputM instance) => <String, dynamic>{
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
      'ints': instance.ints,
      'nested': instance.nested,
      'nestedNullItem': instance.nestedNullItem,
      'nestedNullItemNull': instance.nestedNullItemNull,
      'nestedNull': instance.nestedNull,
    };

InputJsonSerde _$InputJsonSerdeFromJson(Map<String, dynamic> json) =>
    InputJsonSerde(
      name: json['name'] as String,
      parent: json['parent'] == null
          ? null
          : InputM.fromJson(json['parent'] as Map<String, dynamic>),
      inputGenM: json['inputGenM'] == null
          ? null
          : InputGen<InputM>.fromJson(json['inputGenM'] as Map<String, dynamic>,
              (value) => InputM.fromJson(value as Map<String, dynamic>)),
      inputGenMNull: json['inputGenMNull'] == null
          ? null
          : InputGen<InputM?>.fromJson(
              json['inputGenMNull'] as Map<String, dynamic>,
              (value) => value == null
                  ? null
                  : InputM.fromJson(value as Map<String, dynamic>)),
    );

Map<String, dynamic> _$InputJsonSerdeToJson(InputJsonSerde instance) =>
    <String, dynamic>{
      'name': instance.name,
      'parent': instance.parent,
      'inputGenM': instance.inputGenM,
      'inputGenMNull': instance.inputGenMNull,
    };

InputGen<T> _$InputGenFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    InputGen<T>(
      name: json['name'] as String,
      generic: fromJsonT(json['generic']),
    );

Map<String, dynamic> _$InputGenToJson<T>(
  InputGen<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'name': instance.name,
      'generic': toJsonT(instance.generic),
    };

InputGen2<T, O> _$InputGen2FromJson<T, O extends Object>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
  O Function(Object? json) fromJsonO,
) =>
    InputGen2<T, O>(
      name: json['name'] as String,
      generic: fromJsonT(json['generic']),
      value: fromJsonO(json['value']),
      listValue: (json['listValue'] as List<dynamic>).map(fromJsonO).toList(),
    );

Map<String, dynamic> _$InputGen2ToJson<T, O extends Object>(
  InputGen2<T, O> instance,
  Object? Function(T value) toJsonT,
  Object? Function(O value) toJsonO,
) =>
    <String, dynamic>{
      'name': instance.name,
      'generic': toJsonT(instance.generic),
      'value': toJsonO(instance.value),
      'listValue': instance.listValue.map(toJsonO).toList(),
    };
