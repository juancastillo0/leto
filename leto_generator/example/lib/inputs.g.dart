// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inputs.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<int, Object?, Object?> get testInputGenGraphQLField =>
    _testInputGenGraphQLField.value;
final _testInputGenGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<int, Object?, Object?>>(
        (setValue) => setValue(graphQLInt.nonNull().field<Object?>(
              'testInputGen',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return testInputGen((args["input"] as InputGen<int>));
              },
            ))
              ..inputs.addAll([
                inputGenGraphQLType<int>(graphQLInt.nonNull())
                    .nonNull()
                    .inputField('input')
              ]));

GraphQLObjectField<String, Object?, Object?>
    get queryMultipleParamsGraphQLField =>
        _queryMultipleParamsGraphQLField.value;
final _queryMultipleParamsGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<String, Object?, Object?>>(
        (setValue) => setValue(graphQLString.nonNull().field<Object?>(
              'queryMultipleParams',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return queryMultipleParams((args["serde"] as InputJsonSerde?),
                    serdeReq: (args["serdeReq"] as InputJsonSerde),
                    defTwo: (args["defTwo"] as int),
                    mInput: (args["mInput"] as InputM?),
                    gen: (args["gen"] as InputGen<InputJsonSerde?>));
              },
            ))
              ..inputs.addAll([
                inputJsonSerdeGraphQLType.inputField('serde'),
                inputJsonSerdeGraphQLType.nonNull().inputField('serdeReq'),
                graphQLInt
                    .nonNull()
                    .coerceToInputObject()
                    .inputField('defTwo', defaultValue: 2),
                inputMGraphQLType.inputField('mInput'),
                inputGenGraphQLType<InputJsonSerde?>(inputJsonSerdeGraphQLType)
                    .nonNull()
                    .inputField('gen')
              ]));

GraphQLObjectField<String, Object?, Object?>
    get mutationMultipleParamsOptionalPosGraphQLField =>
        _mutationMultipleParamsOptionalPosGraphQLField.value;
final _mutationMultipleParamsOptionalPosGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<String, Object?, Object?>>(
        (setValue) => setValue(graphQLString.nonNull().field<Object?>(
              'mutationMultipleParamsOptionalPos',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return mutationMultipleParamsOptionalPos(
                    (args["serde"] as InputJsonSerde?),
                    (args["defTwo"] as int),
                    (args["gen"] as InputGen<List<InputJsonSerde>?>?),
                    (args["gen2"] as InputGen2<String, List<List<int>?>>?));
              },
            ))
              ..inputs.addAll([
                inputJsonSerdeGraphQLType.inputField('serde'),
                graphQLInt
                    .nonNull()
                    .coerceToInputObject()
                    .inputField('defTwo', defaultValue: 2),
                inputGenGraphQLType<List<InputJsonSerde>?>(
                        inputJsonSerdeGraphQLType.nonNull().list())
                    .inputField('gen'),
                inputGen2GraphQLType<String, List<List<int>?>>(
                        graphQLString.nonNull(),
                        graphQLInt.nonNull().list().list().nonNull())
                    .inputField('gen2')
              ]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final inputMSerializer = SerializerValue<InputM>(
  key: "InputM",
  fromJson: (ctx, json) => InputM.fromJson(json), // _$InputMFromJson,
  // toJson: (m) => _$InputMToJson(m as InputM),
);
final _inputMGraphQLType =
    HotReloadableDefinition<GraphQLInputObjectType<InputM>>((setValue) {
  final __name = 'InputM';

  final __inputMGraphQLType = inputObjectType<InputM>(__name);

  setValue(__inputMGraphQLType);
  __inputMGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().coerceToInputObject().inputField('name'),
      graphQLDate.coerceToInputObject().inputField('date'),
      graphQLInt
          .nonNull()
          .list()
          .nonNull()
          .coerceToInputObject()
          .inputField('ints'),
      graphQLFloat
          .nonNull()
          .list()
          .nonNull()
          .coerceToInputObject()
          .inputField('doubles'),
      inputMNGraphQLType
          .nonNull()
          .list()
          .nonNull()
          .coerceToInputObject()
          .inputField('nested'),
      inputMNGraphQLType
          .list()
          .nonNull()
          .coerceToInputObject()
          .inputField('nestedNullItem'),
      inputMNGraphQLType
          .list()
          .coerceToInputObject()
          .inputField('nestedNullItemNull'),
      inputMNGraphQLType
          .nonNull()
          .list()
          .coerceToInputObject()
          .inputField('nestedNull')
    ],
  );

  return __inputMGraphQLType;
});

