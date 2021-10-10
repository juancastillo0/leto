import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_path/json_path.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/graphql_utils.dart';
import 'package:shelf_graphql_example/types/safe_json.dart';
import 'package:shelf_graphql_example/types/safe_json_graphql.dart';
import 'package:valida/valida.dart';

export 'package:valida/validate/serde_type.dart';

GraphQLSchema schemaFromJson({
  required String fieldName,
  required String jsonString,
  String typeName = 'Root',
  Map<String, Set<String>>? idFields,
}) {
  final Object? response = jsonDecode(jsonString);
  final json = Json.fromJson(response);
  final schema = serdeTypeFromJson(json, root: response);
  final rootType = graphQLTypeFromSerde(typeName, schema);

  final schemas = <GraphQLSchema>[
    GraphQLSchema(
      queryType: objectType(
        'Query',
        fields: [
          field(
            fieldName,
            rootType,
            resolve: (obj, ctx) => response,
          ),
        ],
      ),
    )
  ];

  GraphQLType _inner(GraphQLType type) {
    return type is GraphQLNonNullType ? type.ofType : type;
  }

  void _addFromList(GraphQLListType listType, String name, Object? listJson) {
    if (listType.ofType is GraphQLNonNullType) {
      final typeInner = (listType.ofType as GraphQLNonNullType).ofType;
      if (typeInner is GraphQLObjectType) {
        final schema = makeMutationSchema(
          typeInner,
          (listJson! as List).cast(),
          fieldName:
              '${name.substring(0, 1).toUpperCase()}${name.substring(1)}',
          idFields: idFields == null ? null : idFields[name],
        );
        schemas.add(schema);
      }
    }
  }

  if (_inner(rootType) is GraphQLListType) {
    final listType = _inner(rootType) as GraphQLListType;
    _addFromList(listType, fieldName, response);
  } else if (response is Map<String, Object?> &&
      _inner(rootType) is GraphQLObjectType) {
    for (final _field in (_inner(rootType) as GraphQLObjectType)
        .fields
        .where((f) => _inner(f.type) is GraphQLListType)) {
      final listType = _inner(_field.type) as GraphQLListType;
      final list = response[_field.name];
      _addFromList(listType, _field.name, list);
    }
  }

  return schemas.reduce(mergeGraphQLSchemas);
}

GraphQLObjectField<Object, Object, Object> graphqlFieldFromJson({
  required String fieldName,
  required String jsonString,
  String typeName = 'Root',
}) {
  final Object? response = jsonDecode(jsonString);
  final json = Json.fromJson(response);
  final schema = serdeTypeFromJson(json, root: response);
  final rootType = graphQLTypeFromSerde(typeName, schema);

  return field(
    fieldName,
    rootType,
    resolve: (obj, ctx) => response,
  );
}

