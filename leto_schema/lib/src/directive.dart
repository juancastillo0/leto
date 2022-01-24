// ignore_for_file: constant_identifier_names
part of leto_schema.src.schema;

/// Provides documentation, information or functionalities over
/// different aspects of a GraphQL parsing, validation, execution or
/// interpretation of a [GraphQLSchema]
class GraphQLDirective implements GraphQLElement {
  /// The name of this directive, should be unique
  @override
  final String name;

  /// Provides documentation for this directive
  @override
  final String? description;

  /// The places the a GraphQL document where this
  /// directive can be used
  final List<DirectiveLocation> locations;

  /// The input arguments for this directive
  final List<GraphQLFieldInput> inputs = [];

  /// Whether this directive can be applied multiple types
  final bool isRepeatable;

  @override
  final GraphQLAttachments attachments;

  @override
  final DirectiveDefinitionNode? astNode;

  /// Default GraphQL directive definition constructor
  GraphQLDirective({
    required this.name,
    this.description,
    required this.locations,
    List<GraphQLFieldInput> inputs = const [],
    this.isRepeatable = false,
    this.attachments = const [],
    this.astNode,
  }) {
    this.inputs.addAll(inputs);
  }

  /// Default GraphQL directives
  static final specifiedDirectives = [
    graphQLIncludeDirective,
    graphQLSkipDirective,
    graphQLDeprecatedDirective,
    graphQLSpecifiedByDirective,
    graphQLOneOfDirective,
  ];
}

/// The position within the schema where a given directive can be
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

/// Whether the [directive] is one of the default
/// [GraphQLDirective.specifiedDirectives]
bool isSpecifiedDirective(GraphQLDirective directive) {
  return GraphQLDirective.specifiedDirectives
      .map((e) => e.name)
      .contains(directive.name);
}

/// Returns the directives applied to a given GraphQL [element]
@experimental
Iterable<DirectiveNode> getDirectivesFromElement(GraphQLElement element) {
  final _fromAttachments = getDirectivesFromAttachments(element.attachments);
  if (element is GraphQLNamedType) {
    return element.extra.directives();
  } else if (element is GraphQLObjectField) {
    return (element.astNode?.directives ?? []).followedBy(_fromAttachments);
  } else if (element is GraphQLFieldInput) {
    return (element.astNode?.directives ?? []).followedBy(_fromAttachments);
  } else if (element is GraphQLEnumValue) {
    return (element.astNode?.directives ?? []).followedBy(_fromAttachments);
  } else {
    return [];
  }
}

Iterable<DirectiveNode> getDirectivesFromAttachments(
  GraphQLAttachments attachments,
) {
  return attachments.whereType<DirectiveNode>().followedBy(
        attachments.whereType<ToDirectiveValue>().map((e) => e.directiveValue),
      );
}

/// The implementors of this class specify that the instances represent
/// a GraphQL directive. Can be used in GraphQLElement's attachments so that
/// the directives are present in the schema.
///
/// An example can be found on [ElementComplexity].
abstract class ToDirectiveValue {
  /// The directive value represented by this object
  DirectiveNode get directiveValue;

  /// The directive definition of the [directiveValue]
  GraphQLDirective get directiveDefinition;
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
    GraphQLFieldInput<bool, bool>(
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
    GraphQLFieldInput<bool, bool>(
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
    GraphQLFieldInput<String, String>(
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
    GraphQLFieldInput<String, String>(
      'url',
      graphQLString.nonNull(),
      description: 'The URL that specifies the behaviour of this scalar.',
    ),
  ],
);

final graphQLOneOfDirective = GraphQLDirective(
  name: 'oneOf',
  description:
      'Specifies that an input can only have one of the input object fields.'
      ' All fields should be nullable and have no default value.'
      ' For an input value of the annotate type to be valid, exactly'
      ' one of the provided fields should be present and non-null.',
  locations: [DirectiveLocation.INPUT_OBJECT],
  isRepeatable: false,
);
