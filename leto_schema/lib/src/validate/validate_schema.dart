// ignore_for_file: prefer_is_empty

import 'rules_prelude.dart';

export 'package:leto_schema/leto_schema.dart' show validateSchema;

/// Utility function which asserts a schema is valid by throwing an error if
/// it is invalid.
void assertValidSchema(GraphQLSchema schema) {
  final errors = validateSchema(schema);
  if (errors.length != 0) {
    throw GraphQLException(errors);
  }
}

class SchemaValidationContext {
  final _errors = <GraphQLError>[];
  final GraphQLSchema schema;

  SchemaValidationContext(this.schema);

  void reportError(
    String message,
    List<Node?> nodes,
  ) {
    _errors.add(GraphQLError(
      message,
      locations: List.of(
        nodes.map((e) {
          final span = e?.span ?? e?.nameNode?.span;
          return span == null
              ? null
              : GraphQLErrorLocation.fromSourceLocation(span.start);
        }).whereType(),
      ),
    ));
  }

  List<GraphQLError> getErrors() {
    return _errors;
  }
}

void validateRootTypes(SchemaValidationContext context) {
  final schema = context.schema;
  final queryType = schema.queryType;
  if (queryType == null) {
    context.reportError(
      'Query root type must be provided.',
      [schema.astNode],
    );
  }
  // TODO: interfaces

  // else if (!isObjectType(queryType)) {
  //   context.reportError(
  //     'Query root type must be Object type, it cannot be ${inspect(
  //       queryType,
  //     )}.',
  //     getOperationTypeNode(schema, OperationTypeNode.QUERY) ??
  //         (queryType as any).astNode,
  //   );
  // }

  // final mutationType = schema.getMutationType();
  // if (mutationType && !isObjectType(mutationType)) {
  //   context.reportError(
  //     'Mutation root type must be Object type if provided, it cannot be '
  //         '${inspect(mutationType)}.',
  //     getOperationTypeNode(schema, OperationTypeNode.MUTATION) ??
  //         (mutationType as any).astNode,
  //   );
  // }

  // final subscriptionType = schema.getSubscriptionType();
  // if (subscriptionType && !isObjectType(subscriptionType)) {
  //   context.reportError(
  //     'Subscription root type must be Object type if provided, it cannot be '
  //         '${inspect(subscriptionType)}.',
  //     getOperationTypeNode(schema, OperationTypeNode.SUBSCRIPTION) ??
  //         (subscriptionType as any).astNode,
  //   );
  // }
}

Node? getOperationTypeNode(
  GraphQLSchema schema,
  OperationType operation,
) {
  // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
  return [
    if (schema.astNode != null) ...schema.astNode!.operationTypes,
    ...schema.extensionAstNodes.expand((ext) => ext.operationTypes)
  ]
      .firstWhereOrNull((operationNode) => operationNode.operation == operation)
      ?.type;
}

void validateDirectives(SchemaValidationContext context) {
  for (final directive in context.schema.directives) {
    // Ensure all directives are in fact GraphQL directives.
    // if (!isDirective(directive)) {
    //   context.reportError(
    //     'Expected directive but got: ${inspect(directive)}.',
    //     (directive as any)?.astNode,
    //   );
    //   continue;
    // }

    // Ensure they are named correctly.
    validateName(context, directive);

    // TODO: Ensure proper locations.

    // Ensure the arguments are valid.
    for (final arg in directive.inputs) {
      // Ensure they are named correctly.
      validateName(context, arg);

      // Ensure the type is an input type.
      if (!isInputType(arg.type)) {
        context.reportError(
          'The type of @${directive.name}(${arg.name}:) must be Input Type '
          'but got: ${inspect(arg.type)}.',
          [arg.astNode],
        );
      }

      if (arg.isRequired && arg.deprecationReason != null) {
        context.reportError(
          'Required argument @${directive.name}(${arg.name}:) cannot be deprecated.',
          [
            getDeprecatedDirectiveNode(arg.astNode?.directives),
            arg.astNode?.type
          ],
        );
      }
    }
  }
}

void validateName(
  SchemaValidationContext context,
  GraphQLElement node,
  // : { readonly name: string; readonly astNode: Maybe<ASTNode> },
) {
  // Ensure names are valid, however introspection types opt out.
  if (node.name.startsWith('__')) {
    context.reportError(
      'Name "${node.name}" must not begin with "__", which is reserved by GraphQL introspection.',
      [node.astNode],
    );
  }
}

