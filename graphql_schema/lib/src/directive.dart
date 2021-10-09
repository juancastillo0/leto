// ignore_for_file: constant_identifier_names
part of graphql_schema.src.schema;

class GraphQLDirective {
  final String name;
  final String? description;
  final List<DirectiveLocation> locations;
  final List<GraphQLFieldInput> args;
  final bool isRepeatable;
  final Map<String, Object?>? extensions;
  // ?DirectiveDefinitionNode astNode;

  const GraphQLDirective({
    required this.name,
    this.description,
    required this.locations,
    this.args = const [],
    this.isRepeatable = false,
    this.extensions,
  });

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
  args: [
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
  args: [
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
  args: [
    GraphQLFieldInput(
      'reason',
      graphQLString,
      description:
          'Explains why this element was deprecated, usually also including a suggestion for how to access supported similar data. Formatted using the Markdown syntax, as specified by [CommonMark](https://commonmark.org/).',
      defaultValue: DEFAULT_DEPRECATION_REASON,
    ),
  ],
);

final graphQLSpecifiedByDirective = GraphQLDirective(
  name: 'specifiedBy',
  description: 'Exposes a URL that specifies the behaviour of this scalar.',
  locations: [DirectiveLocation.SCALAR],
  args: [
    GraphQLFieldInput(
      'url',
      graphQLString.nonNull(),
      description: 'The URL that specifies the behaviour of this scalar.',
    ),
  ],
);
