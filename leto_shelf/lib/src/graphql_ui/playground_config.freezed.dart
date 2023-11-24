// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$ISettingsCopyWithImpl<$Res, ISettings>;
  @useResult
  $Res call(
      {@JsonKey(name: 'general.betaUpdates') bool generalbetaUpdates,
      @JsonKey(name: 'editor.cursorShape') String editorcursorShape,
      @JsonKey(name: 'editor.theme') String editortheme,
      @JsonKey(name: 'editor.reuseHeaders') bool editorreuseHeaders,
      @JsonKey(name: 'tracing.hideTracingResponse')
      bool tracinghideTracingResponse,
      @JsonKey(name: 'tracing.tracingSupported') bool tracingtracingSupported,
      @JsonKey(name: 'editor.fontSize') int editorfontSize,
      @JsonKey(name: 'editor.fontFamily') String editorfontFamily,
      @JsonKey(name: 'request.credentials') String requestcredentials,
      @JsonKey(name: 'request.globalHeaders')
      Map<String, Object?> requestglobalHeaders,
      @JsonKey(name: 'schema.polling.enable') bool schemapollingenable,
      @JsonKey(name: 'schema.polling.endpointFilter')
      String schemapollingendpointFilter,
      @JsonKey(name: 'schema.polling.interval') int schemapollinginterval});
}

/// @nodoc
class _$ISettingsCopyWithImpl<$Res, $Val extends ISettings>
    implements $ISettingsCopyWith<$Res> {
  _$ISettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generalbetaUpdates = null,
    Object? editorcursorShape = null,
    Object? editortheme = null,
    Object? editorreuseHeaders = null,
    Object? tracinghideTracingResponse = null,
    Object? tracingtracingSupported = null,
    Object? editorfontSize = null,
    Object? editorfontFamily = null,
    Object? requestcredentials = null,
    Object? requestglobalHeaders = null,
    Object? schemapollingenable = null,
    Object? schemapollingendpointFilter = null,
    Object? schemapollinginterval = null,
  }) {
    return _then(_value.copyWith(
      generalbetaUpdates: null == generalbetaUpdates
          ? _value.generalbetaUpdates
          : generalbetaUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      editorcursorShape: null == editorcursorShape
          ? _value.editorcursorShape
          : editorcursorShape // ignore: cast_nullable_to_non_nullable
              as String,
      editortheme: null == editortheme
          ? _value.editortheme
          : editortheme // ignore: cast_nullable_to_non_nullable
              as String,
      editorreuseHeaders: null == editorreuseHeaders
          ? _value.editorreuseHeaders
          : editorreuseHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      tracinghideTracingResponse: null == tracinghideTracingResponse
          ? _value.tracinghideTracingResponse
          : tracinghideTracingResponse // ignore: cast_nullable_to_non_nullable
              as bool,
      tracingtracingSupported: null == tracingtracingSupported
          ? _value.tracingtracingSupported
          : tracingtracingSupported // ignore: cast_nullable_to_non_nullable
              as bool,
      editorfontSize: null == editorfontSize
          ? _value.editorfontSize
          : editorfontSize // ignore: cast_nullable_to_non_nullable
              as int,
      editorfontFamily: null == editorfontFamily
          ? _value.editorfontFamily
          : editorfontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      requestcredentials: null == requestcredentials
          ? _value.requestcredentials
          : requestcredentials // ignore: cast_nullable_to_non_nullable
              as String,
      requestglobalHeaders: null == requestglobalHeaders
          ? _value.requestglobalHeaders
          : requestglobalHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
      schemapollingenable: null == schemapollingenable
          ? _value.schemapollingenable
          : schemapollingenable // ignore: cast_nullable_to_non_nullable
              as bool,
      schemapollingendpointFilter: null == schemapollingendpointFilter
          ? _value.schemapollingendpointFilter
          : schemapollingendpointFilter // ignore: cast_nullable_to_non_nullable
              as String,
      schemapollinginterval: null == schemapollinginterval
          ? _value.schemapollinginterval
          : schemapollinginterval // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ISettingsCopyWith<$Res> implements $ISettingsCopyWith<$Res> {
  factory _$$_ISettingsCopyWith(
          _$_ISettings value, $Res Function(_$_ISettings) then) =
      __$$_ISettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'general.betaUpdates') bool generalbetaUpdates,
      @JsonKey(name: 'editor.cursorShape') String editorcursorShape,
      @JsonKey(name: 'editor.theme') String editortheme,
      @JsonKey(name: 'editor.reuseHeaders') bool editorreuseHeaders,
      @JsonKey(name: 'tracing.hideTracingResponse')
      bool tracinghideTracingResponse,
      @JsonKey(name: 'tracing.tracingSupported') bool tracingtracingSupported,
      @JsonKey(name: 'editor.fontSize') int editorfontSize,
      @JsonKey(name: 'editor.fontFamily') String editorfontFamily,
      @JsonKey(name: 'request.credentials') String requestcredentials,
      @JsonKey(name: 'request.globalHeaders')
      Map<String, Object?> requestglobalHeaders,
      @JsonKey(name: 'schema.polling.enable') bool schemapollingenable,
      @JsonKey(name: 'schema.polling.endpointFilter')
      String schemapollingendpointFilter,
      @JsonKey(name: 'schema.polling.interval') int schemapollinginterval});
}

