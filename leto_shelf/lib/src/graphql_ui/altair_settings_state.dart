// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'altair_settings_state.freezed.dart';
part 'altair_settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  @JsonSerializable(includeIfNull: false)
  const factory SettingsState({
    /// Theme
    required String theme,

    /// Theme for dark mode
    @JsonKey(name: 'theme.dark') String? themedark,

    /// Set language
    required String language,

    /// 'Add query' functionality depth
    required int addQueryDepthLimit,

    /// Editor tab size
    required int tabSize,

    /// Enable experimental features.
    /// Note: Might be unstable
    bool? enableExperimental,

    /// Base Font Size
    /// (Default - 24)
    @JsonKey(name: 'theme.fontsize') int? themefontsize,

    /// Editor Font Family
    @JsonKey(name: 'theme.editorFontFamily') String? themeeditorFontFamily,

    /// Editor Font Size
    @JsonKey(name: 'theme.editorFontSize') int? themeeditorFontSize,

    /// Disable push notifications
    bool? disablePushNotification,

    /// Enabled plugins
    @JsonKey(name: 'plugin.list') List<String>? pluginlist,

    /// Send requests with credentials (cookies)
    @JsonKey(name: 'request.withCredentials') bool? requestwithCredentials,

    /// Reload schema on app start
    @JsonKey(name: 'schema.reloadOnStart') bool? schemareloadOnStart,

    /// Disable warning alerts
    @JsonKey(name: 'alert.disableWarnings') bool? alertdisableWarnings,

    /// Number of items allowed in history pane
    int? historyDepth,

    /// Theme config object
    /// TODO: ICustomTheme
    /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
    Map<String, Object?>? themeConfig,

    /// Theme config object for dark mode
    /// TODO: ICustomTheme
    /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
    @JsonKey(name: 'themeConfig.dark') Map<String, Object?>? themeConfigdark,

    /// Hides extensions object
    @JsonKey(name: 'response.hideExtensions') bool? responsehideExtensions,
  }) = SettingsState_;

  factory SettingsState.fromJson(Map<String, Object?> json) =>
      _$SettingsStateFromJson(json);
}
