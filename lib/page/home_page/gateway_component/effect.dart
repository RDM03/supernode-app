import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<GatewayState> buildEffect() {
  return combineEffects(<Object, Effect<GatewayState>>{
    Lifecycle.initState: _initState,
    GatewayAction.onAdd: _onAddAction,
    // GatewayAction.onProfile: _onProfile,
  });
}

void _initState(Action action, Context<GatewayState> ctx) {

}

void _onAddAction(Action action, Context<GatewayState> ctx) {
  Navigator.of(ctx.context).pushNamed('add_gateway_page',arguments:{'fromPage': 'home'});

  // Navigator.push(ctx.context,
  //   MaterialPageRoute(
  //     maintainState: false,
  //     fullscreenDialog: true,
  //     builder:(context){
  //       return ctx.buildComponent('add');
  //     }
  //   ),
  // );
}

void _onProfile(Action action, Context<GatewayState> ctx) {
  Navigator.push(ctx.context,
    MaterialPageRoute(
      maintainState: false,
      fullscreenDialog: true,
      builder:(context){
        return ctx.buildComponent('profile');
      }
    ),
  );
}
