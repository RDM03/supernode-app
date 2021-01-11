import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GatewayProfileState> buildReducer() {
  return asReducer(
    <Object, Reducer<GatewayProfileState>>{
      GatewayProfileAction.miningInfo: _miningInfo,
      GatewayProfileAction.gatewayFrame: _gatewayFrame,
    },
  );
}

GatewayProfileState _miningInfo(GatewayProfileState state, Action action) {
  final GatewayProfileState newState = state.clone();
  return newState..miningRevenve = action.payload;
}

GatewayProfileState _gatewayFrame(GatewayProfileState state, Action action) {
  final GatewayProfileState newState = state.clone();
  return newState..gatewayFrame = action.payload;
}
