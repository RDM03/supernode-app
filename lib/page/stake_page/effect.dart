import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/page/stake_page/action.dart';
import 'state.dart';

Effect<StakeState> buildEffect() {
  return combineEffects(<Object, Effect<StakeState>>{
    Lifecycle.initState: _initState,
  });
}

StakeDao _buildStakeDao(Context<StakeState> ctx) {
  return ctx.context.read<SupernodeRepository>().stake;
}

void _initState(Action action, Context<StakeState> ctx) async {
  await loadRates(ctx);
}

Future<void> loadRates(Context<StakeState> ctx) async {
  final dao = _buildStakeDao(ctx);
  final res = await dao.stakingPercentage();
  Map<String, double> rates = {};
  for (final r in res['lockBoosts']) {
    rates[r['lockPeriods']] = double.parse(r['boost']);
  }
  ctx.dispatch(StakeActionCreator.setRates(
    rate6Months: rates['6'] + 1,
    rate9Months: rates['9'] + 1,
    rate12Months: rates['12'] + 1,
    rate24Months: rates['24'] + 1,
    rateFlex: res['stakingInterest'] + 1,
  ));
}
