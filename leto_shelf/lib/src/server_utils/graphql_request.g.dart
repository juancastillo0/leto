// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphqlRequest _$GraphqlRequestFromJson(Map<String, dynamic> json) =>
    GraphqlRequest(
      query: json['query'] as String,
      operationName: json['operationName'] as String?,
      variables: json['variables'] as Map<String, dynamic>?,
      child: json['child'] == null
          ? null
          : GraphqlRequest.fromJson(json['child'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GraphqlRequestToJson(GraphqlRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'operationName': instance.operationName,
      'variables': instance.variables,
      'child': instance.child,
    };
