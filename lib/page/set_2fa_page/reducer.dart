import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<Set2FAState> buildReducer() {
  return asReducer(
    <Object, Reducer<Set2FAState>>{
      Set2FAAction.isEnabled: _isEnabled,
    },
  );
}

Set2FAState _isEnabled(Set2FAState state, Action action) {
  bool isEnabled = action.payload;

  final Set2FAState newState = state.clone();
  return newState
    ..isEnabled = isEnabled;
}