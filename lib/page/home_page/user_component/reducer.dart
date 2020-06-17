import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'action.dart';
import 'state.dart';

Reducer<UserState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserState>>{
      UserAction.addMapController: _addMapController,
    },
  );
}



UserState _addMapController(UserState state, Action action) {
  final UserState newState = state.clone();
  return newState..mapCtl = action.payload;
}
