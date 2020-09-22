import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/stake_page/action.dart';

import 'state.dart';

Reducer<StakeState> buildReducer() {
  return asReducer(
    <Object, Reducer<StakeState>>{
      StakeAction.setRates: _setRates,
      StakeAction.balance: _balance
    },
  );
}

StakeState _setRates(StakeState state, Action action) {
  Map<String, double> rates = action.payload;
  final StakeState newState = state.clone();

  return newState
    ..rate6m = rates['6']
    ..rate9m = rates['9']
    ..rate12m = rates['12']
    ..rate24m = rates['24']
    ..rateFlex = rates['flex'];
}

StakeState _balance(StakeState state, Action action) {
  double balance = action.payload;

  final StakeState newState = state.clone();
  return newState..balance = balance;
}