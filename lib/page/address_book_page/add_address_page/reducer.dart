import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddAddressState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddAddressState>>{
      AddAddressAction.setAddress: _setAddress,
    },
  );
}

AddAddressState _setAddress(AddAddressState state, Action action) {
  final AddAddressState newState = state.clone();
  return newState..addressController.text = action.payload;
}
