import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<GatewayState> buildReducer() {
  return asReducer(
    <Object, Reducer<GatewayState>>{
      GatewayListAction.action: _onAction,
    },
  );
}

GatewayState _onAction(GatewayState state, Action action) {
  final GatewayState newState = state.clone();
  return newState;
}
