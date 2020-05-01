import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ForgotPasswordState> buildReducer() {
  return asReducer(
    <Object, Reducer<ForgotPasswordState>>{
      ForgotPasswordAction.action: _onAction,
    },
  );
}

ForgotPasswordState _onAction(ForgotPasswordState state, Action action) {
  final ForgotPasswordState newState = state.clone();
  return newState;
}
