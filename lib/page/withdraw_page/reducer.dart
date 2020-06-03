import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WithdrawState> buildReducer() {
  return asReducer(
    <Object, Reducer<WithdrawState>>{
      WithdrawAction.address: _address,
      WithdrawAction.fee: _fee,
      WithdrawAction.isEnabled: _isEnabled,
      WithdrawAction.balance: _balance,
      WithdrawAction.status: _status,
    },
  );
}

WithdrawState _address(WithdrawState state, Action action) {
  String address = action.payload;
  final WithdrawState newState = state.clone();

  return newState
    ..addressCtl.text = address;
}

WithdrawState _isEnabled(WithdrawState state, Action action) {
  bool isEnabled = action.payload;

  final WithdrawState newState = state.clone();
  return newState
    ..isEnabled = isEnabled;
}

WithdrawState _fee(WithdrawState state, Action action) {
  double fee = action.payload;

  final WithdrawState newState = state.clone();

  return newState
    ..fee = fee;
}

WithdrawState _balance(WithdrawState state, Action action) {
  double balance = action.payload;

  final WithdrawState newState = state.clone();

  return newState
    ..balance = balance;
}

WithdrawState _status(WithdrawState state, Action action) {
  bool status = action.payload;

  final WithdrawState newState = state.clone();

  return newState
    ..status = status;
}
