// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'playground_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ISettings _$ISettingsFromJson(Map<String, dynamic> json) {
  return _ISettings.fromJson(json);
}

/// @nodoc
mixin _$ISettings {
  @JsonKey(name: 'general.betaUpdates')
  bool get generalbetaUpdates => throw _privateConstructorUsedError;

  /// 'line' | 'block' | 'underline'
  @JsonKey(name: 'editor.cursorShape')
  String get editorcursorShape => throw _privateConstructorUsedError;

  /// 'dark' | 'light'
  @JsonKey(name: 'editor.theme')
  String get editortheme => throw _privateConstructorUsedError;
  @JsonKey(name: 'editor.reuseHeaders')
  bool get editorreuseHeaders => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracing.hideTracingResponse')
  bool get tracinghideTracingResponse => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracing.tracingSupported')
  bool get tracingtracingSupported => throw _privateConstructorUsedError;
  @JsonKey(name: 'editor.fontSize')
  int get editorfontSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'editor.fontFamily')
  String get editorfontFamily => throw _privateConstructorUsedError;

  /// 'omit' | 'include' | 'same-origin'
  @JsonKey(name: 'request.credentials')
  String get requestcredentials => throw _privateConstructorUsedError;
  @JsonKey(name: 'request.globalHeaders')
  Map<String, Object?> get requestglobalHeaders =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'schema.polling.enable')
  bool get schemapollingenable => throw _privateConstructorUsedError;
  @JsonKey(name: 'schema.polling.endpointFilter')
  String get schemapollingendpointFilter => throw _privateConstructorUsedError;
  @JsonKey(name: 'schema.polling.interval')
  int get schemapollinginterval => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ISettingsCopyWith<ISettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ISettingsCopyWith<$Res> {
  factory $ISettingsCopyWith(ISettings value, $Res Function(ISettings) then) =
      _$ISettingsCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'general.betaUpdates')
          bool generalbetaUpdates,
      @JsonKey(name: 'editor.cursorShape')
          String editorcursorShape,
      @JsonKey(name: 'editor.theme')
          String editortheme,
      @JsonKey(name: 'editor.reuseHeaders')
          bool editorreuseHeaders,
      @JsonKey(name: 'tracing.hideTracingResponse')
          bool tracinghideTracingResponse,
      @JsonKey(name: 'tracing.tracingSupported')
          bool tracingtracingSupported,
      @JsonKey(name: 'editor.fontSize')
          int editorfontSize,
      @JsonKey(name: 'editor.fontFamily')
          String editorfontFamily,
      @JsonKey(name: 'request.credentials')
          String requestcredentials,
      @JsonKey(name: 'request.globalHeaders')
          Map<String, Object?> requestglobalHeaders,
      @JsonKey(name: 'schema.polling.enable')
          bool schemapollingenable,
      @JsonKey(name: 'schema.polling.endpointFilter')
          String schemapollingendpointFilter,
      @JsonKey(name: 'schema.polling.interval')
          int schemapollinginterval});
}

/// @nodoc
class _$ISettingsCopyWithImpl<$Res> implements $ISettingsCopyWith<$Res> {
  _$ISettingsCopyWithImpl(this._value, this._then);

  final ISettings _value;
  // ignore: unused_field
  final $Res Function(ISettings) _then;

