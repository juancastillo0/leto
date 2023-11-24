import 'dart:math' show max;

import 'package:leto_schema/src/utilities/collect_fields.dart';
import 'package:leto_schema/src/utilities/look_ahead.dart';

import '../rules_prelude.dart';

class ElementComplexity implements ToDirectiveValue {
  /// The complexity cost
  final int complexity;

  /// A GraphQL attachment which specifies a [complexity] in a [GraphQLElement]
  /// for [queryComplexityRuleBuilder]. Presented as a directive [directiveDefinition]
  /// in the GraphQL schema.
  ///
  /// In code generation use [AttachFn].
  const ElementComplexity(this.complexity);

  @override
  DirectiveNode get directiveValue {
    return DirectiveNode(
      name: const NameNode(value: 'cost'),
      arguments: [
        ArgumentNode(
          name: const NameNode(value: 'complexity'),
          value: IntValueNode(value: complexity.toString()),
        ),
      ],
    );
  }

  @override
  GraphQLDirective get directiveDefinition => costGraphQLDirective;

  @override
  String toString() {
    return 'ElementComplexity($complexity)';
  }
}

/// The directive definition to specify the query complexity cost
/// associated with a Field or Type
final costGraphQLDirective = GraphQLDirective(
  name: 'cost',
  locations: [
    // Types
    DirectiveLocation.SCALAR,
    DirectiveLocation.OBJECT,
    DirectiveLocation.INTERFACE,
    DirectiveLocation.UNION,
    DirectiveLocation.ENUM,
    // Fields
    DirectiveLocation.FIELD_DEFINITION,
  ],
  description: 'The query complexity cost associated with a Field or Type',
  isRepeatable: false,
  inputs: [
    graphQLInt.nonNull().inputField('complexity'),
  ],
);

ElementComplexity? _getTypeComplexity(GraphQLType type) {
  return _getElementComplexity(getNamedType(type));
}

ElementComplexity? _getElementComplexity(GraphQLElement element) {
  final complexity = getDirectiveValue(
    'cost',
    'complexity',
    getDirectivesFromElement(element).toList(),
    {},
  );
  return element.attachments.whereType<ElementComplexity>().firstOrNull ??
      (complexity is int ? ElementComplexity(complexity) : null);
}

/// Returns a [ValidationRule] that reports errors when
/// the [maxComplexity] or [maxDepth] is reached.
///
/// The complexity for each fieldNode is:
/// complexity = fieldComplexity +
///        (childrenComplexity + fieldTypeComplexity) * complexityMultiplier
///
/// Where fieldComplexity is the [ElementComplexity] in
/// [GraphQLObjectField.attachments] or [defaultFieldComplexity]
/// if there aren't any.
///
/// childrenComplexity is:
/// If the field is a scalar or enum (leaf types): 0
/// if it is an object or interface: sum(objectFieldsComplexities)
/// if it is an union: max(possibleTypesComplexities)
///
/// fieldTypeComplexity will be taken as the [ElementComplexity]
/// from [GraphQLNamedType.attachments] or 0 if there aren't any.
///
/// If the fieldType is a [GraphQLListType], complexityMultiplier
/// will be the provided [listComplexityMultiplier], otherwise 1.
ValidationRule queryComplexityRuleBuilder({
  required int maxComplexity,
  required int maxDepth,
  int listComplexityMultiplier = 10,
  int defaultFieldComplexity = 1,
}) {
  return (ValidationCtx context) {
    return TypedVisitor()
      ..add<OperationDefinitionNode>((node) {
        int operationComplexity = 0;
        int currentDepth = 0;
        int maxOperationDepth = 0;

        late final int Function(PossibleSelectionsObject) _compObj;

        int _comp(
          GraphQLObjectField field,
          PossibleSelections? selections,
        ) {
          currentDepth += 1;
          maxOperationDepth = max(maxOperationDepth, currentDepth);

          final int childrenComplexity;
          if (selections == null) {
            // leaf type
            childrenComplexity = 0;
          } else if (selections.isUnion) {
            final unionComplexities = selections.unionMap.values.map(_compObj);
            childrenComplexity = unionComplexities.fold(0, max);
          } else {
            childrenComplexity = _compObj(selections.forObject);
          }
          currentDepth -= 1;

          final fieldComplexity = _getElementComplexity(field)?.complexity ??
              defaultFieldComplexity;

          final type = field.type;
          final fieldTypeComplexity = selections == null || selections.isUnion
              ? _getTypeComplexity(type)?.complexity ?? 0
              // object complexity already accounted for in childrenComplexity
              : 0;

          final _listComplexityMultiplier = type is GraphQLListType ||
                  type is GraphQLNonNullType && type.ofType is GraphQLListType
              ? listComplexityMultiplier
              : 1;

          return fieldComplexity +
              (childrenComplexity + fieldTypeComplexity) *
                  _listComplexityMultiplier;
        }

        _compObj = (PossibleSelectionsObject forObject) {
          final objTypeComplexity =
              _getTypeComplexity(forObject.objectType)?.complexity ?? 0;
          final fieldsComplexity = forObject.mapAliased.values
              .map((value) => _comp(value.field, value.lookAhead()))
              .sum;
          return objTypeComplexity + fieldsComplexity;
        };

        final rootType = context.schema.getRootType(node.type);
        if (rootType != null) {
          final variableValues = <String, Object?>{};

          final fields = collectFields(
            context.schema,
            context.fragmentsMap,
            rootType,
            node.selectionSet,
            variableValues,
          );

          for (final e in fields.entries) {
            final field = rootType.fieldByName(e.value.first.name.value);
            if (field == null) continue;

            final selections = possibleSelectionsCallback(
              context.schema,
              field,
              e.value,
              context.document,
              variableValues,
            )();

            final rootFieldComplexity = _comp(field, selections);
            operationComplexity += rootFieldComplexity;
          }
        }
        final operationName = node.name == null ? '' : ' "${node.name!.value}"';
        if (operationComplexity > maxComplexity) {
          context.reportError(
            GraphQLError(
              'Maximum operation complexity of $maxComplexity reached.'
              ' Operation$operationName complexity: $operationComplexity.',
              extensions: errorExtensions(
                specUrl:
                    'https://github.com/juancastillo0/leto#query-complexity',
                errorCode: 'queryComplexity',
              ),
            ),
          );
        }
        if (maxOperationDepth > maxDepth) {
          context.reportError(
            GraphQLError(
              'Maximum operation depth of $maxDepth reached.'
              ' Operation$operationName depth: $maxOperationDepth.',
              extensions: errorExtensions(
                specUrl:
                    'https://github.com/juancastillo0/leto#query-complexity',
                errorCode: 'queryDepthComplexity',
              ),
            ),
          );
        }
      });
  };
}
