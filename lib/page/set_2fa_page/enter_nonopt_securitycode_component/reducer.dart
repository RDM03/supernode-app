import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EnterNonOTPSecurityCodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<EnterNonOTPSecurityCodeState>>{
      // VerificationCodeAction.action: _onAction,
    },
  );
}

EnterNonOTPSecurityCodeState _onAction(EnterNonOTPSecurityCodeState state, Action action) {
  final EnterNonOTPSecurityCodeState newState = state.clone();
  return newState;
}