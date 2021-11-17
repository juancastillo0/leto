import '../rules_prelude.dart';

const _possibleTypeExtensionsSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Schema',
  code: 'possibleTypeExtensions',
);

/// Possible type extension
///
/// A type extension is only valid if the type is defined and has the same kind.
///
/// See https://spec.graphql.org/draft/#sec-Schema
Visitor possibleTypeExtensionsRule(
  SDLValidationCtx context,
) {
  final schema = context.schema;
  final definedTypes = <String, DefinitionNode>{};

  for (final def
      in context.document.definitions.whereType<TypeDefinitionNode>()) {
    definedTypes[def.name.value] = def;
  }

  VisitBehavior? checkExtension(TypeExtensionNode node) {
    final typeName = node.name.value;
    final defNode = definedTypes[typeName];
    final existingType = schema?.getType(typeName);

    Kind? expectedKind;
    if (defNode != null) {
      expectedKind = defKindToExtKind[defNode.kind];
    } else if (existingType != null) {
      expectedKind = typeToExtKind(existingType);
    }

    if (expectedKind != null) {
      if (expectedKind != node.kind) {
        final kindStr = extensionKindToTypeName(node.kind);
        context.reportError(
          GraphQLError(
            'Cannot extend non-${kindStr} type "${typeName}".',
            locations: [
              ...GraphQLErrorLocation.firstFromNodes([defNode]),
              GraphQLErrorLocation.fromSourceLocation(node.name.span!.start),
            ],
            extensions: _possibleTypeExtensionsSpec.extensions(),
          ),
        );
      }
    } else {
      // final allTypeNames = {
      //   ...definedTypes,
      //   if (schema != null) ...schema.typeMap,
      // };

      // final suggestedTypes = suggestionList(typeName, allTypeNames);
      context.reportError(
        GraphQLError(
          'Cannot extend type "${typeName}" because it is not defined.'
          // + didYouMean(suggestedTypes)
          ,
          locations: GraphQLErrorLocation.firstFromNodes([node.name]),
          extensions: _possibleTypeExtensionsSpec.extensions(),
        ),
      );
    }
  }

  final visitor = TypedVisitor();

  visitor.add<ScalarTypeExtensionNode>(checkExtension);
  visitor.add<ObjectTypeExtensionNode>(checkExtension);
  visitor.add<InterfaceTypeExtensionNode>(checkExtension);
  visitor.add<UnionTypeExtensionNode>(checkExtension);
  visitor.add<EnumTypeExtensionNode>(checkExtension);
  visitor.add<InputObjectTypeExtensionNode>(checkExtension);

  return visitor;
}

/// A map from type definition to type extension node kind
const defKindToExtKind = {
  Kind.ScalarTypeDefinition: Kind.ScalarTypeExtension,
  Kind.ObjectTypeDefinition: Kind.ObjectTypeExtension,
  Kind.InterfaceTypeDefinition: Kind.InterfaceTypeExtension,
  Kind.UnionTypeDefinition: Kind.UnionTypeExtension,
  Kind.EnumTypeDefinition: Kind.EnumTypeExtension,
  Kind.InputObjectTypeDefinition: Kind.InputObjectTypeExtension,
};

/// Returns the extension [Kind] for a given named [GraphQLType]
Kind typeToExtKind(GraphQLType type) {
  return type.when(
    enum_: (type) => Kind.EnumTypeExtension,
    scalar: (type) => Kind.ScalarTypeExtension,
    object: (type) => type.isInterface
        ? Kind.InterfaceTypeExtension
        : Kind.ObjectTypeExtension,
    input: (type) => Kind.InputObjectTypeExtension,
    union: (type) => Kind.UnionTypeExtension,
    list: (type) => throw Error(),
    nonNullable: (type) => throw Error(),
  );

  // istanbul ignore next (Not reachable.
  // All possible types have been considered)
  // assert(false, 'Unexpected type: ' + inspect(type));
}

/// Returns a user facing name for a given type extension node [kind]
String extensionKindToTypeName(Kind kind) {
  switch (kind) {
    case Kind.ScalarTypeExtension:
      return 'scalar';
    case Kind.ObjectTypeExtension:
      return 'object';
    case Kind.InterfaceTypeExtension:
      return 'interface';
    case Kind.UnionTypeExtension:
      return 'union';
    case Kind.EnumTypeExtension:
      return 'enum';
    case Kind.InputObjectTypeExtension:
      return 'input object';
    default:
      // istanbul ignore next (Not reachable.
      // All possible types have been considered)
      assert(false, 'Unexpected kind: $kind');
      return '';
  }
}