GraphQLSchema makeMutationSchema(
  GraphQLObjectType objType,
  List<Map<String, Object?>> response, {
  required String fieldName,
  Set<String>? idFields,
  bool upsert = true,
}) {
  final mutationFields = <GraphQLObjectField<Object, Object, Object>>[];
  final subscriptionFields = <GraphQLObjectField<Object, Object, Object>>[];

  final controllerAdd = StreamController<Map<String, Object?>>.broadcast();
  final controllerUpdate = StreamController<Map<String, Object?>>.broadcast();
  final controllerDelete = StreamController<Map<String, Object?>>.broadcast();

  final streamGroup = StreamGroup.mergeBroadcast([
    controllerAdd.stream.map((event) => {'type': 'add', 'value': event}),
    controllerUpdate.stream.map((event) => {'type': 'update', 'value': event}),
    controllerDelete.stream.map((event) => {'type': 'delete', 'value': event}),
  ]);

  final idObjectFields = idFields != null
      ? objType.fields.where((f) => idFields.contains(f.name)).toList()
      : null;
  if (idObjectFields != null) {
    assert(idObjectFields.every((f) => f.type.isNonNullable));
  }

  int findById(Map<String, Object?> value, Set<String> idFields) {
    return response.indexWhere((element) {
      return idFields.every((name) => element[name] == value[name]);
    });
  }

  Map<String, Object?>? _update(Map<String, Object?> patch) {
    assert(idFields != null);
    if (idFields == null) {
      return null;
    }
    final previous = findById(patch, idFields);
    if (previous == -1) {
      return null;
    }
    final value = response[previous];
    value.addEntries(patch.entries.where((entry) {
      if (entry.value != null) {
        return true;
      }
      final field = objType.fields.firstWhereOrNull(
        (f) => f.name == entry.key,
      );
      return field != null && field.type.isNullable;
    }));
    controllerUpdate.add(value);

    return value;
  }

  subscriptionFields.add(
    listOf(objType.nonNull()).nonNull().field(
      'on${fieldName}ListChange',
      subscribe: (obj, ctx) {
        return streamGroup.map((event) => response);
      },
    ),
  );

  mutationFields.add(field(
    'add$fieldName',
    idFields == null ? objType.nonNull() : objType,
    resolve: (obj, ctx) {
      final value = ctx.args['value']! as Map<String, Object?>;
      if (idFields != null) {
        final previous = findById(value, idFields);
        if (previous != -1) {
          if (upsert && ctx.args['upsert']! as bool) {
            return _update(value);
          } else {
            return null;
          }
        }
      }
      response.add(value);
      controllerAdd.add(value);

      return value;
    },
    inputs: [
      GraphQLFieldInput(
        'value',
        objType.coerceToInputObject().nonNull(),
      ),
      if (upsert && idFields != null)
        GraphQLFieldInput(
          'upsert',
          graphQLBoolean.nonNull(),
          defaultValue: false,
          description: 'Whether to update the item if it was already created.',
        ),
    ],
  ));

  subscriptionFields.add(field(
    'onAdd$fieldName',
    objType.nonNull(),
    subscribe: (obj, ctx) => controllerAdd.stream,
  ));

  if (idFields != null) {
    /// Delete

    mutationFields.add(field(
      'delete$fieldName',
      objType,
      resolve: (obj, ctx) {
        final previous = findById(ctx.args, idFields);
        if (previous == -1) {
          return null;
        }
        final value = response.removeAt(previous);
        controllerDelete.add(value);

        return value;
      },
      inputs: [
        ...idObjectFields!.map(
          (e) => GraphQLFieldInput(
            e.name,
            e.type.coerceToInputObject().nonNull(),
          ),
        ),
      ],
    ));

    subscriptionFields.add(field(
      'onDelete$fieldName',
      objType.nonNull(),
      subscribe: (obj, ctx) => controllerDelete.stream,
    ));

    /// Update

    mutationFields.add(field(
      'update$fieldName',
      objType,
      resolve: (obj, ctx) {
        return _update(ctx.args);
      },
      inputs: [
        ...objType.fields.map(
          (e) {
            final type = e.type.coerceToInputObject();
            return GraphQLFieldInput(
              e.name,
              idFields.contains(e.name)
                  ? type.nonNull()
                  : (type is GraphQLNonNullType ? type.ofType : type),
            );
          },
        ),
      ],
    ));

    subscriptionFields.add(field(
      'onUpdate$fieldName',
      objType.nonNull(),
      subscribe: (obj, ctx) => controllerUpdate.stream,
    ));

    /// All events

    final eventType = enumTypeFromStrings(
      '${fieldName}EventType',
      ['add', 'update', 'delete'],
    );

    subscriptionFields.add(
      objectType<Map<String, Object?>>(
        '${fieldName}Event',
        fields: [
          eventType.nonNull().field('type'),
          objType.nonNull().field('value'),
        ],
      ).nonNull().field(
        'on${fieldName}Event',
        subscribe: (obj, ctx) {
          return streamGroup;
        },
      ),
    );
  }

  return GraphQLSchema(
    queryType: objectType('Query', fields: []),
    mutationType: objectType('Mutation', fields: mutationFields),
    subscriptionType: objectType('Subcription', fields: subscriptionFields),
  );
}

GraphQLType<Object, Object> graphQLTypeFromSerde(String key, SerdeType type) {
  final GraphQLType<Object, Object> gqlType = type.when(
    bool: () => graphQLBoolean,
    int: () => graphQLInt,
    num: () => graphQLFloat,
    str: () => graphQLString,
    option: (option) => graphQLTypeFromSerde(key, option.generic),
    // TODO:
    duration: () => throw UnimplementedError(),
    list: (list) => listOf(graphQLTypeFromSerde('${key}Item', list.generic)),
    set: (set) => listOf(graphQLTypeFromSerde('${key}Item', set.generic)),
    map: (map) => throw UnimplementedError(),
    // TODO:
    function: () => throw UnimplementedError(),
    nested: (nested) => objectType<Map<String, Object?>>(
      key,
      fields: [
        ...nested.props.entries.map(
          (e) => field(
            e.key,
            graphQLTypeFromSerde('$key${e.key}', e.value),
            resolve: (obj, ctx) => obj[e.key],
          ),
        )
      ],
    ),
    union: (union) => GraphQLUnionType(
      key,
      union.variants.entries
          .map((e) => graphQLTypeFromSerde(e.key, e.value))
          .cast(),
    ),
    unionType: (unionType) {
      final variants = unionType.variants
          .map((e) => graphQLTypeFromSerde('$key${e.inner}', e));
      if (variants.every((v) => v.realType is GraphQLObjectType)) {
        return GraphQLUnionType(
          key,
          variants.cast(),
        );
      } else {
        return graphQLJson;
      }
    },
    enumV: (enumV) => enumTypeFromStrings(
      key,
      enumV.values.map((Object? e) => e.toString().split('.').last).toList(),
    ),
    // TODO:
    dynamic: () => graphQLJson,
    late: (late) => graphQLTypeFromSerde(key, late.func()),
  );

  if (type is SerdeTypeOption) {
    return gqlType is GraphQLNonNullType ? gqlType.ofType : gqlType;
  }
  return gqlType.nonNull();
}

