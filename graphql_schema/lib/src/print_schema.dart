// https://github.com/graphql/graphql-js/blob/2d48fbbeb8718e4a0152d458145a9fe2111c0f8d/src/utilities/printSchema.js
// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings

part of graphql_schema.src.schema;

const DEFAULT_DEPRECATION_REASON = 'No longer supported';

bool isSpecifiedDirective(GraphQLDirective directive) {
  return const [
    'GraphQLIncludeDirective',
    'GraphQLSkipDirective',
    'GraphQLDeprecatedDirective',
    'GraphQLSpecifiedByDirective',
  ].contains(directive.name);
}

bool isIntrospectionType(GraphQLType type) {
  return const [
    '__Schema',
    '__Directive',
    '__DirectiveLocation',
    '__Type',
    '__Field',
    '__InputValue',
    '__EnumValue',
    '__TypeKind',
  ].contains(type.name);
}

bool isSpecifiedScalarType(GraphQLType type) {
  return const [
    'String',
    'Int',
    'Float',
    'Boolean',
    'ID',
  ].contains(type.name);
}

String printSchema(
  GraphQLSchema schema, {
  SchemaPrinter printer = const SchemaPrinter(),
}) {
  return printer.printFilteredSchema(
    schema,
    (n) => !isSpecifiedDirective(n),
    isDefinedType,
  );
}

String printIntrospectionSchema(
  GraphQLSchema schema, {
  SchemaPrinter printer = const SchemaPrinter(),
}) {
  return printer.printFilteredSchema(
    schema,
    isSpecifiedDirective,
    isIntrospectionType,
  );
}

// TODO: GraphQLNamedType
bool isDefinedType(GraphQLType type) {
  return !isSpecifiedScalarType(type) && !isIntrospectionType(type);
}

class SchemaPrinter {
  const SchemaPrinter({
    this.printTypeName = defPrintTypeName,
    this.printTypeReference = defPrintTypeReference,
  });
  final String Function(GraphQLType) printTypeName;
  final String Function(GraphQLType) printTypeReference;

  static String defPrintTypeName(GraphQLType type) => type.toString();
  static String defPrintTypeReference(GraphQLType type) => type.toString();

  String printFilteredSchema(
    GraphQLSchema schema,
    bool Function(GraphQLDirective) directiveFilter,
    bool Function(GraphQLType) typeFilter,
  ) {
    final directives = schema.directives.where(directiveFilter);
    final types = fetchAllTypes(schema, []).where(typeFilter);

    return [
      printSchemaDefinition(schema),
      ...directives.map((directive) => printDirective(directive)),
      ...types.map((type) => printType(type)),
    ].whereType<Object>().join('\n\n');
  }

  String? printSchemaDefinition(GraphQLSchema schema) {
    if (schema.description == null && isSchemaOfCommonNames(schema)) {
      return null;
    }

    final operationTypes = <String>[];

    final queryType = schema.queryType;
    if (queryType != null) {
      operationTypes.add('  query: ${printTypeReference(queryType)}');
    }

    final mutationType = schema.mutationType;
    if (mutationType != null) {
      operationTypes.add('  mutation: ${printTypeReference(mutationType)}');
    }

    final subscriptionType = schema.subscriptionType;
    if (subscriptionType != null) {
      operationTypes
          .add('  subscription: ${printTypeReference(subscriptionType)}');
    }

    return printDescription(schema.description) +
        'schema {\n${operationTypes.join('\n')}\n}';
  }

  /// GraphQL schema define root types for each type of operation. These types are
  /// the same as any other type and can be named in any manner, however there is
  /// a common naming convention:
  ///
  ///   schema {
  ///     query: Query
  ///     mutation: Mutation
  ///     subscription: Subscription
  ///   }
  ///
  /// When using this naming convention, the schema description can be omitted.
  bool isSchemaOfCommonNames(GraphQLSchema schema) {
    final queryType = schema.queryType;
    if (queryType != null && queryType.name != 'Query') {
      return false;
    }

    final mutationType = schema.mutationType;
    if (mutationType != null && mutationType.name != 'Mutation') {
      return false;
    }

    final subscriptionType = schema.subscriptionType;
    if (subscriptionType != null && subscriptionType.name != 'Subscription') {
      return false;
    }

    return true;
  }

// TODO: GraphQLNamedType
  String printType(GraphQLType type) {
    return type.when(
      enum_: printEnum,
      scalar: printScalar,
      object: printObject,
      input: printInputObject,
      union: printUnion,
      list: (_) => throw Exception('Unexpected type: $type'),
      nonNullable: (_) => throw Exception('Unexpected type: $type'),
    );
  }

  String printScalar(GraphQLScalarType type) {
    return printDescription(type.description) +
        'scalar ${printTypeName(type)}' +
        printSpecifiedByURL(type);
  }

  String printImplementedInterfaces(
    GraphQLObjectType type,
  ) {
    final interfaces = type.interfaces;
    return interfaces.isNotEmpty
        ? ' implements ' +
            interfaces.map((i) => printTypeReference(i)).join(' & ')
        : '';
  }

