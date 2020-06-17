import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<MapBoxState> buildReducer() {
  return asReducer(
    <Object, Reducer<MapBoxState>>{
      MapBoxAction.addMapController: _addMapController,
    },
  );
}


MapBoxState _addMapController(MapBoxState state, Action action) {
  final MapBoxState newState = state.clone();
  return newState..mapCtl = action.payload;
}