/// Auto-generated from [InputM].
GraphQLInputObjectType<InputM> get inputMGraphQLType =>
    _inputMGraphQLType.value;

final inputMNSerializer = SerializerValue<InputMN>(
  key: "InputMN",
  fromJson: (ctx, json) => InputMN.fromJson(json), // _$InputMNFromJson,
  // toJson: (m) => _$InputMNToJson(m as InputMN),
);
final _inputMNGraphQLType =
    HotReloadableDefinition<GraphQLInputObjectType<InputMN>>((setValue) {
  final __name = 'InputMNRenamed';

  final __inputMNGraphQLType = inputObjectType<InputMN>(__name);

  setValue(__inputMNGraphQLType);
  __inputMNGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().coerceToInputObject().inputField('name'),
      inputMGraphQLType.coerceToInputObject().inputField('parent'),
      Json.graphQLType.nonNull().coerceToInputObject().inputField('json'),
      Json.graphQLType
          .nonNull()
          .list()
          .nonNull()
          .coerceToInputObject()
          .inputField('jsonListArgDef', defaultValue: const [JsonMap({})]),
      inputMGraphQLType
          .nonNull()
          .list()
          .list()
          .coerceToInputObject()
          .inputField('parentNullDef',
              defaultValue: InputMN.parentNullDefDefault())
    ],
  );

  return __inputMNGraphQLType;
});

/// Auto-generated from [InputMN].
GraphQLInputObjectType<InputMN> get inputMNGraphQLType =>
    _inputMNGraphQLType.value;

final inputJsonSerdeSerializer = SerializerValue<InputJsonSerde>(
  key: "InputJsonSerde",
  fromJson: (ctx, json) =>
      InputJsonSerde.fromJson(json), // _$InputJsonSerdeFromJson,
  // toJson: (m) => _$InputJsonSerdeToJson(m as InputJsonSerde),
);
final _inputJsonSerdeGraphQLType =
    HotReloadableDefinition<GraphQLInputObjectType<InputJsonSerde>>((setValue) {
  final __name = 'InputJsonSerde';

  final __inputJsonSerdeGraphQLType = inputObjectType<InputJsonSerde>(__name);

  setValue(__inputJsonSerdeGraphQLType);
  __inputJsonSerdeGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().coerceToInputObject().inputField('name'),
      inputMGraphQLType.coerceToInputObject().inputField('parent'),
      inputGenGraphQLType<InputM>(inputMGraphQLType.nonNull())
          .coerceToInputObject()
          .inputField('inputGenM'),
      inputGenGraphQLType<InputM?>(inputMGraphQLType)
          .coerceToInputObject()
          .inputField('inputGenMNull')
    ],
  );

  return __inputJsonSerdeGraphQLType;
});

/// Auto-generated from [InputJsonSerde].
GraphQLInputObjectType<InputJsonSerde> get inputJsonSerdeGraphQLType =>
    _inputJsonSerdeGraphQLType.value;

final inputGenSerdeCtx = SerdeCtx();
final _inputGenGraphQLType =
    HotReloadableDefinition<Map<String, GraphQLInputObjectType<InputGen>>>(
        (_) => {});

