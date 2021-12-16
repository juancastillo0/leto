import 'package:freezed_annotation/freezed_annotation.dart';
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
enum SimpleEnumRenamed {
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
        ' snake: SnakeCaseEnum! = variant_two, simple: SimpleEnumRenamed): ClassEnum!',
      ),
    );

    final result = await GraphQL(graphqlApiSchema).parseAndExecute(
      r'''
    query ($classEnum: ClassEnum! = VARIANT_TWO, $simple: SimpleEnumRenamed = SIMPLE_VARIANT_TWO) {
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
// @example-start{generator-enum-example}
/// comments for docs
@GraphQLEnum(name: 'SimpleEnumRenamed')
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
// @example-end{generator-enum-example}


class CustomAttachment {
  const CustomAttachment();
}
// @example-start{generator-class-enum-example}
GraphQLAttachments classEnumAttachments() => const [ElementComplexity(2)];

@AttachFn(classEnumAttachments)
@GraphQLEnum(valuesCase: EnumNameCase.CONSTANT_CASE)
@immutable
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassEnum && other.code == code && other.isError == isError;
  }

  @override
  int get hashCode => code.hashCode ^ isError.hashCode;
}
// @example-end{generator-class-enum-example}

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
