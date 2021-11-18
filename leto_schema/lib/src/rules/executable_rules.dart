import 'package:leto_schema/src/utilities/collect_fields.dart'
    show fragmentsFromDocument;

import 'rules_prelude.dart';

const _executableDefinitionsSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Executable-Definitions',
  code: 'executableDefinitions',
);

/// Executable definitions
///
/// A GraphQL document is only valid for execution if all definitions are either
/// operation or fragment definitions.
///
/// See https://spec.graphql.org/draft/#sec-Executable-Definitions
Visitor executableDefinitionsRule(
  SDLValidationCtx ctx, // ASTValidationContext
) =>
    ExecutableDefinitionsRule();

class ExecutableDefinitionsRule extends SimpleVisitor<List<GraphQLError>> {
  @override
  List<GraphQLError>? visitDocumentNode(DocumentNode node) {
    final nonExecutable = node.definitions.where(
      (element) => element is! ExecutableDefinitionNode,
    );
    return nonExecutable.map((e) {
      final nameNode = e.nameNode;
      final _str = nameNode == null
          ? e is SchemaDefinitionNode || e is SchemaExtensionNode
              ? 'schema'
              : '$e'
          : '"${nameNode.value}"';
      return GraphQLError(
        'The $_str definition is not executable.',
        // TODO: get the span from schema nodes
        locations: GraphQLErrorLocation.firstFromNodes([
          e,
          nameNode,
          if (e is SchemaDefinitionNode)
            e.operationTypes.firstOrNull?.type.name,
          if (e is SchemaDefinitionNode) e.directives.firstOrNull?.name,
          if (e is SchemaExtensionNode) e.operationTypes.firstOrNull?.type.name,
          if (e is SchemaExtensionNode) e.directives.firstOrNull?.name,
        ]),
        extensions: _executableDefinitionsSpec.extensions(),
      );
    }).toList();
    // return false;
  }
}

const _uniqueOperationNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Operation-Name-Uniqueness',
  code: 'uniqueOperationNames',
);

/// Unique operation names
///
/// A GraphQL document is only valid if all
/// defined operations have unique names.
///
/// See https://spec.graphql.org/draft/#sec-Operation-Name-Uniqueness
Visitor uniqueOperationNamesRule(
  SDLValidationCtx ctx, // ASTValidationContext
) =>
    UniqueOperationNamesRule();

class UniqueOperationNamesRule extends SimpleVisitor<List<GraphQLError>> {
  final operations = <String, OperationDefinitionNode>{};

  // TODO: FragmentDefinition: () => false,

  @override
  List<GraphQLError>? visitOperationDefinitionNode(
    OperationDefinitionNode node,
  ) {
    final name = node.name?.value;
    if (name == null) {
      return null;
    }
    final prev = operations[name];
    if (prev != null) {
      return [
        GraphQLError(
          'There can be only one operation named "$name".',
          locations: [
            GraphQLErrorLocation.fromSourceLocation(prev.name!.span!.start),
            GraphQLErrorLocation.fromSourceLocation(node.name!.span!.start),
          ],
          extensions: _uniqueOperationNamesSpec.extensions(),
        )
      ];
    } else {
      operations[name] = node;
    }
    // return false;
  }
}

const _loneAnonymousOperationSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Lone-Anonymous-Operation',
  code: 'loneAnonymousOperation',
);

/// Lone anonymous operation
///
/// A GraphQL document is only valid if when it contains an anonymous operation
/// (the query short-hand) that it contains only that one operation definition.
///
/// See https://spec.graphql.org/draft/#sec-Lone-Anonymous-Operation
Visitor loneAnonymousOperationRule(
  SDLValidationCtx ctx, // ASTValidationContext
) =>
    LoneAnonymousOperationRule();

class LoneAnonymousOperationRule extends SimpleVisitor<List<GraphQLError>> {
  final operations = <String, OperationDefinitionNode>{};
  int operationCount = 0;

  @override
  List<GraphQLError>? visitDocumentNode(DocumentNode node) {
    operationCount =
        node.definitions.whereType<OperationDefinitionNode>().length;
  }

  @override
  List<GraphQLError>? visitOperationDefinitionNode(
    OperationDefinitionNode node,
  ) {
    final name = node.name?.value;
    if (name == null && operationCount > 1) {
      return [
        GraphQLError(
          'This anonymous operation must be the only defined operation.',
          locations: GraphQLErrorLocation.firstFromNodes([
            node,
            node.selectionSet,
            node.selectionSet.selections.firstOrNull,
          ]),
          extensions: _loneAnonymousOperationSpec.extensions(),
        )
      ];
    }
  }
}

const _knownTypeNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Fragment-Spread-Type-Existence',
  code: 'knownTypeNames',
);

