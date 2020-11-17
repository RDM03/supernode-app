// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$HomeStateTearOff {
  const _$HomeStateTearOff();

// ignore: unused_element
  _HomeState call({@required int tabIndex, PageRoute<dynamic> routeTo}) {
    return _HomeState(
      tabIndex: tabIndex,
      routeTo: routeTo,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HomeState = _$HomeStateTearOff();

/// @nodoc
mixin _$HomeState {
  int get tabIndex;
  PageRoute<dynamic> get routeTo;

  $HomeStateCopyWith<HomeState> get copyWith;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res>;
  $Res call({int tabIndex, PageRoute<dynamic> routeTo});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  final HomeState _value;
  // ignore: unused_field
  final $Res Function(HomeState) _then;

  @override
  $Res call({
    Object tabIndex = freezed,
    Object routeTo = freezed,
  }) {
    return _then(_value.copyWith(
      tabIndex: tabIndex == freezed ? _value.tabIndex : tabIndex as int,
      routeTo:
          routeTo == freezed ? _value.routeTo : routeTo as PageRoute<dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(
          _HomeState value, $Res Function(_HomeState) then) =
      __$HomeStateCopyWithImpl<$Res>;
  @override
  $Res call({int tabIndex, PageRoute<dynamic> routeTo});
}

/// @nodoc
class __$HomeStateCopyWithImpl<$Res> extends _$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(_HomeState _value, $Res Function(_HomeState) _then)
      : super(_value, (v) => _then(v as _HomeState));

  @override
  _HomeState get _value => super._value as _HomeState;

  @override
  $Res call({
    Object tabIndex = freezed,
    Object routeTo = freezed,
  }) {
    return _then(_HomeState(
      tabIndex: tabIndex == freezed ? _value.tabIndex : tabIndex as int,
      routeTo:
          routeTo == freezed ? _value.routeTo : routeTo as PageRoute<dynamic>,
    ));
  }
}

/// @nodoc
class _$_HomeState with DiagnosticableTreeMixin implements _HomeState {
  _$_HomeState({@required this.tabIndex, this.routeTo})
      : assert(tabIndex != null);

  @override
  final int tabIndex;
  @override
  final PageRoute<dynamic> routeTo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState(tabIndex: $tabIndex, routeTo: $routeTo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomeState'))
      ..add(DiagnosticsProperty('tabIndex', tabIndex))
      ..add(DiagnosticsProperty('routeTo', routeTo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HomeState &&
            (identical(other.tabIndex, tabIndex) ||
                const DeepCollectionEquality()
                    .equals(other.tabIndex, tabIndex)) &&
            (identical(other.routeTo, routeTo) ||
                const DeepCollectionEquality().equals(other.routeTo, routeTo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tabIndex) ^
      const DeepCollectionEquality().hash(routeTo);

  @override
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState({@required int tabIndex, PageRoute<dynamic> routeTo}) =
      _$_HomeState;

  @override
  int get tabIndex;
  @override
  PageRoute<dynamic> get routeTo;
  @override
  _$HomeStateCopyWith<_HomeState> get copyWith;
}