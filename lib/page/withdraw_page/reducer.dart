import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WithdrawState> buildReducer() {
  return asReducer(
    <Object, Reducer<WithdrawState>>{
      WithdrawAction.address: _address,
    },
  );
}

WithdrawState _address(WithdrawState state, Action action) {
  String address = action.payload;
  final WithdrawState newState = state.clone();

  return newState
    ..addressCtl.text = address;
}
