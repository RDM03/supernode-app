import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EnterSecurityCodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<EnterSecurityCodeState>>{
      // VerificationCodeAction.action: _onAction,
    },
  );
}

EnterSecurityCodeState _onAction(EnterSecurityCodeState state, Action action) {
  final EnterSecurityCodeState newState = state.clone();
  return newState;
}