void validateTypes(SchemaValidationContext context) {
  final validateInputObjectCircularRefs =
      createInputObjectCircularRefsValidator(context);
  final typeMap = context.schema.typeMap;
  for (final type in typeMap.values) {
    // Ensure all provided types are in fact GraphQL type.
    // if (type is! GraphQLNamedType) {
    //   context.reportError(
    //     'Expected GraphQL named type but got: ${inspect(type)}.',
    //     [type.astNode],
    //   );
    //   continue;
    // }

    // Ensure it is named correctly (excluding introspection types).
    if (!isIntrospectionType(type)) {
      validateName(context, type);
    }

    type.whenNamed(
      enum_: (type) {
        // Ensure Enums have valid values.
        validateEnumValues(context, type);
      },
      scalar: (type) {},
      object: (type) {
        if (!type.isInterface) {
          // Ensure fields are valid
          validateFields(context, type);

          // Ensure objects implement the interfaces they claim to.
          validateInterfaces(context, type);
        } else {
          // Ensure fields are valid.
          validateFields(context, type);

          // Ensure interfaces implement the interfaces they claim to.
          validateInterfaces(context, type);
        }
      },
      input: (type) {
        // Ensure Input Object fields are valid.
        validateInputFields(context, type);

        // Ensure Input Objects do not contain non-nullable circular references
        validateInputObjectCircularRefs(type);
      },
      union: (type) {
        // Ensure Unions include valid member types.
        validateUnionMembers(context, type);
      },
    );
  }
}

void validateFields(
  SchemaValidationContext context,
  GraphQLObjectType type, // | GraphQLInterfaceType
) {
  final fields = type.fields;

  // Objects and Interfaces both must define one or more fields.
  if (fields.length == 0) {
    context.reportError('Type ${type.name} must define one or more fields.', [
      type.astNode,
      ...type.extra.extensionAstNodes,
    ]);
  }

  for (final field in fields) {
    // Ensure they are named correctly.
    validateName(context, field);

    // Ensure the type is an output type
    if (!isOutputType(field.type)) {
      context.reportError(
        'The type of ${type.name}.${field.name} must be Output Type '
        'but got: ${inspect(field.type)}.',
        [field.astNode?.type],
      );
    }

    // Ensure the arguments are valid
    for (final arg in field.inputs) {
      final argName = arg.name;

      // Ensure they are named correctly.
      validateName(context, arg);

      // Ensure the type is an input type
      if (!isInputType(arg.type)) {
        context.reportError(
          'The type of ${type.name}.${field.name}(${argName}:) must be Input '
          'Type but got: ${inspect(arg.type)}.',
          [arg.astNode?.type],
        );
      }

      if (arg.isRequired && arg.deprecationReason != null) {
        context.reportError(
          'Required argument ${type.name}.${field.name}(${argName}:) cannot be deprecated.',
          [
            getDeprecatedDirectiveNode(arg.astNode?.directives),
            arg.astNode?.type
          ],
        );
      }
    }
  }
}

void validateInterfaces(
  SchemaValidationContext context,
  GraphQLObjectType type, // | GraphQLInterfaceType
) {
  final ifaceTypeNames = <String>{};
  for (final iface in type.interfaces) {
    if (iface is! GraphQLObjectType || !iface.isInterface) {
      context.reportError(
        'Type ${inspect(type)} must only implement Interface types, '
        'it cannot implement ${inspect(iface)}.',
        getAllImplementsInterfaceNodes(type, iface),
      );
      continue;
    }

    if (type == iface) {
      context.reportError(
        'Type ${type.name} cannot implement itself because it would create a circular reference.',
        getAllImplementsInterfaceNodes(type, iface),
      );
      continue;
    }

    if (ifaceTypeNames.contains(iface.name)) {
      context.reportError(
        'Type ${type.name} can only implement ${iface.name} once.',
        getAllImplementsInterfaceNodes(type, iface),
      );
      continue;
    }

    ifaceTypeNames.add(iface.name);

    validateTypeImplementsAncestors(context, type, iface);
    validateTypeImplementsInterface(context, type, iface);
  }
}