/// Known type names
///
/// A GraphQL document is only valid if referenced types (specifically
/// variable definitions and fragment conditions) are defined
/// by the type schema.
///
/// See https://spec.graphql.org/draft/#sec-Fragment-Spread-Type-Existence
Visitor knownTypeNamesRule(SDLValidationCtx ctx) {
  final typeNames = <String>{};
  final schema = ctx.schema;
  if (schema != null) {
    typeNames.addAll(schema.typeMap.keys);
  }
  for (final def in ctx.document.definitions.whereType<TypeDefinitionNode>()) {
    typeNames.add(def.name.value);
  }

  final visitor = TypedVisitor();

  visitor.add<NamedTypeNode>((NamedTypeNode node) {
    final name = node.name.value;
    if (!typeNames.contains(name)) {
      final ancestors = visitor.ancestors();
      // TODO: check ancestors usage
      final definitionNode =
          ancestors.length > 1 ? ancestors[1] : ancestors[ancestors.length - 1];
      final isSDL = definitionNode is TypeSystemDefinitionNode ||
          definitionNode is TypeSystemExtensionNode;
      if (isSDL &&
          (introspectionTypeNames.contains(name) ||
              specifiedScalarNames.contains(name))) {
        return null;
      }
      ctx.reportError(GraphQLError(
        'Unknown type "$name".',
        locations: GraphQLErrorLocation.listFromSource(node.name.span?.start),
        extensions: _knownTypeNamesSpec.extensions(),
      ));
    }
  });
  return visitor;
}

const _fragmentsOnCompositeTypesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Fragments-On-Composite-Types',
  code: 'fragmentsOnCompositeTypes',
);

/// Fragments on composite type
///
/// Fragments use a type condition to determine if they apply, since fragments
/// can only be spread into a composite type (object, interface, or union), the
/// type condition must also be a composite type.
///
/// See https://spec.graphql.org/draft/#sec-Fragments-On-Composite-Types
Visitor fragmentsOnCompositeTypesRule(ValidationCtx ctx) =>
    FragmentsOnCompositeTypesRule(ctx.schema);

class FragmentsOnCompositeTypesRule extends SimpleVisitor<List<GraphQLError>> {
  final GraphQLSchema schema;

  FragmentsOnCompositeTypesRule(this.schema);

  @override
  List<GraphQLError>? visitInlineFragmentNode(InlineFragmentNode node) {
    return validate(node.typeCondition, null);
  }

  @override
  List<GraphQLError>? visitFragmentDefinitionNode(FragmentDefinitionNode node) {
    return validate(node.typeCondition, node.name.value);
  }

  /// Execute the validation
  List<GraphQLError>? validate(TypeConditionNode? typeCondition, String? name) {
    if (typeCondition != null) {
      final type = convertTypeOrNull(typeCondition.on, schema.typeMap);
      if (type != null &&
          type is! GraphQLUnionType &&
          type is! GraphQLObjectType) {
        return [
          GraphQLError(
            'Fragment${name == null ? '' : ' "$name"'} cannot condition'
            ' on non composite type "$type".',
            locations: GraphQLErrorLocation.listFromSource(
              typeCondition.span?.start ?? typeCondition.on.name.span?.start,
            ),
            extensions: _fragmentsOnCompositeTypesSpec.extensions(),
          )
        ];
      }
    }
  }
}

const _variablesAreInputTypesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Variables-Are-Input-Types',
  code: 'variablesAreInputTypes',
);

/// Variables are input types
///
/// A GraphQL operation is only valid if all the variables it defines are of
/// input types (scalar, enum, or input object).
///
/// See https://spec.graphql.org/draft/#sec-Variables-Are-Input-Types
Visitor variablesAreInputTypesRule(ValidationCtx ctx) =>
    VariablesAreInputTypesRule(ctx.schema);

class VariablesAreInputTypesRule extends SimpleVisitor<List<GraphQLError>> {
  final GraphQLSchema schema;

  VariablesAreInputTypesRule(this.schema);

  @override
  List<GraphQLError>? visitVariableDefinitionNode(VariableDefinitionNode node) {
    final type = convertTypeOrNull(node.type, schema.typeMap);

    if (type != null && !isInputType(type)) {
      return [
        GraphQLError(
          'Variable "\$${node.variable.name.value}" cannot'
          ' be non-input type "$type".',
          locations: GraphQLErrorLocation.listFromSource(
            node.span?.start ??
                node.type.span?.start ??
                node.variable.span?.start ??
                node.variable.name.span?.start,
          ),
          extensions: _variablesAreInputTypesSpec.extensions(),
        )
      ];
    }
  }
}

const _uniqueFragmentNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Fragment-Name-Uniqueness',
  code: 'uniqueFragmentNames',
);

/// Unique fragment names
///
/// A GraphQL document is only valid if all defined fragments have unique names.
///
/// See https://spec.graphql.org/draft/#sec-Fragment-Name-Uniqueness
Visitor uniqueFragmentNamesRule(
  SDLValidationCtx ctx, // ASTValidationContext
) {
  final fragments = <String, FragmentDefinitionNode>{};

  return TypedVisitor()
    ..add<OperationDefinitionNode>((_) => VisitBehavior.skipTree)
    ..add<FragmentDefinitionNode>((node) {
      final name = node.name.value;
      final prev = fragments[name];
      if (prev != null) {
        ctx.reportError(GraphQLError(
          'There can be only one fragment named "$name".',
          locations: [
            GraphQLErrorLocation.fromSourceLocation(prev.name.span!.start),
            GraphQLErrorLocation.fromSourceLocation(node.name.span!.start),
          ],
          extensions: _uniqueFragmentNamesSpec.extensions(),
        ));
      } else {
        fragments[name] = node;
      }
      return VisitBehavior.skipTree;
    });
}

