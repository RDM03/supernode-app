import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GatewayState> buildReducer() {
  return asReducer(
    <Object, Reducer<GatewayState>>{
      GatewayAction.profile: _profile
    },
  );
}

GatewayState _profile(GatewayState state, Action action) {
  final GatewayState newState = state.clone();
  return newState
    ..profile = action.payload;
}