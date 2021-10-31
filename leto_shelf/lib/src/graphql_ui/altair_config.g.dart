// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altair_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AltairConfig _$$_AltairConfigFromJson(Map<String, dynamic> json) =>
    _$_AltairConfig(
      endpointURL: json['endpointURL'] as String?,
      subscriptionsEndpoint: json['subscriptionsEndpoint'] as String?,
      initialQuery: json['initialQuery'] as String?,
      initialVariables: json['initialVariables'] as String?,
      initialPreRequestScript: json['initialPreRequestScript'] as String?,
      initialPostRequestScript: json['initialPostRequestScript'] as String?,
      initialHeaders: json['initialHeaders'] as Map<String, dynamic>?,
      initialEnvironments: json['initialEnvironments'] == null
          ? null
          : IInitialEnvironments.fromJson(
              json['initialEnvironments'] as Map<String, dynamic>),
      instanceStorageNamespace: json['instanceStorageNamespace'] as String?,
      initialSettings: json['initialSettings'] == null
          ? null
          : SettingsState.fromJson(
              json['initialSettings'] as Map<String, dynamic>),
      initialSubscriptionsProvider:
          json['initialSubscriptionsProvider'] as String?,
      initialSubscriptionsPayload:
          json['initialSubscriptionsPayload'] as Map<String, dynamic>?,
      preserveState: json['preserveState'] as bool?,
      initialHttpMethod: json['initialHttpMethod'] as String?,
      baseURL: json['baseURL'] as String?,
      serveInitialOptionsInSeperateRequest:
          json['serveInitialOptionsInSeperateRequest'] as bool?,
    );

Map<String, dynamic> _$$_AltairConfigToJson(_$_AltairConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('endpointURL', instance.endpointURL);
  writeNotNull('subscriptionsEndpoint', instance.subscriptionsEndpoint);
  writeNotNull('initialQuery', instance.initialQuery);
  writeNotNull('initialVariables', instance.initialVariables);
  writeNotNull('initialPreRequestScript', instance.initialPreRequestScript);
  writeNotNull('initialPostRequestScript', instance.initialPostRequestScript);
  writeNotNull('initialHeaders', instance.initialHeaders);
  writeNotNull('initialEnvironments', instance.initialEnvironments);
  writeNotNull('instanceStorageNamespace', instance.instanceStorageNamespace);
  writeNotNull('initialSettings', instance.initialSettings);
  writeNotNull(
      'initialSubscriptionsProvider', instance.initialSubscriptionsProvider);
  writeNotNull(
      'initialSubscriptionsPayload', instance.initialSubscriptionsPayload);
  writeNotNull('preserveState', instance.preserveState);
  writeNotNull('initialHttpMethod', instance.initialHttpMethod);
  writeNotNull('baseURL', instance.baseURL);
  writeNotNull('serveInitialOptionsInSeperateRequest',
      instance.serveInitialOptionsInSeperateRequest);
  return val;
}

_$_IInitialEnvironments _$$_IInitialEnvironmentsFromJson(
        Map<String, dynamic> json) =>
    _$_IInitialEnvironments(
      base: json['base'] == null
          ? null
          : InitialEnvironmentState.fromJson(
              json['base'] as Map<String, dynamic>),
      subEnvironments: (json['subEnvironments'] as List<dynamic>?)
          ?.map((e) =>
              InitialEnvironmentState.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_IInitialEnvironmentsToJson(
        _$_IInitialEnvironments instance) =>
    <String, dynamic>{
      'base': instance.base,
      'subEnvironments': instance.subEnvironments,
    };

_$_InitialEnvironmentState _$$_InitialEnvironmentStateFromJson(
        Map<String, dynamic> json) =>
    _$_InitialEnvironmentState(
      id: json['id'] as String?,
      title: json['title'] as String?,
      variables: json['variables'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_InitialEnvironmentStateToJson(
        _$_InitialEnvironmentState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'variables': instance.variables,
    };