  String printObject(GraphQLObjectType type) {
    return printDescription(type.description) +
        'type ${printTypeName(type)}' +
        printImplementedInterfaces(type) +
        printFields(type);
  }

// TODO: GraphQLInterfaceType
// String printInterface(GraphQLObjectType type) {
//   return printDescription(type.description) +
//       'interface ${type.name}' +
//       printImplementedInterfaces(type) +
//       printFields(type);
// }

  String printUnion(GraphQLUnionType type) {
    final types = type.possibleTypes;
    final possibleTypes = types.isNotEmpty ? ' = ' + types.join(' | ') : '';
    return printDescription(type.description) +
        'union ' +
        printTypeName(type) +
        possibleTypes;
  }

  String printEnum(GraphQLEnumType type) {
    final values = type.values.mapIndexed(
      (i, value) =>
          printDescription(value.description, '  ', i == 0) +
          '  ' +
          value.name +
          printDeprecated(value.deprecationReason),
    );

    return printDescription(type.description) +
        'enum ${printTypeName(type)}' +
        printBlock(values);
  }

  String printInputObject(GraphQLInputObjectType type) {
    final fields = type.inputFields.mapIndexed(
      (i, f) =>
          printDescription(f.description, '  ', i == 0) +
          '  ' +
          printInputValue(f),
    );
    return printDescription(type.description) +
        'input ${printTypeName(type)}' +
        printBlock(fields);
  }

  String printFields(GraphQLObjectType type) {
    final fields = type.fields.mapIndexed(
      (i, f) =>
          printDescription(f.description, '  ', i == 0) +
          '  ' +
          f.name +
          printArgs(f.inputs, '  ') +
          ': ' +
          printTypeReference(f.type) +
          printDeprecated(f.deprecationReason),
    );
    return printBlock(fields);
  }

  String printBlock(Iterable<String> items) {
    return items.isNotEmpty ? ' {\n${items.join('\n')}\n}' : '';
  }

  String printArgs(
    List<GraphQLInputField> args, [
    String indentation = '',
  ]) {
    if (args.isEmpty) {
      return '';
    }

    // If every arg does not have a description, print them on one line.
    if (args.every((arg) => arg.description == null)) {
      return '(' + args.map(printInputValue).join(', ') + ')';
    }

    return '(\n' +
        args
            .mapIndexed(
              (i, arg) =>
                  printDescription(
                      arg.description, '  ' + indentation, i == 0) +
                  '  ' +
                  indentation +
                  printInputValue(arg),
            )
            .join('\n') +
        '\n' +
        indentation +
        ')';
  }

// GraphQLInputField => GraphQLInputObjectField, GraphQLArgument
  String printInputValue(GraphQLInputField arg) {
    var argDecl = arg.name + ': ' + printTypeReference(arg.type);
    final defaultValue = arg is GraphQLArgument
        ? arg.defaultValue
        : arg is GraphQLInputObjectField
            ? arg.defaultValue
            : null;
    if (defaultValue != null) {
      final defaultAST = astFromValue(defaultValue, arg.type);
      if (defaultAST != null) {
        argDecl += ' = ${printAST(defaultAST)}';
      }
    }
    return argDecl + printDeprecated(arg.deprecationReason);
  }

  String printDirective(GraphQLDirective directive) {
    return printDescription(directive.description) +
        'directive @' +
        directive.name +
        printArgs(directive.args) +
        (directive.isRepeatable ? ' repeatable' : '') +
        ' on ' +
        directive.locations.join(' | ');
  }

  String printDeprecated(String? reason) {
    if (reason == null) {
      return '';
    }
    final reasonAST = astFromValue(reason, graphQLString);
    if (reasonAST != null && reason != DEFAULT_DEPRECATION_REASON) {
      return ' @deprecated(reason: ' + printAST(reasonAST) + ')';
    }
    return ' @deprecated';
  }

  String printSpecifiedByURL(GraphQLScalarType scalar) {
    if (scalar.specifiedByURL == null) {
      return '';
    }
    final url = scalar.specifiedByURL;
    final urlAST = astFromValue(url, graphQLString);
    if (urlAST == null)
      throw Exception(
        'Unexpected null value returned from `astFromValue` for specifiedByURL',
      );
    return ' @specifiedBy(url: ' + printAST(urlAST) + ')';
  }

  String printDescription(
    String? description, [
    String indentation = '',
    bool firstInBlock = true,
  ]) {
    if (description == null) {
      return '';
    }

    final preferMultipleLines = description.length > 70;
    final blockString = printBlockString(description, preferMultipleLines);
    final prefix = indentation.isNotEmpty && !firstInBlock
        ? '\n' + indentation
        : indentation;

    return prefix +
        blockString.replaceAll(RegExp('\n'), '\n' + indentation) +
        '\n';
  }
}

String printAST(String t) => '"$t"';

