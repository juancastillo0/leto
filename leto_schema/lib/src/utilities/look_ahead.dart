import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/utilities/collect_fields.dart';

class PossibleSelections {
  /// a Map from a [GraphQLObjectType]'s name to it's selections
  ///
  /// If this selection is for an object it will have only one entry.
  /// If it's for an union it will have as many entries as
  /// [GraphQLUnionType.possibleTypes] there are in the union.
  final Map<String, PossibleSelectionsObject> unionMap;

  /// The selection field nodes which reference this selection
  ///
  /// Since [PossibleSelectionsObject] has its fields un-aliased,
  /// this could be used in cases where you require aliased fields.
  final List<FieldNode> fieldNodes;

  final GraphQLObjectField field;

  /// Same as [unionMap.values.first], useful when you know
  /// this selection is for an object an not an union
  PossibleSelectionsObject get forObject {
    assert(!isUnion);
    return unionMap.values.first;
  }

  /// Whether this selection is for an union with one
  /// [PossibleSelectionsObject] in [unionMap]
  /// for every [GraphQLUnionType.possibleTypes].
  bool get isUnion => unionMap.length > 1;

  const PossibleSelections(
    this.unionMap,
    this.fieldNodes,
    this.field,
  );
}

class PossibleSelectionsObject {
  /// A map of un-aliased fields to a function which calculates
  /// the selected properties for that field.
  final Map<String, PossibleSelectionsField> map;

  final Map<String, PossibleSelectionsField> mapAliased;

  final GraphQLObjectType objectType;

  const PossibleSelectionsObject({
    required this.map,
    required this.mapAliased,
    required this.objectType,
  });

  /// true if [fieldName] was selected for this object
  bool contains(String fieldName) => map.containsKey(fieldName);

  /// Returns the nested selections for [fieldName]
  ///
  /// Will be null when [fieldName] was not selected or if [fieldName]
  /// is not an Object or Union type (or list of those).
  ///
  /// If it's a scalar or an enum, for example, it would not have
  /// any selections, so this functions returns null even if they are selected.
  /// Use [contains] in this case.
  PossibleSelections? nested(String fieldName) => map[fieldName]?.lookAhead();
}

class PossibleSelectionsField {
  /// The selection field nodes which reference this selection
  ///
  /// Since [PossibleSelectionsObject] has its fields un-aliased,
  /// this could be used in cases where you require aliased fields.
  final List<FieldNode> fieldNodes;

  final GraphQLObjectField field;

  final PossibleSelections? Function() lookAhead;

  PossibleSelectionsField(
    this.fieldNodes,
    this.field,
    this.lookAhead,
  );
}

PossibleSelections? Function() possibleSelectionsCallback(
  GraphQLSchema schema,
  GraphQLObjectField field,
  List<FieldNode> fields,
  DocumentNode document,
  Map<String, Object?> variableValues,
) {
  bool calculated = false;
  PossibleSelections? _value;
  return () {
    if (calculated) return _value;

    final possibleObjects = <GraphQLObjectType>[];

    void _mapperType(GraphQLWrapperType nn) {
      final ofType = nn.ofType;
      if (ofType is GraphQLObjectType) {
        possibleObjects.add(ofType);
      } else if (ofType is GraphQLUnionType) {
        possibleObjects.addAll(ofType.possibleTypes);
      } else if (ofType is GraphQLWrapperType) {
        _mapperType(ofType as GraphQLWrapperType);
      }
    }

    field.type.whenOrNull(
      object: (obj) {
        possibleObjects.add(obj);
      },
      union: (union) => possibleObjects.addAll(union.possibleTypes),
      nonNullable: _mapperType,
      list: _mapperType,
    );
    if (possibleObjects.isNotEmpty) {
      final selectionSet = mergeSelectionSets(fields);
      final fragments = fragmentsFromDocument(document);

      _value = PossibleSelections(
        Map.fromEntries(
          possibleObjects.map((obj) {
            final nonAliased = collectFields(
              schema,
              fragments,
              obj,
              selectionSet,
              variableValues,
              aliased: false,
            );
            final aliased = collectFields(
              schema,
              fragments,
              obj,
              selectionSet,
              variableValues,
              aliased: true,
            );

            Iterable<MapEntry<String, PossibleSelectionsField>> _mapEntries(
              Iterable<MapEntry<String, List<FieldNode>>> entries,
            ) {
              return entries.map(
                (e) {
                  final fieldName = e.value.first.name.value;
                  final field = obj.fieldByName(fieldName)!;
                  return MapEntry(
                    e.key,
                    PossibleSelectionsField(
                      e.value,
                      field,
                      possibleSelectionsCallback(
                        schema,
                        field,
                        e.value,
                        document,
                        variableValues,
                      ),
                    ),
                  );
                },
              ).whereType();
            }

            return MapEntry(
              obj.name,
              PossibleSelectionsObject(
                map: Map.fromEntries(
                  _mapEntries(nonAliased.entries),
                ),
                mapAliased: Map.fromEntries(
                  _mapEntries(aliased.entries),
                ),
                objectType: obj,
              ),
            );
          }),
        ),
        fields,
        field,
      );
    }
    calculated = true;
    return _value;
  };
}
