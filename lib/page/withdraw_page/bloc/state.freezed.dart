// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$WithdrawStateTearOff {
  const _$WithdrawStateTearOff();

// ignore: unused_element
  _WithdrawState call(
      {Token token,
      String address,
      double amount,
      double fee,
      bool isEnabled = false,
      WithdrawFlow withdrawFlowStep = WithdrawFlow.form,
      DateTime confirmTime,
      bool showLoading = false}) {
    return _WithdrawState(
      token: token,
      address: address,
      amount: amount,
      fee: fee,
      isEnabled: isEnabled,
      withdrawFlowStep: withdrawFlowStep,
      confirmTime: confirmTime,
      showLoading: showLoading,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $WithdrawState = _$WithdrawStateTearOff();

/// @nodoc
mixin _$WithdrawState {
  Token get token;
  String get address;
  double get amount;
  double get fee;
  bool get isEnabled;
  WithdrawFlow get withdrawFlowStep;
  DateTime get confirmTime;
  bool get showLoading;

  $WithdrawStateCopyWith<WithdrawState> get copyWith;
}

/// @nodoc
abstract class $WithdrawStateCopyWith<$Res> {
  factory $WithdrawStateCopyWith(
          WithdrawState value, $Res Function(WithdrawState) then) =
      _$WithdrawStateCopyWithImpl<$Res>;
  $Res call(
      {Token token,
      String address,
      double amount,
      double fee,
      bool isEnabled,
      WithdrawFlow withdrawFlowStep,
      DateTime confirmTime,
      bool showLoading});
}

/// @nodoc
class _$WithdrawStateCopyWithImpl<$Res>
    implements $WithdrawStateCopyWith<$Res> {
  _$WithdrawStateCopyWithImpl(this._value, this._then);

  final WithdrawState _value;
  // ignore: unused_field
  final $Res Function(WithdrawState) _then;

  @override
  $Res call({
    Object token = freezed,
    Object address = freezed,
    Object amount = freezed,
    Object fee = freezed,
    Object isEnabled = freezed,
    Object withdrawFlowStep = freezed,
    Object confirmTime = freezed,
    Object showLoading = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed ? _value.token : token as Token,
      address: address == freezed ? _value.address : address as String,
      amount: amount == freezed ? _value.amount : amount as double,
      fee: fee == freezed ? _value.fee : fee as double,
      isEnabled: isEnabled == freezed ? _value.isEnabled : isEnabled as bool,
      withdrawFlowStep: withdrawFlowStep == freezed
          ? _value.withdrawFlowStep
          : withdrawFlowStep as WithdrawFlow,
      confirmTime:
          confirmTime == freezed ? _value.confirmTime : confirmTime as DateTime,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
    ));
  }
}

/// @nodoc
abstract class _$WithdrawStateCopyWith<$Res>
    implements $WithdrawStateCopyWith<$Res> {
  factory _$WithdrawStateCopyWith(
          _WithdrawState value, $Res Function(_WithdrawState) then) =
      __$WithdrawStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Token token,
      String address,
      double amount,
      double fee,
      bool isEnabled,
      WithdrawFlow withdrawFlowStep,
      DateTime confirmTime,
      bool showLoading});
}

/// @nodoc
class __$WithdrawStateCopyWithImpl<$Res>
    extends _$WithdrawStateCopyWithImpl<$Res>
    implements _$WithdrawStateCopyWith<$Res> {
  __$WithdrawStateCopyWithImpl(
      _WithdrawState _value, $Res Function(_WithdrawState) _then)
      : super(_value, (v) => _then(v as _WithdrawState));

  @override
  _WithdrawState get _value => super._value as _WithdrawState;

  @override
  $Res call({
    Object token = freezed,
    Object address = freezed,
    Object amount = freezed,
    Object fee = freezed,
    Object isEnabled = freezed,
    Object withdrawFlowStep = freezed,
    Object confirmTime = freezed,
    Object showLoading = freezed,
  }) {
    return _then(_WithdrawState(
      token: token == freezed ? _value.token : token as Token,
      address: address == freezed ? _value.address : address as String,
      amount: amount == freezed ? _value.amount : amount as double,
      fee: fee == freezed ? _value.fee : fee as double,
      isEnabled: isEnabled == freezed ? _value.isEnabled : isEnabled as bool,
      withdrawFlowStep: withdrawFlowStep == freezed
          ? _value.withdrawFlowStep
          : withdrawFlowStep as WithdrawFlow,
      confirmTime:
          confirmTime == freezed ? _value.confirmTime : confirmTime as DateTime,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
    ));
  }
}

