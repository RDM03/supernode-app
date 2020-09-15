import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PrepareStakeState> buildReducer() {
  return asReducer(
    <Object, Reducer<PrepareStakeState>>{
      PrepareStakeAction.resSuccess: _resSuccess,
    },
  );
}

PrepareStakeState _resSuccess(PrepareStakeState state, Action action) {
  bool resSuccess = action.payload;

  final PrepareStakeState newState = state.clone();
  return newState..resSuccess = resSuccess;
}
