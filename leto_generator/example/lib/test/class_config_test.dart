import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

part 'class_config_test.g.dart';

const classConfigSchemaStr = [
  '''
type RenamedClassConfig {
  value: String! @deprecated(reason: "value deprecated")
  valueOverridden: String
  valueNull: String
  value2: String
}''',
  '''
interface ClassConfig2Interface {
  value: String!
}''',
  '''
type ClassConfig2 implements ClassConfig2Interface {
  value: String!
  valueOverridden: String
  renamedValue2: String!
}''',
];

@GraphQLClass(nullableFields: true, name: 'RenamedClassConfig')
class ClassConfig {
  @GraphQLDocumentation(deprecationReason: 'value deprecated')
  @GraphQLField()
  final String value;
  final String valueOverridden;
  final String? valueNull;
  @GraphQLField(nullable: true)
  final String value2;

  ClassConfig({
    required this.value2,
    required this.value,
    required this.valueOverridden,
    this.valueNull,
  });
}

final customInterface = objectType<Object>(
  'ClassConfig2Interface',
  fields: [
    graphQLString.nonNull().field('value'),
  ],
  isInterface: true,
);

@GraphQLClass(omitFields: true, interfaces: ['customInterface'])
class ClassConfig2 {
  @GraphQLField()
  final String value;
  @GraphQLField(nullable: true)
  final String valueOverridden;
  final String notFound;
  @GraphQLField(name: 'renamedValue2')
  final String value2;

  const ClassConfig2({
    required this.value,
    required this.valueOverridden,
    required this.notFound,
    required this.value2,
  });
}

void main() {
  test('class config generator', () {
    for (final str in classConfigSchemaStr) {
      expect(graphqlApiSchema.schemaStr, contains(str));
    }
  });
}

@Query()
ClassConfig2 getClassConfig2() {
  return const ClassConfig2(
    notFound: '',
    value2: '',
    value: '',
    valueOverridden: '',
  );
}

@Query()
ClassConfig getClassConfig() {
  return ClassConfig(
    valueNull: null,
    value2: '',
    value: '',
    valueOverridden: '',
  );
}
