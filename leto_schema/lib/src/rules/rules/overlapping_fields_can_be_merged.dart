import 'package:gql/language.dart';
import 'package:leto_schema/src/utilities/collect_fields.dart';

import '../rules_prelude.dart';

const _overlappingFieldsCanBeMergedSpec = ErrorSpec(
  spec: 'https://spec.graphql.org/draft/#sec-Field-Selection-Merging',
  code: 'overlappingFieldsCanBeMerged',
);

/// Overlapping fields can be merged
///
/// A selection set is only valid if all fields (including spreading any
/// fragments) either correspond to distinct response names or can be merged
/// without ambiguity.
///
/// See https://spec.graphql.org/draft/#sec-Field-Selection-Merging
Visitor overlappingFieldsCanBeMergedRule(
  ValidationCtx context,
) {
  // A memoization for when two fragments are compared "between" each other for
  // conflicts. Two fragments may be compared many times, so memoizing this can
  // dramatically improve the performance of this validator.
  final comparedFragmentPairs = PairSet();

  // A cache for the "field map" and list of fragment names found in any given
  // selection set. Selection sets may be asked for this information multiple
  // times, so this improves the performance of this validator.
  final Map<SelectionSetNode, FieldsAndFragmentNames>

      /// [Map.identity] required since the span is not used in [Node.==]
      /// and, right now, [SelectionSetNode.span] is null anyway
      cachedFieldsAndFragmentNames = Map.identity();

  final visitor = TypedVisitor();

  visitor.add<SelectionSetNode>((selectionSet) {
    final conflicts = findConflictsWithinSelectionSet(
      context,
      cachedFieldsAndFragmentNames,
      comparedFragmentPairs,
      context.typeInfo.getParentType(),
      selectionSet,
    );
    for (final c in conflicts) {
      final reasonMsg = _reasonMessage(c.reason);
      context.reportError(
        GraphQLError(
          'Fields "${c.reason.name}" conflict because ${reasonMsg}.'
          ' Use different aliases on the fields to fetch both if this was intentional.',
          locations: List.of(
            c.fields1.followedBy(c.fields2).map(
                  (e) => GraphQLErrorLocation.fromSourceLocation(
                      (e.span ?? e.name.span)!.start),
                ),
          ),
          extensions: _overlappingFieldsCanBeMergedSpec.extensions(),
        ),
      );
    }
  });

  return visitor;
}

// type Conflict = [ConflictReason, Array<FieldNode>, Array<FieldNode>];

class Conflict {
  final ConflictReason reason;
  final List<FieldNode> fields1;
  final List<FieldNode> fields2;

  Conflict(this.reason, this.fields1, this.fields2);
}

// // Field name and reason.
// type ConflictReason = [string, ConflictReasonMessage];
// // Reason is a string, or a nested list of conflicts.
// type ConflictReasonMessage = string | Array<ConflictReason>;

/// Field name and reason.
class ConflictReason {
  final String name;

  /// Reason is a string, or a nested list of conflicts.
  final List<ConflictReason> subReasons;
  final String? message;

  ConflictReason(this.name, this.subReasons, this.message);
}

String _reasonMessage(ConflictReason reason) {
  final message = reason.message;
  if (message == null) {
    return reason.subReasons
        .map(
          (r) => 'subfields "${r.name}" conflict because'
              ' ${_reasonMessage(r)}',
        )
        .join(' and ');
  }
  return message;
}

// // Tuple defining a field node in a context.
// type NodeAndDef = [
//   Maybe<GraphQLNamedType>,
//   FieldNode,
//   Maybe<GraphQLField<unknown, unknown>>,
// ];

/// Tuple defining a field node in a context.
class NodeAndDef {
  final GraphQLType? parentType;
  final FieldNode node;
  final GraphQLObjectField? def;

  NodeAndDef(this.parentType, this.node, this.def);
}

/// Map of array of [NodeAndDef].
typedef NodeAndDefCollection = Map<String, List<NodeAndDef>>;

class FieldsAndFragmentNames {
  final NodeAndDefCollection fieldMap;
  final List<String> fragmentNames;

  FieldsAndFragmentNames(this.fieldMap, this.fragmentNames);
}

