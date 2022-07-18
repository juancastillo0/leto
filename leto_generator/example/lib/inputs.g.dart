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
                inputGenGraphQLTypeInput<int>(graphQLInt.nonNull())
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
                final validationErrorMap = <String, List<ValidaError>>{};

                if ((args["mInput"] as InputM?) != null) {
                  final mInputValidationResult =
                      validateInputM((args["mInput"] as InputM?) as InputM);
                  if (mInputValidationResult.hasErrors) {
                    validationErrorMap['mInput'] = [
                      mInputValidationResult.toError(property: 'mInput')!
                    ];
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

                return queryMultipleParams((args["serde"] as InputJsonSerde?),
                    serdeReq: (args["serdeReq"] as InputJsonSerde),
                    defTwo: (args["defTwo"] as int),
                    mInput: (args["mInput"] as InputM?),
                    gen: (args["gen"] as InputGen<InputJsonSerde?>));
              },
            ))
              ..inputs.addAll([
                inputJsonSerdeGraphQLTypeInput.inputField('serde'),
                inputJsonSerdeGraphQLTypeInput.nonNull().inputField('serdeReq'),
                graphQLInt.nonNull().inputField('defTwo', defaultValue: 2),
                inputMGraphQLTypeInput.inputField('mInput'),
                inputGenGraphQLTypeInput<InputJsonSerde?>(
                        inputJsonSerdeGraphQLTypeInput)
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
                inputJsonSerdeGraphQLTypeInput.inputField('serde'),
                graphQLInt.nonNull().inputField('defTwo', defaultValue: 2),
                inputGenGraphQLTypeInput<List<InputJsonSerde>?>(
                        inputJsonSerdeGraphQLTypeInput.nonNull().list())
                    .inputField('gen'),
                inputGen2GraphQLTypeInput<String, List<List<int>?>>(
                        graphQLString.nonNull(),
                        graphQLInt.nonNull().list().list().nonNull())
                    .inputField('gen2')
              ]));

GraphQLObjectField<CombinedObject, Object?, Object?>
    get combinedFromInputGraphQLField => _combinedFromInputGraphQLField.value;
final _combinedFromInputGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<CombinedObject, Object?, Object?>>(
    (setValue) => setValue(combinedObjectGraphQLType.nonNull().field<Object?>(
          'combinedFromInput',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return combinedFromInput((args["inputCombined"] as CombinedObject));
          },
        ))
          ..inputs.addAll([
            combinedObjectGraphQLTypeInput.nonNull().inputField('inputCombined')
          ]));

GraphQLObjectField<CombinedObject?, Object?, Object?>
    get combinedFromOneOfGraphQLField => _combinedFromOneOfGraphQLField.value;
