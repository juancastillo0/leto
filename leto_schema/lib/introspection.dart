import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/utilities.dart' show astFromValue, printAST;

/// Performs introspection over a GraphQL [schema], and returns one
/// containing introspective information.
///
/// [allTypes] should contain all types, not directly defined in the schema,
/// that you would like to have introspection available for.
GraphQLSchema reflectSchema(GraphQLSchema schema, List<GraphQLType> allTypes) {
  final typeType = _reflectTypeType();
  final directiveType = _reflectDirectiveType();

  Set<GraphQLType>? allTypeSet;

  final schemaType = objectType<Object>('__Schema', fields: [
    field(
      'description',
      graphQLString,
      resolve: (_, __) => schema.description,
    ),
    field(
      'types',
      listOf(typeType.nonNull()).nonNull(),
      resolve: (_, __) => allTypeSet ??= allTypes.toSet(),
    ),
    field(
      'queryType',
      typeType.nonNull(),
      resolve: (_, __) => schema.queryType,
    ),
    field(
      'mutationType',
      typeType,
      resolve: (_, __) => schema.mutationType,
    ),
    field(
      'subscriptionType',
      typeType,
      resolve: (_, __) => schema.subscriptionType,
    ),
    field(
      'directives',
      listOf(directiveType.nonNull()).nonNull(),
      description: 'A list of all directives supported by this server.',
      resolve: (_, __) => schema.directives,
    ),
  ]);

  allTypes.addAll([
    graphQLBoolean,
    graphQLString,
    schemaType,
    typeType,
    _typeKindType,
    _reflectFieldType(),
    _reflectInputValueType(),
    _reflectEnumValueType(),
    directiveType,
    _directiveLocationType,
  ]);

  final fields = <GraphQLObjectField<Object?, Object?, Object?>>[
    field(
      '__schema',
      schemaType,
      resolve: (_, __) => schemaType,
    ),
    field(
      '__type',
      typeType,
      inputs: [GraphQLFieldInput('name', graphQLString.nonNull())],
      resolve: (_, ctx) {
        final name = ctx.args['name'] as String?;
        return allTypes.firstWhere(
          (t) => t.name == name,
          orElse: () => throw GraphQLException.fromMessage(
            'No type named "$name" exists.',
          ),
        );
      },
    ),
  ];

  final queryType = schema.queryType!;
  fields.addAll(queryType.fields);

  return GraphQLSchema(
    queryType: objectType(
      queryType.name,
      fields: fields,
      description: queryType.description,
      interfaces: queryType.interfaces,
      isInterface: queryType.isInterface,
    ),
    mutationType: schema.mutationType,
    subscriptionType: schema.subscriptionType,
    serdeCtx: schema.serdeCtx,
    description: schema.description,
    directives: schema.directives,
  );
}

