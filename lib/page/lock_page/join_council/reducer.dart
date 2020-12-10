import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<JoinCouncilState> buildReducer() {
  return asReducer(
    <Object, Reducer<JoinCouncilState>>{
      JoinCouncilAction.resSuccess: _resSuccess,
    },
  );
}

JoinCouncilState _resSuccess(JoinCouncilState state, Action action) {
  bool resSuccess = action.payload;

  final JoinCouncilState newState = state.clone();
  return newState..resSuccess = resSuccess;
}
