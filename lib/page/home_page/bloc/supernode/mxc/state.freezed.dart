// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SupernodeMxcStateTearOff {
  const _$SupernodeMxcStateTearOff();

// ignore: unused_element
  _SupernodeMxcState call(
      {Wrap<List<StakeHistoryEntity>> stakes = const Wrap.pending(),
      Wrap<List<WithdrawHistoryEntity>> withdraws = const Wrap.pending(),
      Wrap<List<TopupEntity>> topups = const Wrap.pending()}) {
    return _SupernodeMxcState(
      stakes: stakes,
      withdraws: withdraws,
      topups: topups,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SupernodeMxcState = _$SupernodeMxcStateTearOff();

/// @nodoc
mixin _$SupernodeMxcState {
  Wrap<List<StakeHistoryEntity>> get stakes;
  Wrap<List<WithdrawHistoryEntity>> get withdraws;
  Wrap<List<TopupEntity>> get topups;

  @JsonKey(ignore: true)
  $SupernodeMxcStateCopyWith<SupernodeMxcState> get copyWith;
}

/// @nodoc
abstract class $SupernodeMxcStateCopyWith<$Res> {
  factory $SupernodeMxcStateCopyWith(
          SupernodeMxcState value, $Res Function(SupernodeMxcState) then) =
      _$SupernodeMxcStateCopyWithImpl<$Res>;
  $Res call(
      {Wrap<List<StakeHistoryEntity>> stakes,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups});
}

/// @nodoc
class _$SupernodeMxcStateCopyWithImpl<$Res>
    implements $SupernodeMxcStateCopyWith<$Res> {
  _$SupernodeMxcStateCopyWithImpl(this._value, this._then);

  final SupernodeMxcState _value;
  // ignore: unused_field
  final $Res Function(SupernodeMxcState) _then;

  @override
  $Res call({
    Object stakes = freezed,
    Object withdraws = freezed,
    Object topups = freezed,
  }) {
    return _then(_value.copyWith(
      stakes: stakes == freezed
          ? _value.stakes
          : stakes as Wrap<List<StakeHistoryEntity>>,
      withdraws: withdraws == freezed
          ? _value.withdraws
          : withdraws as Wrap<List<WithdrawHistoryEntity>>,
      topups:
          topups == freezed ? _value.topups : topups as Wrap<List<TopupEntity>>,
    ));
  }
}

/// @nodoc
abstract class _$SupernodeMxcStateCopyWith<$Res>
    implements $SupernodeMxcStateCopyWith<$Res> {
  factory _$SupernodeMxcStateCopyWith(
          _SupernodeMxcState value, $Res Function(_SupernodeMxcState) then) =
      __$SupernodeMxcStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Wrap<List<StakeHistoryEntity>> stakes,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups});
}

/// @nodoc
class __$SupernodeMxcStateCopyWithImpl<$Res>
    extends _$SupernodeMxcStateCopyWithImpl<$Res>
    implements _$SupernodeMxcStateCopyWith<$Res> {
  __$SupernodeMxcStateCopyWithImpl(
      _SupernodeMxcState _value, $Res Function(_SupernodeMxcState) _then)
      : super(_value, (v) => _then(v as _SupernodeMxcState));

  @override
  _SupernodeMxcState get _value => super._value as _SupernodeMxcState;

  @override
  $Res call({
    Object stakes = freezed,
    Object withdraws = freezed,
    Object topups = freezed,
  }) {
    return _then(_SupernodeMxcState(
      stakes: stakes == freezed
          ? _value.stakes
          : stakes as Wrap<List<StakeHistoryEntity>>,
      withdraws: withdraws == freezed
          ? _value.withdraws
          : withdraws as Wrap<List<WithdrawHistoryEntity>>,
      topups:
          topups == freezed ? _value.topups : topups as Wrap<List<TopupEntity>>,
    ));
  }
}

/// @nodoc
class _$_SupernodeMxcState implements _SupernodeMxcState {
  _$_SupernodeMxcState(
      {this.stakes = const Wrap.pending(),
      this.withdraws = const Wrap.pending(),
      this.topups = const Wrap.pending()})
      : assert(stakes != null),
        assert(withdraws != null),
        assert(topups != null);

  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<StakeHistoryEntity>> stakes;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<WithdrawHistoryEntity>> withdraws;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<TopupEntity>> topups;

  @override
  String toString() {
    return 'SupernodeMxcState(stakes: $stakes, withdraws: $withdraws, topups: $topups)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SupernodeMxcState &&
            (identical(other.stakes, stakes) ||
                const DeepCollectionEquality().equals(other.stakes, stakes)) &&
            (identical(other.withdraws, withdraws) ||
                const DeepCollectionEquality()
                    .equals(other.withdraws, withdraws)) &&
            (identical(other.topups, topups) ||
                const DeepCollectionEquality().equals(other.topups, topups)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(stakes) ^
      const DeepCollectionEquality().hash(withdraws) ^
      const DeepCollectionEquality().hash(topups);

  @JsonKey(ignore: true)
  @override
  _$SupernodeMxcStateCopyWith<_SupernodeMxcState> get copyWith =>
      __$SupernodeMxcStateCopyWithImpl<_SupernodeMxcState>(this, _$identity);
}

abstract class _SupernodeMxcState implements SupernodeMxcState {
  factory _SupernodeMxcState(
      {Wrap<List<StakeHistoryEntity>> stakes,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups}) = _$_SupernodeMxcState;

  @override
  Wrap<List<StakeHistoryEntity>> get stakes;
  @override
  Wrap<List<WithdrawHistoryEntity>> get withdraws;
  @override
  Wrap<List<TopupEntity>> get topups;
  @override
  @JsonKey(ignore: true)
  _$SupernodeMxcStateCopyWith<_SupernodeMxcState> get copyWith;
}
