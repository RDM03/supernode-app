import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GatewayState> buildReducer() {
  return asReducer(
    <Object, Reducer<GatewayState>>{
      // GatewayAction.action: _onAction,
    },
  );
}

GatewayState _onAction(GatewayState state, Action action) {
  final GatewayState newState = state.clone();
  return newState;
}
