import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EnterSecurityCodeWithdrawState> buildReducer() {
  return asReducer(
    <Object, Reducer<EnterSecurityCodeWithdrawState>>{
      // VerificationCodeAction.action: _onAction,
    },
  );
}

EnterSecurityCodeWithdrawState _onAction(EnterSecurityCodeWithdrawState state, Action action) {
  final EnterSecurityCodeWithdrawState newState = state.clone();
  return newState;
}