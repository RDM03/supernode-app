import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/daos/supernode_dao.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<UnderMaintenanceState> buildEffect() {
  return combineEffects(<Object, Effect<UnderMaintenanceState>>{
    UnderMaintenanceAction.refresh: _refresh,
  });
}

void _refresh(Action action, Context<UnderMaintenanceState> ctx) async {
  ctx.dispatch(UnderMaintenanceActionCreator.setLoading(true));
  try {
    final deserializedNodes = <String, SuperNodeBean>{};

    var nodes = jsonDecode(await SuperNodeDao().superNodes());
    for (var k in nodes.keys) {
      deserializedNodes[k] = SuperNodeBean(
        name: k,
        logo: nodes[k]["logo"],
        region: nodes[k]["region"],
        url: nodes[k]["url"],
        status: nodes[k]['status'],
      );
    }

    final currentNode = GlobalStore.store.getState().superModel.currentNode;
    final currentFreshNode = deserializedNodes[currentNode.name];

    if (currentFreshNode?.status != 'maintenance') {
      Navigator.of(ctx.context)
          .popUntil((route) => route.settings.name != 'under_maintenance_page');
    }
  } finally {
    ctx.dispatch(UnderMaintenanceActionCreator.setLoading(false));
  }
}
