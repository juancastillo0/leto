import 'package:gql/ast.dart';
import 'package:gql/language.dart' as gql;
import 'package:graphql_schema/graphql_schema.dart';

import 'schema_helpers.dart';

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

  Iterable<GraphQLFieldInput<Object, Object>> arguments(
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
              arguments: arguments(e.args),
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
        input.inputFields.addAll(arguments(v.fields));
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
      switch (op.operation) {
        case OperationType.query:
          queryType = types[op.type.name.value]!.key as GraphQLObjectType;
          break;
        case OperationType.mutation:
          mutationType = types[op.type.name.value]!.key as GraphQLObjectType;
          break;
        case OperationType.subscription:
          subscriptionType =
              types[op.type.name.value]!.key as GraphQLObjectType;
          break;
      }
    }
  }

  return GraphQLSchema(
    queryType: queryType,
    mutationType: mutationType,
    subscriptionType: subscriptionType,
    serdeCtx: serdeCtx,
  );
}
