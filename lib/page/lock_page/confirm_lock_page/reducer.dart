import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ConfirmLockState> buildReducer() {
  return asReducer(
    <Object, Reducer<ConfirmLockState>>{
      ConfirmLockAction.resSuccess: _resSuccess,
    },
  );
}

ConfirmLockState _resSuccess(ConfirmLockState state, Action action) {
  bool resSuccess = action.payload;

  final ConfirmLockState newState = state.clone();
  return newState..resSuccess = resSuccess;
}
