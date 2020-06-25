import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'action.dart';
import 'state.dart';

Reducer<MapBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<MapBoxState>>{
      MapBoxAction.action: _onAction,
      MapBoxAction.location: _onLocation,
    },
  );
}

MapBoxState _onAction(MapBoxState state, Action action) {
  final MapBoxState newState = state.clone();
  return newState;
}

MapBoxState _onLocation(MapBoxState state, Action action) {
  LatLng loc = action.payload;

  final MapBoxState newState = state.clone();
  return newState..myLocation = loc;
}
