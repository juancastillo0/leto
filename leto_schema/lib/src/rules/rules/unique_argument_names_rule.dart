import 'package:collection/collection.dart';
import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/validate.dart';

/// Unique argument names
///
/// A GraphQL field or directive is only valid if all supplied arguments are
/// uniquely named.
///
/// See https://spec.graphql.org/draft/#sec-Argument-Names
Visitor uniqueArgumentNamesRule(
  ValidationCtx context, // ASTValidationContext,
) {
  final visitor = TypedVisitor();

  void checkArgUniqueness(List<ArgumentNode> argumentNodes) {
    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    // final argumentNodes = arguments ?? [];

    final seenArgs = argumentNodes.groupListsBy((arg) => arg.name.value);

    for (final entry in seenArgs.entries) {
      if (entry.value.length > 1) {
        context.reportError(
          GraphQLError(
            'There can be only one argument named "${entry.key}".',
            locations: List.of(entry.value
                .map((node) => node.name.span!.start)
                .map((e) => GraphQLErrorLocation.fromSourceLocation(e))),
          ),
        );
      }
    }
  }

  visitor.add<FieldNode>((node) => checkArgUniqueness(node.arguments));
  visitor.add<DirectiveNode>((node) => checkArgUniqueness(node.arguments));
  return visitor;
}
