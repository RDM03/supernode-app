import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GatewayState> buildReducer() {
  return asReducer(
    <Object, Reducer<GatewayState>>{
      GatewayAction.profile: _profile,
      GatewayAction.addGateways: _addGateways,
    },
  );
}

GatewayState _profile(GatewayState state, Action action) {
  final GatewayState newState = state.clone();
  return newState..profile = action.payload;
}

GatewayState _addGateways(GatewayState state, Action action) {
  final GatewayState newState = state.clone();
  return newState..list = [...newState.list, ...action.payload];
}
