import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PrepareLockState> buildReducer() {
  return asReducer(
    <Object, Reducer<PrepareLockState>>{
      PrepareLockAction.resSuccess: _resSuccess,
      PrepareLockAction.balance: _balance,
    },
  );
}

PrepareLockState _resSuccess(PrepareLockState state, Action action) {
  bool resSuccess = action.payload;

  final PrepareLockState newState = state.clone();
  return newState..resSuccess = resSuccess;
}

PrepareLockState _balance(PrepareLockState state, Action action) {
  double balance = action.payload;

  final PrepareLockState newState = state.clone();
  return newState..balance = balance;
}