GraphQLObjectType<GraphQLType>? _typeType;
GraphQLObjectType<GraphQLType> _reflectTypeType() {
  if (_typeType != null) return _typeType!;
  final _type = objectType<GraphQLType>('__Type');
  _typeType = _type;

  _type.fields.addAll([
    field(
      'kind',
      _typeKindType.nonNull(),
      resolve: (t, _) => t.when(
        enum_: (type) => 'ENUM',
        scalar: (type) => 'SCALAR',
        object: (type) => type.isInterface ? 'INTERFACE' : 'OBJECT',
        input: (type) => 'INPUT_OBJECT',
        union: (type) => 'UNION',
        list: (type) => 'LIST',
        nonNullable: (type) => 'NON_NULL',
      ),
    ),
    field(
      'name',
      graphQLString,
      resolve: (type, _) => type.name,
    ),
    field(
      'description',
      graphQLString,
      resolve: (type, _) => type.description,
    ),
    field(
      'specifiedByURL',
      graphQLString,
      resolve: (type, _) =>
          type is GraphQLScalarType ? type.specifiedByURL : null,
    ),
    field(
      'fields',
      listOf(_reflectFieldType().nonNull()),
      inputs: [
        GraphQLFieldInput(
          'includeDeprecated',
          graphQLBoolean,
          defaultValue: false,
        ),
      ],
      resolve: (type, ctx) => type.whenOrNull(
        object: (type) {
          final includeDeprecated = ctx.args['includeDeprecated'] == true;
          return type.fields
              .where((f) => !f.isDeprecated || includeDeprecated)
              .toList();
        },
      ),
    ),
    field(
      'interfaces',
      listOf(_reflectTypeType().nonNull()),
      resolve: (type, _) => type.whenMaybe(
        object: (type) => type.interfaces,
        orElse: (_) => null,
      ),
    ),
    field(
      'possibleTypes',
      listOf(_reflectTypeType().nonNull()),
      resolve: (type, _) => type.whenOrNull(
        object: (type) => type.isInterface ? type.possibleTypes : null,
        union: (type) => type.possibleTypes,
      ),
    ),
    field(
      'enumValues',
      listOf(_reflectEnumValueType().nonNull()),
      inputs: [
        GraphQLFieldInput(
          'includeDeprecated',
          graphQLBoolean,
          defaultValue: false,
        ),
      ],
      resolve: (type, ctx) => type.whenOrNull(
        enum_: (type) {
          final includeDeprecated = ctx.args['includeDeprecated'] == true;
          return type.values
              .where((f) => !f.isDeprecated || includeDeprecated)
              .toList();
        },
      ),
    ),
    field(
      'inputFields',
      listOf(_reflectInputValueType().nonNull()),
      inputs: [
        GraphQLFieldInput(
          'includeDeprecated',
          graphQLBoolean,
          defaultValue: false,
        ),
      ],
      resolve: (obj, ctx) => obj.whenOrNull(
        input: (type) => ctx.args['includeDeprecated'] == true
            ? type.fields
            : type.fields
                .where((element) => element.deprecationReason == null)
                .toList(),
      ),
    ),
    field(
      'ofType',
      _reflectTypeType(),
      resolve: (type, _) {
        return type.whenOrNull(
          list: (type) => type.ofType,
          nonNullable: (type) => type.ofType,
        );
      },
    ),
  ]);

  return _type;
}

final GraphQLEnumType<String> _typeKindType =
    enumTypeFromStrings('__TypeKind', [
  'SCALAR',
  'OBJECT',
  'INTERFACE',
  'UNION',
  'ENUM',
  'INPUT_OBJECT',
  'LIST',
  'NON_NULL'
]);

GraphQLObjectType<GraphQLObjectField>? _fieldType;
GraphQLObjectType<GraphQLObjectField> _reflectFieldType() {
  if (_fieldType != null) return _fieldType!;
  final _type = objectType<GraphQLObjectField>('__Field');
  _fieldType = _type;
  _type.fields.addAll([
    field(
      'name',
      graphQLString.nonNull(),
      resolve: (f, _) => f.name,
    ),
    field(
      'description',
      graphQLString,
      resolve: (f, _) => f.description,
    ),
    field(
      'args',
      listOf(_reflectInputValueType().nonNull()).nonNull(),
      inputs: [
        GraphQLFieldInput(
          'includeDeprecated',
          graphQLBoolean,
          defaultValue: false,
        ),
      ],
      resolve: (f, ctx) => ctx.args['includeDeprecated'] == true
          ? f.inputs
          : f.inputs
              .where((element) => element.deprecationReason == null)
              .toList(),
    ),
    field(
      'type',
      _reflectTypeType().nonNull(),
      resolve: (f, _) => f.type,
    ),
    field(
      'isDeprecated',
      graphQLBoolean.nonNull(),
      resolve: (f, _) => f.isDeprecated,
    ),
    field(
      'deprecationReason',
      graphQLString,
      resolve: (f, _) => f.deprecationReason,
    ),
  ]);
  return _type;
}

