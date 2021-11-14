import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/rules/type_info.dart';
import 'package:leto_schema/src/rules/typed_visitor.dart';
import 'package:leto_schema/src/utilities/predicates.dart';
import 'package:leto_schema/validate.dart';

/// Possible fragment spread
///
/// A fragment spread is only valid if the type condition could ever possibly
/// be true: if there is a non-empty intersection of the possible parent types,
/// and possible types which pass the type condition.
Visitor possibleFragmentSpreadsRule(
  ValidationCtx context,
) {
  final visitor = TypedVisitor();
  final typeInfo = context.typeInfo;
  visitor.add<InlineFragmentNode>((node) {
    final fragType = typeInfo.getType();
    final parentType = typeInfo.getParentType();
    if (isCompositeType(fragType) &&
        isCompositeType(parentType) &&
        !doTypesOverlap(context.schema, fragType, parentType)) {
      final parentTypeStr = inspect(parentType);
      final fragTypeStr = inspect(fragType);
      context.reportError(
        GraphQLError(
          'Fragment cannot be spread here as objects of type "${parentTypeStr}" can never be of type "${fragTypeStr}".',
          node,
        ),
      );
    }
  });
  visitor.add<FragmentSpreadNode>((node) {
    final fragName = node.name.value;
    final fragType = getFragmentType(context, fragName);
    final parentType = typeInfo.getParentType();
    if (fragType != null &&
        parentType != null &&
        !doTypesOverlap(context.schema, fragType, parentType)) {
      final parentTypeStr = inspect(parentType);
      final fragTypeStr = inspect(fragType);
      context.reportError(
        GraphQLError(
          'Fragment "${fragName}" cannot be spread here as objects of type "${parentTypeStr}" can never be of type "${fragTypeStr}".',
          node,
        ),
      );
    }
  });
  return visitor;
}

GraphQLType? getFragmentType(
  ValidationCtx context,
  String name,
) {
  final frag = context.getFragment(name);
  if (frag != null) {
    final type = typeFromAST(context.schema, frag.typeCondition);
    if (isCompositeType(type)) {
      return type;
    }
  }
}
