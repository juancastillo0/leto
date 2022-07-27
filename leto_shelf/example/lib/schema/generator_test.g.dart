// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_test.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<TestModel?, Object?, Object?> get addTestModelGraphQLField =>
    _addTestModelGraphQLField.value;
final _addTestModelGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<TestModel?, Object?, Object?>>(
        (setValue) => setValue(testModelGraphQLType.field<Object?>(
              'addTestModel',
              resolve: (obj, ctx) {
                final args = ctx.args;
                final validationErrorMap = <String, List<ValidaError>>{};

                if ((args["previous"] as TestModel?) != null) {
                  final previousValidationResult =
                      TestModelValidation.fromValue(
                          (args["previous"] as TestModel?) as TestModel);
                  if (previousValidationResult.hasErrors) {
                    validationErrorMap['previous'] = [
                      previousValidationResult.toError(property: 'previous')!
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

                return addTestModel(ctx, (args["realName"] as String),
                    previous: (args["previous"] as TestModel?),
                    name: (args["name"] as String?),
                    value: (args["value"] as List<int>));
              },
              description: 'the function uses [value] to do stuff',
            ))
              ..inputs.addAll([
                graphQLString.nonNull().inputField('realName'),
                testModelGraphQLTypeInput.inputField('previous'),
                graphQLString.inputField('name',
                    deprecationReason: 'use realName'),
                graphQLInt.nonNull().list().nonNull().inputField('value')
              ]));

GraphQLObjectField<List<TestModel>, Object?, Object?>
    get testModelsGraphQLField => _testModelsGraphQLField.value;
final _testModelsGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<List<TestModel>, Object?, Object?>>(
    (setValue) =>
        setValue(testModelGraphQLType.nonNull().list().nonNull().field<Object?>(
          'testModels',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return testModels(ctx, (args["lessThan"] as DateTime),
                position: (args["position"] as int));
          },
          description:
              'Automatic documentation generated\n[position] is the pad',
        ))
          ..inputs.addAll([
            graphQLDate
                .nonNull()
                .inputField('lessThan', description: 'pagination less than'),
            graphQLInt.nonNull().inputField('position',
                defaultValue: 0, description: 'pagination')
          ]));

GraphQLObjectField<List<EventUnion?>, Object?, Object?>
    get testUnionModelsGraphQLField => _testUnionModelsGraphQLField.value;
final _testUnionModelsGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<List<EventUnion?>, Object?, Object?>>(
    (setValue) =>
        setValue(eventUnionGraphQLType.list().nonNull().field<Object?>(
          'testUnionModels',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return testUnionModels(ctx,
                positions: (args["positions"] as List<int?>));
          },
          description:
              'testUnionModels documentation generated\n[position] is the pad',
        ))
          ..inputs.addAll([
            graphQLInt.list().nonNull().inputField('positions',
                defaultValue: const [], description: 'pagination')
          ]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final testModelSerializer = SerializerValue<TestModel>(
  key: "TestModel",
  fromJson: (ctx, json) => TestModel.fromJson(json), // _$TestModelFromJson,
  // toJson: (m) => _$TestModelToJson(m as TestModel),
);
final _testModelGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<TestModel>>((setValue) {
  final __name = 'TestModel';

  final __testModelGraphQLType = objectType<TestModel>(__name,
      isInterface: false, interfaces: [], description: 'Custom doc');

  setValue(__testModelGraphQLType);
  __testModelGraphQLType.fields.addAll(
    [
      graphQLString
          .nonNull()
          .field('name', resolve: (obj, ctx) => obj.name, attachments: [
        ValidaAttachment(ValidaString(minLength: 1, maxLength: 64)),
      ]),
      graphQLString.field('description',
          resolve: (obj, ctx) => obj.description, description: 'Custom doc d'),
      graphQLDate
          .nonNull()
          .list()
          .field('dates', resolve: (obj, ctx) => obj.dates),
      graphQLBoolean
          .nonNull()
          .field('hasDates', resolve: (obj, ctx) => obj.hasDates)
    ],
  );

  return __testModelGraphQLType;
});

/// Auto-generated from [TestModel].
GraphQLObjectType<TestModel> get testModelGraphQLType =>
    _testModelGraphQLType.value;
final _testModelGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<TestModel>>((setValue) {
  final __name = 'TestModelInput';

  final __testModelGraphQLTypeInput = inputObjectType<TestModel>(__name);

  setValue(__testModelGraphQLTypeInput);
  __testModelGraphQLTypeInput.fields.addAll(
    [
      graphQLString.nonNull().inputField('name', attachments: [
        ValidaAttachment(ValidaString(minLength: 1, maxLength: 64)),
      ]),
      graphQLString.inputField('description', description: 'Custom doc d'),
      graphQLDate.nonNull().list().inputField('dates')
    ],
  );

  return __testModelGraphQLTypeInput;
});

/// Auto-generated from [TestModel].
GraphQLInputObjectType<TestModel> get testModelGraphQLTypeInput =>
    _testModelGraphQLTypeInput.value;

final _testModelFreezedGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<TestModelFreezed>>((setValue) {
  final __name = 'TestModelFreezed';

  final __testModelFreezedGraphQLType =
      objectType<TestModelFreezed>(__name, isInterface: false, interfaces: []);

  setValue(__testModelFreezedGraphQLType);
  __testModelFreezedGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name),
      graphQLString.field('description',
          resolve: (obj, ctx) => obj.description, description: 'Custom doc d'),
      graphQLDate
          .nonNull()
          .list()
          .field('dates', resolve: (obj, ctx) => obj.dates),
      graphQLBoolean
          .nonNull()
          .field('hasDates', resolve: (obj, ctx) => obj.hasDates)
    ],
  );

  return __testModelFreezedGraphQLType;
});

