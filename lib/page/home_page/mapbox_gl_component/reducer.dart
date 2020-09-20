import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MapboxGlState> buildReducer() {
  return asReducer(
    <Object, Reducer<MapboxGlState>>{
      MapboxGlAction.action: _onAction,
    },
  );
}

MapboxGlState _onAction(MapboxGlState state, Action action) {
  final MapboxGlState newState = state.clone();
  return newState;
}
