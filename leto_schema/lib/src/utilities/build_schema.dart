import 'package:collection/collection.dart';
import 'package:gql/ast.dart' as ast;
import 'package:gql/ast.dart' hide DirectiveLocation;
import 'package:gql/language.dart' as gql;
import 'package:leto_schema/leto_schema.dart';
import 'package:leto_schema/src/utilities/ast_from_value.dart';
import 'package:leto_schema/utilities.dart';
import 'package:leto_schema/validate.dart';

/// Create a [GraphQLSchema] from a GraphQL Schema Definition
/// Language (SDL) String [schemaStr].
///
/// throws [SourceSpanException] if there is an error on parsing
/// throws [GraphQLException] if there is an error on SDL or schema validation
GraphQLSchema buildSchema(
  String schemaStr, {
  Map<String, Object?>? payload,
  SerdeCtx? serdeCtx,
}) {
  final schemaDoc = gql.parseString(schemaStr);

  final errors = validateSDL(schemaDoc);
  if (errors.isNotEmpty) {
    throw GraphQLException(errors);
  }

  final schemaDef = schemaDoc.definitions.whereType<SchemaDefinitionNode>();
  final typeDefs = schemaDoc.definitions.whereType<TypeDefinitionNode>();
  final directiveDefs =
      schemaDoc.definitions.whereType<DirectiveDefinitionNode>();
  final typeDefsExtensions = schemaDoc.definitions
      .whereType<TypeExtensionNode>()
      .groupListsBy((element) => element.name.value);

  final typesMap = <String, GraphQLNamedType<Object?, Object?>>{};

  final directives = List.of(
    directiveDefs.map(
      (e) => GraphQLDirective(
        name: e.name.value,
        description: e.description?.value,
        isRepeatable: e.repeatable,
        locations: List.of(e.locations.map(mapDirectiveLocation)),
        astNode: e,
      ),
    ),
  );
  final _directiveNames = directives.map((e) => e.name).toSet();
  directives.addAll(
    GraphQLDirective.specifiedDirectives.where(
      (d) => !_directiveNames.contains(d.name),
    ),
  );

  final Map<String, GraphQLDirective> directivesMap = directives
      .fold({}, (previous, element) => previous..[element.name] = element);

  for (final def in typeDefs) {
    final name = def.name.value;
    final extensions = typeDefsExtensions[name] ?? [];

    final GraphQLNamedType type;
    if (def is ScalarTypeDefinitionNode) {
      final _extensions =
          extensions.whereType<ScalarTypeExtensionNode>().toList();
      type = GraphQLScalarTypeValue<Object?, Object?>(
        name: name,
        description: def.description?.value,
        specifiedByURL: getDirectiveValue(
          'specifiedBy',
          'url',
          def.directives,
          payload,
          directivesMap: directivesMap,
        ) as String?,
        serialize: (s) => s,
        deserialize: (_, s) => s,
        validate: (k, inp) => ValidationResult.ok(inp),
        extra: GraphQLTypeDefinitionExtra.ast(def, _extensions),
      );
    } else if (def is ObjectTypeDefinitionNode) {
      final _extensions =
          extensions.whereType<ObjectTypeExtensionNode>().toList();
      type = GraphQLObjectType<Object?>(
        name,
        description: def.description?.value,
        isInterface: false,
        extra: GraphQLTypeDefinitionExtra.ast(def, _extensions),
      );
    } else if (def is InterfaceTypeDefinitionNode) {
      final _extensions =
          extensions.whereType<InterfaceTypeExtensionNode>().toList();
      type = GraphQLObjectType<Object?>(
        name,
        description: def.description?.value,
        isInterface: true,
        extra: GraphQLTypeDefinitionExtra.ast(def, _extensions),
      );
    } else if (def is UnionTypeDefinitionNode) {
      final _extensions =
          extensions.whereType<UnionTypeExtensionNode>().toList();
      type = GraphQLUnionType<Object?>(
        name,
        [],
        description: def.description?.value,
        extra: GraphQLTypeDefinitionExtra.ast(def, _extensions),
      );
    } else if (def is EnumTypeDefinitionNode) {
      final _extensions =
          extensions.whereType<EnumTypeExtensionNode>().toList();
      type = GraphQLEnumType<Object?>(
        name,
        [
          ...def.values.map(
            (e) => GraphQLEnumValue(
              e.name.value,
              EnumValue(e.name.value),
              description: e.description?.value,
              deprecationReason: getDirectiveValue(
                'deprecated',
                'reason',
                e.directives,
                payload,
                directivesMap: directivesMap,
              ) as String?,
              astNode: e,
            ),
          )
        ],
        description: def.description?.value,
        extra: GraphQLTypeDefinitionExtra.ast(def, _extensions),
      );
    } else if (def is InputObjectTypeDefinitionNode) {
      final _extensions =
          extensions.whereType<InputObjectTypeExtensionNode>().toList();
      type = GraphQLInputObjectType<Object?>(
        name,
        description: def.description?.value,
        extra: GraphQLTypeDefinitionExtra.ast(def, _extensions),
        isOneOf: def.directives.any((d) => d.name.value == 'oneOf'),
      );
    } else {
      throw Error();
    }
    typesMap[name] = type;
    if (type.extra.extensionAstNodes.length != extensions.length) {
      final wrongExtensions = extensions
          .where((element) => !type.extra.extensionAstNodes.contains(element))
          .toList();
      errors.add(GraphQLError(
        'Cannot extend $type with ${wrongExtensions.map((e) => e.runtimeType).join(', ')}.',
        locations: [
          ...wrongExtensions.map((e) =>
              GraphQLErrorLocation.fromSourceLocation(e.name.span!.start)),
        ],
      ));
    }
  }

  Iterable<GraphQLFieldInput<Object?, Object?>> arguments(
    NameNode nameNode,
    List<InputValueDefinitionNode> args, {
    String? objectName,
  }) {
    return args.map(
      (e) {
        final type = convertTypeOrNull(e.type, typesMap);
        if (!isInputType(type)) {
          final fieldName = objectName == null
              ? '${nameNode.value}.${e.name.value}'
              : '$objectName.${nameNode.value}(${e.name.value}:)';
          errors.add(
            GraphQLError(
              'The type of $fieldName must be Input Type but got: $type.',
              locations: GraphQLErrorLocation.firstFromNodes([
                e,
                e.type,
                nameNode,
              ]),
            ),
          );
          return null;
        }
        return GraphQLFieldInput(
          e.name.value,
          type!,
          description: e.description?.value,
          deprecationReason: getDirectiveValue(
            'deprecated',
            'reason',
            e.directives,
            payload,
            directivesMap: directivesMap,
          ) as String?,
          defaultValue: e.defaultValue == null
              ? null
              : computeValue(type, e.defaultValue!, null),
          defaultsToNull: e.defaultValue is NullValueNode,
          astNode: e,
        );
      },
    ).whereType();
  }

  directiveDefs.forEachIndexed((index, e) {
    directives[index].inputs.addAll(arguments(e.name, e.args));
  });

  typesMap.forEach((key, value) {
    value.whenNamed(
      enum_: (enum_) {},
      scalar: (scalar) {},
      object: (object) {
        final astNode = object.extra.astNode!;
        final extensionAstNodes = object.extra.extensionAstNodes;
        final List<FieldDefinitionNode> fields = [
          ...astNode is ObjectTypeDefinitionNode
              ? astNode.fields
              : (astNode as InterfaceTypeDefinitionNode).fields,
          ...extensionAstNodes is List<ObjectTypeExtensionNode>
              ? extensionAstNodes.expand((e) => e.fields)
              : (extensionAstNodes as List<InterfaceTypeExtensionNode>)
                  .expand((e) => e.fields),
        ];

        object.fields.addAll([
          ...fields.map(
            (e) {
              final type = convertTypeOrNull(e.type, typesMap);
              if (!isOutputType(type)) {
                errors.add(GraphQLError(
                  'The type of ${object.name}.${e.name.value} must be Output Type but got: $type.',
                ));
                return null;
              }
              return type!.field<Object?>(
                e.name.value,
                description: e.description?.value,
                deprecationReason: getDirectiveValue(
                  'deprecated',
                  'reason',
                  e.directives,
                  payload,
                  directivesMap: directivesMap,
                ) as String?,
                inputs: arguments(e.name, e.args, objectName: object.name),
                astNode: e,
              );
            },
          ).whereType()
        ]);

        final List<NamedTypeNode> interfaces =
            extensionAstNodes is List<ObjectTypeExtensionNode>
                ? [
                    ...(astNode as ObjectTypeDefinitionNode).interfaces,
                    ...extensionAstNodes.expand((element) => element.interfaces)
                  ]
                : [
                    ...(astNode as InterfaceTypeDefinitionNode).interfaces,
                    ...(extensionAstNodes as List<InterfaceTypeExtensionNode>)
                        .expand((element) => element.interfaces)
                  ];

        for (final i in interfaces) {
          // TODO: 3I could be null?
          final type = typesMap[i.name.value];
          if (type is! GraphQLObjectType || !type.isInterface) {
            errors.add(
              GraphQLError(
                'Type $object must only implement Interface types,'
                ' it cannot implement ${i.name.value}.',
              ),
            );
            continue;
          }
          object.inheritFrom(type);
        }
      },
      input: (input) {
        final astNode = input.extra.astNode!;
        final fields = [
          ...astNode.fields,
          ...input.extra.extensionAstNodes.expand((e) => e.fields)
        ];
        input.fields.addAll(arguments(astNode.name, fields));
      },
      union: (union) {
        final typeNodes = [
          ...union.extra.astNode!.types,
          ...union.extra.extensionAstNodes.expand((e) => e.types)
        ];
        union.possibleTypes.addAll(
          [
            ...typeNodes.map((e) {
              final type = typesMap[e.name.value];
              if (type is! GraphQLObjectType || type.isInterface) {
                errors.add(
                  GraphQLError(
                    'Union type $union can only include Object types,'
                    ' it cannot include ${e.name.value}.',
                    locations: [
                      GraphQLErrorLocation.fromSourceLocation(
                          e.name.span!.start),
                    ],
                  ),
                );
                return null;
              }
              return type;
            }).whereType()
          ],
        );
      },
    );
  });
  GraphQLObjectType? queryType;
  GraphQLObjectType? mutationType;
  GraphQLObjectType? subscriptionType;
  SchemaDefinitionNode? schemaNode;
  if (schemaDef.isEmpty) {
    final _queryType = typesMap['Query'];
    if (_queryType is GraphQLObjectType) {
      queryType = _queryType;
    }
    final _mutationType = typesMap['Mutation'];
    if (_mutationType is GraphQLObjectType) {
      mutationType = _mutationType;
    }
    final _subscriptionType = typesMap['Subscription'];
    if (_subscriptionType is GraphQLObjectType) {
      subscriptionType = _subscriptionType;
    }
    [
      _queryType,
      _mutationType,
      _subscriptionType,
    ].forEachIndexed((index, element) {
      if (element != null &&
          (element is! GraphQLObjectType || element.isInterface)) {
        final opType = const ['Query', 'Mutation', 'Subscription'][index];
        errors.add(GraphQLError(
          '$opType root type must be Object type${index != 0 ? ' if provided' : ''}, it cannot be $element.',
        ));
      }
    });
  } else {
    schemaNode = schemaDef.first;
    for (final op in schemaDef.first.operationTypes) {
      final typeName = op.type.name.value;
      final type = typesMap[typeName];
      if (type != null && (type is! GraphQLObjectType || type.isInterface)) {
        final opType = op.operation.toString().split('.').last;
        errors.add(GraphQLError(
          '${opType.substring(0, 1).toUpperCase()}${opType.substring(1)}'
          ' root type must be Object type${op.operation != OperationType.query ? ' if provided' : ''}, it cannot be $type.',
        ));
        continue;
      }
      switch (op.operation) {
        case OperationType.query:
          queryType = queryType ?? type as GraphQLObjectType?;
          break;
        case OperationType.mutation:
          mutationType = mutationType ?? type as GraphQLObjectType?;
          break;
        case OperationType.subscription:
          subscriptionType = subscriptionType ?? type as GraphQLObjectType?;
          break;
      }
    }
  }

  if (errors.isNotEmpty) {
    throw GraphQLException(errors);
  }

  return GraphQLSchema(
    queryType: queryType,
    mutationType: mutationType,
    subscriptionType: subscriptionType,
    serdeCtx: serdeCtx,
    directives: directives,
    otherTypes: typesMap.values.toList(),
    astNode: schemaNode,
    // TODO: 3I extensionAstNodes
  );
}