// /**
//  * Algorithm:
//  *
//  * Conflicts occur when two fields exist in a query which will produce the same
//  * response name, but represent differing values, thus creating a conflict.
//  * The algorithm below finds all conflicts via making a series of comparisons
//  * between fields. In order to compare as few fields as possible, this makes
//  * a series of comparisons "within" sets of fields and "between" sets of fields.
//  *
//  * Given any selection set, a collection produces both a set of fields by
//  * also including all inline fragments, as well as a list of fragments
//  * referenced by fragment spreads.
//  *
//  * A) Each selection set represented in the document first compares "within" its
//  * collected set of fields, finding any conflicts between every pair of
//  * overlapping fields.
//  * Note: This is the *only time* that a the fields "within" a set are compared
//  * to each other. After this only fields "between" sets are compared.
//  *
//  * B) Also, if any fragment is referenced in a selection set, then a
//  * comparison is made "between" the original set of fields and the
//  * referenced fragment.
//  *
//  * C) Also, if multiple fragments are referenced, then comparisons
//  * are made "between" each referenced fragment.
//  *
//  * D) When comparing "between" a set of fields and a referenced fragment, first
//  * a comparison is made between each field in the original set of fields and
//  * each field in the the referenced set of fields.
//  *
//  * E) Also, if any fragment is referenced in the referenced selection set,
//  * then a comparison is made "between" the original set of fields and the
//  * referenced fragment (recursively referring to step D).
//  *
//  * F) When comparing "between" two fragments, first a comparison is made between
//  * each field in the first referenced set of fields and each field in the the
//  * second referenced set of fields.
//  *
//  * G) Also, any fragments referenced by the first must be compared to the
//  * second, and any fragments referenced by the second must be compared to the
//  * first (recursively referring to step F).
//  *
//  * H) When comparing two fields, if both have selection sets, then a comparison
//  * is made "between" both selection sets, first comparing the set of fields in
//  * the first selection set with the set of fields in the second.
//  *
//  * I) Also, if any fragment is referenced in either selection set, then a
//  * comparison is made "between" the other set of fields and the
//  * referenced fragment.
//  *
//  * J) Also, if two fragments are referenced in both selection sets, then a
//  * comparison is made "between" the two fragments.
//  *
//  */

/// Find all conflicts found "within" a selection set, including those found
/// via spreading in fragments. Called when visiting each SelectionSet in the
/// GraphQL Document.
List<Conflict> findConflictsWithinSelectionSet(
  ValidationCtx context,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  PairSet comparedFragmentPairs,
  GraphQLType? parentType,
  SelectionSetNode selectionSet,
) {
  final conflicts = <Conflict>[];

  final _v = getFieldsAndFragmentNames(
    context,
    cachedFieldsAndFragmentNames,
    parentType,
    selectionSet,
  );
  final fieldMap = _v.fieldMap;
  final fragmentNames = _v.fragmentNames;

  // (A) Find find all conflicts "within" the fields of this selection set.
  // Note: this is the *only place* `collectConflictsWithin` is called.
  collectConflictsWithin(
    context,
    conflicts,
    cachedFieldsAndFragmentNames,
    comparedFragmentPairs,
    fieldMap,
  );

  if (fragmentNames.length != 0) {
    // (B) Then collect conflicts between these fields and those represented by
    // each spread fragment name found.
    for (int i = 0; i < fragmentNames.length; i++) {
      collectConflictsBetweenFieldsAndFragment(
        context,
        conflicts,
        cachedFieldsAndFragmentNames,
        comparedFragmentPairs,
        false,
        fieldMap,
        fragmentNames[i],
      );
      // (C) Then compare this fragment with all other fragments found in this
      // selection set to collect conflicts between fragments spread together.
      // This compares each item in the list of fragment names to every other
      // item in that same list (except for itself).
      for (int j = i + 1; j < fragmentNames.length; j++) {
        collectConflictsBetweenFragments(
          context,
          conflicts,
          cachedFieldsAndFragmentNames,
          comparedFragmentPairs,
          false,
          fragmentNames[i],
          fragmentNames[j],
        );
      }
    }
  }
  return conflicts;
}

