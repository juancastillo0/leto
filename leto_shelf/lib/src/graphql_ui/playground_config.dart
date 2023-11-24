// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'playground_config.g.dart';
part 'playground_config.freezed.dart';

/// https://github.com/graphql/graphql-playground
@JsonSerializable(includeIfNull: false)
class PlaygroundConfig {
  final String? endpoint;
  final String? subscriptionEndpoint;
  final String? workspaceName;
  final Map<String, Object?>? env;
  final Map<String, Object?>? config;
  final ISettings? settings;

  /// {"__schema": {...}}
  final Map<String, Object?>? schema;
  final List<Tab>? tabs;
  final EditorColours? codeTheme;
  final String? version;
  final String? cdnUrl;
  final String? title;
  final String? faviconUrl;

  const PlaygroundConfig({
    this.endpoint,
    this.subscriptionEndpoint,
    this.workspaceName,
    this.env,
    this.config,
    this.settings,
    this.schema,
    this.tabs,
    this.codeTheme,
    this.version,
    this.cdnUrl,
    this.title,
    this.faviconUrl,
  });

  factory PlaygroundConfig.fromJson(Map<String, Object?> json) =>
      _$PlaygroundConfigFromJson(json);
  Map<String, Object?> toJson() => _$PlaygroundConfigToJson(this);

  @override
  String toString() {
    return 'PlaygroundConfig${toJson()}';
  }
}

@JsonSerializable(includeIfNull: false)
class Tab {
  final String endpoint;
  final String query;
  final String? name;
  final String? variables;
  final List<String>? responses;
  final Map<String, String>? headers;

  const Tab({
    required this.endpoint,
    required this.query,
    this.name,
    this.variables,
    this.responses,
    this.headers,
  });

  factory Tab.fromJson(Map<String, Object?> json) => _$TabFromJson(json);
  Map<String, Object?> toJson() => _$TabToJson(this);

  @override
  String toString() {
    return 'Tab${toJson()}';
  }
}

@freezed
class ISettings with _$ISettings {
  @JsonSerializable()
  const factory ISettings({
    @JsonKey(name: 'general.betaUpdates') required bool generalbetaUpdates,

    /// 'line' | 'block' | 'underline'
    @JsonKey(name: 'editor.cursorShape') required String editorcursorShape,

    /// 'dark' | 'light'
    @JsonKey(name: 'editor.theme') required String editortheme,
    @JsonKey(name: 'editor.reuseHeaders') required bool editorreuseHeaders,
    @JsonKey(name: 'tracing.hideTracingResponse')
    required bool tracinghideTracingResponse,
    @JsonKey(name: 'tracing.tracingSupported')
    required bool tracingtracingSupported,
    @JsonKey(name: 'editor.fontSize') required int editorfontSize,
    @JsonKey(name: 'editor.fontFamily') required String editorfontFamily,

    /// 'omit' | 'include' | 'same-origin'
    @JsonKey(name: 'request.credentials') required String requestcredentials,
    @JsonKey(name: 'request.globalHeaders')
    required Map<String, Object?> requestglobalHeaders,
    @JsonKey(name: 'schema.polling.enable') required bool schemapollingenable,
    @JsonKey(name: 'schema.polling.endpointFilter')
    required String schemapollingendpointFilter,
    @JsonKey(name: 'schema.polling.interval')
    required int schemapollinginterval,
  }) = _ISettings;

  factory ISettings.fromJson(Map<String, Object?> json) =>
      _$ISettingsFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class EditorColours {
  final String property;
  final String comment;
  final String punctuation;
  final String keyword;
  final String def;
  final String qualifier;
  final String attribute;
  final String number;
  final String string;
  final String builtin;
  final String string2;
  final String variable;
  final String meta;
  final String atom;
  final String ws;
  final String selection;
  final String cursorColor;
  final String editorBackground;
  final String resultBackground;
  final String leftDrawerBackground;
  final String rightDrawerBackground;

  const EditorColours({
    required this.property,
    required this.comment,
    required this.punctuation,
    required this.keyword,
    required this.def,
    required this.qualifier,
    required this.attribute,
    required this.number,
    required this.string,
    required this.builtin,
    required this.string2,
    required this.variable,
    required this.meta,
    required this.atom,
    required this.ws,
    required this.selection,
    required this.cursorColor,
    required this.editorBackground,
    required this.resultBackground,
    required this.leftDrawerBackground,
    required this.rightDrawerBackground,
  });

  factory EditorColours.fromJson(Map<String, Object?> json) =>
      _$EditorColoursFromJson(json);
  Map<String, Object?> toJson() => _$EditorColoursToJson(this);

  @override
  String toString() {
    return 'EditorColours${toJson()}';
  }
}
