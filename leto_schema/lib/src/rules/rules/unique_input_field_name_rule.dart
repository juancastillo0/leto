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
  ValidationCtx context, // ASTValidationContext
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
      invariant(prevKnownNames);
      knownNames = prevKnownNames;
    },
  );
  visitor.add<ObjectFieldNode>((node) {
    final fieldName = node.name.value;
    if (knownNames[fieldName] != null) {
      context.reportError(
        GraphQLError(
          'There can be only one input field named "${fieldName}".',
          [knownNames[fieldName], node.name],
          extensions: _uniqueInputFieldNamesSpec.extensions(),
        ),
      );
    } else {
      knownNames[fieldName] = node.name;
    }
  });
  return visitor;
}
