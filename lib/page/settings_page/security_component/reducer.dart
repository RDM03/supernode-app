import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SecurityState> buildReducer() {
  return asReducer(
    <Object, Reducer<SecurityState>>{
      // SecurityAction.action: _onAction,
    },
  );
}

SecurityState _onAction(SecurityState state, Action action) {
  final SecurityState newState = state.clone();
  return newState;
}
