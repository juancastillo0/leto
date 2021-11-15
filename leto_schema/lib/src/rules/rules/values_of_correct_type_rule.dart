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
  visitor.add<ListValueNode>((node) {
    // Note: TypeInfo will traverse into a list's item type, so look to the
    // parent input type to check if it is a list.
    final type = context.typeInfo.getParentInputType()?.nullable();
    if (type is! GraphQLListType) {
      isValidValueNode(context, node);
      // return false; // Don't traverse further.
      return;
    }
  });
  visitor.add<ObjectValueNode>((node) {
    final type = getNamedType(context.typeInfo.getInputType());
    if (type is! GraphQLInputObjectType) {
      isValidValueNode(context, node);
      // return false; // Don't traverse further.
      return;
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
  visitor.add<EnumValueNode>((node) => isValidValueNode(context, node));
  visitor.add<IntValueNode>((node) => isValidValueNode(context, node));
  visitor.add<FloatValueNode>((node) => isValidValueNode(context, node));
  visitor.add<StringValueNode>((node) => isValidValueNode(context, node));
  visitor.add<BooleanValueNode>((node) => isValidValueNode(context, node));
  return visitor;
}

/// Any value literal may be a valid representation of a Scalar, depending on
/// that scalar type.
void isValidValueNode(ValidationCtx context, ValueNode node) {
  // Report any error at the full type expected by the location.
  final locationType = context.typeInfo.getInputType();
  if (locationType == null) {
    return;
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
    return;
  }

  // Scalars and Enums determine if a literal value is valid via parseLiteral(),
  // which may throw or return an invalid value to indicate failure.
  try {
    // final parseResult = type.parseLiteral(node, undefined /* variables */);
    final value = valueFromAst(null, node, null /* variables */);
    final validation = type.validate('key', value);
    if (!validation.successful) {
      final typeStr = inspect(locationType);
      context.reportError(
        GraphQLError(
          'Expected value of type "${typeStr}", found ${printNode(node)}.'
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
          'Expected value of type "${typeStr}", found ${printNode(node)}; ' +
              error.toString(),
          locations: GraphQLErrorLocation.firstFromNodes([node]),
          sourceError:
              error, // Ensure a reference to the original error is maintained.
          stackTrace: stackTrace,
          extensions: _valuesOfCorrectTypeSpec.extensions(),
        ),
      );
    }
  }
}
