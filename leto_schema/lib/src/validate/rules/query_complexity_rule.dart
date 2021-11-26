import 'dart:math' show max;

import 'package:leto_schema/src/utilities/collect_fields.dart';
import 'package:leto_schema/src/utilities/look_ahead.dart';

import '../rules_prelude.dart';

class ElementComplexity {
  final int complexity;

  const ElementComplexity(this.complexity);

  @override
  String toString() {
    return 'ElementComplexity($complexity)';
  }
}

ElementComplexity _getTypeComplexity(GraphQLType type) {
  return getNamedType(type)!
          .attachments
          .whereType<ElementComplexity>()
          .firstOrNull ??
      const ElementComplexity(0);
}

ElementComplexity _defaultComplexity(
  ValidationCtx _,
  GraphQLObjectField field,
) =>
    field.type is GraphQLListType
        ? const ElementComplexity(10)
        : const ElementComplexity(1);

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
  // ElementComplexity Function(ValidationCtx, GraphQLObjectField)
  //     calculateComplexity = _defaultComplexity,
}) {
  return (ValidationCtx context) {
    final visitor = TypedVisitor();

    // int currentComplexity = 0;
    // int documentMaxDepth = 0;
    // int currentDepth = 0;

    // visitor.visitTypeConditionNode(node);
    // visitor.add<FieldNode>(
    //   (fieldNode) {
    //     currentDepth += 1;
    //     documentMaxDepth = max(documentMaxDepth, currentDepth);
    //     final field = context.typeInfo.getFieldDef();
    //     if (field == null) return;

    //     final complexity =
    //         field.attachments.whereType<ElementComplexity>().firstOrNull ??
    //             calculateComplexity();

    //     currentComplexity += complexity.complexity;
    //   },
    //   leave: (_) {
    //     currentDepth -= 1;
    //   },
    // );
    visitor.add<OperationDefinitionNode>((node) {
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

        final fieldComplexity =
            field.attachments.whereType<ElementComplexity>().firstOrNull ??
                ElementComplexity(defaultFieldComplexity);

        final type = field.type;
        final fieldTypeComplexity = selections == null || selections.isUnion
            ? _getTypeComplexity(type).complexity
            // object complexity already accounted for in childrenComplexity
            : 0;

        final _listComplexityMultiplier = type is GraphQLListType ||
                type is GraphQLNonNullType && type.ofType is GraphQLListType
            ? listComplexityMultiplier
            : 1;

        return fieldComplexity.complexity +
            (childrenComplexity + fieldTypeComplexity) *
                _listComplexityMultiplier;
      }

      _compObj = (PossibleSelectionsObject forObject) {
        final objTypeComplexity =
            _getTypeComplexity(forObject.objectType).complexity;
        final fieldsComplexity = forObject.mapAliased.values
            .map((value) => _comp(value.field, value.lookAhead()))
            .sum
            .toInt();
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
              specUrl: 'https://github.com/juancastillo0/leto#query-complexity',
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
              specUrl: 'https://github.com/juancastillo0/leto#query-complexity',
              errorCode: 'queryDepthComplexity',
            ),
          ),
        );
      }
    });

    return visitor;
  };
}
