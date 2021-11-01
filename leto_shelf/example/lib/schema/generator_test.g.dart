// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_test.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<TestModel, Object, Object> addTestModelGraphQLField =
    field(
  'addTestModel',
  testModelGraphQLType,
  description: r"the function uses [value] to do stuff",
  resolve: (obj, ctx) {
    final args = ctx.args;
    if ((args["previous"] as TestModel?) != null) {
      final previousValidationResult =
          validateTestModel((args["previous"] as TestModel?) as TestModel);
      if (previousValidationResult.hasErrors) {
        throw previousValidationResult;
      }
    }

    return addTestModel(ctx, (args["realName"] as String),
        previous: (args["previous"] as TestModel?),
        name: (args["name"] as String),
        value: (args["value"] as List<int>));
  },
  inputs: [
    GraphQLFieldInput(
      "realName",
      graphQLString.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "previous",
      testModelGraphQLType.coerceToInputObject(),
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
);

final GraphQLObjectField<List<TestModel?>, Object, Object>
    testModelsGraphQLField = field(
  'testModels',
  listOf(testModelGraphQLType.nonNull()).nonNull(),
  description: r"Automatic documentation generated\n[position] is the pad",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return testModels(ctx, (args["lessThan"] as DateTime),
        position: (args["position"] as int));
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
);

final GraphQLObjectField<List<EventUnion?>, Object, Object>
    testUnionModelsGraphQLField = field(
  'testUnionModels',
  listOf(eventUnionGraphQLType).nonNull(),
  description:
      r"testUnionModels documentation generated\n[position] is the pad",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return testUnionModels(ctx, positions: (args["positions"] as List<int?>));
  },
  inputs: [
    GraphQLFieldInput(
      "positions",
      listOf(graphQLInt).nonNull().coerceToInputObject(),
      defaultValue: const [],
      description: r"pagination",
    )
  ],
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final testModelSerializer = SerializerValue<TestModel>(
  fromJson: (ctx, json) => TestModel.fromJson(json), // _$TestModelFromJson,
  // toJson: (m) => _$TestModelToJson(m as TestModel),
);

GraphQLObjectType<TestModel>? _testModelGraphQLType;

/// Auto-generated from [TestModel].
GraphQLObjectType<TestModel> get testModelGraphQLType {
  final __name = 'TestModel';
  if (_testModelGraphQLType != null)
    return _testModelGraphQLType! as GraphQLObjectType<TestModel>;

  final __testModelGraphQLType = objectType<TestModel>('TestModel',
      isInterface: false, interfaces: [], description: 'Custom doc');

  _testModelGraphQLType = __testModelGraphQLType;
  __testModelGraphQLType.fields.addAll(
    [
      field('name', graphQLString.nonNull(), resolve: (obj, ctx) => obj.name),
      field('description', graphQLString,
          resolve: (obj, ctx) => obj.description, description: 'Custom doc d'),
      field('dates', listOf(graphQLDate.nonNull()),
          resolve: (obj, ctx) => obj.dates),
      field('hasDates', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasDates)
    ],
  );

  return __testModelGraphQLType;
}

GraphQLObjectType<TestModelFreezed>? _testModelFreezedGraphQLType;

/// Auto-generated from [TestModelFreezed].
GraphQLObjectType<TestModelFreezed> get testModelFreezedGraphQLType {
  final __name = 'TestModelFreezed';
  if (_testModelFreezedGraphQLType != null)
    return _testModelFreezedGraphQLType! as GraphQLObjectType<TestModelFreezed>;

  final __testModelFreezedGraphQLType = objectType<TestModelFreezed>(
      'TestModelFreezed',
      isInterface: false,
      interfaces: []);

  _testModelFreezedGraphQLType = __testModelFreezedGraphQLType;
  __testModelFreezedGraphQLType.fields.addAll(
    [
      field('name', graphQLString.nonNull(), resolve: (obj, ctx) => obj.name),
      field('description', graphQLString,
          resolve: (obj, ctx) => obj.description, description: 'Custom doc d'),
      field('dates', listOf(graphQLDate.nonNull()),
          resolve: (obj, ctx) => obj.dates),
      field('hasDates', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasDates)
    ],
  );

  return __testModelFreezedGraphQLType;
}

final eventUnionAddSerializer = SerializerValue<_EventUnionAdd>(
  fromJson: (ctx, json) =>
      _EventUnionAdd.fromJson(json), // _$$_EventUnionAddFromJson,
  // toJson: (m) => _$$_EventUnionAddToJson(m as _$_EventUnionAdd),
);

GraphQLObjectType<_EventUnionAdd>? _eventUnionAddGraphQLType;

/// Auto-generated from [_EventUnionAdd].
GraphQLObjectType<_EventUnionAdd> get eventUnionAddGraphQLType {
  final __name = 'EventUnionAdd';
  if (_eventUnionAddGraphQLType != null)
    return _eventUnionAddGraphQLType! as GraphQLObjectType<_EventUnionAdd>;

  final __eventUnionAddGraphQLType = objectType<_EventUnionAdd>('EventUnionAdd',
      isInterface: false, interfaces: []);

  _eventUnionAddGraphQLType = __eventUnionAddGraphQLType;
  __eventUnionAddGraphQLType.fields.addAll(
    [
      field('name', graphQLString.nonNull(), resolve: (obj, ctx) => obj.name),
      field('description', graphQLString,
          resolve: (obj, ctx) => obj.description, description: 'Custom doc d'),
      field('dates', listOf(graphQLDate.nonNull()),
          resolve: (obj, ctx) => obj.dates),
      field('models', listOf(testModelGraphQLType).nonNull(),
          resolve: (obj, ctx) => obj.models),
      field('hasDates', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasDates)
    ],
  );

  return __eventUnionAddGraphQLType;
}

final eventUnionDeleteSerializer = SerializerValue<EventUnionDelete>(
  fromJson: (ctx, json) =>
      EventUnionDelete.fromJson(json), // _$$EventUnionDeleteFromJson,
  // toJson: (m) => _$$EventUnionDeleteToJson(m as _$EventUnionDelete),
);

GraphQLObjectType<EventUnionDelete>? _eventUnionDeleteGraphQLType;

/// Auto-generated from [EventUnionDelete].
GraphQLObjectType<EventUnionDelete> get eventUnionDeleteGraphQLType {
  final __name = 'EventUnionDelete';
  if (_eventUnionDeleteGraphQLType != null)
    return _eventUnionDeleteGraphQLType! as GraphQLObjectType<EventUnionDelete>;

  final __eventUnionDeleteGraphQLType = objectType<EventUnionDelete>(
      'EventUnionDelete',
      isInterface: false,
      interfaces: []);

  _eventUnionDeleteGraphQLType = __eventUnionDeleteGraphQLType;
  __eventUnionDeleteGraphQLType.fields.addAll(
    [
      field('name', graphQLString, resolve: (obj, ctx) => obj.name),
      field('cost', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.cost),
      field('dates', listOf(graphQLDate.nonNull()),
          resolve: (obj, ctx) => obj.dates),
      field('hasDates', graphQLBoolean.nonNull(),
          resolve: (obj, ctx) => obj.hasDates)
    ],
  );

  return __eventUnionDeleteGraphQLType;
}

final eventUnionSerializer = SerializerValue<EventUnion>(
  fromJson: (ctx, json) => EventUnion.fromJson(json), // _$EventUnionFromJson,
  // toJson: (m) => _$EventUnionToJson(m as EventUnion),
);

GraphQLUnionType<EventUnion>? _eventUnionGraphQLType;
GraphQLUnionType<EventUnion> get eventUnionGraphQLType {
  return _eventUnionGraphQLType ??= GraphQLUnionType(
    'EventUnion',
    [eventUnionAddGraphQLType, eventUnionDeleteGraphQLType],
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
  final Map<TestModelField, List<ValidaError>> errorsMap;

  List<ValidaError> get name => errorsMap[TestModelField.name]!;
}

class TestModelValidation extends Validation<TestModel, TestModelField> {
  TestModelValidation(this.errorsMap, this.value, this.fields)
      : super(errorsMap);

  final Map<TestModelField, List<ValidaError>> errorsMap;

  final TestModel value;

  final TestModelValidationFields fields;
}

TestModelValidation validateTestModel(TestModel value) {
  final errors = <TestModelField, List<ValidaError>>{};

  errors[TestModelField.name] = [
    if (value.name.length < 1)
      ValidaError(
        message: r'Should be at a minimum 1 in length',
        errorCode: 'ValidaString.minLength',
        property: 'name',
        validationParam: 1,
        value: value.name,
      ),
    if (value.name.length > 64)
      ValidaError(
        message: r'Should be at a maximum 64 in length',
        errorCode: 'ValidaString.maxLength',
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
