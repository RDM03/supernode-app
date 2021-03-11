import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class DepositState with _$DepositState {
  DepositState._();

  factory DepositState({
    @Default(Wrap.pending()) Wrap<String> address,
  }) = _DepositState;
}