  @override
  $Res call({
    Object? generalbetaUpdates = freezed,
    Object? editorcursorShape = freezed,
    Object? editortheme = freezed,
    Object? editorreuseHeaders = freezed,
    Object? tracinghideTracingResponse = freezed,
    Object? tracingtracingSupported = freezed,
    Object? editorfontSize = freezed,
    Object? editorfontFamily = freezed,
    Object? requestcredentials = freezed,
    Object? requestglobalHeaders = freezed,
    Object? schemapollingenable = freezed,
    Object? schemapollingendpointFilter = freezed,
    Object? schemapollinginterval = freezed,
  }) {
    return _then(_value.copyWith(
      generalbetaUpdates: generalbetaUpdates == freezed
          ? _value.generalbetaUpdates
          : generalbetaUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      editorcursorShape: editorcursorShape == freezed
          ? _value.editorcursorShape
          : editorcursorShape // ignore: cast_nullable_to_non_nullable
              as String,
      editortheme: editortheme == freezed
          ? _value.editortheme
          : editortheme // ignore: cast_nullable_to_non_nullable
              as String,
      editorreuseHeaders: editorreuseHeaders == freezed
          ? _value.editorreuseHeaders
          : editorreuseHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      tracinghideTracingResponse: tracinghideTracingResponse == freezed
          ? _value.tracinghideTracingResponse
          : tracinghideTracingResponse // ignore: cast_nullable_to_non_nullable
              as bool,
      tracingtracingSupported: tracingtracingSupported == freezed
          ? _value.tracingtracingSupported
          : tracingtracingSupported // ignore: cast_nullable_to_non_nullable
              as bool,
      editorfontSize: editorfontSize == freezed
          ? _value.editorfontSize
          : editorfontSize // ignore: cast_nullable_to_non_nullable
              as int,
      editorfontFamily: editorfontFamily == freezed
          ? _value.editorfontFamily
          : editorfontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      requestcredentials: requestcredentials == freezed
          ? _value.requestcredentials
          : requestcredentials // ignore: cast_nullable_to_non_nullable
              as String,
      requestglobalHeaders: requestglobalHeaders == freezed
          ? _value.requestglobalHeaders
          : requestglobalHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
      schemapollingenable: schemapollingenable == freezed
          ? _value.schemapollingenable
          : schemapollingenable // ignore: cast_nullable_to_non_nullable
              as bool,
      schemapollingendpointFilter: schemapollingendpointFilter == freezed
          ? _value.schemapollingendpointFilter
          : schemapollingendpointFilter // ignore: cast_nullable_to_non_nullable
              as String,
      schemapollinginterval: schemapollinginterval == freezed
          ? _value.schemapollinginterval
          : schemapollinginterval // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_ISettingsCopyWith<$Res> implements $ISettingsCopyWith<$Res> {
  factory _$$_ISettingsCopyWith(
          _$_ISettings value, $Res Function(_$_ISettings) then) =
      __$$_ISettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'general.betaUpdates')
          bool generalbetaUpdates,
      @JsonKey(name: 'editor.cursorShape')
          String editorcursorShape,
      @JsonKey(name: 'editor.theme')
          String editortheme,
      @JsonKey(name: 'editor.reuseHeaders')
          bool editorreuseHeaders,
      @JsonKey(name: 'tracing.hideTracingResponse')
          bool tracinghideTracingResponse,
      @JsonKey(name: 'tracing.tracingSupported')
          bool tracingtracingSupported,
      @JsonKey(name: 'editor.fontSize')
          int editorfontSize,
      @JsonKey(name: 'editor.fontFamily')
          String editorfontFamily,
      @JsonKey(name: 'request.credentials')
          String requestcredentials,
      @JsonKey(name: 'request.globalHeaders')
          Map<String, Object?> requestglobalHeaders,
      @JsonKey(name: 'schema.polling.enable')
          bool schemapollingenable,
      @JsonKey(name: 'schema.polling.endpointFilter')
          String schemapollingendpointFilter,
      @JsonKey(name: 'schema.polling.interval')
          int schemapollinginterval});
}

