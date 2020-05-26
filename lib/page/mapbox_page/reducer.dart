import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<mapboxState> buildReducer() {
  return asReducer(
    <Object, Reducer<mapboxState>>{
      mapboxAction.action: _onAction,
    },
  );
}

mapboxState _onAction(mapboxState state, Action action) {
  final mapboxState newState = state.clone();
  return newState;
}
