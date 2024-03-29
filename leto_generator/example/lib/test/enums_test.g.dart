// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums_test.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<ClassEnum, Object?, Object?>
    get enumsTestQueryGraphQLField => _enumsTestQueryGraphQLField.value;
final _enumsTestQueryGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<ClassEnum, Object?, Object?>>(
        (setValue) => setValue(classEnumGraphQLType.nonNull().field<Object?>(
              'enumsTestQuery',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return enumsTestQuery(
                    ctx,
                    (args["classEnum"] as ClassEnum),
                    (args["snake"] as SnakeCaseEnum),
                    (args["simple"] as SimpleEnum?));
              },
            ))
              ..inputs.addAll([
                classEnumGraphQLType.nonNull().inputField(
                      'classEnum',
                      defaultValue: ClassEnum.variantOne,
                    ),
                snakeCaseEnumGraphQLType.nonNull().inputField(
                      'snake',
                      defaultValue: SnakeCaseEnum.variantTwo,
                    ),
                simpleEnumGraphQLType.inputField('simple')
              ]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

/// Auto-generated from [ClassEnum].
final GraphQLEnumType<ClassEnum> classEnumGraphQLType = GraphQLEnumType(
  'ClassEnum',
  [
    GraphQLEnumValue(
      'VARIANT_ONE',
      ClassEnum.variantOne,
    ),
    GraphQLEnumValue(
      'VARIANT_TWO',
      ClassEnum.variantTwo,
      description: 'The second variant docs',
    ),
    GraphQLEnumValue(
      'errorRenamed',
      ClassEnum.variantErrorThree,
      attachments: [
        ...ClassEnum.variantErrorAttachments(),
      ],
    ),
  ],
  extra: GraphQLTypeDefinitionExtra.attach([
    ...classEnumAttachments(),
  ]),
);

/// Auto-generated from [SimpleEnum].
final GraphQLEnumType<SimpleEnum> simpleEnumGraphQLType = GraphQLEnumType(
  'SimpleEnumRenamed',
  [
    GraphQLEnumValue(
      'simpleVariantOne',
      SimpleEnum.simpleVariantOne,
      attachments: [
        ...simpleVariantAttachments(),
      ],
    ),
    GraphQLEnumValue(
      'SIMPLE_VARIANT_TWO',
      SimpleEnum.SIMPLE_VARIANT_TWO,
    ),
  ],
  description: 'comments for docs',
);

/// Auto-generated from [SnakeCaseEnum].
final GraphQLEnumType<SnakeCaseEnum> snakeCaseEnumGraphQLType = GraphQLEnumType(
  'SnakeCaseEnum',
  [
    GraphQLEnumValue(
      'variant_one',
      SnakeCaseEnum.variantOne,
      description: 'description from annotation',
      deprecationReason: 'custom deprecated',
    ),
    GraphQLEnumValue(
      'variant_two',
      SnakeCaseEnum.variantTwo,
      description: 'Documentation for variant two',
    ),
  ],
);
