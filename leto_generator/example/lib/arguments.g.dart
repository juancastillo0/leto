// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arguments.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<String, Object?, Object?> get testManyDefaultsGraphQLField =>
    _testManyDefaultsGraphQLField.value;
final _testManyDefaultsGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<String, Object?, Object?>>(
    (setValue) => setValue(graphQLString.nonNull().field<Object?>(
          'testManyDefaults',
          resolve: (obj, ctx) {
            final args = ctx.args;

            return testManyDefaults(
                str: (args["str"] as String),
                intInput: (args["intInput"] as int),
                doubleInput: (args["doubleInput"] as double),
                doubleInputNull: (args["doubleInputNull"] as double?),
                boolean: (args["boolean"] as bool),
                listStr: (args["listStr"] as List<String>),
                listDecimalNull: (args["listDecimalNull"] as List<Decimal?>?),
                listUri: (args["listUri"] as List<Uri>),
                date: (args["date"] as DateTime),
                gen: (args["gen"] as InputGen<int>?),
                enumValue: (args["enumValue"] as EnumValue),
                enumCustom: (args["enumCustom"] as int),
                enumCustomList: (args["enumCustomList"] as List<int>),
                timestamps: (args["timestamps"] as List<DateTime?>),
                json: (args["json"] as Json));
          },
        ))
          ..inputs.addAll([
            graphQLString.nonNull().inputField('str', defaultValue: 'def'),
            graphQLInt.nonNull().inputField('intInput', defaultValue: 2),
            graphQLFloat.nonNull().inputField('doubleInput', defaultValue: 3),
            graphQLFloat.inputField('doubleInputNull', defaultValue: 4.2),
            graphQLBoolean.nonNull().inputField('boolean', defaultValue: true),
            graphQLString
                .nonNull()
                .list()
                .nonNull()
                .inputField('listStr', defaultValue: const ['dw', 'dd2']),
            decimalGraphQLType.list().inputField('listDecimalNull',
                defaultValue: _defaultListDecimalNull()),
            graphQLUri.nonNull().list().nonNull().inputField('listUri',
                defaultValue: [Uri.parse('http://localhost:8060/')]),
            graphQLDate
                .nonNull()
                .inputField('date', defaultValue: DateTime.parse("2021-03-24")),
            inputGenGraphQLTypeInput<int>(graphQLInt.nonNull()).inputField(
                'gen',
                defaultValue: InputGen(name: 'gen', generic: 2)),
            enumValueGraphQLType
                .nonNull()
                .inputField('enumValue', defaultValue: EnumValue.v1),
            enumCustomGraphQLType.inputField('enumCustom', defaultValue: 3),
            enumCustomGraphQLType
                .nonNull()
                .list()
                .nonNull()
                .inputField('enumCustomList', defaultValue: const [2]),
            _timestampsType().inputField('timestamps',
                defaultValue: [DateTime.parse("2021-01-24"), null]),
            Json.graphQLType.nonNull().inputField('json',
                defaultValue: const Json.map({
                  'd': Json.list([Json.number(2)])
                }))
          ]));

GraphQLObjectField<String, Object?, Object?> get testValidaInArgsGraphQLField =>
    _testValidaInArgsGraphQLField.value;
