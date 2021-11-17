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

  final types =
      <String, MapEntry<GraphQLType<Object?, Object?>, TypeDefinitionNode>>{};

  for (final def in typeDefs) {
    final name = def.name.value;
    final GraphQLType type;
    if (def is ScalarTypeDefinitionNode) {
      type = GraphQLScalarTypeValue<Object?, Object?>(
        name: name,
        description: def.description?.value,
        specifiedByURL:
            getDirectiveValue('specifiedBy', 'url', def.directives, payload)
                as String?,
        serialize: (s) => s,
        deserialize: (_, s) => s,
        validate: (k, inp) => ValidationResult.ok(inp),
      );
    } else if (def is ObjectTypeDefinitionNode) {
      type = GraphQLObjectType<Object?>(
        name,
        description: def.description?.value,
        isInterface: false,
      );
    } else if (def is InterfaceTypeDefinitionNode) {
      type = GraphQLObjectType<Object?>(
        name,
        description: def.description?.value,
        isInterface: true,
      );
    } else if (def is UnionTypeDefinitionNode) {
      type = GraphQLUnionType<Object?>(
        name,
        [],
        description: def.description?.value,
      );
    } else if (def is EnumTypeDefinitionNode) {
      type = GraphQLEnumType<Object?>(
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
      type = GraphQLInputObjectType<Object?>(
        name,
        description: def.description?.value,
      );
    } else {
      throw Error();
    }
    types[name] = MapEntry(type, def);
  }
  final typesMap = types.map((k, v) => MapEntry(k, v.key));

  Iterable<GraphQLFieldInput<Object?, Object?>> arguments(
    List<InputValueDefinitionNode> args,
  ) {
    return args.map(
      (e) {
        final type = convertType(e.type, typesMap);
        return GraphQLFieldInput(
          e.name.value,
          type,
          description: e.description?.value,
          deprecationReason:
              getDirectiveValue('deprecated', 'reason', e.directives, payload)
                  as String?,
          defaultValue: e.defaultValue == null
              ? null
              : computeValue(type, e.defaultValue!, null),
          defaultsToNull: e.defaultValue is NullValueNode,
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
            (e) => convertType(e.type, typesMap).field(
              e.name.value,
              description: e.description?.value,
              deprecationReason: getDirectiveValue(
                  'deprecated', 'reason', e.directives, payload) as String?,
              inputs: arguments(e.args),
            ),
          )
        ]);
        final List<NamedTypeNode> interfaces =
            value.value is ObjectTypeDefinitionNode
                ? (value.value as ObjectTypeDefinitionNode).interfaces
                : (value.value as InterfaceTypeDefinitionNode).interfaces;

        for (final i in interfaces) {
          object.inheritFrom(types[i.name.value]!.key as GraphQLObjectType);
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
          queryType = queryType ?? types[typeName]?.key as GraphQLObjectType?;
          break;
        case OperationType.mutation:
          mutationType =
              mutationType ?? types[typeName]?.key as GraphQLObjectType?;
          break;
        case OperationType.subscription:
          subscriptionType =
              subscriptionType ?? types[typeName]?.key as GraphQLObjectType?;
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
        locations: List.of(e.locations.map(mapDirectiveLocation)),
      ),
    ),
  );
  final _directiveNames = directives.map((e) => e.name).toSet();
  directives.addAll(
    GraphQLDirective.specifiedDirectives.where(
      (d) => !_directiveNames.contains(d.name),
    ),
  );

  return GraphQLSchema(
    queryType: queryType,
    mutationType: mutationType,
    subscriptionType: subscriptionType,
    serdeCtx: serdeCtx,
    directives: directives,
    otherTypes: typesMap.values.toList(),
    astNode: schemaDoc,
    // TODO: description
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
    final variableName = value.name.value;
    if (variableValues == null || !variableValues.containsKey(variableName)) {
      // TODO: this probably should not be here?
      throw GraphQLException.fromMessage(
        'Unknown variable: "$variableName"',
        location: (value.span ??
                value.name.span ??
                argument.span ??
                argument.name.span)
            ?.start,
      );
    }
    return variableValues[variableName];
  }
  return computeValue(null, value, variableValues);
}

GraphQLType? getNamedType(GraphQLType? type) {
  GraphQLType? _type = type;
  while (_type is GraphQLWrapperType) {
    _type = (_type! as GraphQLWrapperType).ofType;
  }
  return _type;
}

GraphQLType<Object?, Object?>? convertTypeOrNull(
  TypeNode node,
  Map<String, GraphQLType> customTypes,
) {
  try {
    return convertType(node, customTypes);
  } catch (_) {
    return null;
  }
}

/// Returns a [GraphQLType] from a [TypeNode] and
/// a map of names to types [customTypes].
/// throws [GraphQLError] there isn't a match.
GraphQLType<Object?, Object?> convertType(
  TypeNode node,
  Map<String, GraphQLType> customTypes,
) {
  GraphQLType _type() {
    if (node is ListTypeNode) {
      return listOf(convertType(node.type, customTypes));
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
          final type = customTypes[node.name.value];
          if (type == null) {
            throw GraphQLError(
              'Unknown GraphQL type: "${node.name.value}".',
              locations: GraphQLErrorLocation.listFromSource(
                node.span?.start ?? node.name.span?.start,
              ),
            );
          }
          return type;
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

DirectiveLocation mapDirectiveLocation(ast.DirectiveLocation location) =>
    _mapDirectiveLocation[location]!;

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
  ast.DirectiveLocation.variableDefinition:
      DirectiveLocation.VARIABLE_DEFINITION,
};
