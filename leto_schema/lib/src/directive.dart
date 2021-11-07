// ignore_for_file: constant_identifier_names
part of leto_schema.src.schema;

/// Provides documentation, information or functionalities over
/// different aspects of a GraphQL parsing, validation, execution or
/// interpretation of a [GraphQLSchema]
class GraphQLDirective {
  /// The name of this directive, should be unique
  final String name;

  /// Provides documentation for this directive
  final String? description;

  /// The places the a GraphQL document where this
  /// directive can be used
  final List<DirectiveLocation> locations;

  /// The input arguments for this directive
  final List<GraphQLFieldInput> inputs;

  /// Whether this directive can be applied multiple types
  final bool isRepeatable;

  final Map<String, Object?>? extensions;

  // DirectiveDefinitionNode? astNode;

  const GraphQLDirective({
    required this.name,
    this.description,
    required this.locations,
    this.inputs = const [],
    this.isRepeatable = false,
    this.extensions,
  });

  /// Default GraphQL directives
  static final specifiedDirectives = [
    graphQLIncludeDirective,
    graphQLSkipDirective,
    graphQLDeprecatedDirective,
    graphQLSpecifiedByDirective,
  ];
}

enum DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  // Type System Definitions
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
}

extension DirectiveLocationEnumSerde on DirectiveLocation {
  String toJson() => toString().split('.').last;
}

bool isSpecifiedDirective(GraphQLDirective directive) {
  return GraphQLDirective.specifiedDirectives
      .map((e) => e.name)
      .contains(directive.name);
}

/// Constant string used for default reason for a deprecation.
const DEFAULT_DEPRECATION_REASON = 'No longer supported';

final graphQLIncludeDirective = GraphQLDirective(
  name: 'include',
  description: 'Directs the executor to include this field or'
      ' fragment only when the `if` argument is true.',
  locations: [
    DirectiveLocation.FIELD,
    DirectiveLocation.FRAGMENT_SPREAD,
    DirectiveLocation.INLINE_FRAGMENT,
  ],
  inputs: [
    GraphQLFieldInput(
      'if',
      graphQLBoolean.nonNull(),
      description: 'Included when true.',
    ),
  ],
);

final graphQLSkipDirective = GraphQLDirective(
  name: 'skip',
  description: 'Directs the executor to skip this field or'
      ' fragment when the `if` argument is true.',
  locations: [
    DirectiveLocation.FIELD,
    DirectiveLocation.FRAGMENT_SPREAD,
    DirectiveLocation.INLINE_FRAGMENT,
  ],
  inputs: [
    GraphQLFieldInput(
      'if',
      graphQLBoolean.nonNull(),
      description: 'Skipped when true.',
    ),
  ],
);

final graphQLDeprecatedDirective = GraphQLDirective(
  name: 'deprecated',
  description: 'Marks an element of a GraphQL schema as no longer supported.',
  locations: [
    DirectiveLocation.FIELD_DEFINITION,
    DirectiveLocation.ARGUMENT_DEFINITION,
    DirectiveLocation.INPUT_FIELD_DEFINITION,
    DirectiveLocation.ENUM_VALUE,
  ],
  inputs: [
    GraphQLFieldInput(
      'reason',
      graphQLString,
      description:
          'Explains why this element was deprecated, usually also including'
          ' a suggestion for how to access supported similar data.'
          ' Formatted using the Markdown syntax, as specified by [CommonMark](https://commonmark.org/).',
      defaultValue: DEFAULT_DEPRECATION_REASON,
    ),
  ],
);

final graphQLSpecifiedByDirective = GraphQLDirective(
  name: 'specifiedBy',
  description: 'Exposes a URL that specifies the behaviour of this scalar.',
  locations: [DirectiveLocation.SCALAR],
  inputs: [
    GraphQLFieldInput(
      'url',
      graphQLString.nonNull(),
      description: 'The URL that specifies the behaviour of this scalar.',
    ),
  ],
);
