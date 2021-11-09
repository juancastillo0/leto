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

Map<String, dynamic> _$GraphiqlConfigToJson(GraphiqlConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('schema', instance.schema);
  writeNotNull('query', instance.query);
  writeNotNull('variables', instance.variables);
  writeNotNull('headers', instance.headers);
  writeNotNull('externalFragments', instance.externalFragments);
  writeNotNull('operationName', instance.operationName);
  writeNotNull('response', instance.response);
  writeNotNull('defaultQuery', instance.defaultQuery);
  writeNotNull('defaultVariableEditorOpen', instance.defaultVariableEditorOpen);
  writeNotNull(
      'defaultSecondaryEditorOpen', instance.defaultSecondaryEditorOpen);
  writeNotNull('editorTheme', instance.editorTheme);
  writeNotNull('readOnly', instance.readOnly);
  writeNotNull('docExplorerOpen', instance.docExplorerOpen);
  writeNotNull('headerEditorEnabled', instance.headerEditorEnabled);
  writeNotNull('shouldPersistHeaders', instance.shouldPersistHeaders);
  writeNotNull('maxHistoryLength', instance.maxHistoryLength);
  return val;
}

GraphiqlFetcher _$GraphiqlFetcherFromJson(Map<String, dynamic> json) =>
    GraphiqlFetcher(
      url: json['url'] as String,
      subscriptionUrl: json['subscriptionUrl'] as String?,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      enableIncrementalDelivery: json['enableIncrementalDelivery'] as bool?,
    );

Map<String, dynamic> _$GraphiqlFetcherToJson(GraphiqlFetcher instance) {
  final val = <String, dynamic>{
    'url': instance.url,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subscriptionUrl', instance.subscriptionUrl);
  writeNotNull('headers', instance.headers);
  writeNotNull('enableIncrementalDelivery', instance.enableIncrementalDelivery);
  return val;
}
