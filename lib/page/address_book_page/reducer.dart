import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddressBookState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddressBookState>>{
      AddressBookAction.setAddresses: _setAddresses,
    },
  );
}

AddressBookState _setAddresses(AddressBookState state, Action action) {
  final AddressBookState newState = state.clone();
  return newState..addresses = action.payload;
}