/// Auto-generated from [TestModelFreezed].
GraphQLObjectType<TestModelFreezed> get testModelFreezedGraphQLType =>
    _testModelFreezedGraphQLType.value;

final eventUnionAddSerializer = SerializerValue<_EventUnionAdd>(
  key: "_EventUnionAdd",
  fromJson: (ctx, json) =>
      _EventUnionAdd.fromJson(json), // _$$_EventUnionAddFromJson,
  // toJson: (m) => _$$_EventUnionAddToJson(m as _$_EventUnionAdd),
);
final _eventUnionAddGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<_EventUnionAdd>>((setValue) {
  final __name = 'EventUnionAdd';

  final __eventUnionAddGraphQLType =
      objectType<_EventUnionAdd>(__name, isInterface: false, interfaces: []);

  setValue(__eventUnionAddGraphQLType);
  __eventUnionAddGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('name', resolve: (obj, ctx) => obj.name),
      graphQLString.field('description',
          resolve: (obj, ctx) => obj.description, description: 'Custom doc d'),
      graphQLDate
          .nonNull()
          .list()
          .field('dates', resolve: (obj, ctx) => obj.dates),
      testModelGraphQLType
          .list()
          .nonNull()
          .field('models', resolve: (obj, ctx) => obj.models),
      graphQLBoolean
          .nonNull()
          .field('hasDates', resolve: (obj, ctx) => obj.hasDates)
    ],
  );

  return __eventUnionAddGraphQLType;
});

/// Auto-generated from [_EventUnionAdd].
GraphQLObjectType<_EventUnionAdd> get eventUnionAddGraphQLType =>
    _eventUnionAddGraphQLType.value;

