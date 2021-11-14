import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/rules/validate.dart';
import 'package:leto_schema/validate.dart';

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
        ),
      );
    } else {
      knownNames[fieldName] = node.name;
    }
  });
  return visitor;
}
