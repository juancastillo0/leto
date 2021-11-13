import 'package:gql/ast.dart';
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/utilities/build_schema.dart';

Map<String, List<FieldNode>> collectFields(
  GraphQLSchema schema,
  Map<String, FragmentDefinitionNode> fragments,
  GraphQLObjectType objectType,
  SelectionSetNode selectionSet,
  Map<String, dynamic> variableValues, {
  Set<String>? visitedFragments,
  bool aliased = true,
}) {
  final groupedFields = <String, List<FieldNode>>{};
  visitedFragments ??= {};

  for (final selection in selectionSet.selections) {
    final directives = selection.directives;
    if (getDirectiveValue('skip', 'if', directives, variableValues) == true) {
      continue;
    }
    if (getDirectiveValue('include', 'if', directives, variableValues) ==
        false) {
      continue;
    }

    if (selection is FieldNode) {
      final responseKey = aliased
          ? (selection.alias?.value ?? selection.name.value)
          : selection.name.value;
      final groupForResponseKey =
          groupedFields.putIfAbsent(responseKey, () => []);
      groupForResponseKey.add(selection);
    } else if (selection is FragmentSpreadNode) {
      final fragmentSpreadName = selection.name.value;
      if (visitedFragments.contains(fragmentSpreadName)) continue;
      visitedFragments.add(fragmentSpreadName);
      final fragment = fragments[fragmentSpreadName];

      if (fragment == null) continue;
      final fragmentType = fragment.typeCondition;
      if (!doesFragmentTypeApply(objectType, fragmentType, schema)) continue;
      final fragmentSelectionSet = fragment.selectionSet;
      final fragmentGroupFieldSet = collectFields(
          schema, fragments, objectType, fragmentSelectionSet, variableValues,
          visitedFragments: visitedFragments, aliased: aliased);

      for (final groupEntry in fragmentGroupFieldSet.entries) {
        final responseKey = groupEntry.key;
        final fragmentGroup = groupEntry.value;
        final groupForResponseKey =
            groupedFields.putIfAbsent(responseKey, () => []);
        groupForResponseKey.addAll(fragmentGroup);
      }
    } else if (selection is InlineFragmentNode) {
      final fragmentType = selection.typeCondition;
      if (fragmentType != null &&
          !doesFragmentTypeApply(objectType, fragmentType, schema)) continue;
      final fragmentSelectionSet = selection.selectionSet;
      final fragmentGroupFieldSet = collectFields(
          schema, fragments, objectType, fragmentSelectionSet, variableValues,
          visitedFragments: visitedFragments, aliased: aliased);

      for (final groupEntry in fragmentGroupFieldSet.entries) {
        final responseKey = groupEntry.key;
        final fragmentGroup = groupEntry.value;
        final groupForResponseKey =
            groupedFields.putIfAbsent(responseKey, () => []);
        groupForResponseKey.addAll(fragmentGroup);
      }
    }
  }

  return groupedFields;
}

bool doesFragmentTypeApply(
  GraphQLObjectType objectType,
  TypeConditionNode fragmentType,
  GraphQLSchema schema,
) {
  final typeNode = NamedTypeNode(
    name: fragmentType.on.name,
    span: fragmentType.on.span,
    isNonNull: fragmentType.on.isNonNull,
  );
  final type = convertType(typeNode, schema.typeMap);

  return type.whenMaybe(
    object: (type) {
      if (type.isInterface) {
        return objectType.isImplementationOf(type);
      } else {
        return type.name == objectType.name;
      }
    },
    union: (type) {
      return type.possibleTypes.any((t) => objectType.isImplementationOf(t));
    },
    orElse: (_) => false,
  );
}

///
extension DirectiveExtension on SelectionNode {
  List<DirectiveNode> get directives {
    final selection = this;
    return selection is FieldNode
        ? selection.directives
        : selection is FragmentSpreadNode
            ? selection.directives
            : (selection as InlineFragmentNode).directives;
  }

  T when<T>({
    required T Function(FieldNode) field,
    required T Function(FragmentSpreadNode) fragmentSpread,
    required T Function(InlineFragmentNode) inlineFragment,
  }) {
    final selection = this;
    if (selection is FieldNode) return field(selection);
    if (selection is FragmentSpreadNode) return fragmentSpread(selection);
    if (selection is InlineFragmentNode) return inlineFragment(selection);
    throw Error();
  }
}

Map<String, FragmentDefinitionNode> fragmentsFromDocument(
  DocumentNode document,
) {
  final allFragments = document.definitions.whereType<FragmentDefinitionNode>();
  return Map.fromEntries(
    allFragments.map((e) => MapEntry(e.name.value, e)),
  );
}
