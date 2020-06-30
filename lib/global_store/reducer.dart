import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.onSettings: _onSettings,
      GlobalAction.choiceSuperNode: _choiceSuperNode,
    },
  );
}

GlobalState _onSettings(GlobalState state, Action action) {
  return state.clone()..settings = action.payload;
}

GlobalState _choiceSuperNode(GlobalState state, Action action) {
  return state.clone()..superModel.currentNode = action.payload;
}