/// @nodoc
class __$$_ISettingsCopyWithImpl<$Res>
    extends _$ISettingsCopyWithImpl<$Res, _$_ISettings>
    implements _$$_ISettingsCopyWith<$Res> {
  __$$_ISettingsCopyWithImpl(
      _$_ISettings _value, $Res Function(_$_ISettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generalbetaUpdates = null,
    Object? editorcursorShape = null,
    Object? editortheme = null,
    Object? editorreuseHeaders = null,
    Object? tracinghideTracingResponse = null,
    Object? tracingtracingSupported = null,
    Object? editorfontSize = null,
    Object? editorfontFamily = null,
    Object? requestcredentials = null,
    Object? requestglobalHeaders = null,
    Object? schemapollingenable = null,
    Object? schemapollingendpointFilter = null,
    Object? schemapollinginterval = null,
  }) {
    return _then(_$_ISettings(
      generalbetaUpdates: null == generalbetaUpdates
          ? _value.generalbetaUpdates
          : generalbetaUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      editorcursorShape: null == editorcursorShape
          ? _value.editorcursorShape
          : editorcursorShape // ignore: cast_nullable_to_non_nullable
              as String,
      editortheme: null == editortheme
          ? _value.editortheme
          : editortheme // ignore: cast_nullable_to_non_nullable
              as String,
      editorreuseHeaders: null == editorreuseHeaders
          ? _value.editorreuseHeaders
          : editorreuseHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      tracinghideTracingResponse: null == tracinghideTracingResponse
          ? _value.tracinghideTracingResponse
          : tracinghideTracingResponse // ignore: cast_nullable_to_non_nullable
              as bool,
      tracingtracingSupported: null == tracingtracingSupported
          ? _value.tracingtracingSupported
          : tracingtracingSupported // ignore: cast_nullable_to_non_nullable
              as bool,
      editorfontSize: null == editorfontSize
          ? _value.editorfontSize
          : editorfontSize // ignore: cast_nullable_to_non_nullable
              as int,
      editorfontFamily: null == editorfontFamily
          ? _value.editorfontFamily
          : editorfontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      requestcredentials: null == requestcredentials
          ? _value.requestcredentials
          : requestcredentials // ignore: cast_nullable_to_non_nullable
              as String,
      requestglobalHeaders: null == requestglobalHeaders
          ? _value._requestglobalHeaders
          : requestglobalHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
      schemapollingenable: null == schemapollingenable
          ? _value.schemapollingenable
          : schemapollingenable // ignore: cast_nullable_to_non_nullable
              as bool,
      schemapollingendpointFilter: null == schemapollingendpointFilter
          ? _value.schemapollingendpointFilter
          : schemapollingendpointFilter // ignore: cast_nullable_to_non_nullable
              as String,
      schemapollinginterval: null == schemapollinginterval
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
      {@JsonKey(name: 'general.betaUpdates') required this.generalbetaUpdates,
      @JsonKey(name: 'editor.cursorShape') required this.editorcursorShape,
      @JsonKey(name: 'editor.theme') required this.editortheme,
      @JsonKey(name: 'editor.reuseHeaders') required this.editorreuseHeaders,
      @JsonKey(name: 'tracing.hideTracingResponse')
      required this.tracinghideTracingResponse,
      @JsonKey(name: 'tracing.tracingSupported')
      required this.tracingtracingSupported,
      @JsonKey(name: 'editor.fontSize') required this.editorfontSize,
      @JsonKey(name: 'editor.fontFamily') required this.editorfontFamily,
      @JsonKey(name: 'request.credentials') required this.requestcredentials,
      @JsonKey(name: 'request.globalHeaders')
      required final Map<String, Object?> requestglobalHeaders,
      @JsonKey(name: 'schema.polling.enable') required this.schemapollingenable,
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
    if (_requestglobalHeaders is EqualUnmodifiableMapView)
      return _requestglobalHeaders;
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
            (identical(other.generalbetaUpdates, generalbetaUpdates) ||
                other.generalbetaUpdates == generalbetaUpdates) &&
            (identical(other.editorcursorShape, editorcursorShape) ||
                other.editorcursorShape == editorcursorShape) &&
            (identical(other.editortheme, editortheme) ||
                other.editortheme == editortheme) &&
            (identical(other.editorreuseHeaders, editorreuseHeaders) ||
                other.editorreuseHeaders == editorreuseHeaders) &&
            (identical(other.tracinghideTracingResponse,
                    tracinghideTracingResponse) ||
                other.tracinghideTracingResponse ==
                    tracinghideTracingResponse) &&
            (identical(
                    other.tracingtracingSupported, tracingtracingSupported) ||
                other.tracingtracingSupported == tracingtracingSupported) &&
            (identical(other.editorfontSize, editorfontSize) ||
                other.editorfontSize == editorfontSize) &&
            (identical(other.editorfontFamily, editorfontFamily) ||
                other.editorfontFamily == editorfontFamily) &&
            (identical(other.requestcredentials, requestcredentials) ||
                other.requestcredentials == requestcredentials) &&
            const DeepCollectionEquality()
                .equals(other._requestglobalHeaders, _requestglobalHeaders) &&
            (identical(other.schemapollingenable, schemapollingenable) ||
                other.schemapollingenable == schemapollingenable) &&
            (identical(other.schemapollingendpointFilter,
                    schemapollingendpointFilter) ||
                other.schemapollingendpointFilter ==
                    schemapollingendpointFilter) &&
            (identical(other.schemapollinginterval, schemapollinginterval) ||
                other.schemapollinginterval == schemapollinginterval));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      generalbetaUpdates,
      editorcursorShape,
      editortheme,
      editorreuseHeaders,
      tracinghideTracingResponse,
      tracingtracingSupported,
      editorfontSize,
      editorfontFamily,
      requestcredentials,
      const DeepCollectionEquality().hash(_requestglobalHeaders),
      schemapollingenable,
      schemapollingendpointFilter,
      schemapollinginterval);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ISettingsCopyWith<_$_ISettings> get copyWith =>
      __$$_ISettingsCopyWithImpl<_$_ISettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ISettingsToJson(
      this,
    );
  }
}

abstract class _ISettings implements ISettings {
  const factory _ISettings(
      {@JsonKey(name: 'general.betaUpdates')
      required final bool generalbetaUpdates,
      @JsonKey(name: 'editor.cursorShape')
      required final String editorcursorShape,
      @JsonKey(name: 'editor.theme') required final String editortheme,
      @JsonKey(name: 'editor.reuseHeaders')
      required final bool editorreuseHeaders,
      @JsonKey(name: 'tracing.hideTracingResponse')
      required final bool tracinghideTracingResponse,
      @JsonKey(name: 'tracing.tracingSupported')
      required final bool tracingtracingSupported,
      @JsonKey(name: 'editor.fontSize') required final int editorfontSize,
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
  bool get generalbetaUpdates;
  @override

  /// 'line' | 'block' | 'underline'
  @JsonKey(name: 'editor.cursorShape')
  String get editorcursorShape;
  @override

  /// 'dark' | 'light'
  @JsonKey(name: 'editor.theme')
  String get editortheme;
  @override
  @JsonKey(name: 'editor.reuseHeaders')
  bool get editorreuseHeaders;
  @override
  @JsonKey(name: 'tracing.hideTracingResponse')
  bool get tracinghideTracingResponse;
  @override
  @JsonKey(name: 'tracing.tracingSupported')
  bool get tracingtracingSupported;
  @override
  @JsonKey(name: 'editor.fontSize')
  int get editorfontSize;
  @override
  @JsonKey(name: 'editor.fontFamily')
  String get editorfontFamily;
  @override

  /// 'omit' | 'include' | 'same-origin'
  @JsonKey(name: 'request.credentials')
  String get requestcredentials;
  @override
  @JsonKey(name: 'request.globalHeaders')
  Map<String, Object?> get requestglobalHeaders;
  @override
  @JsonKey(name: 'schema.polling.enable')
  bool get schemapollingenable;
  @override
  @JsonKey(name: 'schema.polling.endpointFilter')
  String get schemapollingendpointFilter;
  @override
  @JsonKey(name: 'schema.polling.interval')
  int get schemapollinginterval;
  @override
  @JsonKey(ignore: true)
  _$$_ISettingsCopyWith<_$_ISettings> get copyWith =>
      throw _privateConstructorUsedError;
}
