// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altait_settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsState_ _$$SettingsState_FromJson(Map<String, dynamic> json) =>
    _$SettingsState_(
      theme: json['theme'] as String,
      themedark: json['theme.dark'] as String?,
      language: json['language'] as String,
      addQueryDepthLimit: json['addQueryDepthLimit'] as int,
      tabSize: json['tabSize'] as int,
      enableExperimental: json['enableExperimental'] as bool?,
      themefontsize: json['theme.fontsize'] as int?,
      themeeditorFontFamily: json['theme.editorFontFamily'] as String?,
      themeeditorFontSize: json['theme.editorFontSize'] as int?,
      disablePushNotification: json['disablePushNotification'] as bool?,
      pluginlist: (json['plugin.list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requestwithCredentials: json['request.withCredentials'] as bool?,
      schemareloadOnStart: json['schema.reloadOnStart'] as bool?,
      alertdisableWarnings: json['alert.disableWarnings'] as bool?,
      historyDepth: json['historyDepth'] as int?,
      themeConfig: json['themeConfig'] as Map<String, dynamic>?,
      themeConfigdark: json['themeConfig.dark'] as Map<String, dynamic>?,
      responsehideExtensions: json['response.hideExtensions'] as bool?,
    );

Map<String, dynamic> _$$SettingsState_ToJson(_$SettingsState_ instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'theme.dark': instance.themedark,
      'language': instance.language,
      'addQueryDepthLimit': instance.addQueryDepthLimit,
      'tabSize': instance.tabSize,
      'enableExperimental': instance.enableExperimental,
      'theme.fontsize': instance.themefontsize,
      'theme.editorFontFamily': instance.themeeditorFontFamily,
      'theme.editorFontSize': instance.themeeditorFontSize,
      'disablePushNotification': instance.disablePushNotification,
      'plugin.list': instance.pluginlist,
      'request.withCredentials': instance.requestwithCredentials,
      'schema.reloadOnStart': instance.schemareloadOnStart,
      'alert.disableWarnings': instance.alertdisableWarnings,
      'historyDepth': instance.historyDepth,
      'themeConfig': instance.themeConfig,
      'themeConfig.dark': instance.themeConfigdark,
      'response.hideExtensions': instance.responsehideExtensions,
    };