/// Collect all conflicts found between a set of fields and a fragment reference
/// including via spreading in any nested fragments.
void collectConflictsBetweenFieldsAndFragment(
  ValidationCtx context,
  List<Conflict> conflicts,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  PairSet comparedFragmentPairs,
  bool areMutuallyExclusive,
  NodeAndDefCollection fieldMap,
  String fragmentName,
) {
  final fragment = context.fragmentsMap[fragmentName];
  if (fragment == null) {
    return;
  }

  final f = getReferencedFieldsAndFragmentNames(
    context,
    cachedFieldsAndFragmentNames,
    fragment,
  );
  final fieldMap2 = f.fieldMap;
  final referencedFragmentNames = f.fragmentNames;

  // Do not compare a fragment`s fieldMap to itself.
  if (fieldMap == fieldMap2) {
    return;
  }

  // (D) First collect any conflicts between the provided collection of fields
  // and the collection of fields represented by the given fragment.
  collectConflictsBetween(
    context,
    conflicts,
    cachedFieldsAndFragmentNames,
    comparedFragmentPairs,
    areMutuallyExclusive,
    fieldMap,
    fieldMap2,
  );

  // (E) Then collect any conflicts between the provided collection of fields
  // and any fragment names found in the given fragment.
  for (final referencedFragmentName in referencedFragmentNames) {
    collectConflictsBetweenFieldsAndFragment(
      context,
      conflicts,
      cachedFieldsAndFragmentNames,
      comparedFragmentPairs,
      areMutuallyExclusive,
      fieldMap,
      referencedFragmentName,
    );
  }
}

/// Collect all conflicts found between two fragments, including via spreading in
/// any nested fragments.
void collectConflictsBetweenFragments(
  ValidationCtx context,
  List<Conflict> conflicts,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  PairSet comparedFragmentPairs,
  bool areMutuallyExclusive,
  String fragmentName1,
  String fragmentName2,
) {
  // No need to compare a fragment to itself.
  if (fragmentName1 == fragmentName2) {
    return;
  }

  // Memoize so two fragments are not compared for conflicts more than once.
  if (comparedFragmentPairs.has(
    fragmentName1,
    fragmentName2,
    areMutuallyExclusive,
  )) {
    return;
  }
  comparedFragmentPairs.add(fragmentName1, fragmentName2, areMutuallyExclusive);

  final fragment1 = context.fragmentsMap[fragmentName1];
  final fragment2 = context.fragmentsMap[fragmentName2];
  if (fragment1 == null || fragment2 == null) {
    return;
  }

  final fg1 = getReferencedFieldsAndFragmentNames(
    context,
    cachedFieldsAndFragmentNames,
    fragment1,
  );
  final fieldMap1 = fg1.fieldMap;
  final referencedFragmentNames1 = fg1.fragmentNames;
  final fg2 = getReferencedFieldsAndFragmentNames(
    context,
    cachedFieldsAndFragmentNames,
    fragment2,
  );
  final fieldMap2 = fg2.fieldMap;
  final referencedFragmentNames2 = fg2.fragmentNames;

  // (F) First, collect all conflicts between these two collections of fields
  // (not including any nested fragments).
  collectConflictsBetween(
    context,
    conflicts,
    cachedFieldsAndFragmentNames,
    comparedFragmentPairs,
    areMutuallyExclusive,
    fieldMap1,
    fieldMap2,
  );

  // (G) Then collect conflicts between the first fragment and any nested
  // fragments spread in the second fragment.
  for (final referencedFragmentName2 in referencedFragmentNames2) {
    collectConflictsBetweenFragments(
      context,
      conflicts,
      cachedFieldsAndFragmentNames,
      comparedFragmentPairs,
      areMutuallyExclusive,
      fragmentName1,
      referencedFragmentName2,
    );
  }

  // (G) Then collect conflicts between the second fragment and any nested
  // fragments spread in the first fragment.
  for (final referencedFragmentName1 in referencedFragmentNames1) {
    collectConflictsBetweenFragments(
      context,
      conflicts,
      cachedFieldsAndFragmentNames,
      comparedFragmentPairs,
      areMutuallyExclusive,
      referencedFragmentName1,
      fragmentName2,
    );
  }
}