final _combinedFromOneOfGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<CombinedObject?, Object?, Object?>>(
    (setValue) => setValue(combinedObjectGraphQLType.field<Object?>(
          'combinedFromOneOf',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return combinedFromOneOf((args["input"] as OneOfInput));
          },
        ))
          ..inputs.addAll(
              [oneOfInputGraphQLTypeInput.nonNull().inputField('input')]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final inputMSerializer = SerializerValue<InputM>(
  key: "InputM",
  fromJson: (ctx, json) => InputM.fromJson(json), // _$$FromJson,
  // toJson: (m) => _$$ToJson(m as _$),
);
final _inputMGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<InputM>>((setValue) {
  final __name = 'InputM';

  final __inputMGraphQLTypeInput = inputObjectType<InputM>(__name);

  setValue(__inputMGraphQLTypeInput);
  __inputMGraphQLTypeInput.fields.addAll(
    [
      graphQLString.nonNull().inputField('name', attachments: [
        ValidaAttachment(ValidaString(minLength: 1, isAlpha: true)),
      ]),
      graphQLDate.inputField('date', attachments: [
        ValidaAttachment(ValidaDate(min: 'now', max: '2023-01-01')),
      ]),
      graphQLInt.nonNull().list().nonNull().inputField('ints'),
      graphQLFloat
          .nonNull()
          .list()
          .nonNull()
          .inputField('doubles', attachments: [
        ValidaAttachment(ValidaList(each: ValidaNum(min: -2))),
      ]),
      inputMNGraphQLTypeInput
          .nonNull()
          .list()
          .nonNull()
          .inputField('nested', attachments: [
        ValidaAttachment(ValidaList(minLength: 1)),
      ]),
      inputMNGraphQLTypeInput.list().nonNull().inputField('nestedNullItem'),
      inputMNGraphQLTypeInput.list().inputField('nestedNullItemNull'),
      inputMNGraphQLTypeInput.nonNull().list().inputField('nestedNull')
    ],
  );

  return __inputMGraphQLTypeInput;
});

/// Auto-generated from [InputM].
GraphQLInputObjectType<InputM> get inputMGraphQLTypeInput =>
    _inputMGraphQLTypeInput.value;

final inputMNSerializer = SerializerValue<InputMN>(
  key: "InputMN",
  fromJson: (ctx, json) => InputMN.fromJson(json), // _$$FromJson,
  // toJson: (m) => _$$ToJson(m as _$),
);
final _inputMNGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<InputMN>>((setValue) {
  final __name = 'InputMNRenamed';

  final __inputMNGraphQLTypeInput = inputObjectType<InputMN>(__name);

  setValue(__inputMNGraphQLTypeInput);
  __inputMNGraphQLTypeInput.fields.addAll(
    [
      graphQLString.nonNull().inputField('name'),
      inputMGraphQLTypeInput.inputField('parent'),
      Json.graphQLType
          .nonNull()
          .inputField('json', defaultValue: const JsonList([JsonNumber(1)])),
      Json.graphQLType
          .nonNull()
          .list()
          .nonNull()
          .inputField('jsonListArgDef', defaultValue: const [JsonMap({})]),
      inputMGraphQLTypeInput.nonNull().list().list().inputField('parentNullDef',
          defaultValue: InputMN.parentNullDefDefault())
    ],
  );

  return __inputMNGraphQLTypeInput;
});

/// Auto-generated from [InputMN].
GraphQLInputObjectType<InputMN> get inputMNGraphQLTypeInput =>
    _inputMNGraphQLTypeInput.value;

final inputJsonSerdeSerializer = SerializerValue<InputJsonSerde>(
  key: "InputJsonSerde",
  fromJson: (ctx, json) => InputJsonSerde.fromJson(json), // _$$FromJson,
  // toJson: (m) => _$$ToJson(m as _$),
);
final _inputJsonSerdeGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<InputJsonSerde>>((setValue) {
  final __name = 'InputJsonSerde';

  final __inputJsonSerdeGraphQLTypeInput =
      inputObjectType<InputJsonSerde>(__name);

  setValue(__inputJsonSerdeGraphQLTypeInput);
  __inputJsonSerdeGraphQLTypeInput.fields.addAll(
    [
      graphQLString.nonNull().inputField('name'),
      inputMGraphQLTypeInput.inputField('parent'),
      inputGenGraphQLTypeInput<InputM>(inputMGraphQLTypeInput.nonNull())
          .inputField('inputGenM'),
      inputGenGraphQLTypeInput<InputM?>(inputMGraphQLTypeInput)
          .inputField('inputGenMNull')
    ],
  );

  return __inputJsonSerdeGraphQLTypeInput;
});

/// Auto-generated from [InputJsonSerde].
GraphQLInputObjectType<InputJsonSerde> get inputJsonSerdeGraphQLTypeInput =>
    _inputJsonSerdeGraphQLTypeInput.value;

final inputGenSerdeCtx = SerdeCtx();
final _inputGenGraphQLTypeInput =
    HotReloadableDefinition<Map<String, GraphQLInputObjectType<InputGen>>>(
        (_) => {});

/// Auto-generated from [InputGen].
GraphQLInputObjectType<InputGen<T>> inputGenGraphQLTypeInput<T>(
  GraphQLType<T, Object> tGraphQLType, {
  String? name,
}) {
  final __name = name ?? 'InputGen${tGraphQLType.printableName}';
  if (_inputGenGraphQLTypeInput.value[__name] != null)
    return _inputGenGraphQLTypeInput.value[__name]!
        as GraphQLInputObjectType<InputGen<T>>;
  final __inputGenGraphQLTypeInput = inputObjectType<InputGen<T>>(__name);
  inputGenSerdeCtx.add(
    SerializerValue<InputGen<T>>(
      fromJson: (ctx, json) => InputGen.fromJson(json, ctx.fromJson),
    ),
  );
  _inputGenGraphQLTypeInput.value[__name] = __inputGenGraphQLTypeInput;
  __inputGenGraphQLTypeInput.fields.addAll(
    [
      graphQLString.nonNull().inputField('name'),
      tGraphQLType.inputField('generic')
    ],
  );

  return __inputGenGraphQLTypeInput;
}

final inputGen2SerdeCtx = SerdeCtx();
final _inputGen2GraphQLTypeInput =
    HotReloadableDefinition<Map<String, GraphQLInputObjectType<InputGen2>>>(
        (_) => {});

/// Auto-generated from [InputGen2].
GraphQLInputObjectType<InputGen2<T, O>>
    inputGen2GraphQLTypeInput<T, O extends Object>(
  GraphQLType<T, Object> tGraphQLType,
  GraphQLType<O, Object> oGraphQLType, {
  String? name,
}) {
  final __name = name ??
      'InputGen2${tGraphQLType.printableName}${oGraphQLType.printableName}';
  if (_inputGen2GraphQLTypeInput.value[__name] != null)
    return _inputGen2GraphQLTypeInput.value[__name]!
        as GraphQLInputObjectType<InputGen2<T, O>>;
  final __inputGen2GraphQLTypeInput = inputObjectType<InputGen2<T, O>>(__name);
  inputGen2SerdeCtx.add(
    SerializerValue<InputGen2<T, O>>(
      fromJson: (ctx, json) =>
          InputGen2.fromJson(json, ctx.fromJson, ctx.fromJson),
    ),
  );
  _inputGen2GraphQLTypeInput.value[__name] = __inputGen2GraphQLTypeInput;
  __inputGen2GraphQLTypeInput.fields.addAll(
    [
      graphQLString.nonNull().inputField('name'),
      tGraphQLType.inputField('generic'),
      oGraphQLType.nullable().inputField('valueNull'),
      oGraphQLType.nonNull().inputField('value'),
      oGraphQLType.nonNull().list().nonNull().inputField('listValue'),
      oGraphQLType.nullable().list().nonNull().inputField('listValueNull')
    ],
  );

  return __inputGen2GraphQLTypeInput;
}

final combinedObjectSerializer = SerializerValue<CombinedObject>(
  key: "CombinedObject",
  fromJson: (ctx, json) =>
      CombinedObject.fromJson(json), // _$CombinedObjectFromJson,
  // toJson: (m) => _$CombinedObjectToJson(m as CombinedObject),
);
final _combinedObjectGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<CombinedObject>>((setValue) {
  final __name = 'CombinedObject';

  final __combinedObjectGraphQLType =
      objectType<CombinedObject>(__name, isInterface: false, interfaces: []);

  setValue(__combinedObjectGraphQLType);
  __combinedObjectGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('onlyInOutputMethod', resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.onlyInOutputMethod();
      }),
      graphQLInt
          .nonNull()
          .field('otherVal', resolve: (obj, ctx) => obj.otherVal),
      graphQLString.nonNull().field('val', resolve: (obj, ctx) => obj.val),
      graphQLInt.field('onlyInOutput', resolve: (obj, ctx) => obj.onlyInOutput)
    ],
  );

  return __combinedObjectGraphQLType;
});

