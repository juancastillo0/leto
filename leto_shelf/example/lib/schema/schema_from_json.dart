import 'dart:convert';

import 'package:formgen/formgen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/safe_json.dart';
import 'package:shelf_graphql_example/schema/safe_json_graphql.dart';

export 'package:formgen/validate/serde_type.dart';

GraphQLSchema schemaFromJson() {
  // final List<Map<String, Object?>> json =
  //     (jsonDecode(jsonPayload) as List).cast();

  return GraphQLSchema(
    queryType: objectType(
      'Query',
      fields: [
        graphqlFieldFromJson(
          fieldName: 'json',
          jsonString: jsonPayload,
        )
      ],
    ),
  );
}

GraphQLObjectField<Object, Object, Object> graphqlFieldFromJson({
  required String fieldName,
  required String jsonString,
  String typeName = 'Root',
}) {
  final Object? response = jsonDecode(jsonString);
  final json = Json.fromJson(response);
  final schema = serdeTypeFromJson(json);
  final rootType = graphQLTypeFromSerde(typeName, schema);

  return field(
    fieldName,
    rootType,
    resolve: (obj, ctx) => response,
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

SerdeType serdeTypeFromJson(Json obj) {
  return obj.when(
    map: (map) => SerdeType.nested(map.map(
      (key, value) => MapEntry(
        key,
        serdeTypeFromJson(value),
      ),
    )),
    list: (list) => SerdeType.list(serdeFromList(list)),
    number: (v) => v is int ? SerdeType.int : SerdeType.num,
    str: (_) => SerdeType.str,
    none: () => const SerdeType.option(SerdeType.dynamic),
  );
  // if (obj is Map<String, Object?>) {
  //   return Optional(
  //     SerdeType.nested(obj.map((key, value) => MapEntry(key, value))),
  //     nullable: false,
  //   );
  // } else if (obj is int) {

  // }
}

SerdeType serdeFromList(List<Json> obj) {
  final initial = serdeTypeFromJson(obj.first);
  return obj.skip(1).fold(
        initial,
        (v, item) => mergeSerdeSchema(v, serdeTypeFromJson(item)),
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

@immutable
class Optional {
  final bool nullable;
  final SerdeType type;

  const Optional(
    this.type, {
    required this.nullable,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Optional &&
        other.nullable == nullable &&
        other.type == type;
  }

  @override
  int get hashCode => nullable.hashCode ^ type.hashCode;
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