/// Find all conflicts found between two selection sets, including those found
/// via spreading in fragments. Called when determining if conflicts exist
/// between the sub-fields of two overlapping fields.
List<Conflict> findConflictsBetweenSubSelectionSets(
  ValidationCtx context,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  PairSet comparedFragmentPairs,
  bool areMutuallyExclusive,
  GraphQLType? parentType1,
  SelectionSetNode selectionSet1,
  GraphQLType? parentType2,
  SelectionSetNode selectionSet2,
) {
  final conflicts = <Conflict>[];

  final fg1 = getFieldsAndFragmentNames(
    context,
    cachedFieldsAndFragmentNames,
    parentType1,
    selectionSet1,
  );
  final fieldMap1 = fg1.fieldMap;
  final fragmentNames1 = fg1.fragmentNames;
  final fg2 = getFieldsAndFragmentNames(
    context,
    cachedFieldsAndFragmentNames,
    parentType2,
    selectionSet2,
  );
  final fieldMap2 = fg2.fieldMap;
  final fragmentNames2 = fg2.fragmentNames;

  // (H) First, collect all conflicts between these two collections of field.
  collectConflictsBetween(
    context,
    conflicts,
    cachedFieldsAndFragmentNames,
    comparedFragmentPairs,
    areMutuallyExclusive,
    fieldMap1,
    fieldMap2,
  );

  // (I) Then collect conflicts between the first collection of fields and
  // those referenced by each fragment name associated with the second.
  for (final fragmentName2 in fragmentNames2) {
    collectConflictsBetweenFieldsAndFragment(
      context,
      conflicts,
      cachedFieldsAndFragmentNames,
      comparedFragmentPairs,
      areMutuallyExclusive,
      fieldMap1,
      fragmentName2,
    );
  }

  // (I) Then collect conflicts between the second collection of fields and
  // those referenced by each fragment name associated with the first.
  for (final fragmentName1 in fragmentNames1) {
    collectConflictsBetweenFieldsAndFragment(
      context,
      conflicts,
      cachedFieldsAndFragmentNames,
      comparedFragmentPairs,
      areMutuallyExclusive,
      fieldMap2,
      fragmentName1,
    );
  }

  // (J) Also collect conflicts between any fragment names by the first and
  // fragment names by the second. This compares each item in the first set of
  // names to each item in the second set of names.
  for (final fragmentName1 in fragmentNames1) {
    for (final fragmentName2 in fragmentNames2) {
      collectConflictsBetweenFragments(
        context,
        conflicts,
        cachedFieldsAndFragmentNames,
        comparedFragmentPairs,
        areMutuallyExclusive,
        fragmentName1,
        fragmentName2,
      );
    }
  }
  return conflicts;
}

/// Collect all Conflicts "within" one collection of fields.
void collectConflictsWithin(
  ValidationCtx context,
  List<Conflict> conflicts,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  PairSet comparedFragmentPairs,
  NodeAndDefCollection fieldMap,
) {
  // A field map is a keyed collection, where each key represents a response
  // name and the value at that key is a list of all fields which provide that
  // response name. For every response name, if there are multiple fields, they
  // must be compared to find a potential conflict.
  for (final e in fieldMap.entries) {
    final responseName = e.key;
    final fields = e.value;
    // This compares every field in the list to every other field in this list
    // (except to itself). If the list only has one item, nothing needs to
    // be compared.
    if (fields.length > 1) {
      for (int i = 0; i < fields.length; i++) {
        for (int j = i + 1; j < fields.length; j++) {
          final conflict = findConflict(
            context,
            cachedFieldsAndFragmentNames,
            comparedFragmentPairs,
            false, // within one collection is never mutually exclusive
            responseName,
            fields[i],
            fields[j],
          );
          if (conflict != null) {
            conflicts.add(conflict);
          }
        }
      }
    }
  }
}

/// Collect all Conflicts between two collections of fields. This is similar to,
/// but different from the `collectConflictsWithin` function above. This check
/// assumes that `collectConflictsWithin` has already been called on each
/// provided collection of fields. This is true because this validator traverses
/// each individual selection set.
void collectConflictsBetween(
  ValidationCtx context,
  List<Conflict> conflicts,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  PairSet comparedFragmentPairs,
  bool parentFieldsAreMutuallyExclusive,
  NodeAndDefCollection fieldMap1,
  NodeAndDefCollection fieldMap2,
) {
  // A field map is a keyed collection, where each key represents a response
  // name and the value at that key is a list of all fields which provide that
  // response name. For any response name which appears in both provided field
  // maps, each field from the first field map must be compared to every field
  // in the second field map to find potential conflicts.
  for (final e in fieldMap1.entries) {
    final responseName = e.key;
    final fields1 = e.value;
    final fields2 = fieldMap2[responseName];
    if (fields2 != null) {
      for (final field1 in fields1) {
        for (final field2 in fields2) {
          final conflict = findConflict(
            context,
            cachedFieldsAndFragmentNames,
            comparedFragmentPairs,
            parentFieldsAreMutuallyExclusive,
            responseName,
            field1,
            field2,
          );
          if (conflict != null) {
            conflicts.add(conflict);
          }
        }
      }
    }
  }
}

