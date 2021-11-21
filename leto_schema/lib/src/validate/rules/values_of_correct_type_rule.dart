import 'package:gql/language.dart';
import 'package:leto_schema/src/utilities/ast_from_value.dart';

import '../rules_prelude.dart';

const _valuesOfCorrectTypeSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Values-of-Correct-Type',
  code: 'valuesOfCorrectType',
);

/// Value literals of correct type
///
/// A GraphQL document is only valid if all value literals are of the type
/// expected at their position.
///
/// See https://spec.graphql.org/draft/#sec-Values-of-Correct-Type
Visitor valuesOfCorrectTypeRule(
  ValidationCtx context,
) {
  final visitor = TypedVisitor();
  final localCtx = _ValidationCtxWithAncestors(
    context,
    () => visitor.ancestors(),
  );
  visitor.add<ListValueNode>((node) {
    // Note: TypeInfo will traverse into a list's item type, so look to the
    // parent input type to check if it is a list.
    final type = context.typeInfo.getParentInputType()?.nullable();
    if (type is! GraphQLListType) {
      isValidValueNode(localCtx, node);
      return VisitBehavior.skipTree;
    }
  });
  visitor.add<ObjectValueNode>((node) {
    final type = getNamedType(context.typeInfo.getInputType());
    if (type is! GraphQLInputObjectType) {
      isValidValueNode(localCtx, node);
      return VisitBehavior.skipTree;
    }
    // Ensure every required field exists.
    final fieldNodeMap = node.fields
        .groupFoldBy((f) => f.name.value, (previous, f) => previous ?? f);
    for (final fieldDef in type.fields) {
      final fieldNode = fieldNodeMap[fieldDef.name];
      if (fieldNode == null && fieldDef.isRequired) {
        final typeStr = inspect(fieldDef.type);
        context.reportError(
          GraphQLError(
            'Field "${type.name}.${fieldDef.name}" of required type "${typeStr}" was not provided.',
            locations: GraphQLErrorLocation.firstFromNodes([node]),
            extensions: _valuesOfCorrectTypeSpec.extensions(),
          ),
        );
      }
    }
  });
  visitor.add<ObjectFieldNode>((node) {
    final parentType = getNamedType(context.typeInfo.getParentInputType());
    final fieldType = context.typeInfo.getInputType();
    if (fieldType == null && parentType is GraphQLInputObjectType) {
      // final suggestions = suggestionList(
      // node.name.value,
      // Object.keys(parentType.getFields()),
      // );
      context.reportError(
        GraphQLError(
          'Field "${node.name.value}" is not defined by type "${parentType.name}".'
          //  + didYouMean(suggestions)
          ,
          locations: GraphQLErrorLocation.firstFromNodes([node]),
          extensions: _valuesOfCorrectTypeSpec.extensions(),
        ),
      );
    }
  });
  visitor.add<NullValueNode>((node) {
    final type = context.typeInfo.getInputType();
    if (type is GraphQLNonNullType) {
      context.reportError(
        GraphQLError(
          'Expected value of type "${inspect(type)}", found ${printNode(node)}.',
          locations: GraphQLErrorLocation.firstFromNodes([node]),
          extensions: _valuesOfCorrectTypeSpec.extensions(),
        ),
      );
    }
  });
  visitor.add<EnumValueNode>((node) => isValidValueNode(localCtx, node));
  visitor.add<IntValueNode>((node) => isValidValueNode(localCtx, node));
  visitor.add<FloatValueNode>((node) => isValidValueNode(localCtx, node));
  visitor.add<StringValueNode>((node) => isValidValueNode(localCtx, node));
  visitor.add<BooleanValueNode>((node) => isValidValueNode(localCtx, node));
  return visitor;
}

class _ValidationCtxWithAncestors {
  final ValidationCtx context;
  final List<Node> Function() ancestors;

  _ValidationCtxWithAncestors(this.context, this.ancestors);
}

/// Any value literal may be a valid representation of a Scalar, depending on
/// that scalar type.
VisitBehavior? isValidValueNode(
  _ValidationCtxWithAncestors localCtx,
  ValueNode node,
) {
  final context = localCtx.context;
  // Report any error at the full type expected by the location.
  final locationType = context.typeInfo.getInputType();
  if (locationType == null) {
    return null;
  }

  final type = getNamedType(locationType)!;

  if (!isLeafType(type)) {
    final typeStr = inspect(locationType);
    context.reportError(
      GraphQLError(
        'Expected value of type "${typeStr}", found ${printNode(node)}.',
        locations: GraphQLErrorLocation.firstFromNodes([node]),
        extensions: _valuesOfCorrectTypeSpec.extensions(),
      ),
    );
    return null;
  }

  // Scalars and Enums determine if a literal value is valid via parseLiteral(),
  // which may throw or return an invalid value to indicate failure.
  try {
    // final parseResult = type.parseLiteral(node, undefined /* variables */);
    // TODO: we could pass type type to valueFromAst for improved error messages and spans
    final value = valueFromAst(null, node, null /* variables */);
    final validation = type.validate('key', value);
    if (!validation.successful ||
        // Don't allow string inputs as enums
        node is StringValueNode && type is GraphQLEnumType) {
      final ancestors = localCtx.ancestors();
      int _index = 1;
      Node? arg;
      while (ancestors.length > _index) {
        arg = ancestors[ancestors.length - _index];
        if (arg is ArgumentNode) break;
        _index++;
      }

      String argStr = '.';
      if (arg is ArgumentNode) {
        final field = ancestors[ancestors.length - _index - 1];
        final _field = field is FieldNode ? 'field' : 'directive';
        argStr = ' in ${arg.name.value} for $_field ${field.nameNode!.value}.';
      }

      final typeStr = inspect(locationType);
      context.reportError(
        GraphQLError(
          'Expected value of type "${typeStr}", found ${printNode(node)}$argStr'
          // TODO:
          // ' ${validation.errors.join('. ')}'
          ,
          locations: GraphQLErrorLocation.firstFromNodes([node]),
          extensions: _valuesOfCorrectTypeSpec.extensions(),
        ),
      );
    }
  } catch (error, stackTrace) {
    final typeStr = inspect(locationType);
    if (error is GraphQLError) {
      context.reportError(error);
    } else {
      context.reportError(
        GraphQLError(
          'Expected value of type "$typeStr", found ${printNode(node)}; $error',
          locations: GraphQLErrorLocation.firstFromNodes([node]),
          // Ensure a reference to the original error is maintained.
          sourceError: error,
          stackTrace: stackTrace,
          extensions: _valuesOfCorrectTypeSpec.extensions(),
        ),
      );
    }
  }
}
