import '../rules_prelude.dart';

const _implementInterfaceOnceSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Interfaces',
  code: 'implementInterfaceOnce',
);

/// Implement interface once
///
/// A GraphQL Object or Interface can only implement an Interface once.
///
/// See https://spec.graphql.org/draft/#sec-Interfaces
Visitor implementInterfaceOnceRule(
  SDLValidationCtx context,
) {
  final visitor = TypedVisitor();

  final _schema = context.schema;
  final allSeenInterfaces = Map<String, Set<String>>.fromEntries(
    _schema != null
        ? _schema.allTypes.whereType<GraphQLObjectType>().map((e) {
            final types = e.interfaces.map((e) => e.name).toSet();
            return MapEntry(e.name, types);
          })
        : [],
  );

  VisitBehavior? checkInterfaceUniqueness(
    NameNode nameNode,
    List<NamedTypeNode> interfaceNodes,
  ) {
    final seenInterfaces = allSeenInterfaces.putIfAbsent(
      nameNode.value,
      () => {},
    );

    for (final entry in interfaceNodes) {
      final _name = entry.name.value;
      if (seenInterfaces.contains(_name)) {
        context.reportError(
          GraphQLError(
            'Type ${nameNode.value} can only implement $_name once.',
            locations: [
              GraphQLErrorLocation.fromSourceLocation(entry.name.span!.start)
            ],
            extensions: _implementInterfaceOnceSpec.extensions(),
          ),
        );
      } else {
        seenInterfaces.add(_name);
      }
    }
  }

  visitor.add<ObjectTypeDefinitionNode>(
      (node) => checkInterfaceUniqueness(node.name, node.interfaces));
  visitor.add<ObjectTypeExtensionNode>(
      (node) => checkInterfaceUniqueness(node.name, node.interfaces));
  visitor.add<InterfaceTypeDefinitionNode>(
      (node) => checkInterfaceUniqueness(node.name, node.interfaces));
  visitor.add<InterfaceTypeExtensionNode>(
      (node) => checkInterfaceUniqueness(node.name, node.interfaces));
  return visitor;
}