void validateTypeImplementsInterface(
  SchemaValidationContext context,
  GraphQLObjectType type, // | GraphQLInterfaceType
  GraphQLObjectType iface, // GraphQLInterfaceType
) {
  final typeFieldMap = type.fields;

  // Assert each interface field is implemented.
  for (final ifaceField in iface.fields) {
    final fieldName = ifaceField.name;
    final typeField = type.fieldByName(fieldName);

    // Assert interface field exists on type.
    if (typeField == null) {
      context.reportError(
        'Interface field ${iface.name}.${fieldName} expected but ${type.name} does not provide it.',
        [ifaceField.astNode, type.astNode, ...type.extra.extensionAstNodes],
      );
      continue;
    }

    // Assert interface field type is satisfied by type field type, by being
    // a valid subtype. (covariant)
    if (!isTypeSubTypeOf(context.schema, typeField.type, ifaceField.type)) {
      context.reportError(
        'Interface field ${iface.name}.${fieldName} expects type '
        '${inspect(ifaceField.type)} but ${type.name}.${fieldName} '
        'is type ${inspect(typeField.type)}.',
        [ifaceField.astNode?.type, typeField.astNode?.type],
      );
    }

    // Assert each interface field arg is implemented.
    for (final ifaceArg in ifaceField.inputs) {
      final argName = ifaceArg.name;
      final typeArg =
          typeField.inputs.firstWhereOrNull((arg) => arg.name == argName);

      // Assert interface field arg exists on object field.
      if (typeArg == null) {
        context.reportError(
          'Interface field argument ${iface.name}.${fieldName}(${argName}:)'
          ' expected but ${type.name}.${fieldName} does not provide it.',
          [ifaceArg.astNode, typeField.astNode],
        );
        continue;
      }

      // Assert interface field arg type matches object field arg type.
      // (invariant)
      // TODO: change to contravariant?
      if (!isEqualType(ifaceArg.type, typeArg.type)) {
        context.reportError(
          'Interface field argument ${iface.name}.${fieldName}(${argName}:) '
          'expects type ${inspect(ifaceArg.type)} but '
          '${type.name}.${fieldName}(${argName}:) is type '
          '${inspect(typeArg.type)}.',
          [
            // istanbul ignore next
            // TODO: need to write coverage tests
            ifaceArg.astNode?.type,
            // istanbul ignore next
            // TODO: need to write coverage tests
            typeArg.astNode?.type,
          ],
        );
      }

      // TODO: validate default values?
    }

    // Assert additional arguments must not be required.
    for (final typeArg in typeField.inputs) {
      final argName = typeArg.name;
      final ifaceArg =
          ifaceField.inputs.firstWhereOrNull((arg) => arg.name == argName);
      if (ifaceArg == null && typeArg.isRequired) {
        context.reportError(
          'Object field ${type.name}.${fieldName} includes required argument'
          ' ${argName} that is missing from the Interface field ${iface.name}.${fieldName}.',
          [typeArg.astNode, ifaceField.astNode],
        );
      }
    }
  }
}

void validateTypeImplementsAncestors(
  SchemaValidationContext context,
  GraphQLObjectType type, // | GraphQLInterfaceType
  GraphQLObjectType iface, // GraphQLInterfaceType
) {
  final ifaceInterfaces = type.interfaces;
  for (final transitive in iface.interfaces) {
    if (!ifaceInterfaces.contains(transitive)) {
      context.reportError(
        transitive == type
            ? 'Type ${type.name} cannot implement ${iface.name} because it would create a circular reference.'
            : 'Type ${type.name} must implement ${transitive.name} because it is implemented by ${iface.name}.',
        [
          ...getAllImplementsInterfaceNodes(iface, transitive),
          ...getAllImplementsInterfaceNodes(type, iface),
        ],
      );
    }
  }
}

void validateUnionMembers(
  SchemaValidationContext context,
  GraphQLUnionType union,
) {
  final memberTypes = union.possibleTypes;

  if (memberTypes.length == 0) {
    context.reportError(
      'Union type ${union.name} must define one or more member types.',
      [union.astNode, ...union.extra.extensionAstNodes],
    );
  }

  final includedTypeNames = <String>{};
  for (final memberType in memberTypes) {
    if (includedTypeNames.contains(memberType.name)) {
      context.reportError(
        'Union type ${union.name} can only include type ${memberType.name} once.',
        getUnionMemberTypeNodes(union, memberType.name),
      );
      continue;
    }
    includedTypeNames.add(memberType.name);
    if (memberType.isInterface) {
      context.reportError(
        'Union type ${union.name} can only include Object types, '
        'it cannot include ${inspect(memberType)}.',
        getUnionMemberTypeNodes(union, memberType.name),
      );
    }
  }
}

void validateEnumValues(
  SchemaValidationContext context,
  GraphQLEnumType enumType,
) {
  final enumValues = enumType.values;

  if (enumValues.length == 0) {
    context.reportError(
      'Enum type ${enumType.name} must define one or more values.',
      [enumType.astNode, ...enumType.extra.extensionAstNodes],
    );
  }

  for (final enumValue in enumValues) {
    // Ensure valid name.
    validateName(context, enumValue);
  }
}

