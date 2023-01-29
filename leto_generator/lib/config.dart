import 'package:leto_schema/leto_schema.dart';

class Config {
  final String serializerSuffix;
  final String graphqlTypeSuffix;
  final String unionKeySuffix;
  final String graphQLFieldSuffix;
  final bool nullableFields;
  final bool omitFields;
  final bool omitPrivateFields;
  final List<String> omitFieldsNamed;
  final String? instantiateCode;
  final List<CustomTypes> customTypes;
  final EnumNameCase? enumValuesCase;

  ///
  const Config({
    String? serializerSuffix,
    String? graphqlTypeSuffix,
    String? unionKeySuffix,
    String? graphQLFieldSuffix,
    bool? nullableFields,
    bool? omitFields,
    bool? omitPrivateFields,
    List<String>? omitFieldsNamed,
    this.instantiateCode,
    required this.customTypes,
    this.enumValuesCase,
  })  : serializerSuffix = serializerSuffix ?? 'Serializer',
        graphqlTypeSuffix = graphqlTypeSuffix ?? 'GraphQLType',
        unionKeySuffix = unionKeySuffix ?? 'Discriminant',
        graphQLFieldSuffix = graphQLFieldSuffix ?? 'GraphQLField',
        nullableFields = nullableFields ?? false,
        omitFields = omitFields ?? false,
        omitPrivateFields = omitPrivateFields ?? true,
        omitFieldsNamed = omitFieldsNamed ??
            const ['toJson', 'toString', 'compareTo', 'toMap'];

  Map<String, Object?> toJson() {
    return {
      'serializerSuffix': serializerSuffix,
      'graphqlTypeSuffix': graphqlTypeSuffix,
      'unionKeySuffix': unionKeySuffix,
      'graphQLFieldSuffix': graphQLFieldSuffix,
      'nullableFields': nullableFields,
      'omitFields': omitFields,
      'customTypes': customTypes,
      'omitPrivateFields': omitPrivateFields,
      'omitFieldsNamed': omitFieldsNamed,
      'instantiateCode': instantiateCode,
      'enumValuesCase': enumValuesCase?.toString().split('.').last,
    };
  }

  static EnumNameCase? parseEnumCase(String? enumValuesCaseStr) {
    EnumNameCase? enumValuesCase;
    if (enumValuesCaseStr != null) {
      final index = EnumNameCase.values.indexWhere(
        (v) => v.toString().split('.').last == enumValuesCaseStr,
      );
      if (index != -1) {
        enumValuesCase = EnumNameCase.values[index];
      } else {
        final errorMessage = 'enumValuesCase should be one of'
            ' ${EnumNameCase.values.map((e) => '"${e.toString().split('.').last}"').join(', ')}.'
            ' Got $enumValuesCaseStr.';
        throw FormatException(errorMessage, enumValuesCase);
      }
    }
    return enumValuesCase;
  }

  factory Config.fromJson(Map<String, dynamic> map) {
    return Config(
      serializerSuffix: map['serializerSuffix'] as String?,
      graphqlTypeSuffix: map['graphqlTypeSuffix'] as String?,
      unionKeySuffix: map['unionKeySuffix'] as String?,
      graphQLFieldSuffix: map['graphQLFieldSuffix'] as String?,
      nullableFields: map['nullableFields'] as bool?,
      omitFields: map['omitFields'] as bool?,
      omitPrivateFields: map['omitPrivateFields'] as bool?,
      omitFieldsNamed: (map['omitFieldsNamed'] as List?)?.cast<String>(),
      instantiateCode: map['instantiateCode'] as String?,
      enumValuesCase: parseEnumCase(map['enumValuesCase'] as String?),
      customTypes: map['customTypes'] == null
          ? []
          : List.of(
              (map['customTypes'] as List).map(
                (Object? e) => CustomTypes.fromJson((e as Map).cast()),
              ),
            ),
    );
  }
}

class CustomTypes {
  final String name;
  final String import;
  final String getter;

  const CustomTypes({
    required this.name,
    required this.import,
    required this.getter,
  });

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'import': import,
      'getter': getter,
    };
  }

  factory CustomTypes.fromJson(Map<String, Object?> map) {
    return CustomTypes(
      name: map['name']! as String,
      import: map['import']! as String,
      getter: map['getter']! as String,
    );
  }
}