/// Auto-generated from [CombinedObject].
GraphQLObjectType<CombinedObject> get combinedObjectGraphQLType =>
    _combinedObjectGraphQLType.value;
final _combinedObjectGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<CombinedObject>>((setValue) {
  final __name = 'CombinedObjectInput';

  final __combinedObjectGraphQLTypeInput =
      inputObjectType<CombinedObject>(__name);

  setValue(__combinedObjectGraphQLTypeInput);
  __combinedObjectGraphQLTypeInput.fields.addAll(
    [graphQLString.nonNull().inputField('val')],
  );

  return __combinedObjectGraphQLTypeInput;
});

/// Auto-generated from [CombinedObject].
GraphQLInputObjectType<CombinedObject> get combinedObjectGraphQLTypeInput =>
    _combinedObjectGraphQLTypeInput.value;

final oneOfInputSerializer = SerializerValue<OneOfInput>(
  key: "OneOfInput",
  fromJson: (ctx, json) => OneOfInput.fromJson(json), // _$$allFromJson,
  // toJson: (m) => _$$allToJson(m as _$all),
);
final _oneOfInputGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<OneOfInput>>((setValue) {
  final __name = 'OneOfInput';

  final __oneOfInputGraphQLTypeInput =
      inputObjectType<OneOfInput>(__name, isOneOf: true);

  setValue(__oneOfInputGraphQLTypeInput);
  __oneOfInputGraphQLTypeInput.fields.addAll(
    [
      combinedObjectGraphQLTypeInput.inputField('combined'),
      oneOfFreezedInputGraphQLTypeInput.inputField('oneOfFreezed'),
      graphQLString.inputField('str')
    ],
  );

  return __oneOfInputGraphQLTypeInput;
});

