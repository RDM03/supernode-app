import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.onSettings: _onSettings,
    },
  );
}

GlobalState _onSettings(GlobalState state, Action action) {
  return state.clone()
    ..settings = action.payload;
}