/// Determines if there is a conflict between two particular fields, including
/// comparing their sub-fields.
Conflict? findConflict(
  ValidationCtx context,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  PairSet comparedFragmentPairs,
  bool parentFieldsAreMutuallyExclusive,
  String responseName,
  NodeAndDef field1,
  NodeAndDef field2,
) {
  final parentType1 = field1.parentType;
  final parentType2 = field2.parentType;

  // If it is known that two fields could not possibly apply at the same
  // time, due to the parent types, then it is safe to permit them to diverge
  // in aliased field or arguments used as they will not present any ambiguity
  // by differing.
  // It is known that two parent types could never overlap if they are
  // different Object types. Interface or Union types might overlap - if not
  // in the current state of the schema, then perhaps in some future version,
  // thus may not safely diverge.
  final areMutuallyExclusive = parentFieldsAreMutuallyExclusive ||
      (parentType1 != parentType2 &&
          parentType1 is GraphQLObjectType &&
          !parentType1.isInterface &&
          parentType2 is GraphQLObjectType &&
          !parentType2.isInterface);

  if (!areMutuallyExclusive) {
    // Two aliases must refer to the same field.
    final name1 = field1.node.name.value;
    final name2 = field2.node.name.value;
    if (name1 != name2) {
      return Conflict(
        ConflictReason(
            responseName, [], '"${name1}" and "${name2}" are different fields'),
        [field1.node],
        [field2.node],
      );
    }

    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    final args1 = field1.node.arguments;
    // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
    final args2 = field2.node.arguments;
    // Two field calls must have the same arguments.
    if (!sameArguments(args1, args2)) {
      return Conflict(
        ConflictReason(responseName, [], 'they have differing arguments'),
        [field1.node],
        [field2.node],
      );
    }
  }

  // The return type for each field.
  final type1 = field1.def?.type;
  final type2 = field2.def?.type;

  if (type1 != null && type2 != null && doTypesConflict(type1, type2)) {
    return Conflict(
      ConflictReason(
        responseName,
        [],
        'they return conflicting types "${inspect(type1)}" and "${inspect(
          type2,
        )}"',
      ),
      [field1.node],
      [field2.node],
    );
  }

  // Collect and compare sub-fields. Use the same "visited fragment names" list
  // for both collections so fields in a fragment reference are never
  // compared to themselves.
  final selectionSet1 = field1.node.selectionSet;
  final selectionSet2 = field2.node.selectionSet;
  if (selectionSet1 != null && selectionSet2 != null) {
    final conflicts = findConflictsBetweenSubSelectionSets(
      context,
      cachedFieldsAndFragmentNames,
      comparedFragmentPairs,
      areMutuallyExclusive,
      getNamedType(type1),
      selectionSet1,
      getNamedType(type2),
      selectionSet2,
    );
    return subfieldConflicts(conflicts, responseName, field1.node, field2.node);
  }
}

bool sameArguments(
  List<ArgumentNode> arguments1,
  List<ArgumentNode> arguments2,
) {
  if (arguments1.length != arguments2.length) {
    return false;
  }
  return arguments1.every((argument1) {
    final argument2 = arguments2.firstWhereOrNull(
      (argument) => argument.name.value == argument1.name.value,
    );
    if (argument2 == null) {
      return false;
    }
    return sameValue(argument1.value, argument2.value);
  });
}

bool sameValue(ValueNode value1, ValueNode value2) {
  return printNode(value1) == printNode(value2);
}

/// Two types conflict if both types could not apply to a value simultaneously.
/// Composite types are ignored as their individual field types will be compared
/// later recursively. However List and Non-Null types must match.
bool doTypesConflict(
  GraphQLType type1,
  GraphQLType type2,
) {
  if (type1 is GraphQLListType) {
    return type2 is GraphQLListType
        ? doTypesConflict(type1.ofType, type2.ofType)
        : true;
  }
  if (type2 is GraphQLListType) {
    return true;
  }
  if (type1 is GraphQLNonNullType) {
    return type2 is GraphQLNonNullType
        ? doTypesConflict(type1.ofType, type2.ofType)
        : true;
  }
  if (type2 is GraphQLNonNullType) {
    return true;
  }
  if (isLeafType(type1) || isLeafType(type2)) {
    return type1 != type2;
  }
  return false;
}