String? astFromValue(Object? value, GraphQLType type) => value?.toString();

class GraphQLDirective {
  final String name;
  final String? description;
  final List<DirectiveLocationEnum> locations;
  final List<GraphQLArgument> args;
  final bool isRepeatable;
  final Map<String, Object?>? extensions;
  // ?DirectiveDefinitionNode astNode;

  const GraphQLDirective({
    required this.name,
    this.description,
    required this.locations,
    required this.args,
    required this.isRepeatable,
    this.extensions,
  });
}

abstract class GraphQLInputField {
  String get name;
  String? get description;
  GraphQLType get type; // GraphQLInputType
  String? get deprecationReason;
  Object? get defaultValue;
}

class GraphQLArgument implements GraphQLInputField {
  @override
  final String name;
  @override
  final String? description;
  @override
  final GraphQLType type; // GraphQLInputType
  @override
  final Object? defaultValue;
  @override
  final String? deprecationReason;
  final Map<String, Object?>? extensions;
  // final InputValueDefinitionNode? astNode;

  const GraphQLArgument({
    required this.name,
    this.description,
    required this.type,
    this.defaultValue,
    this.deprecationReason,
    this.extensions,
  });
}

// export type GraphQLInputType =
//   | GraphQLScalarType
//   | GraphQLEnumType
//   | GraphQLInputObjectType
//   | GraphQLList<any>
//   | GraphQLNonNull<
//       | GraphQLScalarType
//       | GraphQLEnumType
//       | GraphQLInputObjectType
//       | GraphQLList<any>
//     >;

enum DirectiveLocationEnum {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  // Type System Definitions
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
}

/// Print a block string in the indented block form by adding a leading and
/// trailing blank line. However, if a block string starts with whitespace and is
/// a single-line, adding a leading blank line would strip that whitespace.
///
/// @internal
String printBlockString(
  String value, [
  bool preferMultipleLines = false,
]) {
  final isSingleLine = !value.contains('\n');
  final hasLeadingSpace = value[0] == ' ' || value[0] == '\t';
  final hasTrailingQuote = value[value.length - 1] == '"';
  final hasTrailingSlash = value[value.length - 1] == '\\';
  final printAsMultipleLines = !isSingleLine ||
      hasTrailingQuote ||
      hasTrailingSlash ||
      preferMultipleLines;

  var result = '';
  // Format a multi-line block quote to account for leading space.
  if (printAsMultipleLines && !(isSingleLine && hasLeadingSpace)) {
    result += '\n';
  }
  result += value;
  if (printAsMultipleLines) {
    result += '\n';
  }

  return '"""' + result.replaceAll(RegExp('"""'), '\\"""') + '"""';
}

List<GraphQLType> fetchAllTypes(
    GraphQLSchema schema, List<GraphQLType> specifiedTypes) {
  final data = <GraphQLType>{
    if (schema.queryType != null) schema.queryType!,
    if (schema.mutationType != null) schema.mutationType!,
    if (schema.subscriptionType != null) schema.subscriptionType!,
  }..addAll(specifiedTypes);

  return CollectTypes(data).types.toList();
}

class CollectTypes {
  Set<GraphQLType> traversedTypes = {};

  Set<GraphQLType> get types => traversedTypes;

  CollectTypes(Iterable<GraphQLType> types) {
    types.forEach(_fetchAllTypesFromType);
  }

  CollectTypes.fromRootObject(GraphQLObjectType type) {
    _fetchAllTypesFromObject(type);
  }

  void _fetchAllTypesFromObject(GraphQLObjectType objectType) {
    if (traversedTypes.contains(objectType)) {
      return;
    }

    traversedTypes.add(objectType);

    for (final field in objectType.fields) {
      final type = field.type.realType;
      if (type is GraphQLObjectType) {
        _fetchAllTypesFromObject(type);
      } else if (type is GraphQLInputObjectType) {
        for (final v in type.inputFields) {
          _fetchAllTypesFromType(v.type);
        }
      } else {
        _fetchAllTypesFromType(type);
      }

      for (final input in field.inputs) {
        _fetchAllTypesFromType(input.type);
      }
    }

    for (final i in objectType.interfaces) {
      _fetchAllTypesFromObject(i);
    }
  }

  void _fetchAllTypesFromType(GraphQLType _type) {
    final type = _type.realType;
    if (traversedTypes.contains(type)) {
      return;
    }

    type.when(
      enum_: (type) => traversedTypes.add(type),
      scalar: (type) => traversedTypes.add(type),
      object: _fetchAllTypesFromObject,
      list: (type) => _fetchAllTypesFromType(type.ofType),
      nonNullable: (type) => _fetchAllTypesFromType(type.ofType),
      input: (type) {
        traversedTypes.add(type);
        for (final v in type.inputFields) {
          _fetchAllTypesFromType(v.type);
        }
      },
      union: (type) {
        traversedTypes.add(type);
        for (final t in type.possibleTypes) {
          _fetchAllTypesFromType(t);
        }
      },
    );
  }
}
