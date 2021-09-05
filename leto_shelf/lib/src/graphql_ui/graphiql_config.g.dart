// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphiql_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphiqlConfig _$GraphiqlConfigFromJson(Map<String, dynamic> json) =>
    GraphiqlConfig(
      schema: json['schema'] as Map<String, dynamic>?,
      query: json['query'] as String?,
      variables: json['variables'] as String?,
      headers: json['headers'] as String?,
      externalFragments: json['externalFragments'] as String?,
      operationName: json['operationName'] as String?,
      response: json['response'] as String?,
      defaultQuery: json['defaultQuery'] as String?,
      defaultVariableEditorOpen: json['defaultVariableEditorOpen'] as bool?,
      defaultSecondaryEditorOpen: json['defaultSecondaryEditorOpen'] as bool?,
      editorTheme: json['editorTheme'] as String?,
      readOnly: json['readOnly'] as bool?,
      docExplorerOpen: json['docExplorerOpen'] as bool?,
      headerEditorEnabled: json['headerEditorEnabled'] as bool?,
      shouldPersistHeaders: json['shouldPersistHeaders'] as bool?,
      maxHistoryLength: json['maxHistoryLength'] as int?,
    );

Map<String, dynamic> _$GraphiqlConfigToJson(GraphiqlConfig instance) =>
    <String, dynamic>{
      'schema': instance.schema,
      'query': instance.query,
      'variables': instance.variables,
      'headers': instance.headers,
      'externalFragments': instance.externalFragments,
      'operationName': instance.operationName,
      'response': instance.response,
      'defaultQuery': instance.defaultQuery,
      'defaultVariableEditorOpen': instance.defaultVariableEditorOpen,
      'defaultSecondaryEditorOpen': instance.defaultSecondaryEditorOpen,
      'editorTheme': instance.editorTheme,
      'readOnly': instance.readOnly,
      'docExplorerOpen': instance.docExplorerOpen,
      'headerEditorEnabled': instance.headerEditorEnabled,
      'shouldPersistHeaders': instance.shouldPersistHeaders,
      'maxHistoryLength': instance.maxHistoryLength,
    };

GraphiqlFetcher _$GraphiqlFetcherFromJson(Map<String, dynamic> json) =>
    GraphiqlFetcher(
      url: json['url'] as String,
      subscriptionUrl: json['subscriptionUrl'] as String?,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      enableIncrementalDelivery: json['enableIncrementalDelivery'] as bool?,
    );

Map<String, dynamic> _$GraphiqlFetcherToJson(GraphiqlFetcher instance) =>
    <String, dynamic>{
      'url': instance.url,
      'subscriptionUrl': instance.subscriptionUrl,
      'headers': instance.headers,
      'enableIncrementalDelivery': instance.enableIncrementalDelivery,
    };