/// Auto-generated from [InputGen].
GraphQLInputObjectType<InputGen<T>> inputGenGraphQLType<T>(
  GraphQLType<T, Object> tGraphQLType, {
  String? name,
}) {
  final __name = name ?? 'InputGen${tGraphQLType.printableName}';
  if (_inputGenGraphQLType.value[__name] != null)
    return _inputGenGraphQLType.value[__name]!
        as GraphQLInputObjectType<InputGen<T>>;
  final __inputGenGraphQLType = inputObjectType<InputGen<T>>(__name);
  inputGenSerdeCtx.add(
    SerializerValue<InputGen<T>>(
      fromJson: (ctx, json) => InputGen.fromJson(json, ctx.fromJson),
    ),
  );
  _inputGenGraphQLType.value[__name] = __inputGenGraphQLType;
  __inputGenGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().coerceToInputObject().inputField('name'),
      tGraphQLType.coerceToInputObject().inputField('generic')
    ],
  );

  return __inputGenGraphQLType;
}

final inputGen2SerdeCtx = SerdeCtx();
final _inputGen2GraphQLType =
    HotReloadableDefinition<Map<String, GraphQLInputObjectType<InputGen2>>>(
        (_) => {});

/// Auto-generated from [InputGen2].
GraphQLInputObjectType<InputGen2<T, O>>
    inputGen2GraphQLType<T, O extends Object>(
  GraphQLType<T, Object> tGraphQLType,
  GraphQLType<O, Object> oGraphQLType, {
  String? name,
}) {
  final __name = name ??
      'InputGen2${tGraphQLType.printableName}${oGraphQLType.printableName}';
  if (_inputGen2GraphQLType.value[__name] != null)
    return _inputGen2GraphQLType.value[__name]!
        as GraphQLInputObjectType<InputGen2<T, O>>;
  final __inputGen2GraphQLType = inputObjectType<InputGen2<T, O>>(__name);
  inputGen2SerdeCtx.add(
    SerializerValue<InputGen2<T, O>>(
      fromJson: (ctx, json) =>
          InputGen2.fromJson(json, ctx.fromJson, ctx.fromJson),
    ),
  );
  _inputGen2GraphQLType.value[__name] = __inputGen2GraphQLType;
  __inputGen2GraphQLType.fields.addAll(
    [
      graphQLString.nonNull().coerceToInputObject().inputField('name'),
      tGraphQLType.coerceToInputObject().inputField('generic'),
      oGraphQLType.nullable().coerceToInputObject().inputField('valueNull'),
      oGraphQLType
          .nullable()
          .list()
          .nonNull()
          .coerceToInputObject()
          .inputField('listValueNull'),
      oGraphQLType.nonNull().coerceToInputObject().inputField('value'),
      oGraphQLType
          .nonNull()
          .list()
          .nonNull()
          .coerceToInputObject()
          .inputField('listValue')
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
      doubles: (json['doubles'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
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
      'doubles': instance.doubles,
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
      valueNull: _$nullableGenericFromJson(json['valueNull'], fromJsonO),
      value: fromJsonO(json['value']),
      listValue: (json['listValue'] as List<dynamic>).map(fromJsonO).toList(),
      listValueNull: (json['listValueNull'] as List<dynamic>)
          .map((e) => _$nullableGenericFromJson(e, fromJsonO))
          .toList(),
    );

Map<String, dynamic> _$InputGen2ToJson<T, O extends Object>(
  InputGen2<T, O> instance,
  Object? Function(T value) toJsonT,
  Object? Function(O value) toJsonO,
) =>
    <String, dynamic>{
      'name': instance.name,
      'generic': toJsonT(instance.generic),
      'valueNull': _$nullableGenericToJson(instance.valueNull, toJsonO),
      'listValueNull': instance.listValueNull
          .map((e) => _$nullableGenericToJson(e, toJsonO))
          .toList(),
      'value': toJsonO(instance.value),
      'listValue': instance.listValue.map(toJsonO).toList(),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
