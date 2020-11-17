// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SupernodeDhxStateTearOff {
  const _$SupernodeDhxStateTearOff();

// ignore: unused_element
  _SupernodeDhxState call(
      {Wrap<double> balance = const Wrap.pending(),
      Wrap<double> lockedAmount = const Wrap.pending(),
      Wrap<double> totalRevenue = const Wrap.pending(),
      Wrap<double> lastMiningPower = const Wrap.pending(),
      Wrap<double> currentMiningPower = const Wrap.pending(),
      Wrap<List<StakeDHX>> stakes = const Wrap.pending()}) {
    return _SupernodeDhxState(
      balance: balance,
      lockedAmount: lockedAmount,
      totalRevenue: totalRevenue,
      lastMiningPower: lastMiningPower,
      currentMiningPower: currentMiningPower,
      stakes: stakes,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SupernodeDhxState = _$SupernodeDhxStateTearOff();

/// @nodoc
mixin _$SupernodeDhxState {
  Wrap<double> get balance;
  Wrap<double> get lockedAmount;
  Wrap<double> get totalRevenue;
  Wrap<double> get lastMiningPower;
  Wrap<double> get currentMiningPower;
  Wrap<List<StakeDHX>> get stakes;

  $SupernodeDhxStateCopyWith<SupernodeDhxState> get copyWith;
}

/// @nodoc
abstract class $SupernodeDhxStateCopyWith<$Res> {
  factory $SupernodeDhxStateCopyWith(
          SupernodeDhxState value, $Res Function(SupernodeDhxState) then) =
      _$SupernodeDhxStateCopyWithImpl<$Res>;
  $Res call(
      {Wrap<double> balance,
      Wrap<double> lockedAmount,
      Wrap<double> totalRevenue,
      Wrap<double> lastMiningPower,
      Wrap<double> currentMiningPower,
      Wrap<List<StakeDHX>> stakes});
}

/// @nodoc
class _$SupernodeDhxStateCopyWithImpl<$Res>
    implements $SupernodeDhxStateCopyWith<$Res> {
  _$SupernodeDhxStateCopyWithImpl(this._value, this._then);

  final SupernodeDhxState _value;
  // ignore: unused_field
  final $Res Function(SupernodeDhxState) _then;

  @override
  $Res call({
    Object balance = freezed,
    Object lockedAmount = freezed,
    Object totalRevenue = freezed,
    Object lastMiningPower = freezed,
    Object currentMiningPower = freezed,
    Object stakes = freezed,
  }) {
    return _then(_value.copyWith(
      balance: balance == freezed ? _value.balance : balance as Wrap<double>,
      lockedAmount: lockedAmount == freezed
          ? _value.lockedAmount
          : lockedAmount as Wrap<double>,
      totalRevenue: totalRevenue == freezed
          ? _value.totalRevenue
          : totalRevenue as Wrap<double>,
      lastMiningPower: lastMiningPower == freezed
          ? _value.lastMiningPower
          : lastMiningPower as Wrap<double>,
      currentMiningPower: currentMiningPower == freezed
          ? _value.currentMiningPower
          : currentMiningPower as Wrap<double>,
      stakes:
          stakes == freezed ? _value.stakes : stakes as Wrap<List<StakeDHX>>,
    ));
  }
}

/// @nodoc
abstract class _$SupernodeDhxStateCopyWith<$Res>
    implements $SupernodeDhxStateCopyWith<$Res> {
  factory _$SupernodeDhxStateCopyWith(
          _SupernodeDhxState value, $Res Function(_SupernodeDhxState) then) =
      __$SupernodeDhxStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Wrap<double> balance,
      Wrap<double> lockedAmount,
      Wrap<double> totalRevenue,
      Wrap<double> lastMiningPower,
      Wrap<double> currentMiningPower,
      Wrap<List<StakeDHX>> stakes});
}

