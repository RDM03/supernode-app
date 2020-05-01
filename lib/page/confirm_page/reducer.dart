import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ConfirmState> buildReducer() {
  return asReducer(
    <Object, Reducer<ConfirmState>>{
      ConfirmAction.action: _onAction,
    },
  );
}

ConfirmState _onAction(ConfirmState state, Action action) {
  final ConfirmState newState = state.clone();
  return newState;
}