final _testValidaInArgsGraphQLField = HotReloadableDefinition<
    GraphQLObjectField<String, Object?,
        Object?>>((setValue) => setValue(graphQLString.nonNull().field<Object?>(
      'testValidaInArgs',
      resolve: (obj, ctx) {
        final args = ctx.args;
        final validationErrorMap = <String, List<ValidaError>>{};

        final _validation = TestValidaInArgsArgs(
                strSOrA: (args["strSOrA"] as String),
                otherInt: (args["otherInt"] as int?),
                greaterThan3AndOtherInt:
                    (args["greaterThan3AndOtherInt"] as int),
                after2020: (args["after2020"] as DateTime?),
                nonEmptyList: (args["nonEmptyList"] as List<String>?),
                model: (args["model"] as ValidaArgModel?))
            .validate();
        validationErrorMap.addAll(_validation.errorsMap
            .map((k, v) => MapEntry(k is Enum ? k.name : k.toString(), v)));
        if (validationErrorMap.isNotEmpty) {
          throw GraphQLError(
            'Input validation error',
            extensions: {
              'validaErrors': validationErrorMap,
            },
            sourceError: validationErrorMap,
          );
        }

        return testValidaInArgs(
            strSOrA: (args["strSOrA"] as String),
            otherInt: (args["otherInt"] as int?),
            greaterThan3AndOtherInt: (args["greaterThan3AndOtherInt"] as int),
            after2020: (args["after2020"] as DateTime?),
            nonEmptyList: (args["nonEmptyList"] as List<String>?),
            model: (args["model"] as ValidaArgModel?));
      },
    ))
      ..inputs.addAll([
        graphQLString.nonNull().inputField('strSOrA', attachments: [
          ValidaAttachment(ValidaString(isIn: ['S', 'A'])),
        ]),
        graphQLInt.inputField('otherInt'),
        graphQLInt.nonNull().inputField('greaterThan3AndOtherInt',
            defaultValue: 3,
            attachments: [
              ValidaAttachment(ValidaNum(
                  comp: ValidaComparison(
                      more: CompVal.list(
                          [CompVal(3), CompVal.ref('otherInt')])))),
            ]),
        graphQLDate.inputField('after2020', attachments: [
          ValidaAttachment(ValidaDate(min: '2021-01-01')),
        ]),
        graphQLString.nonNull().list().inputField('nonEmptyList', attachments: [
          ValidaAttachment(ValidaList(minLength: 1)),
        ]),
        validaArgModelGraphQLTypeInput.inputField('model')
      ]));

GraphQLObjectField<String, Object?, Object?>
    get testValidaInArgsSingleModelGraphQLField =>
        _testValidaInArgsSingleModelGraphQLField.value;
