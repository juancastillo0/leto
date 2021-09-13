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
      graphQLString.nonNullable().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "previous",
      testModelGraphQlType.coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "name",
      graphQLString.nonNullable().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "value",
      listOf(graphQLInt.nonNullable()).nonNullable().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<TestModel?>, Object, Object>
    testModelsGraphQLField = field(
  'testModels',
  listOf(testModelGraphQlType.nonNullable()).nonNullable(),
  description: r"Automatic documentation generated\n[position] is the pad",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return testModels(ctx, args["lessThan"] as DateTime,
        position: args["position"] as int);
  },
  inputs: [
    GraphQLFieldInput(
      "lessThan",
      graphQLDate.nonNullable().coerceToInputObject(),
      description: r"pagination less than",
    ),
    GraphQLFieldInput(
      "position",
      graphQLInt.nonNullable().coerceToInputObject(),
      defaultValue: 0,
      description: r"pagination",
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<EventUnion?>, Object, Object>
    testUnionModelsGraphQLField = field(
  'testUnionModels',
  listOf(eventUnionGraphQlType).nonNullable(),
  description:
      r"testUnionModels documentation generated\n[position] is the pad",
  resolve: (obj, ctx) {
    final args = ctx.args;

    return testUnionModels(ctx, positions: args["positions"] as List<int?>);
  },
  inputs: [
    GraphQLFieldInput(
      "positions",
      listOf(graphQLInt).nonNullable().coerceToInputObject(),
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

/// Auto-generated from [TestModel].
final GraphQLObjectType<TestModel> testModelGraphQlType = objectType(
    'TestModel',
    isInterface: false,
    description: 'Custom doc',
    interfaces: [],
    fields: [
      field('name', graphQLString.nonNullable(),
          resolve: (obj, ctx) => obj.name),
      field('description', graphQLString,
          description: 'Custom doc d', resolve: (obj, ctx) => obj.description),
      field('dates', listOf(graphQLDate.nonNullable()),
          resolve: (obj, ctx) => obj.dates),
      field('hasDates', graphQLBoolean.nonNullable(),
          resolve: (obj, ctx) => obj.hasDates)
    ]);

final testModelFreezedSerializer = SerializerValue<_TestModelFreezed>(
  fromJson: _$$_TestModelFreezedFromJson,
  toJson: (m) => _$$_TestModelFreezedToJson(m as _$_TestModelFreezed),
);

/// Auto-generated from [_TestModelFreezed].
final GraphQLObjectType<_TestModelFreezed> testModelFreezedGraphQlType =
    objectType('_TestModelFreezed',
        fields: [
          field('name', graphQLString.nonNullable(),
              resolve: (obj, ctx) => obj.name,
              description: null,
              deprecationReason: null),
          field('description', graphQLString,
              resolve: (obj, ctx) => obj.description,
              description: 'Custom doc d',
              deprecationReason: null),
          field('dates', listOf(graphQLDate.nonNullable()),
              resolve: (obj, ctx) => obj.dates,
              description: null,
              deprecationReason: null)
        ],
        isInterface: false,
        interfaces: [],
        description: null);

final eventUnionAddSerializer = SerializerValue<_EventUnionAdd>(
  fromJson: _$$_EventUnionAddFromJson,
  toJson: (m) => _$$_EventUnionAddToJson(m as _$_EventUnionAdd),
);

/// Auto-generated from [_EventUnionAdd].
final GraphQLObjectType<_EventUnionAdd> eventUnionAddGraphQlType =
    objectType('_EventUnionAdd',
        fields: [
          field('name', graphQLString.nonNullable(),
              resolve: (obj, ctx) => obj.name,
              description: null,
              deprecationReason: null),
          field('description', graphQLString,
              resolve: (obj, ctx) => obj.description,
              description: 'Custom doc d',
              deprecationReason: null),
          field('dates', listOf(graphQLDate.nonNullable()),
              resolve: (obj, ctx) => obj.dates,
              description: null,
              deprecationReason: null),
          field('models', listOf(testModelGraphQlType).nonNullable(),
              resolve: (obj, ctx) => obj.models,
              description: null,
              deprecationReason: null),
          eventUnionGraphQlTypeDiscriminant()
        ],
        isInterface: false,
        interfaces: [],
        description: null);

final eventUnionDeleteSerializer = SerializerValue<EventUnionDelete>(
  fromJson: _$$EventUnionDeleteFromJson,
  toJson: (m) => _$$EventUnionDeleteToJson(m as _$EventUnionDelete),
);

/// Auto-generated from [EventUnionDelete].
final GraphQLObjectType<EventUnionDelete> eventUnionDeleteGraphQlType =
    objectType('EventUnionDelete',
        fields: [
          field('name', graphQLString,
              resolve: (obj, ctx) => obj.name,
              description: null,
              deprecationReason: null),
          field('cost', graphQLInt.nonNullable(),
              resolve: (obj, ctx) => obj.cost,
              description: null,
              deprecationReason: null),
          field('dates', listOf(graphQLDate.nonNullable()),
              resolve: (obj, ctx) => obj.dates,
              description: null,
              deprecationReason: null),
          eventUnionGraphQlTypeDiscriminant()
        ],
        isInterface: false,
        interfaces: [],
        description: null);

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
