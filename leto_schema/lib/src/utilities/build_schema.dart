import 'package:collection/collection.dart';
import 'package:gql/ast.dart' as ast;
import 'package:gql/ast.dart' hide DirectiveLocation;
import 'package:gql/language.dart' as gql;
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/utilities/ast_from_value.dart';

/// Create a [GraphQLSchema] from a GraphQL Schema Definition
/// Language (SDL) String [schemaStr].
GraphQLSchema buildSchema(
  String schemaStr, {
  Map<String, Object?>? payload,
  SerdeCtx? serdeCtx,
}) {
  final schemaDoc = gql.parseString(schemaStr);

  final schemaDef = schemaDoc.definitions.whereType<SchemaDefinitionNode>();
  final typeDefs = schemaDoc.definitions.whereType<TypeDefinitionNode>();
  final directiveDefs =
      schemaDoc.definitions.whereType<DirectiveDefinitionNode>();

  final types = <String, MapEntry<GraphQLType, TypeDefinitionNode>>{};

  for (final def in typeDefs) {
    final name = def.name.value;
    final GraphQLType type;
    if (def is ScalarTypeDefinitionNode) {
      type = GraphQLScalarTypeValue(
        name: name,
        description: def.description?.value,
        specifiedByURL:
            getDirectiveValue('specifiedByURL', 'url', def.directives, payload)
                as String?,
        serialize: (s) => s,
        deserialize: (_, s) => s,
        validate: (k, inp) => ValidationResult.ok(inp!),
      );
    } else if (def is ObjectTypeDefinitionNode) {
      type = GraphQLObjectType(
        name,
        description: def.description?.value,
        isInterface: false,
      );
    } else if (def is InterfaceTypeDefinitionNode) {
      type = GraphQLObjectType(
        name,
        description: def.description?.value,
        isInterface: true,
      );
    } else if (def is UnionTypeDefinitionNode) {
      type = GraphQLUnionType(
        name,
        [],
        description: def.description?.value,
      );
    } else if (def is EnumTypeDefinitionNode) {
      type = GraphQLEnumType(
        name,
        [
          ...def.values.map(
            (e) => GraphQLEnumValue(
              e.name.value,
              e.name.value,
              description: e.description?.value,
              deprecationReason: getDirectiveValue(
                  'deprecated', 'reason', e.directives, payload) as String?,
            ),
          )
        ],
        description: def.description?.value,
      );
    } else if (def is InputObjectTypeDefinitionNode) {
      type = GraphQLInputObjectType(
        name,
        description: def.description?.value,
      );
    } else {
      throw Error();
    }
    types[name] = MapEntry(type, def);
  }

  Iterable<GraphQLFieldInput<Object?, Object?>> arguments(
      List<InputValueDefinitionNode> args) {
    return args.map(
      (e) {
        final type = convertType(e.type, types.values.map((e) => e.key));
        return GraphQLFieldInput(
          e.name.value,
          type,
          description: e.description?.value,
          defaultValue: e.defaultValue == null
              ? null
              : computeValue(type, e.defaultValue!, null),
        );
      },
    );
  }

  types.forEach((key, value) {
    value.key.when(
      list: (list) {},
      nonNullable: (nonNullable) {},
      enum_: (enum_) {},
      scalar: (scalar) {},
      object: (object) {
        final List<FieldDefinitionNode> fields =
            value.value is ObjectTypeDefinitionNode
                ? (value.value as ObjectTypeDefinitionNode).fields
                : (value.value as InterfaceTypeDefinitionNode).fields;

        object.fields.addAll([
          ...fields.map(
            (e) => GraphQLObjectField(
              e.name.value,
              convertType(e.type, types.values.map((e) => e.key)),
              description: e.description?.value,
              inputs: arguments(e.args),
            ),
          )
        ]);

        if (value.value is ObjectTypeDefinitionNode) {
          for (final i
              in (value.value as ObjectTypeDefinitionNode).interfaces) {
            object.inheritFrom(types[i.name.value]!.key as GraphQLObjectType);
          }
        }
      },
      input: (input) {
        final v = value.value as InputObjectTypeDefinitionNode;
        input.fields.addAll(arguments(v.fields));
      },
      union: (union) {
        final v = value.value as UnionTypeDefinitionNode;
        union.possibleTypes.addAll(
          [
            ...v.types.map((e) => types[e.name.value]!.key as GraphQLObjectType)
          ],
        );
      },
    );
  });
  GraphQLObjectType? queryType;
  GraphQLObjectType? mutationType;
  GraphQLObjectType? subscriptionType;
  if (schemaDef.isEmpty) {
    final _queryType = types['Query']?.key ?? types['Queries']?.key;
    if (_queryType is GraphQLObjectType) {
      queryType = _queryType;
    }
    final _mutationType = types['Mutation']?.key ?? types['Mutations']?.key;
    if (_mutationType is GraphQLObjectType) {
      mutationType = _mutationType;
    }
    final _subscriptionType =
        types['Subscription']?.key ?? types['Subscriptions']?.key;
    if (_subscriptionType is GraphQLObjectType) {
      subscriptionType = _subscriptionType;
    }
  } else {
    for (final op in schemaDef.first.operationTypes) {
      final typeName = op.type.name.value;
      switch (op.operation) {
        case OperationType.query:
          queryType = types[typeName]!.key as GraphQLObjectType;
          break;
        case OperationType.mutation:
          mutationType = types[typeName]!.key as GraphQLObjectType;
          break;
        case OperationType.subscription:
          subscriptionType = types[typeName]!.key as GraphQLObjectType;
          break;
      }
    }
  }

  final directives = List.of(
    directiveDefs.map(
      (e) => GraphQLDirective(
        name: e.name.value,
        description: e.description?.value,
        isRepeatable: e.repeatable,
        inputs: List.of(arguments(e.args)),
        locations: List.of(
          e.locations.map((e) => _mapDirectiveLocation[e]!),
        ),
      ),
    ),
  );

  return GraphQLSchema(
    queryType: queryType,
    mutationType: mutationType,
    subscriptionType: subscriptionType,
    serdeCtx: serdeCtx,
    directives: directives,
  );
}

