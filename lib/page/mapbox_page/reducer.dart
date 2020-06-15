import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'action.dart';
import 'state.dart';

Reducer<MapBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<MapBoxState>>{
      MapBoxAction.addLocation: _addLocation,
      MapBoxAction.addMapController: _addMapController,
    },
  );
}

MapBoxState _addLocation(MapBoxState state, Action action) {
  LatLng loc = action.payload;

  final MapBoxState newState = state.clone();
  return newState..myLocation = loc;
}

MapBoxState _addMapController(MapBoxState state, Action action) {
  final MapBoxState newState = state.clone();
  return newState..mapCtl = action.payload;
}