final _testValidaInArgsSingleModelGraphQLField = HotReloadableDefinition<
        GraphQLObjectField<String, Object?, Object?>>(
    (setValue) => setValue(graphQLString.nonNull().field<Object?>(
          'testValidaInArgsSingleModel',
          resolve: (obj, ctx) {
            final args = ctx.args;
            final validationErrorMap = <String, List<ValidaError>>{};

            if ((args["singleModel"] as ValidaArgModel?) != null) {
              final singleModelValidationResult = validateValidaArgModel(
                  (args["singleModel"] as ValidaArgModel?) as ValidaArgModel);
              if (singleModelValidationResult.hasErrors) {
                validationErrorMap['singleModel'] = [
                  singleModelValidationResult.toError(property: 'singleModel')!
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

            return testValidaInArgsSingleModel(
                singleModel: (args["singleModel"] as ValidaArgModel?));
          },
        ))
          ..inputs.addAll(
              [validaArgModelGraphQLTypeInput.inputField('singleModel')]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final validaArgModelSerializer = SerializerValue<ValidaArgModel>(
  key: "ValidaArgModel",
  fromJson: (ctx, json) => ValidaArgModel.fromJson(json), // _$$FromJson,
  // toJson: (m) => _$$ToJson(m as _$),
);
final _validaArgModelGraphQLTypeInput =
    HotReloadableDefinition<GraphQLInputObjectType<ValidaArgModel>>((setValue) {
  final __name = 'ValidaArgModel';

  final __validaArgModelGraphQLTypeInput =
      inputObjectType<ValidaArgModel>(__name);

  setValue(__validaArgModelGraphQLTypeInput);
  __validaArgModelGraphQLTypeInput.fields.addAll(
    [
      graphQLString.nonNull().list().nonNull().inputField('strs', attachments: [
        ValidaAttachment(ValidaList(each: ValidaString(minLength: 1))),
      ]),
      validaArgModelGraphQLTypeInput.inputField('inner')
    ],
  );

  return __validaArgModelGraphQLTypeInput;
});

/// Auto-generated from [ValidaArgModel].
GraphQLInputObjectType<ValidaArgModel> get validaArgModelGraphQLTypeInput =>
    _validaArgModelGraphQLTypeInput.value;

/// Auto-generated from [EnumValue].
final GraphQLEnumType<EnumValue> enumValueGraphQLType =
    GraphQLEnumType('EnumValue', [
  GraphQLEnumValue('v1', EnumValue.v1),
  GraphQLEnumValue('v2', EnumValue.v2),
  GraphQLEnumValue('v3', EnumValue.v3)
]);

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

enum ValidaArgModelField {
  strs,
  inner,
}

class ValidaArgModelValidationFields {
  const ValidaArgModelValidationFields(this.errorsMap);
  final Map<ValidaArgModelField, List<ValidaError>> errorsMap;

  ValidaArgModelValidation? get inner {
    final l = errorsMap[ValidaArgModelField.inner];
    return (l != null && l.isNotEmpty)
        ? l.first.nestedValidation as ValidaArgModelValidation?
        : null;
  }

  List<ValidaError> get strs => errorsMap[ValidaArgModelField.strs]!;
}

class ValidaArgModelValidation
    extends Validation<ValidaArgModel, ValidaArgModelField> {
  ValidaArgModelValidation(this.errorsMap, this.value, this.fields)
      : super(errorsMap);
  @override
  final Map<ValidaArgModelField, List<ValidaError>> errorsMap;
  @override
  final ValidaArgModel value;
  @override
  final ValidaArgModelValidationFields fields;

  /// Validates [value] and returns a [ValidaArgModelValidation] with the errors found as a result
  static ValidaArgModelValidation fromValue(ValidaArgModel value) {
    Object? _getProperty(String property) => spec.getField(value, property);

    final errors = <ValidaArgModelField, List<ValidaError>>{
      ...spec.fieldsMap.map(
        (key, field) => MapEntry(
          key,
          field.validate(key.name, _getProperty),
        ),
      )
    };
    errors.removeWhere((key, value) => value.isEmpty);
    return ValidaArgModelValidation(
        errors, value, ValidaArgModelValidationFields(errors));
  }

  static const spec = ValidaSpec(
    fieldsMap: {
      ValidaArgModelField.inner: ValidaNested<ValidaArgModel>(
        omit: null,
        customValidate: null,
        overrideValidation: validateValidaArgModel,
      ),
      ValidaArgModelField.strs: ValidaList(each: ValidaString(minLength: 1)),
    },
    getField: _getField,
  );

  static List<ValidaError> _globalValidate(ValidaArgModel value) => [];

  static Object? _getField(ValidaArgModel value, String field) {
    switch (field) {
      case 'inner':
        return value.inner;
      case 'strs':
        return value.strs;
      default:
        throw Exception();
    }
  }
}

@Deprecated('Use ValidaArgModelValidation.fromValue')
ValidaArgModelValidation validateValidaArgModel(ValidaArgModel value) {
  return ValidaArgModelValidation.fromValue(value);
}

/// The arguments for [testValidaInArgs].
class TestValidaInArgsArgs with ToJson {
  final String strSOrA;
  final int? otherInt;
  final int greaterThan3AndOtherInt;
  final DateTime? after2020;
  final List<String>? nonEmptyList;
  final ValidaArgModel? model;

  /// The arguments for [testValidaInArgs].
  const TestValidaInArgsArgs({
    required this.strSOrA,
    this.otherInt,
    this.greaterThan3AndOtherInt = 3,
    this.after2020,
    this.nonEmptyList,
    this.model,
  });

  /// Validates this arguments for [testValidaInArgs].
  TestValidaInArgsArgsValidation validate() =>
      validateTestValidaInArgsArgs(this);

  /// Validates this arguments for [testValidaInArgs] and
  /// returns the successfully [Validated] value or
  /// throws a [TestValidaInArgsArgsValidation] when there is an error.
  Validated<TestValidaInArgsArgs> validatedOrThrow() {
    final validation = validate();
    final validated = validation.validated;
    if (validated == null) {
      throw validation;
    }
    return validated;
  }

  @override
  Map<String, Object?> toJson() => {
        'strSOrA': strSOrA,
        'otherInt': otherInt,
        'greaterThan3AndOtherInt': greaterThan3AndOtherInt,
        'after2020': after2020,
        'nonEmptyList': nonEmptyList,
        'model': model,
      };

  @override
  String toString() => 'TestValidaInArgsArgs${toJson()}';

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestValidaInArgsArgs &&
            strSOrA == other.strSOrA &&
            otherInt == other.otherInt &&
            greaterThan3AndOtherInt == other.greaterThan3AndOtherInt &&
            after2020 == other.after2020 &&
            nonEmptyList == other.nonEmptyList &&
            model == other.model);
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        strSOrA,
        otherInt,
        greaterThan3AndOtherInt,
        after2020,
        nonEmptyList,
        model,
      );
}

enum TestValidaInArgsArgsField {
  strSOrA,
  greaterThan3AndOtherInt,
  after2020,
  nonEmptyList,
  model,
}

class TestValidaInArgsArgsValidationFields {
  const TestValidaInArgsArgsValidationFields(this.errorsMap);
  final Map<TestValidaInArgsArgsField, List<ValidaError>> errorsMap;

  ValidaArgModelValidation? get model {
    final l = errorsMap[TestValidaInArgsArgsField.model];
    return (l != null && l.isNotEmpty)
        ? l.first.nestedValidation as ValidaArgModelValidation?
        : null;
  }

  List<ValidaError> get strSOrA =>
      errorsMap[TestValidaInArgsArgsField.strSOrA]!;
  List<ValidaError> get greaterThan3AndOtherInt =>
      errorsMap[TestValidaInArgsArgsField.greaterThan3AndOtherInt]!;
  List<ValidaError> get after2020 =>
      errorsMap[TestValidaInArgsArgsField.after2020]!;
  List<ValidaError> get nonEmptyList =>
      errorsMap[TestValidaInArgsArgsField.nonEmptyList]!;
}

class TestValidaInArgsArgsValidation
    extends Validation<TestValidaInArgsArgs, TestValidaInArgsArgsField> {
  TestValidaInArgsArgsValidation(this.errorsMap, this.value, this.fields)
      : super(errorsMap);
  @override
  final Map<TestValidaInArgsArgsField, List<ValidaError>> errorsMap;
  @override
  final TestValidaInArgsArgs value;
  @override
  final TestValidaInArgsArgsValidationFields fields;

  /// Validates [value] and returns a [TestValidaInArgsArgsValidation] with the errors found as a result
  static TestValidaInArgsArgsValidation fromValue(TestValidaInArgsArgs value) {
    Object? _getProperty(String property) => spec.getField(value, property);

    final errors = <TestValidaInArgsArgsField, List<ValidaError>>{
      ...spec.fieldsMap.map(
        (key, field) => MapEntry(
          key,
          field.validate(key.name, _getProperty),
        ),
      )
    };
    errors.removeWhere((key, value) => value.isEmpty);
    return TestValidaInArgsArgsValidation(
        errors, value, TestValidaInArgsArgsValidationFields(errors));
  }

  static const spec = ValidaSpec(
    fieldsMap: {
      TestValidaInArgsArgsField.model: ValidaNested<ValidaArgModel>(
        omit: null,
        customValidate: null,
        overrideValidation: validateValidaArgModel,
      ),
      TestValidaInArgsArgsField.strSOrA: ValidaString(isIn: ['S', 'A']),
      TestValidaInArgsArgsField.greaterThan3AndOtherInt: ValidaNum(
          comp: ValidaComparison(
              more: CompVal.list([CompVal(3), CompVal.ref('otherInt')]))),
      TestValidaInArgsArgsField.after2020: ValidaDate(min: '2021-01-01'),
      TestValidaInArgsArgsField.nonEmptyList: ValidaList(minLength: 1),
    },
    getField: _getField,
  );

  static List<ValidaError> _globalValidate(TestValidaInArgsArgs value) => [];

  static Object? _getField(TestValidaInArgsArgs value, String field) {
    switch (field) {
      case 'model':
        return value.model;
      case 'strSOrA':
        return value.strSOrA;
      case 'greaterThan3AndOtherInt':
        return value.greaterThan3AndOtherInt;
      case 'after2020':
        return value.after2020;
      case 'nonEmptyList':
        return value.nonEmptyList;
      default:
        throw Exception();
    }
  }
}

@Deprecated('Use TestValidaInArgsArgsValidation.fromValue')
TestValidaInArgsArgsValidation validateTestValidaInArgsArgs(
    TestValidaInArgsArgs value) {
  return TestValidaInArgsArgsValidation.fromValue(value);
}
