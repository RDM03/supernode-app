import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/scheduler.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'state.dart';

Effect<MapBoxState> buildEffect() {
  return combineEffects(<Object, Effect<MapBoxState>>{
    Lifecycle.initState: _initState,
  });
}

void _initState(Action action, Context<MapBoxState> ctx) {
  PermissionUtil.getLocation();
}

