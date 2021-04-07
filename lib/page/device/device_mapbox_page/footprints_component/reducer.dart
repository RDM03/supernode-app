import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FootprintsState> buildReducer() {
  return asReducer(
    <Object, Reducer<FootprintsState>>{
      FootprintsAction.changeFootPrintsType: _onChangeFootPrintsType,
    },
  );
}

FootprintsState _onChangeFootPrintsType(FootprintsState state, Action action) {
  final FootprintsState newState = state.clone();
  newState.footPrintsType = action.payload;
  return newState;
}
