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
      Wrap<double> yesterdayTotalMPower = const Wrap.pending(),
      Wrap<double> currentMiningPower = const Wrap.pending(),
      Wrap<List<StakeDHX>> stakes = const Wrap.pending(),
      Wrap<double> dhxBonded = const Wrap.pending(),
      Wrap<double> dhxUnbonding = const Wrap.pending(),
      List<CalendarModel> calendarBondInfo = const [],
      List<CalendarModel> lastCalendarBondInfo = const [],
      Map<String, List<CalendarModel>> calendarInfo = const {},
      Wrap<List<WithdrawHistoryEntity>> withdraws = const Wrap.pending(),
      Wrap<List<TopupEntity>> topups = const Wrap.pending(),
      bool confirm = false,
      bool success = false,
      bool showLoading = false,
      double bondAmount,
      double unbondAmount}) {
    return _SupernodeDhxState(
      balance: balance,
      lockedAmount: lockedAmount,
      totalRevenue: totalRevenue,
      yesterdayTotalMPower: yesterdayTotalMPower,
      currentMiningPower: currentMiningPower,
      stakes: stakes,
      dhxBonded: dhxBonded,
      dhxUnbonding: dhxUnbonding,
      calendarBondInfo: calendarBondInfo,
      lastCalendarBondInfo: lastCalendarBondInfo,
      calendarInfo: calendarInfo,
      withdraws: withdraws,
      topups: topups,
      confirm: confirm,
      success: success,
      showLoading: showLoading,
      bondAmount: bondAmount,
      unbondAmount: unbondAmount,
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
  Wrap<double> get yesterdayTotalMPower;
  Wrap<double> get currentMiningPower;
  Wrap<List<StakeDHX>> get stakes;
  Wrap<double> get dhxBonded;
  Wrap<double> get dhxUnbonding;
  List<CalendarModel> get calendarBondInfo;
  List<CalendarModel> get lastCalendarBondInfo;
  Map<String, List<CalendarModel>> get calendarInfo;
  Wrap<List<WithdrawHistoryEntity>> get withdraws;
  Wrap<List<TopupEntity>> get topups;
  bool get confirm;
  bool get success;
  bool get showLoading;
  double get bondAmount;
  double get unbondAmount;

  @JsonKey(ignore: true)
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
      Wrap<double> yesterdayTotalMPower,
      Wrap<double> currentMiningPower,
      Wrap<List<StakeDHX>> stakes,
      Wrap<double> dhxBonded,
      Wrap<double> dhxUnbonding,
      List<CalendarModel> calendarBondInfo,
      List<CalendarModel> lastCalendarBondInfo,
      Map<String, List<CalendarModel>> calendarInfo,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups,
      bool confirm,
      bool success,
      bool showLoading,
      double bondAmount,
      double unbondAmount});
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
    Object yesterdayTotalMPower = freezed,
    Object currentMiningPower = freezed,
    Object stakes = freezed,
    Object dhxBonded = freezed,
    Object dhxUnbonding = freezed,
    Object calendarBondInfo = freezed,
    Object lastCalendarBondInfo = freezed,
    Object calendarInfo = freezed,
    Object withdraws = freezed,
    Object topups = freezed,
    Object confirm = freezed,
    Object success = freezed,
    Object showLoading = freezed,
    Object bondAmount = freezed,
    Object unbondAmount = freezed,
  }) {
    return _then(_value.copyWith(
      balance: balance == freezed ? _value.balance : balance as Wrap<double>,
      lockedAmount: lockedAmount == freezed
          ? _value.lockedAmount
          : lockedAmount as Wrap<double>,
      totalRevenue: totalRevenue == freezed
          ? _value.totalRevenue
          : totalRevenue as Wrap<double>,
      yesterdayTotalMPower: yesterdayTotalMPower == freezed
          ? _value.yesterdayTotalMPower
          : yesterdayTotalMPower as Wrap<double>,
      currentMiningPower: currentMiningPower == freezed
          ? _value.currentMiningPower
          : currentMiningPower as Wrap<double>,
      stakes:
          stakes == freezed ? _value.stakes : stakes as Wrap<List<StakeDHX>>,
      dhxBonded:
          dhxBonded == freezed ? _value.dhxBonded : dhxBonded as Wrap<double>,
      dhxUnbonding: dhxUnbonding == freezed
          ? _value.dhxUnbonding
          : dhxUnbonding as Wrap<double>,
      calendarBondInfo: calendarBondInfo == freezed
          ? _value.calendarBondInfo
          : calendarBondInfo as List<CalendarModel>,
      lastCalendarBondInfo: lastCalendarBondInfo == freezed
          ? _value.lastCalendarBondInfo
          : lastCalendarBondInfo as List<CalendarModel>,
      calendarInfo: calendarInfo == freezed
          ? _value.calendarInfo
          : calendarInfo as Map<String, List<CalendarModel>>,
      withdraws: withdraws == freezed
          ? _value.withdraws
          : withdraws as Wrap<List<WithdrawHistoryEntity>>,
      topups:
          topups == freezed ? _value.topups : topups as Wrap<List<TopupEntity>>,
      confirm: confirm == freezed ? _value.confirm : confirm as bool,
      success: success == freezed ? _value.success : success as bool,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
      bondAmount:
          bondAmount == freezed ? _value.bondAmount : bondAmount as double,
      unbondAmount: unbondAmount == freezed
          ? _value.unbondAmount
          : unbondAmount as double,
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
      Wrap<double> yesterdayTotalMPower,
      Wrap<double> currentMiningPower,
      Wrap<List<StakeDHX>> stakes,
      Wrap<double> dhxBonded,
      Wrap<double> dhxUnbonding,
      List<CalendarModel> calendarBondInfo,
      List<CalendarModel> lastCalendarBondInfo,
      Map<String, List<CalendarModel>> calendarInfo,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups,
      bool confirm,
      bool success,
      bool showLoading,
      double bondAmount,
      double unbondAmount});
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
    Object yesterdayTotalMPower = freezed,
    Object currentMiningPower = freezed,
    Object stakes = freezed,
    Object dhxBonded = freezed,
    Object dhxUnbonding = freezed,
    Object calendarBondInfo = freezed,
    Object lastCalendarBondInfo = freezed,
    Object calendarInfo = freezed,
    Object withdraws = freezed,
    Object topups = freezed,
    Object confirm = freezed,
    Object success = freezed,
    Object showLoading = freezed,
    Object bondAmount = freezed,
    Object unbondAmount = freezed,
  }) {
    return _then(_SupernodeDhxState(
      balance: balance == freezed ? _value.balance : balance as Wrap<double>,
      lockedAmount: lockedAmount == freezed
          ? _value.lockedAmount
          : lockedAmount as Wrap<double>,
      totalRevenue: totalRevenue == freezed
          ? _value.totalRevenue
          : totalRevenue as Wrap<double>,
      yesterdayTotalMPower: yesterdayTotalMPower == freezed
          ? _value.yesterdayTotalMPower
          : yesterdayTotalMPower as Wrap<double>,
      currentMiningPower: currentMiningPower == freezed
          ? _value.currentMiningPower
          : currentMiningPower as Wrap<double>,
      stakes:
          stakes == freezed ? _value.stakes : stakes as Wrap<List<StakeDHX>>,
      dhxBonded:
          dhxBonded == freezed ? _value.dhxBonded : dhxBonded as Wrap<double>,
      dhxUnbonding: dhxUnbonding == freezed
          ? _value.dhxUnbonding
          : dhxUnbonding as Wrap<double>,
      calendarBondInfo: calendarBondInfo == freezed
          ? _value.calendarBondInfo
          : calendarBondInfo as List<CalendarModel>,
      lastCalendarBondInfo: lastCalendarBondInfo == freezed
          ? _value.lastCalendarBondInfo
          : lastCalendarBondInfo as List<CalendarModel>,
      calendarInfo: calendarInfo == freezed
          ? _value.calendarInfo
          : calendarInfo as Map<String, List<CalendarModel>>,
      withdraws: withdraws == freezed
          ? _value.withdraws
          : withdraws as Wrap<List<WithdrawHistoryEntity>>,
      topups:
          topups == freezed ? _value.topups : topups as Wrap<List<TopupEntity>>,
      confirm: confirm == freezed ? _value.confirm : confirm as bool,
      success: success == freezed ? _value.success : success as bool,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
      bondAmount:
          bondAmount == freezed ? _value.bondAmount : bondAmount as double,
      unbondAmount: unbondAmount == freezed
          ? _value.unbondAmount
          : unbondAmount as double,
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
      this.yesterdayTotalMPower = const Wrap.pending(),
      this.currentMiningPower = const Wrap.pending(),
      this.stakes = const Wrap.pending(),
      this.dhxBonded = const Wrap.pending(),
      this.dhxUnbonding = const Wrap.pending(),
      this.calendarBondInfo = const [],
      this.lastCalendarBondInfo = const [],
      this.calendarInfo = const {},
      this.withdraws = const Wrap.pending(),
      this.topups = const Wrap.pending(),
      this.confirm = false,
      this.success = false,
      this.showLoading = false,
      this.bondAmount,
      this.unbondAmount})
      : assert(balance != null),
        assert(lockedAmount != null),
        assert(totalRevenue != null),
        assert(yesterdayTotalMPower != null),
        assert(currentMiningPower != null),
        assert(stakes != null),
        assert(dhxBonded != null),
        assert(dhxUnbonding != null),
        assert(calendarBondInfo != null),
        assert(lastCalendarBondInfo != null),
        assert(calendarInfo != null),
        assert(withdraws != null),
        assert(topups != null),
        assert(confirm != null),
        assert(success != null),
        assert(showLoading != null);

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
  final Wrap<double> yesterdayTotalMPower;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> currentMiningPower;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<StakeDHX>> stakes;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> dhxBonded;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> dhxUnbonding;
  @JsonKey(defaultValue: const [])
  @override
  final List<CalendarModel> calendarBondInfo;
  @JsonKey(defaultValue: const [])
  @override
  final List<CalendarModel> lastCalendarBondInfo;
  @JsonKey(defaultValue: const {})
  @override
  final Map<String, List<CalendarModel>> calendarInfo;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<WithdrawHistoryEntity>> withdraws;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<TopupEntity>> topups;
  @JsonKey(defaultValue: false)
  @override
  final bool confirm;
  @JsonKey(defaultValue: false)
  @override
  final bool success;
  @JsonKey(defaultValue: false)
  @override
  final bool showLoading;
  @override
  final double bondAmount;
  @override
  final double unbondAmount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupernodeDhxState(balance: $balance, lockedAmount: $lockedAmount, totalRevenue: $totalRevenue, yesterdayTotalMPower: $yesterdayTotalMPower, currentMiningPower: $currentMiningPower, stakes: $stakes, dhxBonded: $dhxBonded, dhxUnbonding: $dhxUnbonding, calendarBondInfo: $calendarBondInfo, lastCalendarBondInfo: $lastCalendarBondInfo, calendarInfo: $calendarInfo, withdraws: $withdraws, topups: $topups, confirm: $confirm, success: $success, showLoading: $showLoading, bondAmount: $bondAmount, unbondAmount: $unbondAmount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupernodeDhxState'))
      ..add(DiagnosticsProperty('balance', balance))
      ..add(DiagnosticsProperty('lockedAmount', lockedAmount))
      ..add(DiagnosticsProperty('totalRevenue', totalRevenue))
      ..add(DiagnosticsProperty('yesterdayTotalMPower', yesterdayTotalMPower))
      ..add(DiagnosticsProperty('currentMiningPower', currentMiningPower))
      ..add(DiagnosticsProperty('stakes', stakes))
      ..add(DiagnosticsProperty('dhxBonded', dhxBonded))
      ..add(DiagnosticsProperty('dhxUnbonding', dhxUnbonding))
      ..add(DiagnosticsProperty('calendarBondInfo', calendarBondInfo))
      ..add(DiagnosticsProperty('lastCalendarBondInfo', lastCalendarBondInfo))
      ..add(DiagnosticsProperty('calendarInfo', calendarInfo))
      ..add(DiagnosticsProperty('withdraws', withdraws))
      ..add(DiagnosticsProperty('topups', topups))
      ..add(DiagnosticsProperty('confirm', confirm))
      ..add(DiagnosticsProperty('success', success))
      ..add(DiagnosticsProperty('showLoading', showLoading))
      ..add(DiagnosticsProperty('bondAmount', bondAmount))
      ..add(DiagnosticsProperty('unbondAmount', unbondAmount));
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
            (identical(other.yesterdayTotalMPower, yesterdayTotalMPower) ||
                const DeepCollectionEquality().equals(
                    other.yesterdayTotalMPower, yesterdayTotalMPower)) &&
            (identical(other.currentMiningPower, currentMiningPower) ||
                const DeepCollectionEquality()
                    .equals(other.currentMiningPower, currentMiningPower)) &&
            (identical(other.stakes, stakes) ||
                const DeepCollectionEquality().equals(other.stakes, stakes)) &&
            (identical(other.dhxBonded, dhxBonded) ||
                const DeepCollectionEquality()
                    .equals(other.dhxBonded, dhxBonded)) &&
            (identical(other.dhxUnbonding, dhxUnbonding) ||
                const DeepCollectionEquality()
                    .equals(other.dhxUnbonding, dhxUnbonding)) &&
            (identical(other.calendarBondInfo, calendarBondInfo) ||
                const DeepCollectionEquality()
                    .equals(other.calendarBondInfo, calendarBondInfo)) &&
            (identical(other.lastCalendarBondInfo, lastCalendarBondInfo) ||
                const DeepCollectionEquality().equals(
                    other.lastCalendarBondInfo, lastCalendarBondInfo)) &&
            (identical(other.calendarInfo, calendarInfo) ||
                const DeepCollectionEquality()
                    .equals(other.calendarInfo, calendarInfo)) &&
            (identical(other.withdraws, withdraws) ||
                const DeepCollectionEquality()
                    .equals(other.withdraws, withdraws)) &&
            (identical(other.topups, topups) ||
                const DeepCollectionEquality().equals(other.topups, topups)) &&
            (identical(other.confirm, confirm) ||
                const DeepCollectionEquality()
                    .equals(other.confirm, confirm)) &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.showLoading, showLoading) ||
                const DeepCollectionEquality()
                    .equals(other.showLoading, showLoading)) &&
            (identical(other.bondAmount, bondAmount) ||
                const DeepCollectionEquality()
                    .equals(other.bondAmount, bondAmount)) &&
            (identical(other.unbondAmount, unbondAmount) ||
                const DeepCollectionEquality()
                    .equals(other.unbondAmount, unbondAmount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(lockedAmount) ^
      const DeepCollectionEquality().hash(totalRevenue) ^
      const DeepCollectionEquality().hash(yesterdayTotalMPower) ^
      const DeepCollectionEquality().hash(currentMiningPower) ^
      const DeepCollectionEquality().hash(stakes) ^
      const DeepCollectionEquality().hash(dhxBonded) ^
      const DeepCollectionEquality().hash(dhxUnbonding) ^
      const DeepCollectionEquality().hash(calendarBondInfo) ^
      const DeepCollectionEquality().hash(lastCalendarBondInfo) ^
      const DeepCollectionEquality().hash(calendarInfo) ^
      const DeepCollectionEquality().hash(withdraws) ^
      const DeepCollectionEquality().hash(topups) ^
      const DeepCollectionEquality().hash(confirm) ^
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(showLoading) ^
      const DeepCollectionEquality().hash(bondAmount) ^
      const DeepCollectionEquality().hash(unbondAmount);

  @JsonKey(ignore: true)
  @override
  _$SupernodeDhxStateCopyWith<_SupernodeDhxState> get copyWith =>
      __$SupernodeDhxStateCopyWithImpl<_SupernodeDhxState>(this, _$identity);
}

abstract class _SupernodeDhxState implements SupernodeDhxState {
  factory _SupernodeDhxState(
      {Wrap<double> balance,
      Wrap<double> lockedAmount,
      Wrap<double> totalRevenue,
      Wrap<double> yesterdayTotalMPower,
      Wrap<double> currentMiningPower,
      Wrap<List<StakeDHX>> stakes,
      Wrap<double> dhxBonded,
      Wrap<double> dhxUnbonding,
      List<CalendarModel> calendarBondInfo,
      List<CalendarModel> lastCalendarBondInfo,
      Map<String, List<CalendarModel>> calendarInfo,
      Wrap<List<WithdrawHistoryEntity>> withdraws,
      Wrap<List<TopupEntity>> topups,
      bool confirm,
      bool success,
      bool showLoading,
      double bondAmount,
      double unbondAmount}) = _$_SupernodeDhxState;

  @override
  Wrap<double> get balance;
  @override
  Wrap<double> get lockedAmount;
  @override
  Wrap<double> get totalRevenue;
  @override
  Wrap<double> get yesterdayTotalMPower;
  @override
  Wrap<double> get currentMiningPower;
  @override
  Wrap<List<StakeDHX>> get stakes;
  @override
  Wrap<double> get dhxBonded;
  @override
  Wrap<double> get dhxUnbonding;
  @override
  List<CalendarModel> get calendarBondInfo;
  @override
  List<CalendarModel> get lastCalendarBondInfo;
  @override
  Map<String, List<CalendarModel>> get calendarInfo;
  @override
  Wrap<List<WithdrawHistoryEntity>> get withdraws;
  @override
  Wrap<List<TopupEntity>> get topups;
  @override
  bool get confirm;
  @override
  bool get success;
  @override
  bool get showLoading;
  @override
  double get bondAmount;
  @override
  double get unbondAmount;
  @override
  @JsonKey(ignore: true)
  _$SupernodeDhxStateCopyWith<_SupernodeDhxState> get copyWith;
}
