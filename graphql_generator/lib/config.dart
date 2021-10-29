class Config {
  final String serializerSuffix;
  final String graphqlTypeSuffix;
  final String unionKeySuffix;
  final String graphQLFieldSuffix;
  final bool nullableFields;
  final bool omitFields;
  final List<CustomTypes> customTypes;

  const Config({
    String? serializerSuffix,
    String? graphqlTypeSuffix,
    String? unionKeySuffix,
    String? graphQLFieldSuffix,
    bool? nullableFields,
    bool? omitFields,
    required this.customTypes,
  })  : serializerSuffix = serializerSuffix ?? 'Serializer',
        graphqlTypeSuffix = graphqlTypeSuffix ?? 'GraphQLType',
        unionKeySuffix = unionKeySuffix ?? 'Discriminant',
        graphQLFieldSuffix = graphQLFieldSuffix ?? 'GraphQLField',
        nullableFields = nullableFields ?? false,
        omitFields = omitFields ?? false;

  Map<String, dynamic> toJson() {
    return {
      'serializerSuffix': serializerSuffix,
      'graphqlTypeSuffix': graphqlTypeSuffix,
      'unionKeySuffix': unionKeySuffix,
      'graphQLFieldSuffix': graphQLFieldSuffix,
      'nullableFields': nullableFields,
      'omitFields': omitFields,
      'customTypes': customTypes,
    };
  }

  factory Config.fromJson(Map<String, dynamic> map) {
    return Config(
      serializerSuffix: map['serializerSuffix'] as String?,
      graphqlTypeSuffix: map['graphqlTypeSuffix'] as String?,
      unionKeySuffix: map['unionKeySuffix'] as String?,
      graphQLFieldSuffix: map['graphQLFieldSuffix'] as String?,
      nullableFields: map['nullableFields'] as bool?,
      omitFields: map['omitFields'] as bool?,
      customTypes: map['customTypes'] == null
          ? []
          : List.of(
              (map['customTypes'] as List).map(
                (e) => CustomTypes.fromJson((e as Map).cast()),
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'import': import,
      'getter': getter,
    };
  }

  factory CustomTypes.fromJson(Map<String, dynamic> map) {
    return CustomTypes(
      name: map['name'] as String,
      import: map['import'] as String,
      getter: map['getter'] as String,
    );
  }
}
