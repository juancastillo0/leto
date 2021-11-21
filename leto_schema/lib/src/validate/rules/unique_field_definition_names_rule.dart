import '../rules_prelude.dart';

const _uniqueFieldDefinitionNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Object-Extensions',
  code: 'uniqueFieldDefinitionNames',
);

/// Unique field definition names
///
/// A GraphQL complex type is only valid if all its fields are uniquely named.
///
/// See https://spec.graphql.org/draft/#sec-Object-Extensions
/// See https://spec.graphql.org/draft/#sec-Input-Object-Extensions
Visitor uniqueFieldDefinitionNamesRule(
  SDLValidationCtx context,
) {
  final schema = context.schema;
  final Map<String, GraphQLType> existingTypeMap =
      schema != null ? schema.typeMap : {};
  final knownFieldNames = <String, Map<String, NameNode>>{};

  VisitBehavior? checkFieldUniqueness(
    NameNode name,
    Iterable<NameNode> fieldNodes, // | FieldDefinitionNode
  ) {
    final typeName = name.value;
    final fieldNames = knownFieldNames.putIfAbsent(typeName, () => {});

    for (final fieldDefNameNode in fieldNodes) {
      final fieldName = fieldDefNameNode.value;

      if (_hasField(existingTypeMap[typeName], fieldName)) {
        context.reportError(
          GraphQLError(
            'Field "${typeName}.${fieldName}" already exists in the schema.'
            ' It cannot also be defined in this type extension.',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(
                  fieldDefNameNode.span!.start),
            ],
            extensions: _uniqueFieldDefinitionNamesSpec.extensions(),
          ),
        );
      } else if (fieldNames[fieldName] != null) {
        context.reportError(
          GraphQLError(
            'Field "${typeName}.${fieldName}" can only be defined once.',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(
                  fieldNames[fieldName]!.span!.start),
              GraphQLErrorLocation.fromSourceLocation(
                  fieldDefNameNode.span!.start),
            ],
            extensions: _uniqueFieldDefinitionNamesSpec.extensions(),
          ),
        );
      } else {
        fieldNames[fieldName] = fieldDefNameNode;
      }
    }

    return VisitBehavior.skipTree;
  }

  final visitor = TypedVisitor();

  visitor.add<InputObjectTypeDefinitionNode>((node) =>
      checkFieldUniqueness(node.name, node.fields.map((e) => e.name)));
  visitor.add<InputObjectTypeExtensionNode>((node) =>
      checkFieldUniqueness(node.name, node.fields.map((e) => e.name)));
  visitor.add<InterfaceTypeDefinitionNode>((node) =>
      checkFieldUniqueness(node.name, node.fields.map((e) => e.name)));
  visitor.add<InterfaceTypeExtensionNode>((node) =>
      checkFieldUniqueness(node.name, node.fields.map((e) => e.name)));
  visitor.add<ObjectTypeDefinitionNode>((node) =>
      checkFieldUniqueness(node.name, node.fields.map((e) => e.name)));
  visitor.add<ObjectTypeExtensionNode>((node) =>
      checkFieldUniqueness(node.name, node.fields.map((e) => e.name)));

  return visitor;
}

bool _hasField(GraphQLType? type, String fieldName) {
  if (type is GraphQLObjectType) {
    return type.fieldByName(fieldName) != null;
  } else if (type is GraphQLInputObjectType) {
    return type.fieldByName(fieldName) != null;
  }
  return false;
}