const _knownFragmentNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Fragment-spread-target-defined',
  code: 'knownFragmentNames',
);

/// Known fragment names
///
/// A GraphQL document is only valid if all `...Fragment` fragment spreads refer
/// to fragments defined in the same document.
///
/// See https://spec.graphql.org/draft/#sec-Fragment-spread-target-defined
Visitor knownFragmentNamesRule(ValidationCtx ctx) => KnownFragmentNamesRule();

class KnownFragmentNamesRule extends SimpleVisitor<List<GraphQLError>> {
  late final Map<String, FragmentDefinitionNode> fragments;
  @override
  List<GraphQLError>? visitDocumentNode(DocumentNode node) {
    fragments = fragmentsFromDocument(node);
  }

  @override
  List<GraphQLError>? visitFragmentSpreadNode(FragmentSpreadNode node) {
    final found = fragments.containsKey(node.name.value);
    if (!found) {
      return [
        GraphQLError(
          'Unknown fragment "${node.name.value}".',
          locations: GraphQLErrorLocation.listFromSource(
            node.span?.start ?? node.name.span?.start,
          ),
          extensions: _knownFragmentNamesSpec.extensions(),
        )
      ];
    }
  }
}

const _noUnusedFragmentsSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Fragments-Must-Be-Used',
  code: 'noUnusedFragments',
);

/// No unused fragments
///
/// A GraphQL document is only valid if all fragment definitions are spread
/// within operations, or spread within other fragments spread within
/// operations.
///
/// See https://spec.graphql.org/draft/#sec-Fragments-Must-Be-Used
Visitor noUnusedFragmentsRule(
  SDLValidationCtx context, // ASTValidationContext
) {
  final visitor = TypedVisitor();
  final operationDefs = <OperationDefinitionNode>[];
  final fragmentDefs = <FragmentDefinitionNode>[];

  visitor.add<OperationDefinitionNode>((node) {
    operationDefs.add(node);
    return VisitBehavior.skipTree;
  });

  visitor.add<FragmentDefinitionNode>((node) {
    fragmentDefs.add(node);
    return VisitBehavior.skipTree;
  });
  visitor.add<DocumentNode>(
    (_) {},
    leave: (_) {
      final fragmentNameUsed = <String>{};
      for (final operation in operationDefs) {
        for (final fragment in context.getRecursivelyReferencedFragments(
          operation,
        )) {
          fragmentNameUsed.add(fragment.name.value);
        }
      }

      for (final fragmentDef in fragmentDefs) {
        final fragName = fragmentDef.name.value;
        if (!fragmentNameUsed.contains(fragName)) {
          context.reportError(
            GraphQLError(
              'Fragment "${fragName}" is never used.',
              locations: GraphQLErrorLocation.firstFromNodes(
                  [fragmentDef, fragmentDef.name]),
              extensions: _noUnusedFragmentsSpec.extensions(),
            ),
          );
        }
      }
    },
  );

  return visitor;
}

const _fieldsOnCorrectTypeSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Field-Selections',
  code: 'fieldsOnCorrectType',
);

/// Fields on correct type
///
/// A GraphQL document is only valid if all fields selected are defined by the
/// parent type, or are an allowed meta field such as __typename.
///
/// See https://spec.graphql.org/draft/#sec-Field-Selections
TypedVisitor fieldsOnCorrectTypeRule(ValidationCtx context) {
  final visitor = TypedVisitor();
  final typeInfo = context.typeInfo;

  visitor.add<FieldNode>((node) {
    final type = typeInfo.getParentType();
    if (type != null) {
      final fieldDef = typeInfo.getFieldDef();
      if (fieldDef == null) {
        // This field doesn't exist, lets look for suggestions.
        // final schema = context.schema;
        final fieldName = node.name.value;

        // // First determine if there are any suggested types to condition on.
        // var suggestion = didYouMean(
        //   'to use an inline fragment on',
        //   getSuggestedTypeNames(schema, type, fieldName),
        // );

        // // If there are no suggested types, then perhaps this was a typo?
        // if (suggestion == '') {
        //   suggestion = didYouMean(getSuggestedFieldNames(type, fieldName));
        // }

        // Report an error, including helpful suggestions.
        context.reportError(
          GraphQLError(
            'Cannot query field "$fieldName" on type "${type.name}".',
            locations: GraphQLErrorLocation.listFromSource(
              node.span?.start ?? node.name.span?.start,
            ),
            extensions: _fieldsOnCorrectTypeSpec.extensions(),
          ),
        );
      }
    }
  });

  return visitor;
}
