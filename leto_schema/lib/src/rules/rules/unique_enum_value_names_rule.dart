import '../rules_prelude.dart';

const _uniqueEnumValueNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Enums',
  code: 'uniqueEnumValueNames',
);

/// Unique enum value names
///
/// A GraphQL enum type is only valid if all its values are uniquely named.
///
/// See https://spec.graphql.org/draft/#sec-Enums
Visitor uniqueEnumValueNamesRule(
  SDLValidationCtx context,
) {
  final schema = context.schema;
  final Map<String, GraphQLType> existingTypeMap =
      schema != null ? schema.typeMap : {};
  final knownValueNames = <String, Map<String, NameNode>>{};

  VisitBehavior? checkValueUniqueness(
    NameNode name,
    List<EnumValueDefinitionNode> valueNodes,
  ) {
    final typeName = name.value;
    final valueNames = knownValueNames.putIfAbsent(typeName, () => {});

    for (final valueDef in valueNodes) {
      final valueName = valueDef.name.value;

      final existingType = existingTypeMap[typeName];
      if (existingType is GraphQLEnumType &&
          existingType.getValue(valueName) != null) {
        context.reportError(
          GraphQLError(
            'Enum value "$typeName.$valueName" already exists in the schema.'
            ' It cannot also be defined in this type extension.',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(valueDef.name.span!.start)
            ],
            extensions: _uniqueEnumValueNamesSpec.extensions(),
          ),
        );
      } else if (valueNames[valueName] != null) {
        context.reportError(
          GraphQLError(
            'Enum value "$typeName.$valueName" can only be defined once.',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(
                valueNames[valueName]!.span!.start,
              ),
              GraphQLErrorLocation.fromSourceLocation(
                valueDef.name.span!.start,
              )
            ],
            extensions: _uniqueEnumValueNamesSpec.extensions(),
          ),
        );
      } else {
        valueNames[valueName] = valueDef.name;
      }
    }

    return VisitBehavior.skipTree;
  }

  final visitor = TypedVisitor();
  visitor.add<EnumTypeDefinitionNode>(
      (node) => checkValueUniqueness(node.name, node.values));
  visitor.add<EnumTypeExtensionNode>(
      (node) => checkValueUniqueness(node.name, node.values));

  return visitor;
}
