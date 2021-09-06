import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:oxidized/oxidized.dart';

import 'request_from_multipart.dart';

part 'graphql_request.g.dart';

@JsonSerializable()
class GraphqlRequest {
  final String query;
  final String? operationName;
  final Map<String, Object?>? variables;
  final Map<String, Object?>? extensions;
  final GraphqlRequest? child;

  const GraphqlRequest({
    required this.query,
    this.operationName,
    this.variables,
    this.extensions,
    this.child,
  });

  factory GraphqlRequest.fromJson(Map<String, Object?> json) =>
      _$GraphqlRequestFromJson(json);

  Map<String, Object?> toJson() => _$GraphqlRequestToJson(this);

  factory GraphqlRequest.fromQueryParameters(
    Map<String, String> queryParameters,
  ) {
    final variables = queryParameters['variables'];
    final extensions = queryParameters['extensions'];
    return GraphqlRequest.fromJson({
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

  static Result<GraphqlRequest, String> fromMultiPartFormData(
    MultiPartData data,
  ) =>
      graphqlRequestFromMultiPartFormData(data);
}