final eventUnionDeleteSerializer = SerializerValue<EventUnionDelete>(
  key: "EventUnionDelete",
  fromJson: (ctx, json) =>
      EventUnionDelete.fromJson(json), // _$$EventUnionDeleteFromJson,
  // toJson: (m) => _$$EventUnionDeleteToJson(m as _$EventUnionDelete),
);
final _eventUnionDeleteGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<EventUnionDelete>>((setValue) {
  final __name = 'EventUnionDelete';

  final __eventUnionDeleteGraphQLType =
      objectType<EventUnionDelete>(__name, isInterface: false, interfaces: []);

  setValue(__eventUnionDeleteGraphQLType);
  __eventUnionDeleteGraphQLType.fields.addAll(
    [
      graphQLString.field('name', resolve: (obj, ctx) => obj.name),
      graphQLInt.nonNull().field('cost', resolve: (obj, ctx) => obj.cost),
      graphQLDate
          .nonNull()
          .list()
          .field('dates', resolve: (obj, ctx) => obj.dates),
      graphQLBoolean
          .nonNull()
          .field('hasDates', resolve: (obj, ctx) => obj.hasDates)
    ],
  );

  return __eventUnionDeleteGraphQLType;
});

/// Auto-generated from [EventUnionDelete].
GraphQLObjectType<EventUnionDelete> get eventUnionDeleteGraphQLType =>
    _eventUnionDeleteGraphQLType.value;

final eventUnionSerializer = SerializerValue<EventUnion>(
  key: "EventUnion",
  fromJson: (ctx, json) => EventUnion.fromJson(json), // _$EventUnionFromJson,
  // toJson: (m) => _$EventUnionToJson(m as EventUnion),
);

/// Generated from [EventUnion]
GraphQLUnionType<EventUnion> get eventUnionGraphQLType =>
    _eventUnionGraphQLType.value;

final _eventUnionGraphQLType =
    HotReloadableDefinition<GraphQLUnionType<EventUnion>>((setValue) {
  final type = GraphQLUnionType<EventUnion>(
    'EventUnion',
    const [],
  );
  setValue(type);
  type.possibleTypes.addAll([
    eventUnionAddGraphQLType,
    eventUnionDeleteGraphQLType,
  ]);
  return type;
});

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
          .map((e) =>
              e == null ? null : TestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_EventUnionAddToJson(_$_EventUnionAdd instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'dates': instance.dates?.map((e) => e.toIso8601String()).toList(),
      'models': instance.models,
      'runtimeType': instance.$type,
    };

_$EventUnionDelete _$$EventUnionDeleteFromJson(Map<String, dynamic> json) =>
    _$EventUnionDelete(
      name: json['name'] as String?,
      cost: json['cost'] as int,
      dates: (json['dates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EventUnionDeleteToJson(_$EventUnionDelete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cost': instance.cost,
      'dates': instance.dates?.map((e) => e.toIso8601String()).toList(),
      'runtimeType': instance.$type,
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

  List<ValidaError> get name => errorsMap[TestModelField.name] ?? const [];
}

class TestModelValidation extends Validation<TestModel, TestModelField> {
  TestModelValidation(this.errorsMap, this.value, this.fields)
      : super(errorsMap);
  @override
  final Map<TestModelField, List<ValidaError>> errorsMap;
  @override
  final TestModel value;
  @override
  final TestModelValidationFields fields;

  /// Validates [value] and returns a [TestModelValidation] with the errors found as a result
  static TestModelValidation fromValue(TestModel value) {
    Object? _getProperty(String property) => spec.getField(value, property);

    final errors = <TestModelField, List<ValidaError>>{
      ...spec.fieldsMap.map(
        (key, field) => MapEntry(
          key,
          field.validate(key.name, _getProperty),
        ),
      )
    };
    errors.removeWhere((key, value) => value.isEmpty);
    return TestModelValidation(
        errors, value, TestModelValidationFields(errors));
  }

  static const spec = ValidaSpec(
    fieldsMap: {
      TestModelField.name: ValidaString(minLength: 1, maxLength: 64),
    },
    getField: _getField,
  );

  static List<ValidaError> _globalValidate(TestModel value) => [];

  static Object? _getField(TestModel value, String field) {
    switch (field) {
      case 'name':
        return value.name;
      case 'description':
        return value.description;
      case 'dates':
        return value.dates;
      case 'hasDates':
        return value.hasDates;
      case 'hashCode':
        return value.hashCode;
      case 'runtimeType':
        return value.runtimeType;
      default:
        throw Exception('Could not find field "$field" for value $value.');
    }
  }
}