/// @nodoc
class __$$_ISettingsCopyWithImpl<$Res> extends _$ISettingsCopyWithImpl<$Res>
    implements _$$_ISettingsCopyWith<$Res> {
  __$$_ISettingsCopyWithImpl(
      _$_ISettings _value, $Res Function(_$_ISettings) _then)
      : super(_value, (v) => _then(v as _$_ISettings));

  @override
  _$_ISettings get _value => super._value as _$_ISettings;

  @override
  $Res call({
    Object? generalbetaUpdates = freezed,
    Object? editorcursorShape = freezed,
    Object? editortheme = freezed,
    Object? editorreuseHeaders = freezed,
    Object? tracinghideTracingResponse = freezed,
    Object? tracingtracingSupported = freezed,
    Object? editorfontSize = freezed,
    Object? editorfontFamily = freezed,
    Object? requestcredentials = freezed,
    Object? requestglobalHeaders = freezed,
    Object? schemapollingenable = freezed,
    Object? schemapollingendpointFilter = freezed,
    Object? schemapollinginterval = freezed,
  }) {
    return _then(_$_ISettings(
      generalbetaUpdates: generalbetaUpdates == freezed
          ? _value.generalbetaUpdates
          : generalbetaUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      editorcursorShape: editorcursorShape == freezed
          ? _value.editorcursorShape
          : editorcursorShape // ignore: cast_nullable_to_non_nullable
              as String,
      editortheme: editortheme == freezed
          ? _value.editortheme
          : editortheme // ignore: cast_nullable_to_non_nullable
              as String,
      editorreuseHeaders: editorreuseHeaders == freezed
          ? _value.editorreuseHeaders
          : editorreuseHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      tracinghideTracingResponse: tracinghideTracingResponse == freezed
          ? _value.tracinghideTracingResponse
          : tracinghideTracingResponse // ignore: cast_nullable_to_non_nullable
              as bool,
      tracingtracingSupported: tracingtracingSupported == freezed
          ? _value.tracingtracingSupported
          : tracingtracingSupported // ignore: cast_nullable_to_non_nullable
              as bool,
      editorfontSize: editorfontSize == freezed
          ? _value.editorfontSize
          : editorfontSize // ignore: cast_nullable_to_non_nullable
              as int,
      editorfontFamily: editorfontFamily == freezed
          ? _value.editorfontFamily
          : editorfontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      requestcredentials: requestcredentials == freezed
          ? _value.requestcredentials
          : requestcredentials // ignore: cast_nullable_to_non_nullable
              as String,
      requestglobalHeaders: requestglobalHeaders == freezed
          ? _value._requestglobalHeaders
          : requestglobalHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
      schemapollingenable: schemapollingenable == freezed
          ? _value.schemapollingenable
          : schemapollingenable // ignore: cast_nullable_to_non_nullable
              as bool,
      schemapollingendpointFilter: schemapollingendpointFilter == freezed
          ? _value.schemapollingendpointFilter
          : schemapollingendpointFilter // ignore: cast_nullable_to_non_nullable
              as String,
      schemapollinginterval: schemapollinginterval == freezed
          ? _value.schemapollinginterval
          : schemapollinginterval // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_ISettings implements _ISettings {
  const _$_ISettings(
      {@JsonKey(name: 'general.betaUpdates')
          required this.generalbetaUpdates,
      @JsonKey(name: 'editor.cursorShape')
          required this.editorcursorShape,
      @JsonKey(name: 'editor.theme')
          required this.editortheme,
      @JsonKey(name: 'editor.reuseHeaders')
          required this.editorreuseHeaders,
      @JsonKey(name: 'tracing.hideTracingResponse')
          required this.tracinghideTracingResponse,
      @JsonKey(name: 'tracing.tracingSupported')
          required this.tracingtracingSupported,
      @JsonKey(name: 'editor.fontSize')
          required this.editorfontSize,
      @JsonKey(name: 'editor.fontFamily')
          required this.editorfontFamily,
      @JsonKey(name: 'request.credentials')
          required this.requestcredentials,
      @JsonKey(name: 'request.globalHeaders')
          required final Map<String, Object?> requestglobalHeaders,
      @JsonKey(name: 'schema.polling.enable')
          required this.schemapollingenable,
      @JsonKey(name: 'schema.polling.endpointFilter')
          required this.schemapollingendpointFilter,
      @JsonKey(name: 'schema.polling.interval')
          required this.schemapollinginterval})
      : _requestglobalHeaders = requestglobalHeaders;

  factory _$_ISettings.fromJson(Map<String, dynamic> json) =>
      _$$_ISettingsFromJson(json);

  @override
  @JsonKey(name: 'general.betaUpdates')
  final bool generalbetaUpdates;

  /// 'line' | 'block' | 'underline'
  @override
  @JsonKey(name: 'editor.cursorShape')
  final String editorcursorShape;

  /// 'dark' | 'light'
  @override
  @JsonKey(name: 'editor.theme')
  final String editortheme;
  @override
  @JsonKey(name: 'editor.reuseHeaders')
  final bool editorreuseHeaders;
  @override
  @JsonKey(name: 'tracing.hideTracingResponse')
  final bool tracinghideTracingResponse;
  @override
  @JsonKey(name: 'tracing.tracingSupported')
  final bool tracingtracingSupported;
  @override
  @JsonKey(name: 'editor.fontSize')
  final int editorfontSize;
  @override
  @JsonKey(name: 'editor.fontFamily')
  final String editorfontFamily;

  /// 'omit' | 'include' | 'same-origin'
  @override
  @JsonKey(name: 'request.credentials')
  final String requestcredentials;
  final Map<String, Object?> _requestglobalHeaders;
  @override
  @JsonKey(name: 'request.globalHeaders')
  Map<String, Object?> get requestglobalHeaders {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requestglobalHeaders);
  }

  @override
  @JsonKey(name: 'schema.polling.enable')
  final bool schemapollingenable;
  @override
  @JsonKey(name: 'schema.polling.endpointFilter')
  final String schemapollingendpointFilter;
  @override
  @JsonKey(name: 'schema.polling.interval')
  final int schemapollinginterval;

  @override
  String toString() {
    return 'ISettings(generalbetaUpdates: $generalbetaUpdates, editorcursorShape: $editorcursorShape, editortheme: $editortheme, editorreuseHeaders: $editorreuseHeaders, tracinghideTracingResponse: $tracinghideTracingResponse, tracingtracingSupported: $tracingtracingSupported, editorfontSize: $editorfontSize, editorfontFamily: $editorfontFamily, requestcredentials: $requestcredentials, requestglobalHeaders: $requestglobalHeaders, schemapollingenable: $schemapollingenable, schemapollingendpointFilter: $schemapollingendpointFilter, schemapollinginterval: $schemapollinginterval)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ISettings &&
            const DeepCollectionEquality()
                .equals(other.generalbetaUpdates, generalbetaUpdates) &&
            const DeepCollectionEquality()
                .equals(other.editorcursorShape, editorcursorShape) &&
            const DeepCollectionEquality()
                .equals(other.editortheme, editortheme) &&
            const DeepCollectionEquality()
                .equals(other.editorreuseHeaders, editorreuseHeaders) &&
            const DeepCollectionEquality().equals(
                other.tracinghideTracingResponse, tracinghideTracingResponse) &&
            const DeepCollectionEquality().equals(
                other.tracingtracingSupported, tracingtracingSupported) &&
            const DeepCollectionEquality()
                .equals(other.editorfontSize, editorfontSize) &&
            const DeepCollectionEquality()
                .equals(other.editorfontFamily, editorfontFamily) &&
            const DeepCollectionEquality()
                .equals(other.requestcredentials, requestcredentials) &&
            const DeepCollectionEquality()
                .equals(other._requestglobalHeaders, _requestglobalHeaders) &&
            const DeepCollectionEquality()
                .equals(other.schemapollingenable, schemapollingenable) &&
            const DeepCollectionEquality().equals(
                other.schemapollingendpointFilter,
                schemapollingendpointFilter) &&
            const DeepCollectionEquality()
                .equals(other.schemapollinginterval, schemapollinginterval));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(generalbetaUpdates),
      const DeepCollectionEquality().hash(editorcursorShape),
      const DeepCollectionEquality().hash(editortheme),
      const DeepCollectionEquality().hash(editorreuseHeaders),
      const DeepCollectionEquality().hash(tracinghideTracingResponse),
      const DeepCollectionEquality().hash(tracingtracingSupported),
      const DeepCollectionEquality().hash(editorfontSize),
      const DeepCollectionEquality().hash(editorfontFamily),
      const DeepCollectionEquality().hash(requestcredentials),
      const DeepCollectionEquality().hash(_requestglobalHeaders),
      const DeepCollectionEquality().hash(schemapollingenable),
      const DeepCollectionEquality().hash(schemapollingendpointFilter),
      const DeepCollectionEquality().hash(schemapollinginterval));

  @JsonKey(ignore: true)
  @override
  _$$_ISettingsCopyWith<_$_ISettings> get copyWith =>
      __$$_ISettingsCopyWithImpl<_$_ISettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ISettingsToJson(this);
  }
}

