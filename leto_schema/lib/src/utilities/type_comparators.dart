import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/utilities/predicates.dart';

/// Provided two types, return true if the types are equal (invariant).
bool isEqualType(GraphQLType typeA, GraphQLType typeB) {
  // Equivalent types are equal.
  if (typeA == typeB) {
    return true;
  }

  // If either type is non-null, the other must also be non-null.
  if (typeA is GraphQLNonNullType && typeB is GraphQLNonNullType) {
    return isEqualType(typeA.ofType, typeB.ofType);
  }

  // If either type is a list, the other must also be a list.
  if (typeA is GraphQLListType && typeB is GraphQLListType) {
    return isEqualType(typeA.ofType, typeB.ofType);
  }

  // Otherwise the types are not equal.
  return false;
}

/// Provided a type and a super type, return true if the first type is either
/// equal or a subset of the second super type (covariant).
bool isTypeSubTypeOf(
  GraphQLSchema schema,
  GraphQLType maybeSubType,
  GraphQLType superType,
) {
  // Equivalent type is a valid subtype
  if (maybeSubType == superType) {
    return true;
  }

  // If superType is non-null, maybeSubType must also be non-null.
  if (superType is GraphQLNonNullType) {
    if (maybeSubType is GraphQLNonNullType) {
      return isTypeSubTypeOf(schema, maybeSubType.ofType, superType.ofType);
    }
    return false;
  }
  if (maybeSubType is GraphQLNonNullType) {
    // If superType is nullable, maybeSubType may be non-null or nullable.
    return isTypeSubTypeOf(schema, maybeSubType.ofType, superType);
  }

  // If superType type is a list, maybeSubType type must also be a list.
  if (superType is GraphQLListType) {
    if (maybeSubType is GraphQLListType) {
      return isTypeSubTypeOf(schema, maybeSubType.ofType, superType.ofType);
    }
    return false;
  }
  if (maybeSubType is GraphQLListType) {
    // If superType is not a list, maybeSubType must also be not a list.
    return false;
  }

  // If superType type is an abstract type, check if it is super type of maybeSubType.
  // Otherwise, the child type is not a valid subtype of the parent type.
  return isAbstractType(superType) &&
      (maybeSubType is GraphQLObjectType) &&
      superType is GraphQLCompositeType &&
      schema.isSubType(superType, maybeSubType);
}

/// Provided two composite types, determine if they "overlap". Two composite
/// types overlap when the Sets of possible concrete types for each intersect.
///
/// This is often used to determine if a fragment of a given type could possibly
/// be visited in a context of another type.
///
/// This function is commutative.
bool doTypesOverlap(
  GraphQLSchema schema,
  GraphQLCompositeType typeA,
  GraphQLCompositeType typeB,
) {
  // Equivalent types overlap
  if (typeA == typeB) {
    return true;
  }

  if (isAbstractType(typeA)) {
    if (isAbstractType(typeB)) {
      // If both types are abstract, then determine if there is any intersection
      // between possible concrete types of each.
      return schema
          .getPossibleTypes(typeA)!
          .any((type) => schema.isSubType(typeB, type));
    }
    // Determine if the latter type is a possible concrete type of the former.
    return typeB is GraphQLObjectType && schema.isSubType(typeA, typeB);
  }

  if (isAbstractType(typeB)) {
    // Determine if the former type is a possible concrete type of the latter.
    return typeA is GraphQLObjectType && schema.isSubType(typeB, typeA);
  }

  // Otherwise the types do not overlap.
  return false;
}
