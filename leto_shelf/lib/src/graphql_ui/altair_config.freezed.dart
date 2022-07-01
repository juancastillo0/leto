// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'altair_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AltairConfig _$AltairConfigFromJson(Map<String, dynamic> json) {
  return _AltairConfig.fromJson(json);
}

/// @nodoc
class _$AltairConfigTearOff {
  const _$AltairConfigTearOff();

  _AltairConfig call(
      {String? endpointURL,
      String? subscriptionsEndpoint,
      String? initialQuery,
      String? initialVariables,
      String? initialPreRequestScript,
      String? initialPostRequestScript,
      Map<String, Object?>? initialHeaders,
      IInitialEnvironments? initialEnvironments,
      String? instanceStorageNamespace,
      SettingsState? initialSettings,
      String? initialSubscriptionsProvider,
      Map<String, Object?>? initialSubscriptionsPayload,
      bool? preserveState,
      String? initialHttpMethod,
      String? baseURL,
      bool? serveInitialOptionsInSeperateRequest}) {
    return _AltairConfig(
      endpointURL: endpointURL,
      subscriptionsEndpoint: subscriptionsEndpoint,
      initialQuery: initialQuery,
      initialVariables: initialVariables,
      initialPreRequestScript: initialPreRequestScript,
      initialPostRequestScript: initialPostRequestScript,
      initialHeaders: initialHeaders,
      initialEnvironments: initialEnvironments,
      instanceStorageNamespace: instanceStorageNamespace,
      initialSettings: initialSettings,
      initialSubscriptionsProvider: initialSubscriptionsProvider,
      initialSubscriptionsPayload: initialSubscriptionsPayload,
      preserveState: preserveState,
      initialHttpMethod: initialHttpMethod,
      baseURL: baseURL,
      serveInitialOptionsInSeperateRequest:
          serveInitialOptionsInSeperateRequest,
    );
  }

  AltairConfig fromJson(Map<String, Object?> json) {
    return AltairConfig.fromJson(json);
  }
}

/// @nodoc
const $AltairConfig = _$AltairConfigTearOff();

