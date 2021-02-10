// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SettingsStateTearOff {
  const _$SettingsStateTearOff();

// ignore: unused_element
  _SettingsState call(
      {@nullable PackageInfo info,
      @nullable String version,
      @nullable String buildNumber,
      @nullable String mxVersion,
      @nullable String language,
      bool screenShot}) {
    return _SettingsState(
      info: info,
      version: version,
      buildNumber: buildNumber,
      mxVersion: mxVersion,
      language: language,
      screenShot: screenShot,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SettingsState = _$SettingsStateTearOff();

/// @nodoc
mixin _$SettingsState {
  @nullable
  PackageInfo get info;
  @nullable
  String get version;
  @nullable
  String get buildNumber;
  @nullable
  String get mxVersion;
  @nullable
  String get language;
  bool get screenShot;

  $SettingsStateCopyWith<SettingsState> get copyWith;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res>;
  $Res call(
      {@nullable PackageInfo info,
      @nullable String version,
      @nullable String buildNumber,
      @nullable String mxVersion,
      @nullable String language,
      bool screenShot});
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
    Object info = freezed,
    Object version = freezed,
    Object buildNumber = freezed,
    Object mxVersion = freezed,
    Object language = freezed,
    Object screenShot = freezed,
  }) {
    return _then(_value.copyWith(
      info: info == freezed ? _value.info : info as PackageInfo,
      version: version == freezed ? _value.version : version as String,
      buildNumber:
          buildNumber == freezed ? _value.buildNumber : buildNumber as String,
      mxVersion: mxVersion == freezed ? _value.mxVersion : mxVersion as String,
      language: language == freezed ? _value.language : language as String,
      screenShot:
          screenShot == freezed ? _value.screenShot : screenShot as bool,
    ));
  }
}

/// @nodoc
abstract class _$SettingsStateCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(
          _SettingsState value, $Res Function(_SettingsState) then) =
      __$SettingsStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable PackageInfo info,
      @nullable String version,
      @nullable String buildNumber,
      @nullable String mxVersion,
      @nullable String language,
      bool screenShot});
}

/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(
      _SettingsState _value, $Res Function(_SettingsState) _then)
      : super(_value, (v) => _then(v as _SettingsState));

  @override
  _SettingsState get _value => super._value as _SettingsState;

  @override
  $Res call({
    Object info = freezed,
    Object version = freezed,
    Object buildNumber = freezed,
    Object mxVersion = freezed,
    Object language = freezed,
    Object screenShot = freezed,
  }) {
    return _then(_SettingsState(
      info: info == freezed ? _value.info : info as PackageInfo,
      version: version == freezed ? _value.version : version as String,
      buildNumber:
          buildNumber == freezed ? _value.buildNumber : buildNumber as String,
      mxVersion: mxVersion == freezed ? _value.mxVersion : mxVersion as String,
      language: language == freezed ? _value.language : language as String,
      screenShot:
          screenShot == freezed ? _value.screenShot : screenShot as bool,
    ));
  }
}

/// @nodoc
class _$_SettingsState with DiagnosticableTreeMixin implements _SettingsState {
  _$_SettingsState(
      {@nullable this.info,
      @nullable this.version,
      @nullable this.buildNumber,
      @nullable this.mxVersion,
      @nullable this.language,
      this.screenShot});

  @override
  @nullable
  final PackageInfo info;
  @override
  @nullable
  final String version;
  @override
  @nullable
  final String buildNumber;
  @override
  @nullable
  final String mxVersion;
  @override
  @nullable
  final String language;
  @override
  final bool screenShot;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SettingsState(info: $info, version: $version, buildNumber: $buildNumber, mxVersion: $mxVersion, language: $language, screenShot: $screenShot)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SettingsState'))
      ..add(DiagnosticsProperty('info', info))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('buildNumber', buildNumber))
      ..add(DiagnosticsProperty('mxVersion', mxVersion))
      ..add(DiagnosticsProperty('language', language))
      ..add(DiagnosticsProperty('screenShot', screenShot));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SettingsState &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.buildNumber, buildNumber) ||
                const DeepCollectionEquality()
                    .equals(other.buildNumber, buildNumber)) &&
            (identical(other.mxVersion, mxVersion) ||
                const DeepCollectionEquality()
                    .equals(other.mxVersion, mxVersion)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.screenShot, screenShot) ||
                const DeepCollectionEquality()
                    .equals(other.screenShot, screenShot)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(info) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(buildNumber) ^
      const DeepCollectionEquality().hash(mxVersion) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(screenShot);

  @override
  _$SettingsStateCopyWith<_SettingsState> get copyWith =>
      __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);
}

abstract class _SettingsState implements SettingsState {
  factory _SettingsState(
      {@nullable PackageInfo info,
      @nullable String version,
      @nullable String buildNumber,
      @nullable String mxVersion,
      @nullable String language,
      bool screenShot}) = _$_SettingsState;

  @override
  @nullable
  PackageInfo get info;
  @override
  @nullable
  String get version;
  @override
  @nullable
  String get buildNumber;
  @override
  @nullable
  String get mxVersion;
  @override
  @nullable
  String get language;
  @override
  bool get screenShot;
  @override
  _$SettingsStateCopyWith<_SettingsState> get copyWith;
}