void validateInputFields(
  SchemaValidationContext context,
  GraphQLInputObjectType inputObj,
) {
  final fields = inputObj.fields;

  if (fields.length == 0) {
    context.reportError(
      'Input Object type ${inputObj.name} must define one or more fields.',
      [inputObj.astNode, ...inputObj.extra.extensionAstNodes],
    );
  }

  // Ensure the arguments are valid
  for (final field in fields) {
    // Ensure they are named correctly.
    validateName(context, field);

    // Ensure the type is an input type
    if (!isInputType(field.type)) {
      context.reportError(
        'The type of ${inputObj.name}.${field.name} must be Input Type '
        'but got: ${inspect(field.type)}.',
        [field.astNode?.type],
      );
    }

    if (field.isRequired && field.deprecationReason != null) {
      context.reportError(
        'Required input field ${inputObj.name}.${field.name} cannot be deprecated.',
        [
          getDeprecatedDirectiveNode(field.astNode?.directives),
          // istanbul ignore next (TODO need to write coverage tests)
          field.astNode?.type,
        ],
      );
    }
  }
}

void Function(GraphQLInputObjectType) createInputObjectCircularRefsValidator(
  SchemaValidationContext context,
) {
  // Modified copy of algorithm from 'src/validation/rules/NoFragmentCycles.js'.
  // Tracks already visited types to maintain O(N) and to ensure that cycles
  // are not redundantly reported.
  final visitedTypes = <String>{};

  // Array of types nodes used to produce meaningful errors
  final fieldPath = <GraphQLFieldInput>[];

  // Position in the type path
  final fieldPathIndexByTypeName = <String, int?>{};

  // This does a straight-forward DFS to find cycles.
  // It does not terminate when a cycle was found but continues to explore
  // the graph to find all possible cycles.
  void detectCycleRecursive(GraphQLInputObjectType inputObj) {
    if (visitedTypes.contains(inputObj.name)) {
      return;
    }

    visitedTypes.add(inputObj.name);
    fieldPathIndexByTypeName[inputObj.name] = fieldPath.length;

    for (final field in inputObj.fields) {
      final _type = field.type;
      if (_type is GraphQLNonNullType &&
          _type.ofType is GraphQLInputObjectType) {
        final fieldType = _type.ofType as GraphQLInputObjectType;
        final cycleIndex = fieldPathIndexByTypeName[fieldType.name];

        fieldPath.add(field);
        if (cycleIndex == null) {
          detectCycleRecursive(fieldType);
        } else {
          final cyclePath = fieldPath.slice(cycleIndex);
          final pathStr = cyclePath.map((fieldObj) => fieldObj.name).join('.');
          context.reportError(
            'Cannot reference Input Object "${fieldType.name}" within'
            ' itself through a series of non-null fields: "${pathStr}".',
            cyclePath.map((fieldObj) => fieldObj.astNode).toList(),
          );
        }
        fieldPath.removeLast();
      }
    }

    fieldPathIndexByTypeName[inputObj.name] = null;
  }

  return detectCycleRecursive;
}

List<NamedTypeNode> getAllImplementsInterfaceNodes(
    GraphQLObjectType type, // | GraphQLInterfaceType,
    GraphQLObjectType iface // : GraphQLInterfaceType,
    ) {
  final astNode = type.extra.astNode;
  final extensionAstNodes = type.extra.extensionAstNodes;
  final List<NamedTypeNode> nodes = !type.isInterface
      ? [
          if (astNode != null)
            ...(astNode as ObjectTypeDefinitionNode).interfaces,
          ...extensionAstNodes.expand(
              (element) => (element as ObjectTypeExtensionNode).interfaces)
        ]
      : [
          if (astNode != null)
            ...(astNode as InterfaceTypeDefinitionNode).interfaces,
          ...extensionAstNodes.expand(
              (element) => (element as InterfaceTypeExtensionNode).interfaces)
        ];

  // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
  return nodes
      .where((ifaceNode) => ifaceNode.name.value == iface.name)
      .toList();
}

List<NamedTypeNode> getUnionMemberTypeNodes(
  GraphQLUnionType union,
  String typeName,
) {
  final astNode = union.extra.astNode;
  final nodes = [
    if (astNode != null) ...astNode.types,
    ...union.extra.extensionAstNodes.expand((element) => element.types)
  ];

  // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
  return nodes.where((typeNode) => typeNode.name.value == typeName).toList();
}

DirectiveNode? getDeprecatedDirectiveNode(
  List<DirectiveNode>? directives,
) {
  // istanbul ignore next (See: 'https://github.com/graphql/graphql-js/issues/2203')
  return directives?.firstWhereOrNull(
    (node) => node.name.value == graphQLDeprecatedDirective.name,
  );
}
