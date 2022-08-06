import 'package:leto_generator_example/graphql_api.schema.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:test/test.dart';

part 'class_config_test.g.dart';

const classConfigSchemaStr = [
// @example-start{generator-class-renamed-graphql,extension:graphql,start:1,end:-1}
  '''
type RenamedClassConfig {
  value: String! @deprecated(reason: "value deprecated")
  valueOverridden: String
  valueNull: String
  value2: String
}
''',
// @example-end{generator-class-renamed-graphql}
  '''
interface ClassConfig2Interface {
  value: String!
}''',
// @example-start{generator-class-graphql,extension:graphql,start:1,end:-1}
  '''
type ClassConfig2 implements ClassConfig2Interface {
  value: String!
  valueOverridden: String
  renamedValue2: String!
}
''',
// @example-end{generator-class-graphql}
];

// @example-start{generator-object-class-renamed}
@GraphQLObject(nullableFields: true, name: 'RenamedClassConfig')
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
// @example-end{generator-object-class-renamed}

// @example-start{generator-object-class}
final customInterface = objectType<Object>(
  'ClassConfig2Interface',
  fields: [
    graphQLString.nonNull().field('value'),
  ],
  isInterface: true,
);

@GraphQLObject(omitFields: true, interfaces: ['customInterface'])
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
// @example-end{generator-object-class}

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
