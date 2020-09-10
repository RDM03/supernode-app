import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListUnstakeState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListUnstakeState>>{
      ListUnstakeAction.setStakes: _setStakes,
    },
  );
}

ListUnstakeState _setStakes(ListUnstakeState state, Action action) {
  final ListUnstakeState newState = state.clone();

  return newState
    ..stakes = action.payload
    ..isLoading = false;
}