abstract class _ISettings implements ISettings {
  const factory _ISettings(
      {@JsonKey(name: 'general.betaUpdates')
          required final bool generalbetaUpdates,
      @JsonKey(name: 'editor.cursorShape')
          required final String editorcursorShape,
      @JsonKey(name: 'editor.theme')
          required final String editortheme,
      @JsonKey(name: 'editor.reuseHeaders')
          required final bool editorreuseHeaders,
      @JsonKey(name: 'tracing.hideTracingResponse')
          required final bool tracinghideTracingResponse,
      @JsonKey(name: 'tracing.tracingSupported')
          required final bool tracingtracingSupported,
      @JsonKey(name: 'editor.fontSize')
          required final int editorfontSize,
      @JsonKey(name: 'editor.fontFamily')
          required final String editorfontFamily,
      @JsonKey(name: 'request.credentials')
          required final String requestcredentials,
      @JsonKey(name: 'request.globalHeaders')
          required final Map<String, Object?> requestglobalHeaders,
      @JsonKey(name: 'schema.polling.enable')
          required final bool schemapollingenable,
      @JsonKey(name: 'schema.polling.endpointFilter')
          required final String schemapollingendpointFilter,
      @JsonKey(name: 'schema.polling.interval')
          required final int schemapollinginterval}) = _$_ISettings;

