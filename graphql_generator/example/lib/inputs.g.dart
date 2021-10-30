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

    return testInputGen((args["v"] as InputGen<int>));
  },
  inputs: [
    GraphQLFieldInput(
      "v",
      inputGenGraphQLType(graphQLInt.nonNull()).nonNull(),
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
          'ints', listOf(graphQLInt.nonNull()).nonNull().coerceToInputObject()),
      inputField('nested',
          listOf(inputMNGraphQLType.nonNull()).nonNull().coerceToInputObject()),
      inputField('nestedNullItem',
          listOf(inputMNGraphQLType).nonNull().coerceToInputObject()),
      inputField('nestedNullItemNull',
          listOf(inputMNGraphQLType).coerceToInputObject()),
      inputField('nestedNull',
          listOf(inputMNGraphQLType.nonNull()).coerceToInputObject())
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
          inputGenGraphQLType(inputMGraphQLType.nonNull())
              .coerceToInputObject()),
      inputField('inputGenMNull',
          inputGenGraphQLType(inputMGraphQLType).coerceToInputObject())
    ],
  );

  return __inputJsonSerdeGraphQLType;
}

final inputGenSerdeCtx = SerdeCtx();
Map<String, GraphQLInputObjectType<InputGen>> _inputGenGraphQLType = {};

/// Auto-generated from [InputGen].
GraphQLInputObjectType<InputGen<T>> inputGenGraphQLType<T extends Object>(
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
      inputField('generic', tGraphQLType.nonNull().coerceToInputObject())
    ],
  );

  return __inputGenGraphQLType;
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
