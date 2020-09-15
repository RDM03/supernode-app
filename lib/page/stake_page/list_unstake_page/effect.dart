import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/stake_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'action.dart';
import 'state.dart';

Effect<ListUnstakeState> buildEffect() {
  return combineEffects(<Object, Effect<ListUnstakeState>>{
    Lifecycle.initState: _initState,
  });
}

StakeDao _buildStakeDao(Context<ListUnstakeState> ctx) {
  return ctx.state.isDemo ? DemoStakeDao() : StakeDao();
}

void _initState(Action action, Context<ListUnstakeState> ctx) async {
  await loadStakes(ctx);
}

Future<void> loadStakes(Context<ListUnstakeState> ctx) async {
  final dao = _buildStakeDao(ctx);
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  final activeStakesRes = await dao.activestakes({
    "orgId": orgId,
  });
  final now = DateTime.now();
  final activeStakes = (activeStakesRes['actStake'] as List)
      .map((e) => Stake.fromMap(e))
      .where((e) =>
          e.endTime == null && (e.lockTill == null || e.lockTill.isBefore(now)))
      .toList();
  ctx.dispatch(ListUnstakeActionCreator.setStakes(activeStakes));
}
