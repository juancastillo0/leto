import 'package:gql/ast.dart' hide DirectiveLocation;
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/ast_node_enum.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/utilities/build_schema.dart';
import 'package:leto_schema/validate.dart';

/// Known directives
///
/// A GraphQL document is only valid if all `@directives` are known by the
/// schema and legally positioned.
///
/// See https://spec.graphql.org/draft/#sec-Directives-Are-Defined
Visitor knownDirectivesRule(
  ValidationCtx context, //| SDLValidationContext,
) {
  final visitor = TypedVisitor();
  final locationsMap = <String, List<DirectiveLocation>>{};

  final schema = context.schema;
  final definedDirectives =
      schema != null ? schema.directives : GraphQLDirective.specifiedDirectives;
  for (final directive in definedDirectives) {
    locationsMap[directive.name] = directive.locations;
  }

  final astDefinitions = context.document.definitions;
  for (final def in astDefinitions.whereType<DirectiveDefinitionNode>()) {
    locationsMap[def.name.value] =
        def.locations.map(mapDirectiveLocation).toList();
  }

  visitor.add<DirectiveNode>((node) {
    final name = node.name.value;
    final locations = locationsMap[name];

    if (locations == null) {
      context.reportError(
        GraphQLError('Unknown directive "@${name}".', node),
      );
      return;
    }

    final candidateLocation = getDirectiveLocationForASTPath(ancestors);
    if (candidateLocation != null && !locations.contains(candidateLocation)) {
      context.reportError(
        GraphQLError(
          'Directive "@${name}" may not be used on ${candidateLocation}.',
          node,
        ),
      );
    }
  });

  return visitor;
}

DirectiveLocation getDirectiveLocationForASTPath(
  List<Node> ancestors, // Array<ASTNode | ReadonlyArray<ASTNode>>
) {
  final appliedTo = ancestors[ancestors.length - 1];
  // invariant('kind' in appliedTo);

  switch (appliedTo.kind) {
    case Kind.OperationDefinition:
      return getDirectiveLocationForOperation(
          (appliedTo as OperationDefinitionNode).type);
    case Kind.Field:
      return DirectiveLocation.FIELD;
    case Kind.FragmentDefinition:
      return DirectiveLocation.FRAGMENT_SPREAD;
    case Kind.InlineFragment:
      return DirectiveLocation.INLINE_FRAGMENT;
    case Kind.FragmentDefinition:
      return DirectiveLocation.FRAGMENT_DEFINITION;
    case Kind.VariableDefinition:
      return DirectiveLocation.VARIABLE_DEFINITION;
    case Kind.SchemaDefinition:
    case Kind.SchemaExtension:
      return DirectiveLocation.SCHEMA;
    case Kind.ScalarTypeDefinition:
    case Kind.ScalarTypeExtension:
      return DirectiveLocation.SCALAR;
    case Kind.ObjectTypeDefinition:
    case Kind.ObjectTypeExtension:
      return DirectiveLocation.OBJECT;
    case Kind.FieldDefinition:
      return DirectiveLocation.FIELD_DEFINITION;
    case Kind.InterfaceTypeDefinition:
    case Kind.InterfaceTypeExtension:
      return DirectiveLocation.INTERFACE;
    case Kind.UnionTypeDefinition:
    case Kind.UnionTypeExtension:
      return DirectiveLocation.UNION;
    case Kind.EnumTypeDefinition:
    case Kind.EnumTypeExtension:
      return DirectiveLocation.ENUM;
    case Kind.EnumValueDefinition:
      return DirectiveLocation.ENUM_VALUE;
    case Kind.InputObjectTypeDefinition:
    case Kind.InputObjectTypeExtension:
      return DirectiveLocation.INPUT_OBJECT;
    case Kind.InputValueDefinition:
      {
        final parentNode = ancestors[ancestors.length - 3];
        // invariant('kind' in parentNode);
        return parentNode.kind == Kind.InputObjectTypeDefinition
            ? DirectiveLocation.INPUT_FIELD_DEFINITION
            : DirectiveLocation.ARGUMENT_DEFINITION;
      }
  }
}

DirectiveLocation getDirectiveLocationForOperation(
  OperationType operation,
) {
  switch (operation) {
    case OperationType.query:
      return DirectiveLocation.QUERY;
    case OperationType.mutation:
      return DirectiveLocation.MUTATION;
    case OperationType.subscription:
      return DirectiveLocation.SUBSCRIPTION;
  }
}
