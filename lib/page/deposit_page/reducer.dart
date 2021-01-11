import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DepositState> buildReducer() {
  return asReducer(
    <Object, Reducer<DepositState>>{
      DepositAction.address: _address,
    },
  );
}

DepositState _address(DepositState state, Action action) {
  String address = action.payload;

  final DepositState newState = state.clone();
  return newState..address = address;
}
