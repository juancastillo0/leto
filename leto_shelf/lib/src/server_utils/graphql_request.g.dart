// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphQLRequest _$GraphQLRequestFromJson(Map<String, dynamic> json) =>
    GraphQLRequest(
      query: json['query'] as String,
      operationName: json['operationName'] as String?,
      variables: json['variables'] as Map<String, dynamic>?,
      extensions: json['extensions'] as Map<String, dynamic>?,
      child: json['child'] == null
          ? null
          : GraphQLRequest.fromJson(json['child'] as Object),
      isBatched: json['isBatched'] as bool? ?? false,
    );

Map<String, dynamic> _$GraphQLRequestToJson(GraphQLRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'operationName': instance.operationName,
      'variables': instance.variables,
      'extensions': instance.extensions,
      'child': instance.child,
      'isBatched': instance.isBatched,
    };