/// Given a selection set, return the collection of fields (a mapping of response
/// name to field nodes and definitions) as well as a list of fragment names
/// referenced via fragment spreads.
FieldsAndFragmentNames getFieldsAndFragmentNames(
  ValidationCtx context,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  GraphQLType? parentType,
  SelectionSetNode selectionSet,
) {
  final cached = cachedFieldsAndFragmentNames[selectionSet];
  if (cached != null) {
    return cached;
  }
  final NodeAndDefCollection nodeAndDefs = {};
  final fragmentNames = <String, bool>{};
  _collectFieldsAndFragmentNames(
    context,
    parentType,
    selectionSet,
    nodeAndDefs,
    fragmentNames,
  );
  final result =
      FieldsAndFragmentNames(nodeAndDefs, fragmentNames.keys.toList());
  cachedFieldsAndFragmentNames[selectionSet] = result;
  return result;
}

/// Given a reference to a fragment, return the represented collection of fields
/// as well as a list of nested fragment names referenced via fragment spreads.
FieldsAndFragmentNames getReferencedFieldsAndFragmentNames(
  ValidationCtx context,
  Map<SelectionSetNode, FieldsAndFragmentNames> cachedFieldsAndFragmentNames,
  FragmentDefinitionNode fragment,
) {
  // Short-circuit building a type from the node if possible.
  final cached = cachedFieldsAndFragmentNames[fragment.selectionSet];
  if (cached != null) {
    return cached;
  }

  final fragmentType = convertTypeOrNull(
    fragment.typeCondition.on,
    context.schema.typeMap,
  );
  return getFieldsAndFragmentNames(
    context,
    cachedFieldsAndFragmentNames,
    fragmentType,
    fragment.selectionSet,
  );
}

void _collectFieldsAndFragmentNames(
  ValidationCtx context,
  GraphQLType? parentType,
  SelectionSetNode selectionSet,
  NodeAndDefCollection nodeAndDefs,
  Map<String, bool> fragmentNames,
) {
  for (final selection in selectionSet.selections) {
    selection.when(
      field: (selection) {
        final fieldName = selection.name.value;
        GraphQLObjectField? fieldDef;
        if (parentType is GraphQLObjectType) {
          fieldDef = parentType.fieldByName(fieldName);
        }
        final responseName =
            selection.alias != null ? selection.alias!.value : fieldName;
        if (nodeAndDefs[responseName] == null) {
          nodeAndDefs[responseName] = [];
        }
        nodeAndDefs[responseName]!
            .add(NodeAndDef(parentType, selection, fieldDef));
      },
      fragmentSpread: (selection) {
        fragmentNames[selection.name.value] = true;
      },
      inlineFragment: (selection) {
        final typeCondition = selection.typeCondition;
        final inlineFragmentType = typeCondition != null
            ? convertTypeOrNull(typeCondition.on, context.schema.typeMap)
            : parentType;
        _collectFieldsAndFragmentNames(
          context,
          inlineFragmentType,
          selection.selectionSet,
          nodeAndDefs,
          fragmentNames,
        );
      },
    );
  }
}

/// Given a series of Conflicts which occurred between two sub-fields, generate
/// a single Conflict.
Conflict? subfieldConflicts(
  List<Conflict> conflicts,
  String responseName,
  FieldNode node1,
  FieldNode node2,
) {
  if (conflicts.length > 0) {
    return Conflict(
      ConflictReason(
        responseName,
        conflicts.map((c) => c.reason).toList(),
        null,
      ),
      [node1, ...conflicts.expand((c) => c.fields1)],
      [node2, ...conflicts.expand((c) => c.fields2)],
    );
  }
}

/// A way to keep track of pairs of things when the ordering of the pair does not matter.
class PairSet {
  final Map<String, Map<String, bool>> _data = {};

  bool has(String a, String b, bool areMutuallyExclusive) {
    final key1 = a.compareTo(b) < 0 ? a : b;
    final key2 = a.compareTo(b) < 0 ? b : a;

    final result = this._data[key1]?[key2];
    if (result == null) {
      return false;
    }

    // areMutuallyExclusive being false is a superset of being true, hence if
    // we want to know if this PairSet "has" these two with no exclusivity,
    // we have to ensure it was added as such.
    return areMutuallyExclusive ? true : areMutuallyExclusive == result;
  }

  void add(String a, String b, bool areMutuallyExclusive) {
    final key1 = a.compareTo(b) < 0 ? a : b;
    final key2 = a.compareTo(b) < 0 ? b : a;

    final map = this._data[key1];
    if (map == null) {
      this._data[key1] = {key2: areMutuallyExclusive};
    } else {
      map[key2] = areMutuallyExclusive;
    }
  }
}
