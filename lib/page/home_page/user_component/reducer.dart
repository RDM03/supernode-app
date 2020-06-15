import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'action.dart';
import 'state.dart';

Reducer<UserState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserState>>{
      UserAction.addLocation: _addLocation,
      UserAction.addMapController: _addMapController,
    },
  );
}

UserState _addLocation(UserState state, Action action) {
  LatLng location = action.payload;

  final UserState newState = state.clone();
  return newState..location = location;
}

UserState _addMapController(UserState state, Action action) {
  final UserState newState = state.clone();
  return newState..mapCtl = action.payload;
}
