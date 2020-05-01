import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GatewayItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<GatewayItemState>>{
      // GatewayItemAction.action: _onAction,
    },
  );
}

GatewayItemState _onAction(GatewayItemState state, Action action) {
  final GatewayItemState newState = state.clone();
  return newState;
}
