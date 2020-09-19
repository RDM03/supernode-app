import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Reducer<AddressDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddressDetailsState>>{},
  );
}
