// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/config.ts

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'altair_settings_state.dart';
export 'altair_settings_state.dart';

part 'altair_config.freezed.dart';
part 'altair_config.g.dart';

@freezed
class AltairConfig with _$AltairConfig {
  @JsonSerializable(includeIfNull: false)
  const factory AltairConfig({
    /// URL to set as the server endpoint
    String? endpointURL,

    /// URL to set as the subscription endpoint
    String? subscriptionsEndpoint,

    /// Initial query to be added
    String? initialQuery,

    /// Initial variables to be added
    String? initialVariables,

    /// Initial pre-request script to be added
    String? initialPreRequestScript,

    /// Initial post-request script to be added
    String? initialPostRequestScript,

    /// Initial headers object to be added
    /// @example
    /// {
    ///  'X-GraphQL-Token': 'asd7-237s-2bdk-nsdk4'
    /// }
    Map<String, Object?>? initialHeaders,

    /// Initial Environments to be added
    /// @example
    /// {
    ///   base: {
    ///     title: 'Environment',
    ///     variables: {}
    ///   },
    ///   subEnvironments: [
    ///     {
    ///       title: 'sub-1',
    ///       variables: {}
    ///     }
    ///   ]
    /// }
    IInitialEnvironments? initialEnvironments,

    /// Namespace for storing the data for the altair instance.
    /// Use this when you have multiple altair instances
    /// running on the same domain.
    /// @example
    /// instanceStorageNamespace: 'altair_dev_'
    String? instanceStorageNamespace,

    /// Initial app settings to use
    SettingsState? initialSettings,

    /// Initial subscriptions provider
    /// One of: 'websocket' | 'graphql-ws' | 'app-sync' | 'action-cable'
    /// @default "websocket"
    String? initialSubscriptionsProvider,

    /// Initial subscriptions connection params
    Map<String, Object?>? initialSubscriptionsPayload,

    /// Indicates if the state should be preserved for subsequent app loads
    ///
    /// @default true
    bool? preserveState,

    /// HTTP method to use for making requests 'POST', 'GET', 'PUT', 'DELETE'
    String? initialHttpMethod,

    /// URL to be used as a base for relative URLs
    String? baseURL,

    /// Whether to render the initial options in a seperate javascript
    /// file or not.
    /// Use this to be able to enforce strict CSP rules.
    ///
    /// @default false
    bool? serveInitialOptionsInSeperateRequest,
  }) = _AltairConfig;

  factory AltairConfig.fromJson(Map<String, dynamic> json) =>
      _$AltairConfigFromJson(json);
}

@freezed
class IInitialEnvironments with _$IInitialEnvironments {
  const factory IInitialEnvironments({
    InitialEnvironmentState? base,
    List<InitialEnvironmentState>? subEnvironments,
  }) = _IInitialEnvironments;

  factory IInitialEnvironments.fromJson(Map<String, dynamic> json) =>
      _$IInitialEnvironmentsFromJson(json);
}

@freezed
class InitialEnvironmentState with _$InitialEnvironmentState {
  const factory InitialEnvironmentState({
    String? id,
    String? title,
    Map<String, Object?>? variables,
  }) = _InitialEnvironmentState;

  factory InitialEnvironmentState.fromJson(Map<String, dynamic> json) =>
      _$InitialEnvironmentStateFromJson(json);
}
