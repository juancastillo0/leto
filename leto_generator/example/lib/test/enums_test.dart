import 'package:leto/leto.dart';
import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart';
import 'package:leto_schema/validate_rules.dart';
import 'package:test/test.dart';

part 'enums_test.g.dart';

void main() {
  test('simple enum', () {
    expect(graphqlApiSchema.schemaStr, contains('''
"""comments for docs"""
enum SimpleEnum {
  simpleVariantOne
  SIMPLE_VARIANT_TWO
}'''));
  });

  test('EnumNameCase.snake_case enum', () {
    expect(graphqlApiSchema.schemaStr, contains('''
enum SnakeCaseEnum {
  """description from annotation"""
  variant_one @deprecated(reason: "custom deprecated")

  """Documentation for variant two"""
  variant_two
}'''));
  });

  test('class enum', () {
    expect(graphqlApiSchema.schemaStr, contains('''
enum ClassEnum @cost(complexity: 2) {
  VARIANT_ONE

  """The second variant docs"""
  VARIANT_TWO
  errorRenamed
}'''));
  });

  test('query field with enums', () async {
    expect(
      graphqlApiSchema.schemaStr,
      contains(
        'enumsTestQuery(classEnum: ClassEnum! = VARIANT_ONE,'
        ' snake: SnakeCaseEnum! = variant_two, simple: SimpleEnum): ClassEnum!',
      ),
    );

    final result = await GraphQL(graphqlApiSchema).parseAndExecute(
      r'''
    query ($classEnum: ClassEnum! = VARIANT_TWO, $simple: SimpleEnum = SIMPLE_VARIANT_TWO) {
      enumsTestQuery(classEnum:$classEnum, snake: variant_one, simple: $simple)
    }''',
      variableValues: {
        'classEnum': 'errorRenamed',
        'simple': 'simpleVariantOne',
      },
    );
    expect(result.toJson(), {
      'data': {
        'enumsTestQuery': 'errorRenamed',
      }
    });
  });
}

/// comments for docs
@GraphQLEnum()
enum SimpleEnum {
  @AttachFn(simpleVariantAttachments)
  simpleVariantOne,

  SIMPLE_VARIANT_TWO,
}

GraphQLAttachments simpleVariantAttachments() => const [CustomAttachment()];

@GraphQLEnum(valuesCase: EnumNameCase.snake_case)
enum SnakeCaseEnum {
  @GraphQLDocumentation(description: 'description from annotation')
  @Deprecated('custom deprecated')
  variantOne,

  /// Documentation for variant two
  variantTwo,
}

GraphQLAttachments classEnumAttachments() => const [ElementComplexity(2)];

class CustomAttachment {
  const CustomAttachment();
}

@AttachFn(classEnumAttachments)
@GraphQLEnum(valuesCase: EnumNameCase.CONSTANT_CASE)
class ClassEnum {
  final int code;
  final bool isError;

  const ClassEnum._(this.code, this.isError);

  @GraphQLEnumVariant()
  static const variantOne = ClassEnum._(100, false);

  /// The second variant docs
  @GraphQLEnumVariant()
  static const variantTwo = ClassEnum._(201, false);
  @GraphQLEnumVariant(name: 'errorRenamed')
  @AttachFn(variantErrorAttachments)
  static const variantErrorThree = ClassEnum._(300, true);

  static GraphQLAttachments variantErrorAttachments() =>
      const [CustomAttachment()];

  static const List<ClassEnum> values = [
    variantOne,
    variantTwo,
    variantErrorThree,
  ];
}

@Query()
ClassEnum enumsTestQuery(
  Ctx ctx, [
  ClassEnum classEnum = ClassEnum.variantOne,
  SnakeCaseEnum snake = SnakeCaseEnum.variantTwo,
  SimpleEnum? simple,
]) {
  final errorRenamedVariant = (getNamedType(ctx.field.type) as GraphQLEnumType)
      .getValue('errorRenamed');
  expect(
    errorRenamedVariant!.attachments,
    ClassEnum.variantErrorAttachments(),
  );
  return classEnum;
}