/// @nodoc
class _$_WithdrawState extends _WithdrawState with DiagnosticableTreeMixin {
  _$_WithdrawState(
      {this.token,
      this.address,
      this.amount,
      this.fee,
      this.isEnabled = false,
      this.withdrawFlowStep = WithdrawFlow.form,
      this.confirmTime,
      this.showLoading = false})
      : assert(isEnabled != null),
        assert(withdrawFlowStep != null),
        assert(showLoading != null),
        super._();

  @override
  final Token token;
  @override
  final String address;
  @override
  final double amount;
  @override
  final double fee;
  @JsonKey(defaultValue: false)
  @override
  final bool isEnabled;
  @JsonKey(defaultValue: WithdrawFlow.form)
  @override
  final WithdrawFlow withdrawFlowStep;
  @override
  final DateTime confirmTime;
  @JsonKey(defaultValue: false)
  @override
  final bool showLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WithdrawState(token: $token, address: $address, amount: $amount, fee: $fee, isEnabled: $isEnabled, withdrawFlowStep: $withdrawFlowStep, confirmTime: $confirmTime, showLoading: $showLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WithdrawState'))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('fee', fee))
      ..add(DiagnosticsProperty('isEnabled', isEnabled))
      ..add(DiagnosticsProperty('withdrawFlowStep', withdrawFlowStep))
      ..add(DiagnosticsProperty('confirmTime', confirmTime))
      ..add(DiagnosticsProperty('showLoading', showLoading));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WithdrawState &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.fee, fee) ||
                const DeepCollectionEquality().equals(other.fee, fee)) &&
            (identical(other.isEnabled, isEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.isEnabled, isEnabled)) &&
            (identical(other.withdrawFlowStep, withdrawFlowStep) ||
                const DeepCollectionEquality()
                    .equals(other.withdrawFlowStep, withdrawFlowStep)) &&
            (identical(other.confirmTime, confirmTime) ||
                const DeepCollectionEquality()
                    .equals(other.confirmTime, confirmTime)) &&
            (identical(other.showLoading, showLoading) ||
                const DeepCollectionEquality()
                    .equals(other.showLoading, showLoading)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(fee) ^
      const DeepCollectionEquality().hash(isEnabled) ^
      const DeepCollectionEquality().hash(withdrawFlowStep) ^
      const DeepCollectionEquality().hash(confirmTime) ^
      const DeepCollectionEquality().hash(showLoading);

  @override
  _$WithdrawStateCopyWith<_WithdrawState> get copyWith =>
      __$WithdrawStateCopyWithImpl<_WithdrawState>(this, _$identity);
}

abstract class _WithdrawState extends WithdrawState {
  _WithdrawState._() : super._();
  factory _WithdrawState(
      {Token token,
      String address,
      double amount,
      double fee,
      bool isEnabled,
      WithdrawFlow withdrawFlowStep,
      DateTime confirmTime,
      bool showLoading}) = _$_WithdrawState;

  @override
  Token get token;
  @override
  String get address;
  @override
  double get amount;
  @override
  double get fee;
  @override
  bool get isEnabled;
  @override
  WithdrawFlow get withdrawFlowStep;
  @override
  DateTime get confirmTime;
  @override
  bool get showLoading;
  @override
  _$WithdrawStateCopyWith<_WithdrawState> get copyWith;
}