GraphQLObjectType<GraphQLFieldInput>? _inputValueType;
GraphQLObjectType<GraphQLFieldInput> _reflectInputValueType() {
  return _inputValueType ??= objectType('__InputValue', fields: [
    field(
      'name',
      graphQLString.nonNull(),
      resolve: (obj, _) => obj.name,
    ),
    field(
      'description',
      graphQLString,
      resolve: (obj, _) => obj.description,
    ),
    field(
      'type',
      _reflectTypeType().nonNull(),
      resolve: (f, _) => f.type,
    ),
    field(
      'defaultValue',
      graphQLString,
      description: 'A GraphQL-formatted string representing the default'
          ' value for this input value.',
      resolve: (obj, _) {
        if (obj.defaultsToNull) {
          return 'null';
        }
        final ast = obj.type.isNullable && obj.defaultValue == null
            ? null
            : astFromValue(obj.defaultValue, obj.type);
        if (ast == null) {
          return null;
        }
        return printAST(ast);
      },
    ),
    field(
      'isDeprecated',
      graphQLBoolean.nonNull(),
      resolve: (obj, _) => obj.deprecationReason != null,
    ),
    field(
      'deprecationReason',
      graphQLString,
      resolve: (obj, _) => obj.deprecationReason,
    ),
  ]);
}

final GraphQLEnumType<String> _directiveLocationType = enumTypeFromStrings(
  '__DirectiveLocation',
  [
    ...DirectiveLocation.values.map((e) => e.toJson()),
  ],
  description:
      'A Directive can be adjacent to many parts of the GraphQL language,'
      ' a __DirectiveLocation describes one such possible adjacencies.',
);

GraphQLObjectType<GraphQLDirective>? _directiveType;
GraphQLObjectType<GraphQLDirective> _reflectDirectiveType() {
  return _directiveType ??= objectType(
    '__Directive',
    description: '''
A Directive provides a way to describe alternate runtime execution and type validation behavior in a GraphQL document.
In some cases, you need to provide options to alter GraphQL's execution behavior in ways field arguments will not suffice, 
such as conditionally including or skipping a field. Directives provide this by describing additional information to the executor.
''',
    fields: [
      field(
        'name',
        graphQLString.nonNull(),
        resolve: (obj, _) => obj.name,
      ),
      field(
        'description',
        graphQLString,
        resolve: (obj, _) => obj.description,
      ),
      field(
        'isRepeatable',
        graphQLBoolean.nonNull(),
        resolve: (obj, _) => obj.isRepeatable,
      ),
      field(
        'locations',
        listOf(_directiveLocationType.nonNull()).nonNull(),
        resolve: (obj, _) => obj.locations.map((e) => e.toJson()).toList(),
      ),
      field(
        'args',
        listOf(_reflectInputValueType().nonNull()).nonNull(),
        resolve: (obj, ctx) => ctx.args['includeDeprecated'] == true
            ? obj.inputs
            : obj.inputs.where((e) => e.deprecationReason == null).toList(),
        inputs: [
          GraphQLFieldInput(
            'includeDeprecated',
            graphQLBoolean,
            defaultValue: false,
          )
        ],
      ),
    ],
  );
}

GraphQLObjectType<GraphQLEnumValue>? _enumValueType;
GraphQLObjectType<GraphQLEnumValue> _reflectEnumValueType() {
  return _enumValueType ??= objectType(
    '__EnumValue',
    fields: [
      field(
        'name',
        graphQLString.nonNull(),
        resolve: (obj, _) => obj.name,
      ),
      field(
        'description',
        graphQLString,
        resolve: (obj, _) => obj.description,
      ),
      field(
        'isDeprecated',
        graphQLBoolean.nonNull(),
        resolve: (obj, _) => obj.isDeprecated,
      ),
      field(
        'deprecationReason',
        graphQLString,
        resolve: (obj, _) => obj.deprecationReason,
      ),
    ],
  );
}
