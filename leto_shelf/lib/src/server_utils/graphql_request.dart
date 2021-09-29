import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:oxidized/oxidized.dart';

import 'request_from_multipart.dart';

part 'graphql_request.g.dart';

@JsonSerializable()
class GraphQLRequest {
  final String query;
  final String? operationName;
  final Map<String, Object?>? variables;
  final Map<String, Object?>? extensions;
  final GraphQLRequest? child;
  final bool isBatched;

  const GraphQLRequest({
    required this.query,
    this.operationName,
    this.variables,
    this.extensions,
    this.child,
    this.isBatched = false,
  });

  factory GraphQLRequest.fromJson(Object? json) {
    if (json is List) {
      final list = json.cast<Map<String, Object?>>();
      return GraphQLRequest.fromJson(
        {
          ...list.reversed.reduce(
            (value, element) {
              return {...element, 'child': value};
            },
          ),
          'isBatched': true,
        },
      );
    }
    return _$GraphQLRequestFromJson(json! as Map<String, Object?>);
  }

  Map<String, Object?> toJson() => _$GraphQLRequestToJson(this);

  factory GraphQLRequest.fromQueryParameters(
    Map<String, String> queryParameters,
  ) {
    final variables = queryParameters['variables'];
    final extensions = queryParameters['extensions'];
    return GraphQLRequest.fromJson(<String, Object?>{
      ...queryParameters,
      if (variables is String) 'variables': jsonDecode(variables),
      if (extensions is String) 'extensions': jsonDecode(extensions),
    });
  }

  Map<String, String> toQueryParameters() => {
        'query': query,
        if (operationName != null) 'operationName': operationName!,
        if (variables != null) 'variables': jsonEncode(variables),
        if (extensions != null) 'extensions': jsonEncode(extensions),
      };

  static Result<GraphQLRequest, String> fromMultiPartFormData(
    MultiPartData data,
  ) =>
      graphqlRequestFromMultiPartFormData(data);

  Iterable<GraphQLRequest> asIterable() sync* {
    GraphQLRequest? req = this;
    while (req != null) {
      yield req;
      req = req.child;
    }
  }
}
