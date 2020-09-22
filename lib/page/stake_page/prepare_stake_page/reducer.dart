import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PrepareStakeState> buildReducer() {
  return asReducer(
    <Object, Reducer<PrepareStakeState>>{
      PrepareStakeAction.resSuccess: _resSuccess,
      PrepareStakeAction.balance: _balance,
    },
  );
}

PrepareStakeState _resSuccess(PrepareStakeState state, Action action) {
  bool resSuccess = action.payload;

  final PrepareStakeState newState = state.clone();
  return newState..resSuccess = resSuccess;
}

PrepareStakeState _balance(PrepareStakeState state, Action action) {
  double balance = action.payload;

  final PrepareStakeState newState = state.clone();
  return newState..balance = balance;
}
