import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StakeState> buildReducer() {
  return asReducer(
    <Object, Reducer<StakeState>>{
      StakeAction.resSuccess: _resSuccess,
      StakeAction.setOtpEnabled: _setOtpEnabled,
    },
  );
}

StakeState _resSuccess(StakeState state, Action action) {
  bool resSuccess = action.payload;

  final StakeState newState = state.clone();
  return newState
    ..resSuccess = resSuccess;
}

StakeState _setOtpEnabled(StakeState state, Action action) {
  bool enabled = action.payload;

  final StakeState newState = state.clone();
  return newState
    ..otpEnabled = enabled;
}
