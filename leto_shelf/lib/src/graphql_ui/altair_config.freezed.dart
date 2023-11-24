// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'altair_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AltairConfig _$AltairConfigFromJson(Map<String, dynamic> json) {
  return _AltairConfig.fromJson(json);
}

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
      _$AltairConfigCopyWithImpl<$Res, AltairConfig>;
  @useResult
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
class _$AltairConfigCopyWithImpl<$Res, $Val extends AltairConfig>
    implements $AltairConfigCopyWith<$Res> {
  _$AltairConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
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
      endpointURL: freezed == endpointURL
          ? _value.endpointURL
          : endpointURL // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionsEndpoint: freezed == subscriptionsEndpoint
          ? _value.subscriptionsEndpoint
          : subscriptionsEndpoint // ignore: cast_nullable_to_non_nullable
              as String?,
      initialQuery: freezed == initialQuery
          ? _value.initialQuery
          : initialQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      initialVariables: freezed == initialVariables
          ? _value.initialVariables
          : initialVariables // ignore: cast_nullable_to_non_nullable
              as String?,
      initialPreRequestScript: freezed == initialPreRequestScript
          ? _value.initialPreRequestScript
          : initialPreRequestScript // ignore: cast_nullable_to_non_nullable
              as String?,
      initialPostRequestScript: freezed == initialPostRequestScript
          ? _value.initialPostRequestScript
          : initialPostRequestScript // ignore: cast_nullable_to_non_nullable
              as String?,
      initialHeaders: freezed == initialHeaders
          ? _value.initialHeaders
          : initialHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      initialEnvironments: freezed == initialEnvironments
          ? _value.initialEnvironments
          : initialEnvironments // ignore: cast_nullable_to_non_nullable
              as IInitialEnvironments?,
      instanceStorageNamespace: freezed == instanceStorageNamespace
          ? _value.instanceStorageNamespace
          : instanceStorageNamespace // ignore: cast_nullable_to_non_nullable
              as String?,
      initialSettings: freezed == initialSettings
          ? _value.initialSettings
          : initialSettings // ignore: cast_nullable_to_non_nullable
              as SettingsState?,
      initialSubscriptionsProvider: freezed == initialSubscriptionsProvider
          ? _value.initialSubscriptionsProvider
          : initialSubscriptionsProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      initialSubscriptionsPayload: freezed == initialSubscriptionsPayload
          ? _value.initialSubscriptionsPayload
          : initialSubscriptionsPayload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      preserveState: freezed == preserveState
          ? _value.preserveState
          : preserveState // ignore: cast_nullable_to_non_nullable
              as bool?,
      initialHttpMethod: freezed == initialHttpMethod
          ? _value.initialHttpMethod
          : initialHttpMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      baseURL: freezed == baseURL
          ? _value.baseURL
          : baseURL // ignore: cast_nullable_to_non_nullable
              as String?,
      serveInitialOptionsInSeperateRequest: freezed ==
              serveInitialOptionsInSeperateRequest
          ? _value.serveInitialOptionsInSeperateRequest
          : serveInitialOptionsInSeperateRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IInitialEnvironmentsCopyWith<$Res>? get initialEnvironments {
    if (_value.initialEnvironments == null) {
      return null;
    }

    return $IInitialEnvironmentsCopyWith<$Res>(_value.initialEnvironments!,
        (value) {
      return _then(_value.copyWith(initialEnvironments: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SettingsStateCopyWith<$Res>? get initialSettings {
    if (_value.initialSettings == null) {
      return null;
    }

    return $SettingsStateCopyWith<$Res>(_value.initialSettings!, (value) {
      return _then(_value.copyWith(initialSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AltairConfigCopyWith<$Res>
    implements $AltairConfigCopyWith<$Res> {
  factory _$$_AltairConfigCopyWith(
          _$_AltairConfig value, $Res Function(_$_AltairConfig) then) =
      __$$_AltairConfigCopyWithImpl<$Res>;
  @override
  @useResult
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
class __$$_AltairConfigCopyWithImpl<$Res>
    extends _$AltairConfigCopyWithImpl<$Res, _$_AltairConfig>
    implements _$$_AltairConfigCopyWith<$Res> {
  __$$_AltairConfigCopyWithImpl(
      _$_AltairConfig _value, $Res Function(_$_AltairConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
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
    return _then(_$_AltairConfig(
      endpointURL: freezed == endpointURL
          ? _value.endpointURL
          : endpointURL // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionsEndpoint: freezed == subscriptionsEndpoint
          ? _value.subscriptionsEndpoint
          : subscriptionsEndpoint // ignore: cast_nullable_to_non_nullable
              as String?,
      initialQuery: freezed == initialQuery
          ? _value.initialQuery
          : initialQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      initialVariables: freezed == initialVariables
          ? _value.initialVariables
          : initialVariables // ignore: cast_nullable_to_non_nullable
              as String?,
      initialPreRequestScript: freezed == initialPreRequestScript
          ? _value.initialPreRequestScript
          : initialPreRequestScript // ignore: cast_nullable_to_non_nullable
              as String?,
      initialPostRequestScript: freezed == initialPostRequestScript
          ? _value.initialPostRequestScript
          : initialPostRequestScript // ignore: cast_nullable_to_non_nullable
              as String?,
      initialHeaders: freezed == initialHeaders
          ? _value._initialHeaders
          : initialHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      initialEnvironments: freezed == initialEnvironments
          ? _value.initialEnvironments
          : initialEnvironments // ignore: cast_nullable_to_non_nullable
              as IInitialEnvironments?,
      instanceStorageNamespace: freezed == instanceStorageNamespace
          ? _value.instanceStorageNamespace
          : instanceStorageNamespace // ignore: cast_nullable_to_non_nullable
              as String?,
      initialSettings: freezed == initialSettings
          ? _value.initialSettings
          : initialSettings // ignore: cast_nullable_to_non_nullable
              as SettingsState?,
      initialSubscriptionsProvider: freezed == initialSubscriptionsProvider
          ? _value.initialSubscriptionsProvider
          : initialSubscriptionsProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      initialSubscriptionsPayload: freezed == initialSubscriptionsPayload
          ? _value._initialSubscriptionsPayload
          : initialSubscriptionsPayload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      preserveState: freezed == preserveState
          ? _value.preserveState
          : preserveState // ignore: cast_nullable_to_non_nullable
              as bool?,
      initialHttpMethod: freezed == initialHttpMethod
          ? _value.initialHttpMethod
          : initialHttpMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      baseURL: freezed == baseURL
          ? _value.baseURL
          : baseURL // ignore: cast_nullable_to_non_nullable
              as String?,
      serveInitialOptionsInSeperateRequest: freezed ==
              serveInitialOptionsInSeperateRequest
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
      final Map<String, Object?>? initialHeaders,
      this.initialEnvironments,
      this.instanceStorageNamespace,
      this.initialSettings,
      this.initialSubscriptionsProvider,
      final Map<String, Object?>? initialSubscriptionsPayload,
      this.preserveState,
      this.initialHttpMethod,
      this.baseURL,
      this.serveInitialOptionsInSeperateRequest})
      : _initialHeaders = initialHeaders,
        _initialSubscriptionsPayload = initialSubscriptionsPayload;

  factory _$_AltairConfig.fromJson(Map<String, dynamic> json) =>
      _$$_AltairConfigFromJson(json);

  /// URL to set as the server endpoint
  @override
  final String? endpointURL;

  /// URL to set as the subscription endpoint
  @override
  final String? subscriptionsEndpoint;

  /// Initial query to be added
  @override
  final String? initialQuery;

  /// Initial variables to be added
  @override
  final String? initialVariables;

  /// Initial pre-request script to be added
  @override
  final String? initialPreRequestScript;

  /// Initial post-request script to be added
  @override
  final String? initialPostRequestScript;

  /// Initial headers object to be added
  /// @example
  /// {
  ///  'X-GraphQL-Token': 'asd7-237s-2bdk-nsdk4'
  /// }
  final Map<String, Object?>? _initialHeaders;

  /// Initial headers object to be added
  /// @example
  /// {
  ///  'X-GraphQL-Token': 'asd7-237s-2bdk-nsdk4'
  /// }
  @override
  Map<String, Object?>? get initialHeaders {
    final value = _initialHeaders;
    if (value == null) return null;
    if (_initialHeaders is EqualUnmodifiableMapView) return _initialHeaders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

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
  @override
  final IInitialEnvironments? initialEnvironments;

  /// Namespace for storing the data for the altair instance.
  /// Use this when you have multiple altair instances
  /// running on the same domain.
  /// @example
  /// instanceStorageNamespace: 'altair_dev_'
  @override
  final String? instanceStorageNamespace;

  /// Initial app settings to use
  @override
  final SettingsState? initialSettings;

  /// Initial subscriptions provider
  /// One of: 'websocket' | 'graphql-ws' | 'app-sync' | 'action-cable'
  /// @default "websocket"
  @override
  final String? initialSubscriptionsProvider;

  /// Initial subscriptions connection params
  final Map<String, Object?>? _initialSubscriptionsPayload;

  /// Initial subscriptions connection params
  @override
  Map<String, Object?>? get initialSubscriptionsPayload {
    final value = _initialSubscriptionsPayload;
    if (value == null) return null;
    if (_initialSubscriptionsPayload is EqualUnmodifiableMapView)
      return _initialSubscriptionsPayload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Indicates if the state should be preserved for subsequent app loads
  ///
  /// @default true
  @override
  final bool? preserveState;

  /// HTTP method to use for making requests 'POST', 'GET', 'PUT', 'DELETE'
  @override
  final String? initialHttpMethod;

  /// URL to be used as a base for relative URLs
  @override
  final String? baseURL;

  /// Whether to render the initial options in a seperate javascript
  /// file or not.
  /// Use this to be able to enforce strict CSP rules.
  ///
  /// @default false
  @override
  final bool? serveInitialOptionsInSeperateRequest;

  @override
  String toString() {
    return 'AltairConfig(endpointURL: $endpointURL, subscriptionsEndpoint: $subscriptionsEndpoint, initialQuery: $initialQuery, initialVariables: $initialVariables, initialPreRequestScript: $initialPreRequestScript, initialPostRequestScript: $initialPostRequestScript, initialHeaders: $initialHeaders, initialEnvironments: $initialEnvironments, instanceStorageNamespace: $instanceStorageNamespace, initialSettings: $initialSettings, initialSubscriptionsProvider: $initialSubscriptionsProvider, initialSubscriptionsPayload: $initialSubscriptionsPayload, preserveState: $preserveState, initialHttpMethod: $initialHttpMethod, baseURL: $baseURL, serveInitialOptionsInSeperateRequest: $serveInitialOptionsInSeperateRequest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AltairConfig &&
            (identical(other.endpointURL, endpointURL) ||
                other.endpointURL == endpointURL) &&
            (identical(other.subscriptionsEndpoint, subscriptionsEndpoint) ||
                other.subscriptionsEndpoint == subscriptionsEndpoint) &&
            (identical(other.initialQuery, initialQuery) ||
                other.initialQuery == initialQuery) &&
            (identical(other.initialVariables, initialVariables) ||
                other.initialVariables == initialVariables) &&
            (identical(other.initialPreRequestScript, initialPreRequestScript) ||
                other.initialPreRequestScript == initialPreRequestScript) &&
            (identical(other.initialPostRequestScript, initialPostRequestScript) ||
                other.initialPostRequestScript == initialPostRequestScript) &&
            const DeepCollectionEquality()
                .equals(other._initialHeaders, _initialHeaders) &&
            (identical(other.initialEnvironments, initialEnvironments) ||
                other.initialEnvironments == initialEnvironments) &&
            (identical(other.instanceStorageNamespace, instanceStorageNamespace) ||
                other.instanceStorageNamespace == instanceStorageNamespace) &&
            (identical(other.initialSettings, initialSettings) ||
                other.initialSettings == initialSettings) &&
            (identical(other.initialSubscriptionsProvider,
                    initialSubscriptionsProvider) ||
                other.initialSubscriptionsProvider ==
                    initialSubscriptionsProvider) &&
            const DeepCollectionEquality().equals(
                other._initialSubscriptionsPayload,
                _initialSubscriptionsPayload) &&
            (identical(other.preserveState, preserveState) ||
                other.preserveState == preserveState) &&
            (identical(other.initialHttpMethod, initialHttpMethod) ||
                other.initialHttpMethod == initialHttpMethod) &&
            (identical(other.baseURL, baseURL) || other.baseURL == baseURL) &&
            (identical(other.serveInitialOptionsInSeperateRequest,
                    serveInitialOptionsInSeperateRequest) ||
                other.serveInitialOptionsInSeperateRequest ==
                    serveInitialOptionsInSeperateRequest));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      endpointURL,
      subscriptionsEndpoint,
      initialQuery,
      initialVariables,
      initialPreRequestScript,
      initialPostRequestScript,
      const DeepCollectionEquality().hash(_initialHeaders),
      initialEnvironments,
      instanceStorageNamespace,
      initialSettings,
      initialSubscriptionsProvider,
      const DeepCollectionEquality().hash(_initialSubscriptionsPayload),
      preserveState,
      initialHttpMethod,
      baseURL,
      serveInitialOptionsInSeperateRequest);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AltairConfigCopyWith<_$_AltairConfig> get copyWith =>
      __$$_AltairConfigCopyWithImpl<_$_AltairConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AltairConfigToJson(
      this,
    );
  }
}

abstract class _AltairConfig implements AltairConfig {
  const factory _AltairConfig(
      {final String? endpointURL,
      final String? subscriptionsEndpoint,
      final String? initialQuery,
      final String? initialVariables,
      final String? initialPreRequestScript,
      final String? initialPostRequestScript,
      final Map<String, Object?>? initialHeaders,
      final IInitialEnvironments? initialEnvironments,
      final String? instanceStorageNamespace,
      final SettingsState? initialSettings,
      final String? initialSubscriptionsProvider,
      final Map<String, Object?>? initialSubscriptionsPayload,
      final bool? preserveState,
      final String? initialHttpMethod,
      final String? baseURL,
      final bool? serveInitialOptionsInSeperateRequest}) = _$_AltairConfig;

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
  _$$_AltairConfigCopyWith<_$_AltairConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

IInitialEnvironments _$IInitialEnvironmentsFromJson(Map<String, dynamic> json) {
  return _IInitialEnvironments.fromJson(json);
}

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
      _$IInitialEnvironmentsCopyWithImpl<$Res, IInitialEnvironments>;
  @useResult
  $Res call(
      {InitialEnvironmentState? base,
      List<InitialEnvironmentState>? subEnvironments});

  $InitialEnvironmentStateCopyWith<$Res>? get base;
}

/// @nodoc
class _$IInitialEnvironmentsCopyWithImpl<$Res,
        $Val extends IInitialEnvironments>
    implements $IInitialEnvironmentsCopyWith<$Res> {
  _$IInitialEnvironmentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base = freezed,
    Object? subEnvironments = freezed,
  }) {
    return _then(_value.copyWith(
      base: freezed == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as InitialEnvironmentState?,
      subEnvironments: freezed == subEnvironments
          ? _value.subEnvironments
          : subEnvironments // ignore: cast_nullable_to_non_nullable
              as List<InitialEnvironmentState>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InitialEnvironmentStateCopyWith<$Res>? get base {
    if (_value.base == null) {
      return null;
    }

    return $InitialEnvironmentStateCopyWith<$Res>(_value.base!, (value) {
      return _then(_value.copyWith(base: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_IInitialEnvironmentsCopyWith<$Res>
    implements $IInitialEnvironmentsCopyWith<$Res> {
  factory _$$_IInitialEnvironmentsCopyWith(_$_IInitialEnvironments value,
          $Res Function(_$_IInitialEnvironments) then) =
      __$$_IInitialEnvironmentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InitialEnvironmentState? base,
      List<InitialEnvironmentState>? subEnvironments});

  @override
  $InitialEnvironmentStateCopyWith<$Res>? get base;
}

/// @nodoc
class __$$_IInitialEnvironmentsCopyWithImpl<$Res>
    extends _$IInitialEnvironmentsCopyWithImpl<$Res, _$_IInitialEnvironments>
    implements _$$_IInitialEnvironmentsCopyWith<$Res> {
  __$$_IInitialEnvironmentsCopyWithImpl(_$_IInitialEnvironments _value,
      $Res Function(_$_IInitialEnvironments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base = freezed,
    Object? subEnvironments = freezed,
  }) {
    return _then(_$_IInitialEnvironments(
      base: freezed == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as InitialEnvironmentState?,
      subEnvironments: freezed == subEnvironments
          ? _value._subEnvironments
          : subEnvironments // ignore: cast_nullable_to_non_nullable
              as List<InitialEnvironmentState>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IInitialEnvironments implements _IInitialEnvironments {
  const _$_IInitialEnvironments(
      {this.base, final List<InitialEnvironmentState>? subEnvironments})
      : _subEnvironments = subEnvironments;

  factory _$_IInitialEnvironments.fromJson(Map<String, dynamic> json) =>
      _$$_IInitialEnvironmentsFromJson(json);

  @override
  final InitialEnvironmentState? base;
  final List<InitialEnvironmentState>? _subEnvironments;
  @override
  List<InitialEnvironmentState>? get subEnvironments {
    final value = _subEnvironments;
    if (value == null) return null;
    if (_subEnvironments is EqualUnmodifiableListView) return _subEnvironments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'IInitialEnvironments(base: $base, subEnvironments: $subEnvironments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IInitialEnvironments &&
            (identical(other.base, base) || other.base == base) &&
            const DeepCollectionEquality()
                .equals(other._subEnvironments, _subEnvironments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, base, const DeepCollectionEquality().hash(_subEnvironments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IInitialEnvironmentsCopyWith<_$_IInitialEnvironments> get copyWith =>
      __$$_IInitialEnvironmentsCopyWithImpl<_$_IInitialEnvironments>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IInitialEnvironmentsToJson(
      this,
    );
  }
}

abstract class _IInitialEnvironments implements IInitialEnvironments {
  const factory _IInitialEnvironments(
          {final InitialEnvironmentState? base,
          final List<InitialEnvironmentState>? subEnvironments}) =
      _$_IInitialEnvironments;

  factory _IInitialEnvironments.fromJson(Map<String, dynamic> json) =
      _$_IInitialEnvironments.fromJson;

  @override
  InitialEnvironmentState? get base;
  @override
  List<InitialEnvironmentState>? get subEnvironments;
  @override
  @JsonKey(ignore: true)
  _$$_IInitialEnvironmentsCopyWith<_$_IInitialEnvironments> get copyWith =>
      throw _privateConstructorUsedError;
}

InitialEnvironmentState _$InitialEnvironmentStateFromJson(
    Map<String, dynamic> json) {
  return _InitialEnvironmentState.fromJson(json);
}

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
      _$InitialEnvironmentStateCopyWithImpl<$Res, InitialEnvironmentState>;
  @useResult
  $Res call({String? id, String? title, Map<String, Object?>? variables});
}

/// @nodoc
class _$InitialEnvironmentStateCopyWithImpl<$Res,
        $Val extends InitialEnvironmentState>
    implements $InitialEnvironmentStateCopyWith<$Res> {
  _$InitialEnvironmentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? variables = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      variables: freezed == variables
          ? _value.variables
          : variables // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialEnvironmentStateCopyWith<$Res>
    implements $InitialEnvironmentStateCopyWith<$Res> {
  factory _$$_InitialEnvironmentStateCopyWith(_$_InitialEnvironmentState value,
          $Res Function(_$_InitialEnvironmentState) then) =
      __$$_InitialEnvironmentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? title, Map<String, Object?>? variables});
}

/// @nodoc
class __$$_InitialEnvironmentStateCopyWithImpl<$Res>
    extends _$InitialEnvironmentStateCopyWithImpl<$Res,
        _$_InitialEnvironmentState>
    implements _$$_InitialEnvironmentStateCopyWith<$Res> {
  __$$_InitialEnvironmentStateCopyWithImpl(_$_InitialEnvironmentState _value,
      $Res Function(_$_InitialEnvironmentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? variables = freezed,
  }) {
    return _then(_$_InitialEnvironmentState(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      variables: freezed == variables
          ? _value._variables
          : variables // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InitialEnvironmentState implements _InitialEnvironmentState {
  const _$_InitialEnvironmentState(
      {this.id, this.title, final Map<String, Object?>? variables})
      : _variables = variables;

  factory _$_InitialEnvironmentState.fromJson(Map<String, dynamic> json) =>
      _$$_InitialEnvironmentStateFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  final Map<String, Object?>? _variables;
  @override
  Map<String, Object?>? get variables {
    final value = _variables;
    if (value == null) return null;
    if (_variables is EqualUnmodifiableMapView) return _variables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'InitialEnvironmentState(id: $id, title: $title, variables: $variables)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InitialEnvironmentState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._variables, _variables));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, const DeepCollectionEquality().hash(_variables));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialEnvironmentStateCopyWith<_$_InitialEnvironmentState>
      get copyWith =>
          __$$_InitialEnvironmentStateCopyWithImpl<_$_InitialEnvironmentState>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialEnvironmentStateToJson(
      this,
    );
  }
}

abstract class _InitialEnvironmentState implements InitialEnvironmentState {
  const factory _InitialEnvironmentState(
      {final String? id,
      final String? title,
      final Map<String, Object?>? variables}) = _$_InitialEnvironmentState;

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
  _$$_InitialEnvironmentStateCopyWith<_$_InitialEnvironmentState>
      get copyWith => throw _privateConstructorUsedError;
}
