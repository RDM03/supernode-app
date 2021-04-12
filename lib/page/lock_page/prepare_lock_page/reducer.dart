import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PrepareLockState> buildReducer() {
  return asReducer(
    <Object, Reducer<PrepareLockState>>{
      PrepareLockAction.resSuccess: _resSuccess,
      PrepareLockAction.balance: _balance,
      PrepareLockAction.minersOwned: _minersOwned,
      PrepareLockAction.lastMining: _lastMining,
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

PrepareLockState _minersOwned(PrepareLockState state, Action action) {
  int minersOwned = action.payload;

  final PrepareLockState newState = state.clone();
  return newState..minersOwned = minersOwned;
}

PrepareLockState _lastMining(PrepareLockState state, Action action) {
  double yesterdayTotalDHX = action.payload[0];
  double yesterdayTotalMPower = action.payload[1];

  final PrepareLockState newState = state.clone();
  return newState
    ..yesterdayTotalDHX = yesterdayTotalDHX
    ..yesterdayTotalMPower = yesterdayTotalMPower;
}
