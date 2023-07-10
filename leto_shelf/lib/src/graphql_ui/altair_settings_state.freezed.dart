// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'altair_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) {
  return SettingsState_.fromJson(json);
}

/// @nodoc
mixin _$SettingsState {
  /// Theme
  String get theme => throw _privateConstructorUsedError;

  /// Theme for dark mode
  @JsonKey(name: 'theme.dark')
  String? get themedark => throw _privateConstructorUsedError;

  /// Set language
  String get language => throw _privateConstructorUsedError;

  /// 'Add query' functionality depth
  int get addQueryDepthLimit => throw _privateConstructorUsedError;

  /// Editor tab size
  int get tabSize => throw _privateConstructorUsedError;

  /// Enable experimental features.
  /// Note: Might be unstable
  bool? get enableExperimental => throw _privateConstructorUsedError;

  /// Base Font Size
  /// (Default - 24)
  @JsonKey(name: 'theme.fontsize')
  int? get themefontsize => throw _privateConstructorUsedError;

  /// Editor Font Family
  @JsonKey(name: 'theme.editorFontFamily')
  String? get themeeditorFontFamily => throw _privateConstructorUsedError;

  /// Editor Font Size
  @JsonKey(name: 'theme.editorFontSize')
  int? get themeeditorFontSize => throw _privateConstructorUsedError;

  /// Disable push notifications
  bool? get disablePushNotification => throw _privateConstructorUsedError;

  /// Enabled plugins
  @JsonKey(name: 'plugin.list')
  List<String>? get pluginlist => throw _privateConstructorUsedError;

  /// Send requests with credentials (cookies)
  @JsonKey(name: 'request.withCredentials')
  bool? get requestwithCredentials => throw _privateConstructorUsedError;

  /// Reload schema on app start
  @JsonKey(name: 'schema.reloadOnStart')
  bool? get schemareloadOnStart => throw _privateConstructorUsedError;

  /// Disable warning alerts
  @JsonKey(name: 'alert.disableWarnings')
  bool? get alertdisableWarnings => throw _privateConstructorUsedError;

  /// Number of items allowed in history pane
  int? get historyDepth => throw _privateConstructorUsedError;

  /// Theme config object
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  Map<String, Object?>? get themeConfig => throw _privateConstructorUsedError;

  /// Theme config object for dark mode
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  @JsonKey(name: 'themeConfig.dark')
  Map<String, Object?>? get themeConfigdark =>
      throw _privateConstructorUsedError;

  /// Hides extensions object
  @JsonKey(name: 'response.hideExtensions')
  bool? get responsehideExtensions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call(
      {String theme,
      @JsonKey(name: 'theme.dark') String? themedark,
      String language,
      int addQueryDepthLimit,
      int tabSize,
      bool? enableExperimental,
      @JsonKey(name: 'theme.fontsize') int? themefontsize,
      @JsonKey(name: 'theme.editorFontFamily') String? themeeditorFontFamily,
      @JsonKey(name: 'theme.editorFontSize') int? themeeditorFontSize,
      bool? disablePushNotification,
      @JsonKey(name: 'plugin.list') List<String>? pluginlist,
      @JsonKey(name: 'request.withCredentials') bool? requestwithCredentials,
      @JsonKey(name: 'schema.reloadOnStart') bool? schemareloadOnStart,
      @JsonKey(name: 'alert.disableWarnings') bool? alertdisableWarnings,
      int? historyDepth,
      Map<String, Object?>? themeConfig,
      @JsonKey(name: 'themeConfig.dark') Map<String, Object?>? themeConfigdark,
      @JsonKey(name: 'response.hideExtensions') bool? responsehideExtensions});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? themedark = freezed,
    Object? language = null,
    Object? addQueryDepthLimit = null,
    Object? tabSize = null,
    Object? enableExperimental = freezed,
    Object? themefontsize = freezed,
    Object? themeeditorFontFamily = freezed,
    Object? themeeditorFontSize = freezed,
    Object? disablePushNotification = freezed,
    Object? pluginlist = freezed,
    Object? requestwithCredentials = freezed,
    Object? schemareloadOnStart = freezed,
    Object? alertdisableWarnings = freezed,
    Object? historyDepth = freezed,
    Object? themeConfig = freezed,
    Object? themeConfigdark = freezed,
    Object? responsehideExtensions = freezed,
  }) {
    return _then(_value.copyWith(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      themedark: freezed == themedark
          ? _value.themedark
          : themedark // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      addQueryDepthLimit: null == addQueryDepthLimit
          ? _value.addQueryDepthLimit
          : addQueryDepthLimit // ignore: cast_nullable_to_non_nullable
              as int,
      tabSize: null == tabSize
          ? _value.tabSize
          : tabSize // ignore: cast_nullable_to_non_nullable
              as int,
      enableExperimental: freezed == enableExperimental
          ? _value.enableExperimental
          : enableExperimental // ignore: cast_nullable_to_non_nullable
              as bool?,
      themefontsize: freezed == themefontsize
          ? _value.themefontsize
          : themefontsize // ignore: cast_nullable_to_non_nullable
              as int?,
      themeeditorFontFamily: freezed == themeeditorFontFamily
          ? _value.themeeditorFontFamily
          : themeeditorFontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      themeeditorFontSize: freezed == themeeditorFontSize
          ? _value.themeeditorFontSize
          : themeeditorFontSize // ignore: cast_nullable_to_non_nullable
              as int?,
      disablePushNotification: freezed == disablePushNotification
          ? _value.disablePushNotification
          : disablePushNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      pluginlist: freezed == pluginlist
          ? _value.pluginlist
          : pluginlist // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requestwithCredentials: freezed == requestwithCredentials
          ? _value.requestwithCredentials
          : requestwithCredentials // ignore: cast_nullable_to_non_nullable
              as bool?,
      schemareloadOnStart: freezed == schemareloadOnStart
          ? _value.schemareloadOnStart
          : schemareloadOnStart // ignore: cast_nullable_to_non_nullable
              as bool?,
      alertdisableWarnings: freezed == alertdisableWarnings
          ? _value.alertdisableWarnings
          : alertdisableWarnings // ignore: cast_nullable_to_non_nullable
              as bool?,
      historyDepth: freezed == historyDepth
          ? _value.historyDepth
          : historyDepth // ignore: cast_nullable_to_non_nullable
              as int?,
      themeConfig: freezed == themeConfig
          ? _value.themeConfig
          : themeConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      themeConfigdark: freezed == themeConfigdark
          ? _value.themeConfigdark
          : themeConfigdark // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      responsehideExtensions: freezed == responsehideExtensions
          ? _value.responsehideExtensions
          : responsehideExtensions // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsState_CopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsState_CopyWith(
          _$SettingsState_ value, $Res Function(_$SettingsState_) then) =
      __$$SettingsState_CopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String theme,
      @JsonKey(name: 'theme.dark') String? themedark,
      String language,
      int addQueryDepthLimit,
      int tabSize,
      bool? enableExperimental,
      @JsonKey(name: 'theme.fontsize') int? themefontsize,
      @JsonKey(name: 'theme.editorFontFamily') String? themeeditorFontFamily,
      @JsonKey(name: 'theme.editorFontSize') int? themeeditorFontSize,
      bool? disablePushNotification,
      @JsonKey(name: 'plugin.list') List<String>? pluginlist,
      @JsonKey(name: 'request.withCredentials') bool? requestwithCredentials,
      @JsonKey(name: 'schema.reloadOnStart') bool? schemareloadOnStart,
      @JsonKey(name: 'alert.disableWarnings') bool? alertdisableWarnings,
      int? historyDepth,
      Map<String, Object?>? themeConfig,
      @JsonKey(name: 'themeConfig.dark') Map<String, Object?>? themeConfigdark,
      @JsonKey(name: 'response.hideExtensions') bool? responsehideExtensions});
}

