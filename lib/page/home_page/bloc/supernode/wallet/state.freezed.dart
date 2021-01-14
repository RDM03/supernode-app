// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$WalletStateTearOff {
  const _$WalletStateTearOff();

// ignore: unused_element
  _WalletState call(
      {bool expanded = false,
      @nullable WalletToken selectedToken,
      List<WalletToken> displayTokens = const [WalletToken.mxc],
      Wrap<List<StakeHistoryEntity>> stakes = const Wrap.pending(),
      Wrap<List<WithdrawHistoryEntity>> withdraws = const Wrap.pending(),
      Wrap<List<TopupEntity>> topups = const Wrap.pending()}) {
    return _WalletState(
      expanded: expanded,
      selectedToken: selectedToken,
      displayTokens: displayTokens,
      stakes: stakes,
      withdraws: withdraws,
      topups: topups,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $WalletState = _$WalletStateTearOff();

/// @nodoc
mixin _$WalletState {
  bool get expanded;
  @nullable
  WalletToken get selectedToken;
  List<WalletToken> get displayTokens;
  Wrap<List<StakeHistoryEntity>> get stakes;
  Wrap<List<WithdrawHistoryEntity>> get withdraws;
  Wrap<List<TopupEntity>> get topups;

  $WalletStateCopyWith<WalletState> get copyWith;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
          WalletState value, $Res Function(WalletState) then) =
      _$WalletStateCopyWithImpl<$Res>;
  $Res call(
      {bool expanded,
      @nullable WalletToken selectedToken,
      List<WalletToken> displayTokens,
      Wrap<List<StakeHistoryEntity>> stakes,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups});
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res> implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  final WalletState _value;
  // ignore: unused_field
  final $Res Function(WalletState) _then;

  @override
  $Res call({
    Object expanded = freezed,
    Object selectedToken = freezed,
    Object displayTokens = freezed,
    Object stakes = freezed,
    Object withdraws = freezed,
    Object topups = freezed,
  }) {
    return _then(_value.copyWith(
      expanded: expanded == freezed ? _value.expanded : expanded as bool,
      selectedToken: selectedToken == freezed
          ? _value.selectedToken
          : selectedToken as WalletToken,
      displayTokens: displayTokens == freezed
          ? _value.displayTokens
          : displayTokens as List<WalletToken>,
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
abstract class _$WalletStateCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$WalletStateCopyWith(
          _WalletState value, $Res Function(_WalletState) then) =
      __$WalletStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool expanded,
      @nullable WalletToken selectedToken,
      List<WalletToken> displayTokens,
      Wrap<List<StakeHistoryEntity>> stakes,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups});
}

/// @nodoc
class __$WalletStateCopyWithImpl<$Res> extends _$WalletStateCopyWithImpl<$Res>
    implements _$WalletStateCopyWith<$Res> {
  __$WalletStateCopyWithImpl(
      _WalletState _value, $Res Function(_WalletState) _then)
      : super(_value, (v) => _then(v as _WalletState));

  @override
  _WalletState get _value => super._value as _WalletState;

  @override
  $Res call({
    Object expanded = freezed,
    Object selectedToken = freezed,
    Object displayTokens = freezed,
    Object stakes = freezed,
    Object withdraws = freezed,
    Object topups = freezed,
  }) {
    return _then(_WalletState(
      expanded: expanded == freezed ? _value.expanded : expanded as bool,
      selectedToken: selectedToken == freezed
          ? _value.selectedToken
          : selectedToken as WalletToken,
      displayTokens: displayTokens == freezed
          ? _value.displayTokens
          : displayTokens as List<WalletToken>,
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
class _$_WalletState implements _WalletState {
  _$_WalletState(
      {this.expanded = false,
      @nullable this.selectedToken,
      this.displayTokens = const [WalletToken.mxc],
      this.stakes = const Wrap.pending(),
      this.withdraws = const Wrap.pending(),
      this.topups = const Wrap.pending()})
      : assert(expanded != null),
        assert(displayTokens != null),
        assert(stakes != null),
        assert(withdraws != null),
        assert(topups != null);

  @JsonKey(defaultValue: false)
  @override
  final bool expanded;
  @override
  @nullable
  final WalletToken selectedToken;
  @JsonKey(defaultValue: const [WalletToken.mxc])
  @override
  final List<WalletToken> displayTokens;
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
    return 'WalletState(expanded: $expanded, selectedToken: $selectedToken, displayTokens: $displayTokens, stakes: $stakes, withdraws: $withdraws, topups: $topups)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WalletState &&
            (identical(other.expanded, expanded) ||
                const DeepCollectionEquality()
                    .equals(other.expanded, expanded)) &&
            (identical(other.selectedToken, selectedToken) ||
                const DeepCollectionEquality()
                    .equals(other.selectedToken, selectedToken)) &&
            (identical(other.displayTokens, displayTokens) ||
                const DeepCollectionEquality()
                    .equals(other.displayTokens, displayTokens)) &&
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
      const DeepCollectionEquality().hash(expanded) ^
      const DeepCollectionEquality().hash(selectedToken) ^
      const DeepCollectionEquality().hash(displayTokens) ^
      const DeepCollectionEquality().hash(stakes) ^
      const DeepCollectionEquality().hash(withdraws) ^
      const DeepCollectionEquality().hash(topups);

  @override
  _$WalletStateCopyWith<_WalletState> get copyWith =>
      __$WalletStateCopyWithImpl<_WalletState>(this, _$identity);
}

abstract class _WalletState implements WalletState {
  factory _WalletState(
      {bool expanded,
      @nullable WalletToken selectedToken,
      List<WalletToken> displayTokens,
      Wrap<List<StakeHistoryEntity>> stakes,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups}) = _$_WalletState;

  @override
  bool get expanded;
  @override
  @nullable
  WalletToken get selectedToken;
  @override
  List<WalletToken> get displayTokens;
  @override
  Wrap<List<StakeHistoryEntity>> get stakes;
  @override
  Wrap<List<WithdrawHistoryEntity>> get withdraws;
  @override
  Wrap<List<TopupEntity>> get topups;
  @override
  _$WalletStateCopyWith<_WalletState> get copyWith;
}