Object? computeValue(
  GraphQLType? targetType,
  ValueNode node,
  Map<String, dynamic>? values,
) =>
    // TODO: 3I we can improve errors by passing targetType
    // but we need to be careful of potential performance
    // problems
    valueFromAst(null, node, values);

Object? getDirectiveValue(
  String name,
  String argumentName,
  List<DirectiveNode> directives,
  Map<String, Object?>? variableValues, {
  Map<String, GraphQLDirective> directivesMap = const {},
}) {
  final directive = directives.firstWhereOrNull(
    (d) => d.name.value == name,
  );
  if (directive == null) return null;

  final argument = directive.arguments.firstWhereOrNull(
    (arg) => arg.name.value == argumentName,
  );
  if (argument == null) {
    final arg = directivesMap[name]?.inputs.firstWhereOrNull(
          (arg) => arg.name == argumentName,
        );
    return arg?.defaultValue;
  }

  final value = argument.value;
  if (value is VariableNode) {
    final variableName = value.name.value;
    if (variableValues == null || !variableValues.containsKey(variableName)) {
      // TODO: 2I this probably should not be here?
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

GraphQLNamedType getNamedType(GraphQLType type) {
  GraphQLType _type = type;
  while (_type is GraphQLWrapperType) {
    _type = (_type as GraphQLWrapperType).ofType;
  }
  return _type as GraphQLNamedType;
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
