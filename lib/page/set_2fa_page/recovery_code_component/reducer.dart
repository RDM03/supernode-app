import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RecoveryCodeState> buildReducer() {
  return asReducer(
    <Object, Reducer<RecoveryCodeState>>{
      RecoveryCodeAction.isAgreed: _isAgreed,
    },
  );
}

RecoveryCodeState _onAction(RecoveryCodeState state, Action action) {
  final RecoveryCodeState newState = state.clone();
  return newState;
}

RecoveryCodeState _isAgreed(RecoveryCodeState state, Action action) {
  bool isAgreed = action.payload;

  final RecoveryCodeState newState = state.clone();
  return newState
    ..isAgreed = isAgreed;
}