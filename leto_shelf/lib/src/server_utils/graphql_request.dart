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
  final GraphqlRequest? child;

  const GraphqlRequest({
    required this.query,
    this.operationName,
    this.variables,
    this.child,
  });

  factory GraphqlRequest.fromJson(Map<String, Object?> json) =>
      _$GraphqlRequestFromJson(json);

  Map<String, Object?> toJson() => _$GraphqlRequestToJson(this);

  factory GraphqlRequest.fromQueryParameters(
    Map<String, String> queryParameters,
  ) {
    final variables = queryParameters['variables'];
    return GraphqlRequest.fromJson(
      variables is String
          ? {...queryParameters, 'variables': jsonDecode(variables)}
          : queryParameters,
    );
  }

  Map<String, String> toQueryParameters() => {
        'query': query,
        if (variables != null) 'variables': jsonEncode(variables),
        if (operationName != null) 'operationName': operationName!,
      };

  static Result<GraphqlRequest, String> fromMultiPartFormData(
    MultiPartData data,
  ) =>
      graphqlRequestFromMultiPartFormData(data);
}
