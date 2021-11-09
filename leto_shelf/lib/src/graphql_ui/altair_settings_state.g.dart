// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altair_settings_state.dart';

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

Map<String, dynamic> _$$SettingsState_ToJson(_$SettingsState_ instance) {
  final val = <String, dynamic>{
    'theme': instance.theme,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('theme.dark', instance.themedark);
  val['language'] = instance.language;
  val['addQueryDepthLimit'] = instance.addQueryDepthLimit;
  val['tabSize'] = instance.tabSize;
  writeNotNull('enableExperimental', instance.enableExperimental);
  writeNotNull('theme.fontsize', instance.themefontsize);
  writeNotNull('theme.editorFontFamily', instance.themeeditorFontFamily);
  writeNotNull('theme.editorFontSize', instance.themeeditorFontSize);
  writeNotNull('disablePushNotification', instance.disablePushNotification);
  writeNotNull('plugin.list', instance.pluginlist);
  writeNotNull('request.withCredentials', instance.requestwithCredentials);
  writeNotNull('schema.reloadOnStart', instance.schemareloadOnStart);
  writeNotNull('alert.disableWarnings', instance.alertdisableWarnings);
  writeNotNull('historyDepth', instance.historyDepth);
  writeNotNull('themeConfig', instance.themeConfig);
  writeNotNull('themeConfig.dark', instance.themeConfigdark);
  writeNotNull('response.hideExtensions', instance.responsehideExtensions);
  return val;
}