SerdeType serdeTypeFromJson(
  Json obj, {
  Object? root,
  List<String> path = const [],
}) {
  return obj.when(
    map: (map) => SerdeType.nested(map.map(
      (key, value) => MapEntry(
        key,
        serdeTypeFromJson(value, root: root),
      ),
    )),
    list: (list) => SerdeType.list(serdeFromList(list, root: root)),
    number: (v) => v is int ? SerdeType.int : SerdeType.num,
    boolean: (b) => SerdeType.bool,
    str: (value) {
      if (value.startsWith('@late:')) {
        return SerdeType.late(() {
          final Object? val =
              JsonPath(value.substring(6)).readValues(root).first;
          final v = Json.fromJson(val);
          return serdeTypeFromJson(v, root: root);
        });
      }
      return SerdeType.str;
    },
    none: () => const SerdeType.option(SerdeType.dynamic),
  );
}

SerdeType serdeFromList(
  List<Json> obj, {
  Object? root,
  List<String> path = const [],
}) {
  final initial = serdeTypeFromJson(obj.first, root: root);
  return obj.skip(1).fold(
        initial,
        (v, item) => mergeSerdeSchema(v, serdeTypeFromJson(item, root: root)),
      );
}

SerdeType mergeSerdeSchema(
  SerdeType a,
  SerdeType b,
) {
  if (a == b) {
    return a;
    // TODO:
  } else if (a == SerdeType.dynamic || b == SerdeType.dynamic) {
    return a == SerdeType.dynamic ? b : a;
  } else if ((a == SerdeType.num || a == SerdeType.int) &&
      (b == SerdeType.num || b == SerdeType.int)) {
    return a == SerdeType.num || b == SerdeType.num
        ? SerdeType.num
        : SerdeType.int;
  } else if (a is SerdeTypeOption || b is SerdeTypeOption) {
    return SerdeType.option(mergeSerdeSchema(
      a is SerdeTypeOption ? a.generic : a,
      b is SerdeTypeOption ? b.generic : b,
    ));
  } else if (a is SerdeTypeNested && b is SerdeTypeNested) {
    return SerdeType.nested(
      Map.fromEntries(
        a.props.keys.followedBy(b.props.keys).toSet().map(
          (e) {
            final _a = a.props[e];
            final _b = b.props[e];
            return MapEntry(
              e,
              mergeSerdeSchema(
                _a ?? SerdeType.option(_b!),
                _b ?? SerdeType.option(_a!),
              ),
            );
          },
        ),
      ),
    );
  } else if (a is SerdeTypeList && b is SerdeTypeList) {
    return SerdeType.list(mergeSerdeSchema(a.generic, b.generic));
  }
  final Set<SerdeType> variants = {
    if (a is SerdeTypeUnionType) ...a.variants else a,
    if (b is SerdeTypeUnionType) ...b.variants else b,
  };

  return variants.length == 1 ? variants.first : SerdeType.unionType(variants);
}

const jsonPayload = '''
[{
  "id": 1,
  "first_name": "Clarisse",
  "last_name": "Durnan",
  "email": "cdurnan0@xrea.com",
  "gender": "Agender",
  "ip_address": "22.82.125.26"
}, {
  "id": 2,
  "first_name": "Rubia",
  "last_name": "Gaywood",
  "email": "rgaywood1@opera.com",
  "gender": "Non-binary",
  "ip_address": "90.228.223.176"
}, {
  "id": 3,
  "first_name": "Everard",
  "last_name": "Batrim",
  "email": "ebatrim2@accuweather.com",
  "gender": "Female",
  "ip_address": "165.42.90.76"
}, {
  "id": 4,
  "first_name": "Gerti",
  "last_name": "Pahlsson",
  "email": "gpahlsson3@bluehost.com",
  "gender": "Genderqueer",
  "ip_address": "223.48.0.50"
}, {
  "id": 5,
  "first_name": "Maje",
  "last_name": "McKernan",
  "email": "mmckernan4@berkeley.edu",
  "gender": "Female",
  "ip_address": "43.30.127.6"
}, {
  "id": 6,
  "first_name": "Lenette",
  "last_name": "Screas",
  "email": "lscreas5@cdbaby.com",
  "gender": "Agender",
  "ip_address": "13.130.59.125"
}, {
  "id": 7,
  "first_name": "Donnie",
  "last_name": "Melarkey",
  "email": "dmelarkey6@g.co",
  "gender": "Genderfluid",
  "ip_address": "216.57.176.34"
}, {
  "id": 8,
  "first_name": "Andrea",
  "last_name": "McGrane",
  "email": "amcgrane7@topsy.com",
  "gender": "Bigender",
  "ip_address": "130.18.218.3"
}, {
  "id": 9,
  "first_name": "Grier",
  "last_name": "Winchcomb",
  "email": "gwinchcomb8@mediafire.com",
  "gender": "Male",
  "ip_address": "12.245.5.142"
}, {
  "id": 10,
  "first_name": "Kassie",
  "last_name": "Rawlingson",
  "email": "krawlingson9@skyrock.com",
  "gender": "Bigender",
  "ip_address": "14.137.231.53"
}]
''';
