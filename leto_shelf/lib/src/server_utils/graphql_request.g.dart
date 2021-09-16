// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphQLRequest _$GraphqlRequestFromJson(Map<String, dynamic> json) =>
    GraphQLRequest(
      query: json['query'] as String,
      operationName: json['operationName'] as String?,
      variables: json['variables'] as Map<String, dynamic>?,
      extensions: json['extensions'] as Map<String, dynamic>?,
      child: json['child'] == null
          ? null
          : GraphQLRequest.fromJson(json['child'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GraphqlRequestToJson(GraphQLRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'operationName': instance.operationName,
      'variables': instance.variables,
      'extensions': instance.extensions,
      'child': instance.child,
    };