/// Auto-generated from [OneOfInput].
GraphQLInputObjectType<OneOfInput> get oneOfInputGraphQLTypeInput =>
    _oneOfInputGraphQLTypeInput.value;

final oneOfFreezedInputSerializer = SerializerValue<OneOfFreezedInput>(
  key: "OneOfFreezedInput",
  fromJson: (ctx, json) =>
      OneOfFreezedInput.fromJson(json), // _$$_OneOfFreezedInputFromJson,
  // toJson: (m) => _$$_OneOfFreezedInputToJson(m as _$_OneOfFreezedInput),
);
final _oneOfFreezedInputGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<OneOfFreezedInput>>(
        (setValue) {
  final __name = 'OneOfFreezedInput';

  final __oneOfFreezedInputGraphQLTypeInput =
      inputObjectType<OneOfFreezedInput>(__name);

  setValue(__oneOfFreezedInputGraphQLTypeInput);
  __oneOfFreezedInputGraphQLTypeInput.fields.addAll(
    [graphQLString.nonNull().inputField('str')],
  );

  return __oneOfFreezedInputGraphQLTypeInput;
});

/// Auto-generated from [OneOfFreezedInput].
GraphQLInputObjectType<OneOfFreezedInput>
    get oneOfFreezedInputGraphQLTypeInput =>
        _oneOfFreezedInputGraphQLTypeInput.value;

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

CombinedObject _$CombinedObjectFromJson(Map<String, dynamic> json) =>
    CombinedObject(
      json['val'] as String,
    );

Map<String, dynamic> _$CombinedObjectToJson(CombinedObject instance) =>
    <String, dynamic>{
      'val': instance.val,
    };

_$_OneOfFreezedInput _$$_OneOfFreezedInputFromJson(Map<String, dynamic> json) =>
    _$_OneOfFreezedInput(
      json['str'] as String,
    );

Map<String, dynamic> _$$_OneOfFreezedInputToJson(
        _$_OneOfFreezedInput instance) =>
    <String, dynamic>{
      'str': instance.str,
    };

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

enum InputMField {
  name,
  date,
  doubles,
  nested,

  $global
}

class InputMValidationFields {
  const InputMValidationFields(this.errorsMap);
  final Map<InputMField, List<ValidaError>> errorsMap;

  List<ValidaError> get name => errorsMap[InputMField.name]!;
  List<ValidaError> get date => errorsMap[InputMField.date]!;
  List<ValidaError> get doubles => errorsMap[InputMField.doubles]!;
  List<ValidaError> get nested => errorsMap[InputMField.nested]!;
}

class InputMValidation extends Validation<InputM, InputMField> {
  InputMValidation(this.errorsMap, this.value, this.fields) : super(errorsMap);
  @override
  final Map<InputMField, List<ValidaError>> errorsMap;
  @override
  final InputM value;
  @override
  final InputMValidationFields fields;

  /// Validates [value] and returns a [InputMValidation] with the errors found as a result
  static InputMValidation fromValue(InputM value) {
    Object? _getProperty(String property) => spec.getField(value, property);

    final errors = <InputMField, List<ValidaError>>{
      if (spec.globalValidate != null)
        InputMField.$global: spec.globalValidate!(value),
      ...spec.fieldsMap.map(
        (key, field) => MapEntry(
          key,
          field.validate(key.name, _getProperty),
        ),
      )
    };
    errors.removeWhere((key, value) => value.isEmpty);
    return InputMValidation(errors, value, InputMValidationFields(errors));
  }

  static const spec = ValidaSpec(
    fieldsMap: {
      InputMField.name: ValidaString(minLength: 1, isAlpha: true),
      InputMField.date: ValidaDate(min: 'now', max: '2023-01-01'),
      InputMField.doubles: ValidaList(each: ValidaNum(min: -2)),
      InputMField.nested: ValidaList(minLength: 1),
    },
    getField: _getField,
    globalValidate: _globalValidate,
  );

  static List<ValidaError> _globalValidate(InputM value) => [
        ...InputM._hasIntsOrDoubles(value),
      ];

  static Object? _getField(InputM value, String field) {
    switch (field) {
      case 'name':
        return value.name;
      case 'date':
        return value.date;
      case 'doubles':
        return value.doubles;
      case 'nested':
        return value.nested;
      default:
        throw Exception();
    }
  }
}

@Deprecated('Use InputMValidation.fromValue')
InputMValidation validateInputM(InputM value) {
  return InputMValidation.fromValue(value);
}
