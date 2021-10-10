import 'package:collection/collection.dart' show IterableExtension;
import 'package:gql/ast.dart';
import 'package:graphql_schema/graphql_schema.dart';

Object? computeValue(
  GraphQLType? targetType,
  ValueNode node,
  Map<String, dynamic>? values,
) =>
    node.accept(GraphQLValueComputer(targetType, values));

class GraphQLValueComputer extends SimpleVisitor<Object> {
  final GraphQLType? targetType;
  final Map<String, dynamic>? variableValues;

  GraphQLValueComputer(this.targetType, this.variableValues);

  @override
  Object visitBooleanValueNode(BooleanValueNode node) => node.value;

  @override
  Object? visitEnumValueNode(EnumValueNode node) {
    final span = (node.span ?? node.name.span)!;
    final _targetType = targetType?.whenOrNull(nonNullable: (v) => v.ofType) ??
        targetType?.realType;

    if (_targetType == null) {
      throw GraphQLException.fromSourceSpan(
        'An enum value was given, but in this context,'
        ' its type cannot be deduced.',
        span,
      );
    } else if (_targetType is! GraphQLEnumType) {
      throw GraphQLException.fromSourceSpan(
          'An enum value (${node.name.value}) was given, but the expected type'
          ' "$targetType" is not an enum.',
          span);
    } else {
      final matchingValue =
          _targetType.values.firstWhereOrNull((v) => v.name == node.name.value);
      if (matchingValue == null) {
        throw GraphQLException.fromSourceSpan(
          'The enum "$_targetType" has no'
          ' member named "${node.name.value}".',
          span,
        );
      } else {
        return matchingValue.name;
      }
    }
  }

  @override
  Object visitFloatValueNode(FloatValueNode node) => double.parse(node.value);

  @override
  Object visitIntValueNode(IntValueNode node) => int.parse(node.value);

  @override
  Object visitListValueNode(ListValueNode node) {
    return node.values.map((v) => v.accept(this)).toList();
  }

  @override
  Object visitObjectValueNode(ObjectValueNode node) {
    return Map.fromEntries(node.fields.map((f) {
      return MapEntry(f.name.value, f.value.accept(this));
    }));
  }

  @override
  Object? visitNullValueNode(NullValueNode node) => null;

  @override
  Object visitStringValueNode(StringValueNode node) => node.value;

  @override
  Object? visitVariableNode(VariableNode node) =>
      variableValues?[node.name.value];
}

Object? getDirectiveValue(
  String name,
  String argumentName,
  List<DirectiveNode> directives,
  Map<String, dynamic>? variableValues,
) {
  final directive = directives.firstWhereOrNull(
    (d) => d.arguments.isNotEmpty && d.name.value == name,
  );
  if (directive == null) return null;

  final argument = directive.arguments.firstWhereOrNull(
    (arg) => arg.name.value == argumentName,
  );
  if (argument == null) return null;

  final value = argument.value;
  if (value is VariableNode) {
    final vname = value.name.value;
    if (variableValues == null || !variableValues.containsKey(vname)) {
      throw GraphQLException.fromSourceSpan(
        'Unknown variable: "$vname"',
        (value.span ?? value.name.span ?? argument.span ?? argument.name.span)!,
      );
    }
    return variableValues[vname];
  }
  return computeValue(null, value, variableValues);
}

GraphQLType convertType(
  TypeNode node,
  Iterable<GraphQLType> customTypes,
) {
  GraphQLType _type() {
    if (node is ListTypeNode) {
      return GraphQLListType<Object, Object>(
        convertType(node.type, customTypes),
      );
    } else if (node is NamedTypeNode) {
      switch (node.name.value) {
        case 'Int':
          return graphQLInt;
        case 'Float':
          return graphQLFloat;
        case 'String':
          return graphQLString;
        case 'Boolean':
          return graphQLBoolean;
        case 'ID':
          return graphQLId;
        case 'Date':
        case 'DateTime':
          return graphQLDate;
        default:
          return customTypes.firstWhere(
            (t) => t.name == node.name.value,
            orElse: () => throw GraphQLError(
              'Unknown GraphQL type: "${node.name.value}".',
              locations: GraphQLErrorLocation.listFromSource(
                node.span?.start ?? node.name.span?.start,
              ),
            ),
          );
      }
    } else {
      throw ArgumentError('Invalid GraphQL type: "${node.span!.text}"');
    }
  }

  if (node.isNonNull) {
    return _type().nonNull();
  }
  return _type();
}
