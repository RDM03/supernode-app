import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'action.dart';
import 'state.dart';

Effect<ListUnstakeState> buildEffect() {
  return combineEffects(<Object, Effect<ListUnstakeState>>{
    Lifecycle.initState: _initState,
  });
}

StakeDao _buildStakeDao(Context<ListUnstakeState> ctx) {
  return ctx.context.read<SupernodeRepository>().stake;
}

void _initState(Action action, Context<ListUnstakeState> ctx) async {
  await loadStakes(ctx);
}

Future<void> loadStakes(Context<ListUnstakeState> ctx) async {
  final dao = _buildStakeDao(ctx);
  final orgId = ctx.context.read<SupernodeCubit>().state.orgId;
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
