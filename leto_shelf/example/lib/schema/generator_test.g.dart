// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_test.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<TestModel, Object, Object> addTestModelGraphQLField =
    field(
  'addTestModel',
  testModelGraphQlType,
  description: r"the function uses [value] to do stuff",
  resolve: (obj, ctx) {
    final args = ctx.args;
    if (args["previous"] != null) {
      final previousValidationResult =
          validateTestModel(args["previous"] as TestModel);
      if (previousValidationResult.hasErrors) {
        throw previousValidationResult;
      }
    }

    return addTestModel(ctx, args["realName"] as String,
        previous: args["previous"] as TestModel?,
        name: args["name"] as String,
        value: args["value"] as List<int>);
  },
  inputs: [
    GraphQLFieldInput(
      "realName",
      graphQLString.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "previous",
      testModelGraphQlType.coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "name",
      graphQLString.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "value",
      listOf(graphQLInt.nonNull()).nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<TestModel?>, Object, Object>
    testModelsGraphQLField = field(
  'testModels',
  listOf(testModelGraphQlType.nonNull()).nonNull(),
  description: r"Automatic documentation generated\n[position] is the pad",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return testModels(ctx, args["lessThan"] as DateTime,
        position: args["position"] as int);
  },
  inputs: [
    GraphQLFieldInput(
      "lessThan",
      graphQLDate.nonNull().coerceToInputObject(),
      description: r"pagination less than",
    ),
    GraphQLFieldInput(
      "position",
      graphQLInt.nonNull().coerceToInputObject(),
      defaultValue: 0,
      description: r"pagination",
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<EventUnion?>, Object, Object>
    testUnionModelsGraphQLField = field(
  'testUnionModels',
  listOf(eventUnionGraphQlType).nonNull(),
  description:
      r"testUnionModels documentation generated\n[position] is the pad",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return testUnionModels(ctx, positions: args["positions"] as List<int?>);
  },
  inputs: [
    GraphQLFieldInput(
      "positions",
      listOf(graphQLInt).nonNull().coerceToInputObject(),
      defaultValue: const [],
      description: r"pagination",
    )
  ],
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final testModelSerializer = SerializerValue<TestModel>(
  fromJson: _$TestModelFromJson,
  toJson: (m) => _$TestModelToJson(m as TestModel),
);
GraphQLObjectType<TestModel>? _testModelGraphQlType;

/// Auto-generated from [TestModel].
GraphQLObjectType<TestModel> get testModelGraphQlType {
  if (_testModelGraphQlType != null) return _testModelGraphQlType!;

  _testModelGraphQlType = objectType('TestModel',
      isInterface: false, interfaces: [], description: 'Custom doc');
  _testModelGraphQlType!.fields.addAll(
    [
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('description', graphQLString,
          resolve: (obj, ctx) => obj.description,
          inputs: [],
          description: 'Custom doc d',
          deprecationReason: null),
      field('dates', listOf(graphQLDate.nonNull()),
          resolve: (obj, ctx) => obj.dates,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('hasDates', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasDates,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return _testModelGraphQlType!;
}

final testModelFreezedSerializer = SerializerValue<TestModelFreezed>(
  fromJson: _$$_TestModelFreezedFromJson,
  toJson: (m) => _$$_TestModelFreezedToJson(m as _$_TestModelFreezed),
);
GraphQLObjectType<TestModelFreezed>? _testModelFreezedGraphQlType;

/// Auto-generated from [TestModelFreezed].
GraphQLObjectType<TestModelFreezed> get testModelFreezedGraphQlType {
  if (_testModelFreezedGraphQlType != null)
    return _testModelFreezedGraphQlType!;

  _testModelFreezedGraphQlType = objectType('TestModelFreezed',
      isInterface: false, interfaces: [], description: null);
  _testModelFreezedGraphQlType!.fields.addAll(
    [
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('description', graphQLString,
          resolve: (obj, ctx) => obj.description,
          inputs: [],
          description: 'Custom doc d',
          deprecationReason: null),
      field('dates', listOf(graphQLDate.nonNull()),
          resolve: (obj, ctx) => obj.dates,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('hasDates', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasDates,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return _testModelFreezedGraphQlType!;
}

final eventUnionAddSerializer = SerializerValue<_EventUnionAdd>(
  fromJson: _$$_EventUnionAddFromJson,
  toJson: (m) => _$$_EventUnionAddToJson(m as _$_EventUnionAdd),
);
GraphQLObjectType<_EventUnionAdd>? _eventUnionAddGraphQlType;

/// Auto-generated from [_EventUnionAdd].
GraphQLObjectType<_EventUnionAdd> get eventUnionAddGraphQlType {
  if (_eventUnionAddGraphQlType != null) return _eventUnionAddGraphQlType!;

  _eventUnionAddGraphQlType = objectType('_EventUnionAdd',
      isInterface: false, interfaces: [], description: null);
  _eventUnionAddGraphQlType!.fields.addAll(
    [
      field('name', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.name,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('description', graphQLString,
          resolve: (obj, ctx) => obj.description,
          inputs: [],
          description: 'Custom doc d',
          deprecationReason: null),
      field('dates', listOf(graphQLDate.nonNull()),
          resolve: (obj, ctx) => obj.dates,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('models', listOf(testModelGraphQlType).nonNull(),
          resolve: (obj, ctx) => obj.models,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('hasDates', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasDates,
          inputs: [],
          description: null,
          deprecationReason: null),
      eventUnionGraphQlTypeDiscriminant()
    ],
  );

  return _eventUnionAddGraphQlType!;
}

final eventUnionDeleteSerializer = SerializerValue<EventUnionDelete>(
  fromJson: _$$EventUnionDeleteFromJson,
  toJson: (m) => _$$EventUnionDeleteToJson(m as _$EventUnionDelete),
);
GraphQLObjectType<EventUnionDelete>? _eventUnionDeleteGraphQlType;

/// Auto-generated from [EventUnionDelete].
GraphQLObjectType<EventUnionDelete> get eventUnionDeleteGraphQlType {
  if (_eventUnionDeleteGraphQlType != null)
    return _eventUnionDeleteGraphQlType!;

  _eventUnionDeleteGraphQlType = objectType('EventUnionDelete',
      isInterface: false, interfaces: [], description: null);
  _eventUnionDeleteGraphQlType!.fields.addAll(
    [
      field('name', graphQLString,
          resolve: (obj, ctx) => obj.name,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('cost', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.cost,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('dates', listOf(graphQLDate.nonNull()),
          resolve: (obj, ctx) => obj.dates,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('hasDates', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasDates,
          inputs: [],
          description: null,
          deprecationReason: null),
      eventUnionGraphQlTypeDiscriminant()
    ],
  );

  return _eventUnionDeleteGraphQlType!;
}

final eventUnionSerializer = SerializerValue<EventUnion>(
  fromJson: _$EventUnionFromJson,
  toJson: (m) => _$EventUnionToJson(m as EventUnion),
);

Map<String, Object?> _$EventUnionToJson(EventUnion instance) =>
    instance.toJson();

GraphQLObjectField<String, String, P>
    eventUnionGraphQlTypeDiscriminant<P extends EventUnion>() => field(
          'runtimeType',
          enumTypeFromStrings('EventUnionType', ["add", "delete"]),
        );

GraphQLUnionType<EventUnion>? _eventUnionGraphQlType;
GraphQLUnionType<EventUnion> get eventUnionGraphQlType {
  return _eventUnionGraphQlType ??= GraphQLUnionType(
    'EventUnion',
    [eventUnionAddGraphQlType, eventUnionDeleteGraphQlType],
  );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestModel _$TestModelFromJson(Map<String, dynamic> json) => TestModel(
      name: json['name'] as String,
      description: json['description'] as String?,
      dates: (json['dates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$TestModelToJson(TestModel instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'dates': instance.dates?.map((e) => e.toIso8601String()).toList(),
    };

_$_TestModelFreezed _$$_TestModelFreezedFromJson(Map<String, dynamic> json) =>
    _$_TestModelFreezed(
      name: json['name'] as String,
      description: json['description'] as String?,
      dates: (json['dates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$$_TestModelFreezedToJson(_$_TestModelFreezed instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'dates': instance.dates?.map((e) => e.toIso8601String()).toList(),
    };

_$_EventUnionAdd _$$_EventUnionAddFromJson(Map<String, dynamic> json) =>
    _$_EventUnionAdd(
      name: json['name'] as String,
      description: json['description'] as String?,
      dates: (json['dates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      models: (json['models'] as List<dynamic>)
          .map((e) => TestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_EventUnionAddToJson(_$_EventUnionAdd instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'dates': instance.dates?.map((e) => e.toIso8601String()).toList(),
      'models': instance.models,
    };

_$EventUnionDelete _$$EventUnionDeleteFromJson(Map<String, dynamic> json) =>
    _$EventUnionDelete(
      name: json['name'] as String?,
      cost: json['cost'] as int,
      dates: (json['dates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$$EventUnionDeleteToJson(_$EventUnionDelete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cost': instance.cost,
      'dates': instance.dates?.map((e) => e.toIso8601String()).toList(),
    };

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

enum TestModelField {
  name,
}

class TestModelValidationFields {
  const TestModelValidationFields(this.errorsMap);
  final Map<TestModelField, List<ValidationError>> errorsMap;

  List<ValidationError> get name => errorsMap[TestModelField.name]!;
}

class TestModelValidation extends Validation<TestModel, TestModelField> {
  TestModelValidation(this.errorsMap, this.value, this.fields)
      : super(errorsMap);

  final Map<TestModelField, List<ValidationError>> errorsMap;

  final TestModel value;

  final TestModelValidationFields fields;
}

TestModelValidation validateTestModel(TestModel value) {
  final errors = <TestModelField, List<ValidationError>>{};

  errors[TestModelField.name] = [
    if (value.name.length < 1)
      ValidationError(
        message: r'Should be at a minimum 1 in length',
        errorCode: 'ValidateString.minLength',
        property: 'name',
        validationParam: 1,
        value: value.name,
      ),
    if (value.name.length > 64)
      ValidationError(
        message: r'Should be at a maximum 64 in length',
        errorCode: 'ValidateString.maxLength',
        property: 'name',
        validationParam: 64,
        value: value.name,
      )
  ];

  return TestModelValidation(
    errors,
    value,
    TestModelValidationFields(errors),
  );
}
