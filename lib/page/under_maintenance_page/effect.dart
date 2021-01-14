import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'action.dart';
import 'state.dart';

Effect<UnderMaintenanceState> buildEffect() {
  return combineEffects(<Object, Effect<UnderMaintenanceState>>{
    UnderMaintenanceAction.refresh: _refresh,
    UnderMaintenanceAction.logOut: _logOut,
  });
}

SupernodeRepository buildSupernodeDao(Context<UnderMaintenanceState> ctx) {
  return ctx.context.read<SupernodeRepository>();
}

void _logOut(Action action, Context<UnderMaintenanceState> ctx) async {
  // RETHINK.TODO
  //await logOut(ctx.context);
}

void _refresh(Action action, Context<UnderMaintenanceState> ctx) async {
  ctx.dispatch(UnderMaintenanceActionCreator.setLoading(true));
  try {
    final deserializedNodes = await buildSupernodeDao(ctx).loadSupernodes();

    final state = ctx.context.read<SupernodeCubit>().state;
    final currentNode = state.user?.node ?? state.selectedNode;
    final currentFreshNode = deserializedNodes[currentNode.name];

    if (currentFreshNode?.status != 'maintenance') {
      Navigator.of(ctx.context)
          .popUntil((route) => route.settings.name != 'under_maintenance_page');
    }
  } finally {
    ctx.dispatch(UnderMaintenanceActionCreator.setLoading(false));
  }
}
