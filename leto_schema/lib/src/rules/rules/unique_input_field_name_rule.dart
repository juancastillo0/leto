import '../rules_prelude.dart';

const _uniqueInputFieldNamesSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Input-Object-Field-Uniqueness',
  code: 'uniqueInputFieldNames',
);

/// Unique input field names
///
/// A GraphQL input object value is only valid if all supplied fields are
/// uniquely named.
///
/// See https://spec.graphql.org/draft/#sec-Input-Object-Field-Uniqueness
Visitor uniqueInputFieldNamesRule(
  SDLValidationCtx context, // ASTValidationContext
) {
  final visitor = TypedVisitor();
  final knownNameStack = <Map<String, NameNode>>[];
  var knownNames = <String, NameNode>{};

  visitor.add<ObjectValueNode>(
    (_) {
      knownNameStack.add(knownNames);
      knownNames = {};
    },
    leave: (_) {
      final prevKnownNames = knownNameStack.removeLast();
      knownNames = prevKnownNames;
    },
  );
  visitor.add<ObjectFieldNode>((node) {
    final fieldName = node.name.value;
    final other = knownNames[fieldName];
    if (other != null) {
      context.reportError(
        GraphQLError(
          'There can be only one input field named "${fieldName}".',
          locations: List.of(
            [other, node.name].map(
              (e) => GraphQLErrorLocation.fromSourceLocation(e.span!.start),
            ),
          ),
          extensions: _uniqueInputFieldNamesSpec.extensions(),
        ),
      );
    } else {
      knownNames[fieldName] = node.name;
    }
  });
  return visitor;
}
