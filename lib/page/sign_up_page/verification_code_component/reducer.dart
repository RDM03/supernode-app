import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VerificationCodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<VerificationCodeState>>{
      // VerificationCodeAction.action: _onAction,
    },
  );
}

VerificationCodeState _onAction(VerificationCodeState state, Action action) {
  final VerificationCodeState newState = state.clone();
  return newState;
}
