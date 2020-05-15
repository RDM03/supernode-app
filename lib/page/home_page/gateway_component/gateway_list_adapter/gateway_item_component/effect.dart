import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<GatewayItemState> buildEffect() {
  return combineEffects(<Object, Effect<GatewayItemState>>{
    // GatewayItemAction.onProfile: _onProfile,
  });
}

void _onProfile(Action action, Context<GatewayItemState> ctx) {
  
}
