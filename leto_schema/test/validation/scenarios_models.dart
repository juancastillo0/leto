import 'package:leto_schema/leto_schema.dart';

class Scenario {
  final String name;
  final String? schema;
  final List<TestCase> tests;

  Scenario({
    required this.name,
    required this.schema,
    required this.tests,
  });

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'tests': tests.map((x) => x.toJson()).toList(),
    };
  }

  factory Scenario.fromJson(Map<String, Object?> map) {
    return Scenario(
      name: map['name']! as String,
      schema: map['schema'] as String?,
      tests: List<TestCase>.of((map['tests']! as List).map(
        (Object? x) => TestCase.fromJson(
          x! as Map<String, Object?>,
        ),
      )),
    );
  }
}

class TestCase {
  final String name;
  final String? schema;
  final String document;
  final List<String>? rules;
  final List<GraphQLError>? errors;

  TestCase({
    required this.name,
    this.schema,
    required this.document,
    this.rules,
    this.errors,
  });

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'schema': schema,
      'document': document,
      'rules': rules,
      'errors': errors?.map((x) => x.toJson()).toList(),
    };
  }

  factory TestCase.fromJson(Map<String, Object?> map) {
    return TestCase(
      name: map['name']! as String,
      schema: map['schema'] != null ? map['schema']! as String : null,
      document: map['document']! as String,
      rules: map['rules'] != null ? (map['rules']! as List).cast() : null,
      errors: map['errors'] != null
          ? List<GraphQLError>.of(
              (map['errors']! as List).map((Object? x) =>
                  GraphQLError.fromJson(x! as Map<String, Object?>)),
            )
          : null,
    );
  }
}
