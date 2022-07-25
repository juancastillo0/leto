// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  /// TODO: ICustomTheme
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  Map<String, Object?>? get themeConfig => throw _privateConstructorUsedError;

  /// Theme config object for dark mode
  /// TODO: ICustomTheme
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
      _$SettingsStateCopyWithImpl<$Res>;
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
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  final SettingsState _value;
  // ignore: unused_field
  final $Res Function(SettingsState) _then;

  @override
  $Res call({
    Object? theme = freezed,
    Object? themedark = freezed,
    Object? language = freezed,
    Object? addQueryDepthLimit = freezed,
    Object? tabSize = freezed,
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
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      themedark: themedark == freezed
          ? _value.themedark
          : themedark // ignore: cast_nullable_to_non_nullable
              as String?,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      addQueryDepthLimit: addQueryDepthLimit == freezed
          ? _value.addQueryDepthLimit
          : addQueryDepthLimit // ignore: cast_nullable_to_non_nullable
              as int,
      tabSize: tabSize == freezed
          ? _value.tabSize
          : tabSize // ignore: cast_nullable_to_non_nullable
              as int,
      enableExperimental: enableExperimental == freezed
          ? _value.enableExperimental
          : enableExperimental // ignore: cast_nullable_to_non_nullable
              as bool?,
      themefontsize: themefontsize == freezed
          ? _value.themefontsize
          : themefontsize // ignore: cast_nullable_to_non_nullable
              as int?,
      themeeditorFontFamily: themeeditorFontFamily == freezed
          ? _value.themeeditorFontFamily
          : themeeditorFontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      themeeditorFontSize: themeeditorFontSize == freezed
          ? _value.themeeditorFontSize
          : themeeditorFontSize // ignore: cast_nullable_to_non_nullable
              as int?,
      disablePushNotification: disablePushNotification == freezed
          ? _value.disablePushNotification
          : disablePushNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      pluginlist: pluginlist == freezed
          ? _value.pluginlist
          : pluginlist // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requestwithCredentials: requestwithCredentials == freezed
          ? _value.requestwithCredentials
          : requestwithCredentials // ignore: cast_nullable_to_non_nullable
              as bool?,
      schemareloadOnStart: schemareloadOnStart == freezed
          ? _value.schemareloadOnStart
          : schemareloadOnStart // ignore: cast_nullable_to_non_nullable
              as bool?,
      alertdisableWarnings: alertdisableWarnings == freezed
          ? _value.alertdisableWarnings
          : alertdisableWarnings // ignore: cast_nullable_to_non_nullable
              as bool?,
      historyDepth: historyDepth == freezed
          ? _value.historyDepth
          : historyDepth // ignore: cast_nullable_to_non_nullable
              as int?,
      themeConfig: themeConfig == freezed
          ? _value.themeConfig
          : themeConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      themeConfigdark: themeConfigdark == freezed
          ? _value.themeConfigdark
          : themeConfigdark // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      responsehideExtensions: responsehideExtensions == freezed
          ? _value.responsehideExtensions
          : responsehideExtensions // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$SettingsState_CopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsState_CopyWith(
          _$SettingsState_ value, $Res Function(_$SettingsState_) then) =
      __$$SettingsState_CopyWithImpl<$Res>;
  @override
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
    extends _$SettingsStateCopyWithImpl<$Res>
    implements _$$SettingsState_CopyWith<$Res> {
  __$$SettingsState_CopyWithImpl(
      _$SettingsState_ _value, $Res Function(_$SettingsState_) _then)
      : super(_value, (v) => _then(v as _$SettingsState_));

  @override
  _$SettingsState_ get _value => super._value as _$SettingsState_;

  @override
  $Res call({
    Object? theme = freezed,
    Object? themedark = freezed,
    Object? language = freezed,
    Object? addQueryDepthLimit = freezed,
    Object? tabSize = freezed,
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
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      themedark: themedark == freezed
          ? _value.themedark
          : themedark // ignore: cast_nullable_to_non_nullable
              as String?,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      addQueryDepthLimit: addQueryDepthLimit == freezed
          ? _value.addQueryDepthLimit
          : addQueryDepthLimit // ignore: cast_nullable_to_non_nullable
              as int,
      tabSize: tabSize == freezed
          ? _value.tabSize
          : tabSize // ignore: cast_nullable_to_non_nullable
              as int,
      enableExperimental: enableExperimental == freezed
          ? _value.enableExperimental
          : enableExperimental // ignore: cast_nullable_to_non_nullable
              as bool?,
      themefontsize: themefontsize == freezed
          ? _value.themefontsize
          : themefontsize // ignore: cast_nullable_to_non_nullable
              as int?,
      themeeditorFontFamily: themeeditorFontFamily == freezed
          ? _value.themeeditorFontFamily
          : themeeditorFontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      themeeditorFontSize: themeeditorFontSize == freezed
          ? _value.themeeditorFontSize
          : themeeditorFontSize // ignore: cast_nullable_to_non_nullable
              as int?,
      disablePushNotification: disablePushNotification == freezed
          ? _value.disablePushNotification
          : disablePushNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      pluginlist: pluginlist == freezed
          ? _value._pluginlist
          : pluginlist // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      requestwithCredentials: requestwithCredentials == freezed
          ? _value.requestwithCredentials
          : requestwithCredentials // ignore: cast_nullable_to_non_nullable
              as bool?,
      schemareloadOnStart: schemareloadOnStart == freezed
          ? _value.schemareloadOnStart
          : schemareloadOnStart // ignore: cast_nullable_to_non_nullable
              as bool?,
      alertdisableWarnings: alertdisableWarnings == freezed
          ? _value.alertdisableWarnings
          : alertdisableWarnings // ignore: cast_nullable_to_non_nullable
              as bool?,
      historyDepth: historyDepth == freezed
          ? _value.historyDepth
          : historyDepth // ignore: cast_nullable_to_non_nullable
              as int?,
      themeConfig: themeConfig == freezed
          ? _value._themeConfig
          : themeConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      themeConfigdark: themeConfigdark == freezed
          ? _value._themeConfigdark
          : themeConfigdark // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      responsehideExtensions: responsehideExtensions == freezed
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
      @JsonKey(name: 'theme.dark')
          this.themedark,
      required this.language,
      required this.addQueryDepthLimit,
      required this.tabSize,
      this.enableExperimental,
      @JsonKey(name: 'theme.fontsize')
          this.themefontsize,
      @JsonKey(name: 'theme.editorFontFamily')
          this.themeeditorFontFamily,
      @JsonKey(name: 'theme.editorFontSize')
          this.themeeditorFontSize,
      this.disablePushNotification,
      @JsonKey(name: 'plugin.list')
          final List<String>? pluginlist,
      @JsonKey(name: 'request.withCredentials')
          this.requestwithCredentials,
      @JsonKey(name: 'schema.reloadOnStart')
          this.schemareloadOnStart,
      @JsonKey(name: 'alert.disableWarnings')
          this.alertdisableWarnings,
      this.historyDepth,
      final Map<String, Object?>? themeConfig,
      @JsonKey(name: 'themeConfig.dark')
          final Map<String, Object?>? themeConfigdark,
      @JsonKey(name: 'response.hideExtensions')
          this.responsehideExtensions})
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
  /// TODO: ICustomTheme
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  final Map<String, Object?>? _themeConfig;

  /// Theme config object
  /// TODO: ICustomTheme
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  @override
  Map<String, Object?>? get themeConfig {
    final value = _themeConfig;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Theme config object for dark mode
  /// TODO: ICustomTheme
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  final Map<String, Object?>? _themeConfigdark;

  /// Theme config object for dark mode
  /// TODO: ICustomTheme
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  @override
  @JsonKey(name: 'themeConfig.dark')
  Map<String, Object?>? get themeConfigdark {
    final value = _themeConfigdark;
    if (value == null) return null;
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
            const DeepCollectionEquality().equals(other.theme, theme) &&
            const DeepCollectionEquality().equals(other.themedark, themedark) &&
            const DeepCollectionEquality().equals(other.language, language) &&
            const DeepCollectionEquality()
                .equals(other.addQueryDepthLimit, addQueryDepthLimit) &&
            const DeepCollectionEquality().equals(other.tabSize, tabSize) &&
            const DeepCollectionEquality()
                .equals(other.enableExperimental, enableExperimental) &&
            const DeepCollectionEquality()
                .equals(other.themefontsize, themefontsize) &&
            const DeepCollectionEquality()
                .equals(other.themeeditorFontFamily, themeeditorFontFamily) &&
            const DeepCollectionEquality()
                .equals(other.themeeditorFontSize, themeeditorFontSize) &&
            const DeepCollectionEquality().equals(
                other.disablePushNotification, disablePushNotification) &&
            const DeepCollectionEquality()
                .equals(other._pluginlist, _pluginlist) &&
            const DeepCollectionEquality()
                .equals(other.requestwithCredentials, requestwithCredentials) &&
            const DeepCollectionEquality()
                .equals(other.schemareloadOnStart, schemareloadOnStart) &&
            const DeepCollectionEquality()
                .equals(other.alertdisableWarnings, alertdisableWarnings) &&
            const DeepCollectionEquality()
                .equals(other.historyDepth, historyDepth) &&
            const DeepCollectionEquality()
                .equals(other._themeConfig, _themeConfig) &&
            const DeepCollectionEquality()
                .equals(other._themeConfigdark, _themeConfigdark) &&
            const DeepCollectionEquality()
                .equals(other.responsehideExtensions, responsehideExtensions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(theme),
      const DeepCollectionEquality().hash(themedark),
      const DeepCollectionEquality().hash(language),
      const DeepCollectionEquality().hash(addQueryDepthLimit),
      const DeepCollectionEquality().hash(tabSize),
      const DeepCollectionEquality().hash(enableExperimental),
      const DeepCollectionEquality().hash(themefontsize),
      const DeepCollectionEquality().hash(themeeditorFontFamily),
      const DeepCollectionEquality().hash(themeeditorFontSize),
      const DeepCollectionEquality().hash(disablePushNotification),
      const DeepCollectionEquality().hash(_pluginlist),
      const DeepCollectionEquality().hash(requestwithCredentials),
      const DeepCollectionEquality().hash(schemareloadOnStart),
      const DeepCollectionEquality().hash(alertdisableWarnings),
      const DeepCollectionEquality().hash(historyDepth),
      const DeepCollectionEquality().hash(_themeConfig),
      const DeepCollectionEquality().hash(_themeConfigdark),
      const DeepCollectionEquality().hash(responsehideExtensions));

  @JsonKey(ignore: true)
  @override
  _$$SettingsState_CopyWith<_$SettingsState_> get copyWith =>
      __$$SettingsState_CopyWithImpl<_$SettingsState_>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsState_ToJson(this);
  }
}

abstract class SettingsState_ implements SettingsState {
  const factory SettingsState_(
      {required final String theme,
      @JsonKey(name: 'theme.dark')
          final String? themedark,
      required final String language,
      required final int addQueryDepthLimit,
      required final int tabSize,
      final bool? enableExperimental,
      @JsonKey(name: 'theme.fontsize')
          final int? themefontsize,
      @JsonKey(name: 'theme.editorFontFamily')
          final String? themeeditorFontFamily,
      @JsonKey(name: 'theme.editorFontSize')
          final int? themeeditorFontSize,
      final bool? disablePushNotification,
      @JsonKey(name: 'plugin.list')
          final List<String>? pluginlist,
      @JsonKey(name: 'request.withCredentials')
          final bool? requestwithCredentials,
      @JsonKey(name: 'schema.reloadOnStart')
          final bool? schemareloadOnStart,
      @JsonKey(name: 'alert.disableWarnings')
          final bool? alertdisableWarnings,
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
  String get theme => throw _privateConstructorUsedError;
  @override

  /// Theme for dark mode
  @JsonKey(name: 'theme.dark')
  String? get themedark => throw _privateConstructorUsedError;
  @override

  /// Set language
  String get language => throw _privateConstructorUsedError;
  @override

  /// 'Add query' functionality depth
  int get addQueryDepthLimit => throw _privateConstructorUsedError;
  @override

  /// Editor tab size
  int get tabSize => throw _privateConstructorUsedError;
  @override

  /// Enable experimental features.
  /// Note: Might be unstable
  bool? get enableExperimental => throw _privateConstructorUsedError;
  @override

  /// Base Font Size
  /// (Default - 24)
  @JsonKey(name: 'theme.fontsize')
  int? get themefontsize => throw _privateConstructorUsedError;
  @override

  /// Editor Font Family
  @JsonKey(name: 'theme.editorFontFamily')
  String? get themeeditorFontFamily => throw _privateConstructorUsedError;
  @override

  /// Editor Font Size
  @JsonKey(name: 'theme.editorFontSize')
  int? get themeeditorFontSize => throw _privateConstructorUsedError;
  @override

  /// Disable push notifications
  bool? get disablePushNotification => throw _privateConstructorUsedError;
  @override

  /// Enabled plugins
  @JsonKey(name: 'plugin.list')
  List<String>? get pluginlist => throw _privateConstructorUsedError;
  @override

  /// Send requests with credentials (cookies)
  @JsonKey(name: 'request.withCredentials')
  bool? get requestwithCredentials => throw _privateConstructorUsedError;
  @override

  /// Reload schema on app start
  @JsonKey(name: 'schema.reloadOnStart')
  bool? get schemareloadOnStart => throw _privateConstructorUsedError;
  @override

  /// Disable warning alerts
  @JsonKey(name: 'alert.disableWarnings')
  bool? get alertdisableWarnings => throw _privateConstructorUsedError;
  @override

  /// Number of items allowed in history pane
  int? get historyDepth => throw _privateConstructorUsedError;
  @override

  /// Theme config object
  /// TODO: ICustomTheme
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  Map<String, Object?>? get themeConfig => throw _privateConstructorUsedError;
  @override

  /// Theme config object for dark mode
  /// TODO: ICustomTheme
  /// https://github.com/altair-graphql/altair/blob/4bcf08ca63b7e2fdf447c4d40260fb91f698d83b/packages/altair-core/src/theme/theme.ts
  @JsonKey(name: 'themeConfig.dark')
  Map<String, Object?>? get themeConfigdark =>
      throw _privateConstructorUsedError;
  @override

  /// Hides extensions object
  @JsonKey(name: 'response.hideExtensions')
  bool? get responsehideExtensions => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$SettingsState_CopyWith<_$SettingsState_> get copyWith =>
      throw _privateConstructorUsedError;
}