/// @nodoc
mixin _$AltairConfig {
  /// URL to set as the server endpoint
  String? get endpointURL => throw _privateConstructorUsedError;

  /// URL to set as the subscription endpoint
  String? get subscriptionsEndpoint => throw _privateConstructorUsedError;

  /// Initial query to be added
  String? get initialQuery => throw _privateConstructorUsedError;

  /// Initial variables to be added
  String? get initialVariables => throw _privateConstructorUsedError;

  /// Initial pre-request script to be added
  String? get initialPreRequestScript => throw _privateConstructorUsedError;

  /// Initial post-request script to be added
  String? get initialPostRequestScript => throw _privateConstructorUsedError;

  /// Initial headers object to be added
  /// @example
  /// {
  ///  'X-GraphQL-Token': 'asd7-237s-2bdk-nsdk4'
  /// }
  Map<String, Object?>? get initialHeaders =>
      throw _privateConstructorUsedError;

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
  IInitialEnvironments? get initialEnvironments =>
      throw _privateConstructorUsedError;

  /// Namespace for storing the data for the altair instance.
  /// Use this when you have multiple altair instances
  /// running on the same domain.
  /// @example
  /// instanceStorageNamespace: 'altair_dev_'
  String? get instanceStorageNamespace => throw _privateConstructorUsedError;

  /// Initial app settings to use
  SettingsState? get initialSettings => throw _privateConstructorUsedError;

  /// Initial subscriptions provider
  /// One of: 'websocket' | 'graphql-ws' | 'app-sync' | 'action-cable'
  /// @default "websocket"
  String? get initialSubscriptionsProvider =>
      throw _privateConstructorUsedError;

  /// Initial subscriptions connection params
  Map<String, Object?>? get initialSubscriptionsPayload =>
      throw _privateConstructorUsedError;

  /// Indicates if the state should be preserved for subsequent app loads
  ///
  /// @default true
  bool? get preserveState => throw _privateConstructorUsedError;

  /// HTTP method to use for making requests 'POST', 'GET', 'PUT', 'DELETE'
  String? get initialHttpMethod => throw _privateConstructorUsedError;

  /// URL to be used as a base for relative URLs
  String? get baseURL => throw _privateConstructorUsedError;

  /// Whether to render the initial options in a seperate javascript
  /// file or not.
  /// Use this to be able to enforce strict CSP rules.
  ///
  /// @default false
  bool? get serveInitialOptionsInSeperateRequest =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AltairConfigCopyWith<AltairConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AltairConfigCopyWith<$Res> {
  factory $AltairConfigCopyWith(
          AltairConfig value, $Res Function(AltairConfig) then) =
      _$AltairConfigCopyWithImpl<$Res>;
  $Res call(
      {String? endpointURL,
      String? subscriptionsEndpoint,
      String? initialQuery,
      String? initialVariables,
      String? initialPreRequestScript,
      String? initialPostRequestScript,
      Map<String, Object?>? initialHeaders,
      IInitialEnvironments? initialEnvironments,
      String? instanceStorageNamespace,
      SettingsState? initialSettings,
      String? initialSubscriptionsProvider,
      Map<String, Object?>? initialSubscriptionsPayload,
      bool? preserveState,
      String? initialHttpMethod,
      String? baseURL,
      bool? serveInitialOptionsInSeperateRequest});

  $IInitialEnvironmentsCopyWith<$Res>? get initialEnvironments;
  $SettingsStateCopyWith<$Res>? get initialSettings;
}

/// @nodoc
class _$AltairConfigCopyWithImpl<$Res> implements $AltairConfigCopyWith<$Res> {
  _$AltairConfigCopyWithImpl(this._value, this._then);

  final AltairConfig _value;
  // ignore: unused_field
  final $Res Function(AltairConfig) _then;

  @override
  $Res call({
    Object? endpointURL = freezed,
    Object? subscriptionsEndpoint = freezed,
    Object? initialQuery = freezed,
    Object? initialVariables = freezed,
    Object? initialPreRequestScript = freezed,
    Object? initialPostRequestScript = freezed,
    Object? initialHeaders = freezed,
    Object? initialEnvironments = freezed,
    Object? instanceStorageNamespace = freezed,
    Object? initialSettings = freezed,
    Object? initialSubscriptionsProvider = freezed,
    Object? initialSubscriptionsPayload = freezed,
    Object? preserveState = freezed,
    Object? initialHttpMethod = freezed,
    Object? baseURL = freezed,
    Object? serveInitialOptionsInSeperateRequest = freezed,
  }) {
    return _then(_value.copyWith(
      endpointURL: endpointURL == freezed
          ? _value.endpointURL
          : endpointURL // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionsEndpoint: subscriptionsEndpoint == freezed
          ? _value.subscriptionsEndpoint
          : subscriptionsEndpoint // ignore: cast_nullable_to_non_nullable
              as String?,
      initialQuery: initialQuery == freezed
          ? _value.initialQuery
          : initialQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      initialVariables: initialVariables == freezed
          ? _value.initialVariables
          : initialVariables // ignore: cast_nullable_to_non_nullable
              as String?,
      initialPreRequestScript: initialPreRequestScript == freezed
          ? _value.initialPreRequestScript
          : initialPreRequestScript // ignore: cast_nullable_to_non_nullable
              as String?,
      initialPostRequestScript: initialPostRequestScript == freezed
          ? _value.initialPostRequestScript
          : initialPostRequestScript // ignore: cast_nullable_to_non_nullable
              as String?,
      initialHeaders: initialHeaders == freezed
          ? _value.initialHeaders
          : initialHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      initialEnvironments: initialEnvironments == freezed
          ? _value.initialEnvironments
          : initialEnvironments // ignore: cast_nullable_to_non_nullable
              as IInitialEnvironments?,
      instanceStorageNamespace: instanceStorageNamespace == freezed
          ? _value.instanceStorageNamespace
          : instanceStorageNamespace // ignore: cast_nullable_to_non_nullable
              as String?,
      initialSettings: initialSettings == freezed
          ? _value.initialSettings
          : initialSettings // ignore: cast_nullable_to_non_nullable
              as SettingsState?,
      initialSubscriptionsProvider: initialSubscriptionsProvider == freezed
          ? _value.initialSubscriptionsProvider
          : initialSubscriptionsProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      initialSubscriptionsPayload: initialSubscriptionsPayload == freezed
          ? _value.initialSubscriptionsPayload
          : initialSubscriptionsPayload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      preserveState: preserveState == freezed
          ? _value.preserveState
          : preserveState // ignore: cast_nullable_to_non_nullable
              as bool?,
      initialHttpMethod: initialHttpMethod == freezed
          ? _value.initialHttpMethod
          : initialHttpMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      baseURL: baseURL == freezed
          ? _value.baseURL
          : baseURL // ignore: cast_nullable_to_non_nullable
              as String?,
      serveInitialOptionsInSeperateRequest: serveInitialOptionsInSeperateRequest ==
              freezed
          ? _value.serveInitialOptionsInSeperateRequest
          : serveInitialOptionsInSeperateRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  @override
  $IInitialEnvironmentsCopyWith<$Res>? get initialEnvironments {
    if (_value.initialEnvironments == null) {
      return null;
    }

    return $IInitialEnvironmentsCopyWith<$Res>(_value.initialEnvironments!,
        (value) {
      return _then(_value.copyWith(initialEnvironments: value));
    });
  }

  @override
  $SettingsStateCopyWith<$Res>? get initialSettings {
    if (_value.initialSettings == null) {
      return null;
    }

    return $SettingsStateCopyWith<$Res>(_value.initialSettings!, (value) {
      return _then(_value.copyWith(initialSettings: value));
    });
  }
}

/// @nodoc
abstract class _$AltairConfigCopyWith<$Res>
    implements $AltairConfigCopyWith<$Res> {
  factory _$AltairConfigCopyWith(
          _AltairConfig value, $Res Function(_AltairConfig) then) =
      __$AltairConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? endpointURL,
      String? subscriptionsEndpoint,
      String? initialQuery,
      String? initialVariables,
      String? initialPreRequestScript,
      String? initialPostRequestScript,
      Map<String, Object?>? initialHeaders,
      IInitialEnvironments? initialEnvironments,
      String? instanceStorageNamespace,
      SettingsState? initialSettings,
      String? initialSubscriptionsProvider,
      Map<String, Object?>? initialSubscriptionsPayload,
      bool? preserveState,
      String? initialHttpMethod,
      String? baseURL,
      bool? serveInitialOptionsInSeperateRequest});

  @override
  $IInitialEnvironmentsCopyWith<$Res>? get initialEnvironments;
  @override
  $SettingsStateCopyWith<$Res>? get initialSettings;
}

/// @nodoc
class __$AltairConfigCopyWithImpl<$Res> extends _$AltairConfigCopyWithImpl<$Res>
    implements _$AltairConfigCopyWith<$Res> {
  __$AltairConfigCopyWithImpl(
      _AltairConfig _value, $Res Function(_AltairConfig) _then)
      : super(_value, (v) => _then(v as _AltairConfig));

  @override
  _AltairConfig get _value => super._value as _AltairConfig;

  @override
  $Res call({
    Object? endpointURL = freezed,
    Object? subscriptionsEndpoint = freezed,
    Object? initialQuery = freezed,
    Object? initialVariables = freezed,
    Object? initialPreRequestScript = freezed,
    Object? initialPostRequestScript = freezed,
    Object? initialHeaders = freezed,
    Object? initialEnvironments = freezed,
    Object? instanceStorageNamespace = freezed,
    Object? initialSettings = freezed,
    Object? initialSubscriptionsProvider = freezed,
    Object? initialSubscriptionsPayload = freezed,
    Object? preserveState = freezed,
    Object? initialHttpMethod = freezed,
    Object? baseURL = freezed,
    Object? serveInitialOptionsInSeperateRequest = freezed,
  }) {
    return _then(_AltairConfig(
      endpointURL: endpointURL == freezed
          ? _value.endpointURL
          : endpointURL // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionsEndpoint: subscriptionsEndpoint == freezed
          ? _value.subscriptionsEndpoint
          : subscriptionsEndpoint // ignore: cast_nullable_to_non_nullable
              as String?,
      initialQuery: initialQuery == freezed
          ? _value.initialQuery
          : initialQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      initialVariables: initialVariables == freezed
          ? _value.initialVariables
          : initialVariables // ignore: cast_nullable_to_non_nullable
              as String?,
      initialPreRequestScript: initialPreRequestScript == freezed
          ? _value.initialPreRequestScript
          : initialPreRequestScript // ignore: cast_nullable_to_non_nullable
              as String?,
      initialPostRequestScript: initialPostRequestScript == freezed
          ? _value.initialPostRequestScript
          : initialPostRequestScript // ignore: cast_nullable_to_non_nullable
              as String?,
      initialHeaders: initialHeaders == freezed
          ? _value.initialHeaders
          : initialHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      initialEnvironments: initialEnvironments == freezed
          ? _value.initialEnvironments
          : initialEnvironments // ignore: cast_nullable_to_non_nullable
              as IInitialEnvironments?,
      instanceStorageNamespace: instanceStorageNamespace == freezed
          ? _value.instanceStorageNamespace
          : instanceStorageNamespace // ignore: cast_nullable_to_non_nullable
              as String?,
      initialSettings: initialSettings == freezed
          ? _value.initialSettings
          : initialSettings // ignore: cast_nullable_to_non_nullable
              as SettingsState?,
      initialSubscriptionsProvider: initialSubscriptionsProvider == freezed
          ? _value.initialSubscriptionsProvider
          : initialSubscriptionsProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      initialSubscriptionsPayload: initialSubscriptionsPayload == freezed
          ? _value.initialSubscriptionsPayload
          : initialSubscriptionsPayload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      preserveState: preserveState == freezed
          ? _value.preserveState
          : preserveState // ignore: cast_nullable_to_non_nullable
              as bool?,
      initialHttpMethod: initialHttpMethod == freezed
          ? _value.initialHttpMethod
          : initialHttpMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      baseURL: baseURL == freezed
          ? _value.baseURL
          : baseURL // ignore: cast_nullable_to_non_nullable
              as String?,
      serveInitialOptionsInSeperateRequest: serveInitialOptionsInSeperateRequest ==
              freezed
          ? _value.serveInitialOptionsInSeperateRequest
          : serveInitialOptionsInSeperateRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_AltairConfig implements _AltairConfig {
  const _$_AltairConfig(
      {this.endpointURL,
      this.subscriptionsEndpoint,
      this.initialQuery,
      this.initialVariables,
      this.initialPreRequestScript,
      this.initialPostRequestScript,
      this.initialHeaders,
      this.initialEnvironments,
      this.instanceStorageNamespace,
      this.initialSettings,
      this.initialSubscriptionsProvider,
      this.initialSubscriptionsPayload,
      this.preserveState,
      this.initialHttpMethod,
      this.baseURL,
      this.serveInitialOptionsInSeperateRequest});

  factory _$_AltairConfig.fromJson(Map<String, dynamic> json) =>
      _$$_AltairConfigFromJson(json);

  @override

  /// URL to set as the server endpoint
  final String? endpointURL;
  @override

  /// URL to set as the subscription endpoint
  final String? subscriptionsEndpoint;
  @override

  /// Initial query to be added
  final String? initialQuery;
  @override

  /// Initial variables to be added
  final String? initialVariables;
  @override

  /// Initial pre-request script to be added
  final String? initialPreRequestScript;
  @override

  /// Initial post-request script to be added
  final String? initialPostRequestScript;
  @override

  /// Initial headers object to be added
  /// @example
  /// {
  ///  'X-GraphQL-Token': 'asd7-237s-2bdk-nsdk4'
  /// }
  final Map<String, Object?>? initialHeaders;
  @override

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
  final IInitialEnvironments? initialEnvironments;
  @override

  /// Namespace for storing the data for the altair instance.
  /// Use this when you have multiple altair instances
  /// running on the same domain.
  /// @example
  /// instanceStorageNamespace: 'altair_dev_'
  final String? instanceStorageNamespace;
  @override

  /// Initial app settings to use
  final SettingsState? initialSettings;
  @override

  /// Initial subscriptions provider
  /// One of: 'websocket' | 'graphql-ws' | 'app-sync' | 'action-cable'
  /// @default "websocket"
  final String? initialSubscriptionsProvider;
  @override

  /// Initial subscriptions connection params
  final Map<String, Object?>? initialSubscriptionsPayload;
  @override

  /// Indicates if the state should be preserved for subsequent app loads
  ///
  /// @default true
  final bool? preserveState;
  @override

  /// HTTP method to use for making requests 'POST', 'GET', 'PUT', 'DELETE'
  final String? initialHttpMethod;
  @override

  /// URL to be used as a base for relative URLs
  final String? baseURL;
  @override

  /// Whether to render the initial options in a seperate javascript
  /// file or not.
  /// Use this to be able to enforce strict CSP rules.
  ///
  /// @default false
  final bool? serveInitialOptionsInSeperateRequest;

  @override
  String toString() {
    return 'AltairConfig(endpointURL: $endpointURL, subscriptionsEndpoint: $subscriptionsEndpoint, initialQuery: $initialQuery, initialVariables: $initialVariables, initialPreRequestScript: $initialPreRequestScript, initialPostRequestScript: $initialPostRequestScript, initialHeaders: $initialHeaders, initialEnvironments: $initialEnvironments, instanceStorageNamespace: $instanceStorageNamespace, initialSettings: $initialSettings, initialSubscriptionsProvider: $initialSubscriptionsProvider, initialSubscriptionsPayload: $initialSubscriptionsPayload, preserveState: $preserveState, initialHttpMethod: $initialHttpMethod, baseURL: $baseURL, serveInitialOptionsInSeperateRequest: $serveInitialOptionsInSeperateRequest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AltairConfig &&
            const DeepCollectionEquality()
                .equals(other.endpointURL, endpointURL) &&
            const DeepCollectionEquality()
                .equals(other.subscriptionsEndpoint, subscriptionsEndpoint) &&
            const DeepCollectionEquality()
                .equals(other.initialQuery, initialQuery) &&
            const DeepCollectionEquality()
                .equals(other.initialVariables, initialVariables) &&
            const DeepCollectionEquality().equals(
                other.initialPreRequestScript, initialPreRequestScript) &&
            const DeepCollectionEquality().equals(
                other.initialPostRequestScript, initialPostRequestScript) &&
            const DeepCollectionEquality()
                .equals(other.initialHeaders, initialHeaders) &&
            const DeepCollectionEquality()
                .equals(other.initialEnvironments, initialEnvironments) &&
            const DeepCollectionEquality().equals(
                other.instanceStorageNamespace, instanceStorageNamespace) &&
            const DeepCollectionEquality()
                .equals(other.initialSettings, initialSettings) &&
            const DeepCollectionEquality().equals(
                other.initialSubscriptionsProvider,
                initialSubscriptionsProvider) &&
            const DeepCollectionEquality().equals(
                other.initialSubscriptionsPayload,
                initialSubscriptionsPayload) &&
            const DeepCollectionEquality()
                .equals(other.preserveState, preserveState) &&
            const DeepCollectionEquality()
                .equals(other.initialHttpMethod, initialHttpMethod) &&
            const DeepCollectionEquality().equals(other.baseURL, baseURL) &&
            const DeepCollectionEquality().equals(
                other.serveInitialOptionsInSeperateRequest,
                serveInitialOptionsInSeperateRequest));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(endpointURL),
      const DeepCollectionEquality().hash(subscriptionsEndpoint),
      const DeepCollectionEquality().hash(initialQuery),
      const DeepCollectionEquality().hash(initialVariables),
      const DeepCollectionEquality().hash(initialPreRequestScript),
      const DeepCollectionEquality().hash(initialPostRequestScript),
      const DeepCollectionEquality().hash(initialHeaders),
      const DeepCollectionEquality().hash(initialEnvironments),
      const DeepCollectionEquality().hash(instanceStorageNamespace),
      const DeepCollectionEquality().hash(initialSettings),
      const DeepCollectionEquality().hash(initialSubscriptionsProvider),
      const DeepCollectionEquality().hash(initialSubscriptionsPayload),
      const DeepCollectionEquality().hash(preserveState),
      const DeepCollectionEquality().hash(initialHttpMethod),
      const DeepCollectionEquality().hash(baseURL),
      const DeepCollectionEquality()
          .hash(serveInitialOptionsInSeperateRequest));

  @JsonKey(ignore: true)
  @override
  _$AltairConfigCopyWith<_AltairConfig> get copyWith =>
      __$AltairConfigCopyWithImpl<_AltairConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AltairConfigToJson(this);
  }
}

abstract class _AltairConfig implements AltairConfig {
  const factory _AltairConfig(
      {String? endpointURL,
      String? subscriptionsEndpoint,
      String? initialQuery,
      String? initialVariables,
      String? initialPreRequestScript,
      String? initialPostRequestScript,
      Map<String, Object?>? initialHeaders,
      IInitialEnvironments? initialEnvironments,
      String? instanceStorageNamespace,
      SettingsState? initialSettings,
      String? initialSubscriptionsProvider,
      Map<String, Object?>? initialSubscriptionsPayload,
      bool? preserveState,
      String? initialHttpMethod,
      String? baseURL,
      bool? serveInitialOptionsInSeperateRequest}) = _$_AltairConfig;

  factory _AltairConfig.fromJson(Map<String, dynamic> json) =
      _$_AltairConfig.fromJson;

  @override

  /// URL to set as the server endpoint
  String? get endpointURL;
  @override

  /// URL to set as the subscription endpoint
  String? get subscriptionsEndpoint;
  @override

  /// Initial query to be added
  String? get initialQuery;
  @override

  /// Initial variables to be added
  String? get initialVariables;
  @override

  /// Initial pre-request script to be added
  String? get initialPreRequestScript;
  @override

  /// Initial post-request script to be added
  String? get initialPostRequestScript;
  @override

  /// Initial headers object to be added
  /// @example
  /// {
  ///  'X-GraphQL-Token': 'asd7-237s-2bdk-nsdk4'
  /// }
  Map<String, Object?>? get initialHeaders;
  @override

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
  IInitialEnvironments? get initialEnvironments;
  @override

  /// Namespace for storing the data for the altair instance.
  /// Use this when you have multiple altair instances
  /// running on the same domain.
  /// @example
  /// instanceStorageNamespace: 'altair_dev_'
  String? get instanceStorageNamespace;
  @override

  /// Initial app settings to use
  SettingsState? get initialSettings;
  @override

  /// Initial subscriptions provider
  /// One of: 'websocket' | 'graphql-ws' | 'app-sync' | 'action-cable'
  /// @default "websocket"
  String? get initialSubscriptionsProvider;
  @override

  /// Initial subscriptions connection params
  Map<String, Object?>? get initialSubscriptionsPayload;
  @override

  /// Indicates if the state should be preserved for subsequent app loads
  ///
  /// @default true
  bool? get preserveState;
  @override

  /// HTTP method to use for making requests 'POST', 'GET', 'PUT', 'DELETE'
  String? get initialHttpMethod;
  @override

  /// URL to be used as a base for relative URLs
  String? get baseURL;
  @override

  /// Whether to render the initial options in a seperate javascript
  /// file or not.
  /// Use this to be able to enforce strict CSP rules.
  ///
  /// @default false
  bool? get serveInitialOptionsInSeperateRequest;
  @override
  @JsonKey(ignore: true)
  _$AltairConfigCopyWith<_AltairConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

IInitialEnvironments _$IInitialEnvironmentsFromJson(Map<String, dynamic> json) {
  return _IInitialEnvironments.fromJson(json);
}

/// @nodoc
class _$IInitialEnvironmentsTearOff {
  const _$IInitialEnvironmentsTearOff();

  _IInitialEnvironments call(
      {InitialEnvironmentState? base,
      List<InitialEnvironmentState>? subEnvironments}) {
    return _IInitialEnvironments(
      base: base,
      subEnvironments: subEnvironments,
    );
  }

  IInitialEnvironments fromJson(Map<String, Object?> json) {
    return IInitialEnvironments.fromJson(json);
  }
}

/// @nodoc
const $IInitialEnvironments = _$IInitialEnvironmentsTearOff();

/// @nodoc
mixin _$IInitialEnvironments {
  InitialEnvironmentState? get base => throw _privateConstructorUsedError;
  List<InitialEnvironmentState>? get subEnvironments =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IInitialEnvironmentsCopyWith<IInitialEnvironments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IInitialEnvironmentsCopyWith<$Res> {
  factory $IInitialEnvironmentsCopyWith(IInitialEnvironments value,
          $Res Function(IInitialEnvironments) then) =
      _$IInitialEnvironmentsCopyWithImpl<$Res>;
  $Res call(
      {InitialEnvironmentState? base,
      List<InitialEnvironmentState>? subEnvironments});

  $InitialEnvironmentStateCopyWith<$Res>? get base;
}

/// @nodoc
class _$IInitialEnvironmentsCopyWithImpl<$Res>
    implements $IInitialEnvironmentsCopyWith<$Res> {
  _$IInitialEnvironmentsCopyWithImpl(this._value, this._then);

  final IInitialEnvironments _value;
  // ignore: unused_field
  final $Res Function(IInitialEnvironments) _then;

  @override
  $Res call({
    Object? base = freezed,
    Object? subEnvironments = freezed,
  }) {
    return _then(_value.copyWith(
      base: base == freezed
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as InitialEnvironmentState?,
      subEnvironments: subEnvironments == freezed
          ? _value.subEnvironments
          : subEnvironments // ignore: cast_nullable_to_non_nullable
              as List<InitialEnvironmentState>?,
    ));
  }

  @override
  $InitialEnvironmentStateCopyWith<$Res>? get base {
    if (_value.base == null) {
      return null;
    }

    return $InitialEnvironmentStateCopyWith<$Res>(_value.base!, (value) {
      return _then(_value.copyWith(base: value));
    });
  }
}

/// @nodoc
abstract class _$IInitialEnvironmentsCopyWith<$Res>
    implements $IInitialEnvironmentsCopyWith<$Res> {
  factory _$IInitialEnvironmentsCopyWith(_IInitialEnvironments value,
          $Res Function(_IInitialEnvironments) then) =
      __$IInitialEnvironmentsCopyWithImpl<$Res>;
  @override
  $Res call(
      {InitialEnvironmentState? base,
      List<InitialEnvironmentState>? subEnvironments});

  @override
  $InitialEnvironmentStateCopyWith<$Res>? get base;
}

/// @nodoc
class __$IInitialEnvironmentsCopyWithImpl<$Res>
    extends _$IInitialEnvironmentsCopyWithImpl<$Res>
    implements _$IInitialEnvironmentsCopyWith<$Res> {
  __$IInitialEnvironmentsCopyWithImpl(
      _IInitialEnvironments _value, $Res Function(_IInitialEnvironments) _then)
      : super(_value, (v) => _then(v as _IInitialEnvironments));

  @override
  _IInitialEnvironments get _value => super._value as _IInitialEnvironments;

  @override
  $Res call({
    Object? base = freezed,
    Object? subEnvironments = freezed,
  }) {
    return _then(_IInitialEnvironments(
      base: base == freezed
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as InitialEnvironmentState?,
      subEnvironments: subEnvironments == freezed
          ? _value.subEnvironments
          : subEnvironments // ignore: cast_nullable_to_non_nullable
              as List<InitialEnvironmentState>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IInitialEnvironments implements _IInitialEnvironments {
  const _$_IInitialEnvironments({this.base, this.subEnvironments});

  factory _$_IInitialEnvironments.fromJson(Map<String, dynamic> json) =>
      _$$_IInitialEnvironmentsFromJson(json);

  @override
  final InitialEnvironmentState? base;
  @override
  final List<InitialEnvironmentState>? subEnvironments;

  @override
  String toString() {
    return 'IInitialEnvironments(base: $base, subEnvironments: $subEnvironments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IInitialEnvironments &&
            const DeepCollectionEquality().equals(other.base, base) &&
            const DeepCollectionEquality()
                .equals(other.subEnvironments, subEnvironments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(base),
      const DeepCollectionEquality().hash(subEnvironments));

  @JsonKey(ignore: true)
  @override
  _$IInitialEnvironmentsCopyWith<_IInitialEnvironments> get copyWith =>
      __$IInitialEnvironmentsCopyWithImpl<_IInitialEnvironments>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IInitialEnvironmentsToJson(this);
  }
}

abstract class _IInitialEnvironments implements IInitialEnvironments {
  const factory _IInitialEnvironments(
          {InitialEnvironmentState? base,
          List<InitialEnvironmentState>? subEnvironments}) =
      _$_IInitialEnvironments;

  factory _IInitialEnvironments.fromJson(Map<String, dynamic> json) =
      _$_IInitialEnvironments.fromJson;

  @override
  InitialEnvironmentState? get base;
  @override
  List<InitialEnvironmentState>? get subEnvironments;
  @override
  @JsonKey(ignore: true)
  _$IInitialEnvironmentsCopyWith<_IInitialEnvironments> get copyWith =>
      throw _privateConstructorUsedError;
}

InitialEnvironmentState _$InitialEnvironmentStateFromJson(
    Map<String, dynamic> json) {
  return _InitialEnvironmentState.fromJson(json);
}

/// @nodoc
class _$InitialEnvironmentStateTearOff {
  const _$InitialEnvironmentStateTearOff();

  _InitialEnvironmentState call(
      {String? id, String? title, Map<String, Object?>? variables}) {
    return _InitialEnvironmentState(
      id: id,
      title: title,
      variables: variables,
    );
  }

  InitialEnvironmentState fromJson(Map<String, Object?> json) {
    return InitialEnvironmentState.fromJson(json);
  }
}

/// @nodoc
const $InitialEnvironmentState = _$InitialEnvironmentStateTearOff();

/// @nodoc
mixin _$InitialEnvironmentState {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  Map<String, Object?>? get variables => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InitialEnvironmentStateCopyWith<InitialEnvironmentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitialEnvironmentStateCopyWith<$Res> {
  factory $InitialEnvironmentStateCopyWith(InitialEnvironmentState value,
          $Res Function(InitialEnvironmentState) then) =
      _$InitialEnvironmentStateCopyWithImpl<$Res>;
  $Res call({String? id, String? title, Map<String, Object?>? variables});
}

/// @nodoc
class _$InitialEnvironmentStateCopyWithImpl<$Res>
    implements $InitialEnvironmentStateCopyWith<$Res> {
  _$InitialEnvironmentStateCopyWithImpl(this._value, this._then);

  final InitialEnvironmentState _value;
  // ignore: unused_field
  final $Res Function(InitialEnvironmentState) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? variables = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      variables: variables == freezed
          ? _value.variables
          : variables // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ));
  }
}

/// @nodoc
abstract class _$InitialEnvironmentStateCopyWith<$Res>
    implements $InitialEnvironmentStateCopyWith<$Res> {
  factory _$InitialEnvironmentStateCopyWith(_InitialEnvironmentState value,
          $Res Function(_InitialEnvironmentState) then) =
      __$InitialEnvironmentStateCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? title, Map<String, Object?>? variables});
}

/// @nodoc
class __$InitialEnvironmentStateCopyWithImpl<$Res>
    extends _$InitialEnvironmentStateCopyWithImpl<$Res>
    implements _$InitialEnvironmentStateCopyWith<$Res> {
  __$InitialEnvironmentStateCopyWithImpl(_InitialEnvironmentState _value,
      $Res Function(_InitialEnvironmentState) _then)
      : super(_value, (v) => _then(v as _InitialEnvironmentState));

  @override
  _InitialEnvironmentState get _value =>
      super._value as _InitialEnvironmentState;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? variables = freezed,
  }) {
    return _then(_InitialEnvironmentState(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      variables: variables == freezed
          ? _value.variables
          : variables // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InitialEnvironmentState implements _InitialEnvironmentState {
  const _$_InitialEnvironmentState({this.id, this.title, this.variables});

  factory _$_InitialEnvironmentState.fromJson(Map<String, dynamic> json) =>
      _$$_InitialEnvironmentStateFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final Map<String, Object?>? variables;

  @override
  String toString() {
    return 'InitialEnvironmentState(id: $id, title: $title, variables: $variables)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InitialEnvironmentState &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.variables, variables));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(variables));

  @JsonKey(ignore: true)
  @override
  _$InitialEnvironmentStateCopyWith<_InitialEnvironmentState> get copyWith =>
      __$InitialEnvironmentStateCopyWithImpl<_InitialEnvironmentState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialEnvironmentStateToJson(this);
  }
}

abstract class _InitialEnvironmentState implements InitialEnvironmentState {
  const factory _InitialEnvironmentState(
      {String? id,
      String? title,
      Map<String, Object?>? variables}) = _$_InitialEnvironmentState;

  factory _InitialEnvironmentState.fromJson(Map<String, dynamic> json) =
      _$_InitialEnvironmentState.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  Map<String, Object?>? get variables;
  @override
  @JsonKey(ignore: true)
  _$InitialEnvironmentStateCopyWith<_InitialEnvironmentState> get copyWith =>
      throw _privateConstructorUsedError;
}