  factory _ISettings.fromJson(Map<String, dynamic> json) =
      _$_ISettings.fromJson;

  @override
  @JsonKey(name: 'general.betaUpdates')
  bool get generalbetaUpdates => throw _privateConstructorUsedError;
  @override

  /// 'line' | 'block' | 'underline'
  @JsonKey(name: 'editor.cursorShape')
  String get editorcursorShape => throw _privateConstructorUsedError;
  @override

  /// 'dark' | 'light'
  @JsonKey(name: 'editor.theme')
  String get editortheme => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'editor.reuseHeaders')
  bool get editorreuseHeaders => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'tracing.hideTracingResponse')
  bool get tracinghideTracingResponse => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'tracing.tracingSupported')
  bool get tracingtracingSupported => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'editor.fontSize')
  int get editorfontSize => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'editor.fontFamily')
  String get editorfontFamily => throw _privateConstructorUsedError;
  @override

  /// 'omit' | 'include' | 'same-origin'
  @JsonKey(name: 'request.credentials')
  String get requestcredentials => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'request.globalHeaders')
  Map<String, Object?> get requestglobalHeaders =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'schema.polling.enable')
  bool get schemapollingenable => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'schema.polling.endpointFilter')
  String get schemapollingendpointFilter => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'schema.polling.interval')
  int get schemapollinginterval => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ISettingsCopyWith<_$_ISettings> get copyWith =>
      throw _privateConstructorUsedError;
}