/// @nodoc
class __$$SettingsState_CopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsState_>
    implements _$$SettingsState_CopyWith<$Res> {
  __$$SettingsState_CopyWithImpl(
      _$SettingsState_ _value, $Res Function(_$SettingsState_) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? themedark = freezed,
    Object? language = null,
    Object? addQueryDepthLimit = null,
    Object? tabSize = null,
    Object? enableExperimental = freezed,
    Object? themefontsize = freezed,
    Object? themeeditorFontFamily = freezed,
    Object? themeeditorFontSize = freezed,
    Object? disablePushNotification = freezed,
    Object? pluginlist = freezed,
    Object? requestwithCredentials = freezed,
    Object? schemareloadOnStart = freezed,
    Object? alertdisableWarnings = freezed,
    Object? historyDepth = freezed,
    Object? themeConfig = freezed,
    Object? themeConfigdark = freezed,
    Object? responsehideExtensions = freezed,
  }) {
    return _then(_$SettingsState_(
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      themedark: freezed == themedark
          ? _value.themedark
          : themedark // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      addQueryDepthLimit: null == addQueryDepthLimit
          ? _value.addQueryDepthLimit
          : addQueryDepthLimit // ignore: cast_nullable_to_non_nullable
              as int,
      tabSize: null == tabSize
          ? _value.tabSize
          : tabSize // ignore: cast_nullable_to_non_nullable
              as int,
      enableExperimental: freezed == enableExperimental
          ? _value.enableExperimental
          : enableExperimental // ignore: cast_nullable_to_non_nullable
              as bool?,
      themefontsize: freezed == themefontsize
          ? _value.themefontsize
          : themefontsize // ignore: cast_nullable_to_non_nullable
              as int?,
      themeeditorFontFamily: freezed == themeeditorFontFamily
          ? _value.themeeditorFontFamily
          : themeeditorFontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      themeeditorFontSize: freezed == themeeditorFontSize
          ? _value.themeeditorFontSize
          : themeeditorFontSize // ignore: cast_nullable_to_non_nullable
              as int?,
      disablePushNotification: freezed == disablePushNotification
          ? _value.disablePushNotification
          : disablePushNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      pluginlist: freezed == pluginlist
          ? _value._pluginlist
          : pluginlist // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requestwithCredentials: freezed == requestwithCredentials
          ? _value.requestwithCredentials
          : requestwithCredentials // ignore: cast_nullable_to_non_nullable
              as bool?,
      schemareloadOnStart: freezed == schemareloadOnStart
          ? _value.schemareloadOnStart
          : schemareloadOnStart // ignore: cast_nullable_to_non_nullable
              as bool?,
      alertdisableWarnings: freezed == alertdisableWarnings
          ? _value.alertdisableWarnings
          : alertdisableWarnings // ignore: cast_nullable_to_non_nullable
              as bool?,
      historyDepth: freezed == historyDepth
          ? _value.historyDepth
          : historyDepth // ignore: cast_nullable_to_non_nullable
              as int?,
      themeConfig: freezed == themeConfig
          ? _value._themeConfig
          : themeConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      themeConfigdark: freezed == themeConfigdark
          ? _value._themeConfigdark
          : themeConfigdark // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      responsehideExtensions: freezed == responsehideExtensions
          ? _value.responsehideExtensions
          : responsehideExtensions // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$SettingsState_ implements SettingsState_ {
  const _$SettingsState_(
      {required this.theme,
      @JsonKey(name: 'theme.dark') this.themedark,
      required this.language,
      required this.addQueryDepthLimit,
      required this.tabSize,
      this.enableExperimental,
      @JsonKey(name: 'theme.fontsize') this.themefontsize,
      @JsonKey(name: 'theme.editorFontFamily') this.themeeditorFontFamily,
      @JsonKey(name: 'theme.editorFontSize') this.themeeditorFontSize,
      this.disablePushNotification,
      @JsonKey(name: 'plugin.list') final List<String>? pluginlist,
      @JsonKey(name: 'request.withCredentials') this.requestwithCredentials,
      @JsonKey(name: 'schema.reloadOnStart') this.schemareloadOnStart,
      @JsonKey(name: 'alert.disableWarnings') this.alertdisableWarnings,
      this.historyDepth,
      final Map<String, Object?>? themeConfig,
      @JsonKey(name: 'themeConfig.dark')
      final Map<String, Object?>? themeConfigdark,
      @JsonKey(name: 'response.hideExtensions') this.responsehideExtensions})
      : _pluginlist = pluginlist,
        _themeConfig = themeConfig,
        _themeConfigdark = themeConfigdark;

  factory _$SettingsState_.fromJson(Map<String, dynamic> json) =>
      _$$SettingsState_FromJson(json);

  /// Theme
  @override
  final String theme;

  /// Theme for dark mode
  @override
  @JsonKey(name: 'theme.dark')
  final String? themedark;

  /// Set language
  @override
  final String language;

  /// 'Add query' functionality depth
  @override
  final int addQueryDepthLimit;

  /// Editor tab size
  @override
  final int tabSize;

  /// Enable experimental features.
  /// Note: Might be unstable
  @override
  final bool? enableExperimental;

  /// Base Font Size
  /// (Default - 24)
  @override
  @JsonKey(name: 'theme.fontsize')
  final int? themefontsize;

  /// Editor Font Family
  @override
  @JsonKey(name: 'theme.editorFontFamily')
  final String? themeeditorFontFamily;

  /// Editor Font Size
  @override
  @JsonKey(name: 'theme.editorFontSize')
  final int? themeeditorFontSize;

  /// Disable push notifications
  @override
  final bool? disablePushNotification;

  /// Enabled plugins
  final List<String>? _pluginlist;

  /// Enabled plugins
  @override
  @JsonKey(name: 'plugin.list')
  List<String>? get pluginlist {
    final value = _pluginlist;
    if (value == null) return null;
    if (_pluginlist is EqualUnmodifiableListView) return _pluginlist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Send requests with credentials (cookies)
  @override
  @JsonKey(name: 'request.withCredentials')
  final bool? requestwithCredentials;

  /// Reload schema on app start
  @override
  @JsonKey(name: 'schema.reloadOnStart')
  final bool? schemareloadOnStart;

  /// Disable warning alerts
  @override
  @JsonKey(name: 'alert.disableWarnings')
  final bool? alertdisableWarnings;

  /// Number of items allowed in history pane
  @override
  final int? historyDepth;

  /// Theme config object
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  final Map<String, Object?>? _themeConfig;

  /// Theme config object
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  @override
  Map<String, Object?>? get themeConfig {
    final value = _themeConfig;
    if (value == null) return null;
    if (_themeConfig is EqualUnmodifiableMapView) return _themeConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Theme config object for dark mode
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  final Map<String, Object?>? _themeConfigdark;

  /// Theme config object for dark mode
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  @override
  @JsonKey(name: 'themeConfig.dark')
  Map<String, Object?>? get themeConfigdark {
    final value = _themeConfigdark;
    if (value == null) return null;
    if (_themeConfigdark is EqualUnmodifiableMapView) return _themeConfigdark;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Hides extensions object
  @override
  @JsonKey(name: 'response.hideExtensions')
  final bool? responsehideExtensions;

  @override
  String toString() {
    return 'SettingsState(theme: $theme, themedark: $themedark, language: $language, addQueryDepthLimit: $addQueryDepthLimit, tabSize: $tabSize, enableExperimental: $enableExperimental, themefontsize: $themefontsize, themeeditorFontFamily: $themeeditorFontFamily, themeeditorFontSize: $themeeditorFontSize, disablePushNotification: $disablePushNotification, pluginlist: $pluginlist, requestwithCredentials: $requestwithCredentials, schemareloadOnStart: $schemareloadOnStart, alertdisableWarnings: $alertdisableWarnings, historyDepth: $historyDepth, themeConfig: $themeConfig, themeConfigdark: $themeConfigdark, responsehideExtensions: $responsehideExtensions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsState_ &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.themedark, themedark) ||
                other.themedark == themedark) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.addQueryDepthLimit, addQueryDepthLimit) ||
                other.addQueryDepthLimit == addQueryDepthLimit) &&
            (identical(other.tabSize, tabSize) || other.tabSize == tabSize) &&
            (identical(other.enableExperimental, enableExperimental) ||
                other.enableExperimental == enableExperimental) &&
            (identical(other.themefontsize, themefontsize) ||
                other.themefontsize == themefontsize) &&
            (identical(other.themeeditorFontFamily, themeeditorFontFamily) ||
                other.themeeditorFontFamily == themeeditorFontFamily) &&
            (identical(other.themeeditorFontSize, themeeditorFontSize) ||
                other.themeeditorFontSize == themeeditorFontSize) &&
            (identical(
                    other.disablePushNotification, disablePushNotification) ||
                other.disablePushNotification == disablePushNotification) &&
            const DeepCollectionEquality()
                .equals(other._pluginlist, _pluginlist) &&
            (identical(other.requestwithCredentials, requestwithCredentials) ||
                other.requestwithCredentials == requestwithCredentials) &&
            (identical(other.schemareloadOnStart, schemareloadOnStart) ||
                other.schemareloadOnStart == schemareloadOnStart) &&
            (identical(other.alertdisableWarnings, alertdisableWarnings) ||
                other.alertdisableWarnings == alertdisableWarnings) &&
            (identical(other.historyDepth, historyDepth) ||
                other.historyDepth == historyDepth) &&
            const DeepCollectionEquality()
                .equals(other._themeConfig, _themeConfig) &&
            const DeepCollectionEquality()
                .equals(other._themeConfigdark, _themeConfigdark) &&
            (identical(other.responsehideExtensions, responsehideExtensions) ||
                other.responsehideExtensions == responsehideExtensions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      theme,
      themedark,
      language,
      addQueryDepthLimit,
      tabSize,
      enableExperimental,
      themefontsize,
      themeeditorFontFamily,
      themeeditorFontSize,
      disablePushNotification,
      const DeepCollectionEquality().hash(_pluginlist),
      requestwithCredentials,
      schemareloadOnStart,
      alertdisableWarnings,
      historyDepth,
      const DeepCollectionEquality().hash(_themeConfig),
      const DeepCollectionEquality().hash(_themeConfigdark),
      responsehideExtensions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsState_CopyWith<_$SettingsState_> get copyWith =>
      __$$SettingsState_CopyWithImpl<_$SettingsState_>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsState_ToJson(
      this,
    );
  }
}

abstract class SettingsState_ implements SettingsState {
  const factory SettingsState_(
      {required final String theme,
      @JsonKey(name: 'theme.dark') final String? themedark,
      required final String language,
      required final int addQueryDepthLimit,
      required final int tabSize,
      final bool? enableExperimental,
      @JsonKey(name: 'theme.fontsize') final int? themefontsize,
      @JsonKey(name: 'theme.editorFontFamily')
      final String? themeeditorFontFamily,
      @JsonKey(name: 'theme.editorFontSize') final int? themeeditorFontSize,
      final bool? disablePushNotification,
      @JsonKey(name: 'plugin.list') final List<String>? pluginlist,
      @JsonKey(name: 'request.withCredentials')
      final bool? requestwithCredentials,
      @JsonKey(name: 'schema.reloadOnStart') final bool? schemareloadOnStart,
      @JsonKey(name: 'alert.disableWarnings') final bool? alertdisableWarnings,
      final int? historyDepth,
      final Map<String, Object?>? themeConfig,
      @JsonKey(name: 'themeConfig.dark')
      final Map<String, Object?>? themeConfigdark,
      @JsonKey(name: 'response.hideExtensions')
      final bool? responsehideExtensions}) = _$SettingsState_;

  factory SettingsState_.fromJson(Map<String, dynamic> json) =
      _$SettingsState_.fromJson;

  @override

  /// Theme
  String get theme;
  @override

  /// Theme for dark mode
  @JsonKey(name: 'theme.dark')
  String? get themedark;
  @override

  /// Set language
  String get language;
  @override

  /// 'Add query' functionality depth
  int get addQueryDepthLimit;
  @override

  /// Editor tab size
  int get tabSize;
  @override

  /// Enable experimental features.
  /// Note: Might be unstable
  bool? get enableExperimental;
  @override

  /// Base Font Size
  /// (Default - 24)
  @JsonKey(name: 'theme.fontsize')
  int? get themefontsize;
  @override

  /// Editor Font Family
  @JsonKey(name: 'theme.editorFontFamily')
  String? get themeeditorFontFamily;
  @override

  /// Editor Font Size
  @JsonKey(name: 'theme.editorFontSize')
  int? get themeeditorFontSize;
  @override

  /// Disable push notifications
  bool? get disablePushNotification;
  @override

  /// Enabled plugins
  @JsonKey(name: 'plugin.list')
  List<String>? get pluginlist;
  @override

  /// Send requests with credentials (cookies)
  @JsonKey(name: 'request.withCredentials')
  bool? get requestwithCredentials;
  @override

  /// Reload schema on app start
  @JsonKey(name: 'schema.reloadOnStart')
  bool? get schemareloadOnStart;
  @override

  /// Disable warning alerts
  @JsonKey(name: 'alert.disableWarnings')
  bool? get alertdisableWarnings;
  @override

  /// Number of items allowed in history pane
  int? get historyDepth;
  @override

  /// Theme config object
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  Map<String, Object?>? get themeConfig;
  @override

  /// Theme config object for dark mode
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  @JsonKey(name: 'themeConfig.dark')
  Map<String, Object?>? get themeConfigdark;
  @override

  /// Hides extensions object
  @JsonKey(name: 'response.hideExtensions')
  bool? get responsehideExtensions;
  @override
  @JsonKey(ignore: true)
  _$$SettingsState_CopyWith<_$SettingsState_> get copyWith =>
      throw _privateConstructorUsedError;
}
