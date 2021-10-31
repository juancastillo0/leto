// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playground_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaygroundConfig _$PlaygroundConfigFromJson(Map<String, dynamic> json) =>
    PlaygroundConfig(
      endpoint: json['endpoint'] as String?,
      subscriptionEndpoint: json['subscriptionEndpoint'] as String?,
      workspaceName: json['workspaceName'] as String?,
      env: json['env'] as Map<String, dynamic>?,
      config: json['config'] as Map<String, dynamic>?,
      settings: json['settings'] == null
          ? null
          : ISettings.fromJson(json['settings'] as Map<String, dynamic>),
      schema: json['schema'] as Map<String, dynamic>?,
      tabs: (json['tabs'] as List<dynamic>?)
          ?.map((e) => Tab.fromJson(e as Map<String, dynamic>))
          .toList(),
      codeTheme: json['codeTheme'] == null
          ? null
          : EditorColours.fromJson(json['codeTheme'] as Map<String, dynamic>),
      version: json['version'] as String?,
      cdnUrl: json['cdnUrl'] as String?,
      title: json['title'] as String?,
      faviconUrl: json['faviconUrl'] as String?,
    );

Map<String, dynamic> _$PlaygroundConfigToJson(PlaygroundConfig instance) =>
    <String, dynamic>{
      'endpoint': instance.endpoint,
      'subscriptionEndpoint': instance.subscriptionEndpoint,
      'workspaceName': instance.workspaceName,
      'env': instance.env,
      'config': instance.config,
      'settings': instance.settings,
      'schema': instance.schema,
      'tabs': instance.tabs,
      'codeTheme': instance.codeTheme,
      'version': instance.version,
      'cdnUrl': instance.cdnUrl,
      'title': instance.title,
      'faviconUrl': instance.faviconUrl,
    };

Tab _$TabFromJson(Map<String, dynamic> json) => Tab(
      endpoint: json['endpoint'] as String,
      query: json['query'] as String,
      name: json['name'] as String?,
      variables: json['variables'] as String?,
      responses: (json['responses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$TabToJson(Tab instance) => <String, dynamic>{
      'endpoint': instance.endpoint,
      'query': instance.query,
      'name': instance.name,
      'variables': instance.variables,
      'responses': instance.responses,
      'headers': instance.headers,
    };

EditorColours _$EditorColoursFromJson(Map<String, dynamic> json) =>
    EditorColours(
      property: json['property'] as String,
      comment: json['comment'] as String,
      punctuation: json['punctuation'] as String,
      keyword: json['keyword'] as String,
      def: json['def'] as String,
      qualifier: json['qualifier'] as String,
      attribute: json['attribute'] as String,
      number: json['number'] as String,
      string: json['string'] as String,
      builtin: json['builtin'] as String,
      string2: json['string2'] as String,
      variable: json['variable'] as String,
      meta: json['meta'] as String,
      atom: json['atom'] as String,
      ws: json['ws'] as String,
      selection: json['selection'] as String,
      cursorColor: json['cursorColor'] as String,
      editorBackground: json['editorBackground'] as String,
      resultBackground: json['resultBackground'] as String,
      leftDrawerBackground: json['leftDrawerBackground'] as String,
      rightDrawerBackground: json['rightDrawerBackground'] as String,
    );

Map<String, dynamic> _$EditorColoursToJson(EditorColours instance) =>
    <String, dynamic>{
      'property': instance.property,
      'comment': instance.comment,
      'punctuation': instance.punctuation,
      'keyword': instance.keyword,
      'def': instance.def,
      'qualifier': instance.qualifier,
      'attribute': instance.attribute,
      'number': instance.number,
      'string': instance.string,
      'builtin': instance.builtin,
      'string2': instance.string2,
      'variable': instance.variable,
      'meta': instance.meta,
      'atom': instance.atom,
      'ws': instance.ws,
      'selection': instance.selection,
      'cursorColor': instance.cursorColor,
      'editorBackground': instance.editorBackground,
      'resultBackground': instance.resultBackground,
      'leftDrawerBackground': instance.leftDrawerBackground,
      'rightDrawerBackground': instance.rightDrawerBackground,
    };

_$_ISettings _$$_ISettingsFromJson(Map<String, dynamic> json) => _$_ISettings(
      generalbetaUpdates: json['general.betaUpdates'] as bool,
      editorcursorShape: json['editor.cursorShape'] as String,
      editortheme: json['editor.theme'] as String,
      editorreuseHeaders: json['editor.reuseHeaders'] as bool,
      tracinghideTracingResponse: json['tracing.hideTracingResponse'] as bool,
      tracingtracingSupported: json['tracing.tracingSupported'] as bool,
      editorfontSize: json['editor.fontSize'] as int,
      editorfontFamily: json['editor.fontFamily'] as String,
      requestcredentials: json['request.credentials'] as String,
      requestglobalHeaders:
          json['request.globalHeaders'] as Map<String, dynamic>,
      schemapollingenable: json['schema.polling.enable'] as bool,
      schemapollingendpointFilter:
          json['schema.polling.endpointFilter'] as String,
      schemapollinginterval: json['schema.polling.interval'] as int,
    );

Map<String, dynamic> _$$_ISettingsToJson(_$_ISettings instance) =>
    <String, dynamic>{
      'general.betaUpdates': instance.generalbetaUpdates,
      'editor.cursorShape': instance.editorcursorShape,
      'editor.theme': instance.editortheme,
      'editor.reuseHeaders': instance.editorreuseHeaders,
      'tracing.hideTracingResponse': instance.tracinghideTracingResponse,
      'tracing.tracingSupported': instance.tracingtracingSupported,
      'editor.fontSize': instance.editorfontSize,
      'editor.fontFamily': instance.editorfontFamily,
      'request.credentials': instance.requestcredentials,
      'request.globalHeaders': instance.requestglobalHeaders,
      'schema.polling.enable': instance.schemapollingenable,
      'schema.polling.endpointFilter': instance.schemapollingendpointFilter,
      'schema.polling.interval': instance.schemapollinginterval,
    };