/// @nodoc
class __$SupernodeDhxStateCopyWithImpl<$Res>
    extends _$SupernodeDhxStateCopyWithImpl<$Res>
    implements _$SupernodeDhxStateCopyWith<$Res> {
  __$SupernodeDhxStateCopyWithImpl(
      _SupernodeDhxState _value, $Res Function(_SupernodeDhxState) _then)
      : super(_value, (v) => _then(v as _SupernodeDhxState));

  @override
  _SupernodeDhxState get _value => super._value as _SupernodeDhxState;

  @override
  $Res call({
    Object balance = freezed,
    Object lockedAmount = freezed,
    Object totalRevenue = freezed,
    Object lastMiningPower = freezed,
    Object currentMiningPower = freezed,
    Object stakes = freezed,
  }) {
    return _then(_SupernodeDhxState(
      balance: balance == freezed ? _value.balance : balance as Wrap<double>,
      lockedAmount: lockedAmount == freezed
          ? _value.lockedAmount
          : lockedAmount as Wrap<double>,
      totalRevenue: totalRevenue == freezed
          ? _value.totalRevenue
          : totalRevenue as Wrap<double>,
      lastMiningPower: lastMiningPower == freezed
          ? _value.lastMiningPower
          : lastMiningPower as Wrap<double>,
      currentMiningPower: currentMiningPower == freezed
          ? _value.currentMiningPower
          : currentMiningPower as Wrap<double>,
      stakes:
          stakes == freezed ? _value.stakes : stakes as Wrap<List<StakeDHX>>,
    ));
  }
}

/// @nodoc
class _$_SupernodeDhxState
    with DiagnosticableTreeMixin
    implements _SupernodeDhxState {
  _$_SupernodeDhxState(
      {this.balance = const Wrap.pending(),
      this.lockedAmount = const Wrap.pending(),
      this.totalRevenue = const Wrap.pending(),
      this.lastMiningPower = const Wrap.pending(),
      this.currentMiningPower = const Wrap.pending(),
      this.stakes = const Wrap.pending()})
      : assert(balance != null),
        assert(lockedAmount != null),
        assert(totalRevenue != null),
        assert(lastMiningPower != null),
        assert(currentMiningPower != null),
        assert(stakes != null);

  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> balance;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> lockedAmount;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> totalRevenue;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> lastMiningPower;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> currentMiningPower;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<StakeDHX>> stakes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupernodeDhxState(balance: $balance, lockedAmount: $lockedAmount, totalRevenue: $totalRevenue, lastMiningPower: $lastMiningPower, currentMiningPower: $currentMiningPower, stakes: $stakes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupernodeDhxState'))
      ..add(DiagnosticsProperty('balance', balance))
      ..add(DiagnosticsProperty('lockedAmount', lockedAmount))
      ..add(DiagnosticsProperty('totalRevenue', totalRevenue))
      ..add(DiagnosticsProperty('lastMiningPower', lastMiningPower))
      ..add(DiagnosticsProperty('currentMiningPower', currentMiningPower))
      ..add(DiagnosticsProperty('stakes', stakes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SupernodeDhxState &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality()
                    .equals(other.balance, balance)) &&
            (identical(other.lockedAmount, lockedAmount) ||
                const DeepCollectionEquality()
                    .equals(other.lockedAmount, lockedAmount)) &&
            (identical(other.totalRevenue, totalRevenue) ||
                const DeepCollectionEquality()
                    .equals(other.totalRevenue, totalRevenue)) &&
            (identical(other.lastMiningPower, lastMiningPower) ||
                const DeepCollectionEquality()
                    .equals(other.lastMiningPower, lastMiningPower)) &&
            (identical(other.currentMiningPower, currentMiningPower) ||
                const DeepCollectionEquality()
                    .equals(other.currentMiningPower, currentMiningPower)) &&
            (identical(other.stakes, stakes) ||
                const DeepCollectionEquality().equals(other.stakes, stakes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(lockedAmount) ^
      const DeepCollectionEquality().hash(totalRevenue) ^
      const DeepCollectionEquality().hash(lastMiningPower) ^
      const DeepCollectionEquality().hash(currentMiningPower) ^
      const DeepCollectionEquality().hash(stakes);

  @override
  _$SupernodeDhxStateCopyWith<_SupernodeDhxState> get copyWith =>
      __$SupernodeDhxStateCopyWithImpl<_SupernodeDhxState>(this, _$identity);
}

abstract class _SupernodeDhxState implements SupernodeDhxState {
  factory _SupernodeDhxState(
      {Wrap<double> balance,
      Wrap<double> lockedAmount,
      Wrap<double> totalRevenue,
      Wrap<double> lastMiningPower,
      Wrap<double> currentMiningPower,
      Wrap<List<StakeDHX>> stakes}) = _$_SupernodeDhxState;

  @override
  Wrap<double> get balance;
  @override
  Wrap<double> get lockedAmount;
  @override
  Wrap<double> get totalRevenue;
  @override
  Wrap<double> get lastMiningPower;
  @override
  Wrap<double> get currentMiningPower;
  @override
  Wrap<List<StakeDHX>> get stakes;
  @override
  _$SupernodeDhxStateCopyWith<_SupernodeDhxState> get copyWith;
}