Object? computeValue(
  GraphQLType? targetType,
  ValueNode node,
  Map<String, dynamic>? values,
) =>
    // TODO: we can improve errors by passing targetType
    // but we need to be careful of potential performance
    // problems
    valueFromAst(null, node, values);
// node.accept(GraphQLValueComputer(targetType, values));

// class GraphQLValueComputer extends SimpleVisitor<Object> {
//   final GraphQLType? targetType;
//   final Map<String, dynamic>? variableValues;

//   GraphQLValueComputer(this.targetType, this.variableValues);

//   @override
//   Object visitBooleanValueNode(BooleanValueNode node) => node.value;

//   @override
//   Object? visitEnumValueNode(EnumValueNode node) {
//     final span = (node.span ?? node.name.span)!;
//     final _targetType =
//         targetType?.whenOrNull(nonNullable: (v) => v.ofType) ?? targetType;

//     if (_targetType == null) {
//       throw GraphQLException.fromSourceSpan(
//         'An enum value was given, but in this context,'
//         ' its type cannot be deduced.',
//         span,
//       );
//     } else if (_targetType is! GraphQLEnumType) {
//       throw GraphQLException.fromSourceSpan(
//           'An enum value (${node.name.value}) was given, but the expected type'
//           ' "$targetType" is not an enum.',
//           span);
//     } else {
//       final matchingValue =
//           _targetType.values.firstWhereOrNull((v) => v.name == node.name.value);
//       if (matchingValue == null) {
//         throw GraphQLException.fromSourceSpan(
//           'The enum "$_targetType" has no'
//           ' member named "${node.name.value}".',
//           span,
//         );
//       } else {
//         return matchingValue.name;
//       }
//     }
//   }

//   @override
//   Object visitFloatValueNode(FloatValueNode node) => double.parse(node.value);

//   @override
//   Object visitIntValueNode(IntValueNode node) => int.parse(node.value);

//   @override
//   Object visitListValueNode(ListValueNode node) {
//     return node.values.map((v) => v.accept(this)).toList();
//   }

//   @override
//   Object visitObjectValueNode(ObjectValueNode node) {
//     return Map.fromEntries(node.fields.map((f) {
//       return MapEntry(f.name.value, f.value.accept(this));
//     }));
//   }

//   @override
//   Object? visitNullValueNode(NullValueNode node) => null;

//   @override
//   Object visitStringValueNode(StringValueNode node) => node.value;

//   @override
//   Object? visitVariableNode(VariableNode node) =>
//       variableValues?[node.name.value];
// }

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
      // TODO: this probably should not be here?
      throw GraphQLException.fromMessage(
        'Unknown variable: "$vname"',
        location: (value.span ??
                value.name.span ??
                argument.span ??
                argument.name.span)
            ?.start,
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
      return GraphQLListType<Object?, Object?>(
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

const _mapDirectiveLocation = {
  ast.DirectiveLocation.query: DirectiveLocation.QUERY,
  ast.DirectiveLocation.mutation: DirectiveLocation.MUTATION,
  ast.DirectiveLocation.subscription: DirectiveLocation.SUBSCRIPTION,
  ast.DirectiveLocation.field: DirectiveLocation.FIELD,
  ast.DirectiveLocation.fragmentDefinition:
      DirectiveLocation.FRAGMENT_DEFINITION,
  ast.DirectiveLocation.fragmentSpread: DirectiveLocation.FRAGMENT_SPREAD,
  ast.DirectiveLocation.inlineFragment: DirectiveLocation.INLINE_FRAGMENT,
  ast.DirectiveLocation.schema: DirectiveLocation.SCHEMA,
  ast.DirectiveLocation.scalar: DirectiveLocation.SCALAR,
  ast.DirectiveLocation.object: DirectiveLocation.OBJECT,
  ast.DirectiveLocation.fieldDefinition: DirectiveLocation.FIELD_DEFINITION,
  ast.DirectiveLocation.argumentDefinition:
      DirectiveLocation.ARGUMENT_DEFINITION,
  ast.DirectiveLocation.interface: DirectiveLocation.INTERFACE,
  ast.DirectiveLocation.union: DirectiveLocation.UNION,
  ast.DirectiveLocation.enumDefinition: DirectiveLocation.ENUM,
  ast.DirectiveLocation.enumValue: DirectiveLocation.ENUM_VALUE,
  ast.DirectiveLocation.inputObject: DirectiveLocation.INPUT_OBJECT,
  ast.DirectiveLocation.inputFieldDefinition:
      DirectiveLocation.INPUT_FIELD_DEFINITION,
  // TODO: VARIABLE_DEFINITION https://github.com/gql-dart/gql/pull/279
};
