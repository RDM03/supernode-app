import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EnterRecoveryCodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<EnterRecoveryCodeState>>{
      // VerificationCodeAction.action: _onAction,
    },
  );
}

EnterRecoveryCodeState _onAction(EnterRecoveryCodeState state, Action action) {
  final EnterRecoveryCodeState newState = state.clone();
  return newState;
}