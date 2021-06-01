import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

part 'state.freezed.dart';

enum WithdrawFlow { form, confirm, securityCode, finish }

@freezed
abstract class WithdrawState with _$WithdrawState {
  WithdrawState._();

  factory WithdrawState({
    Token token,
    String address,
    double amount,
    double fee,
    @Default(false) bool isEnabled,
    @Default(WithdrawFlow.form) WithdrawFlow withdrawFlowStep,
    DateTime confirmTime,
    @Default(false) bool showLoading,
  }) = _WithdrawState;
}
