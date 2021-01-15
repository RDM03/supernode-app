import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/tools.dart';

import 'action.dart';
import 'state.dart';

Effect<MiningSimulatorState> buildEffect() {
  return combineEffects(<Object, Effect<MiningSimulatorState>>{
    Lifecycle.initState: _onInitState,
  });
}

WalletDao _buildWalletDao(Context<MiningSimulatorState> ctx) {
  return ctx.context.read<SupernodeRepository>().wallet;
}

DhxDao _buildDhxDao(Context<MiningSimulatorState> ctx) {
  return ctx.context.read<SupernodeRepository>().dhx;
}

GatewaysDao _buildGatewaysDao(Context<MiningSimulatorState> ctx) =>
    ctx.context.read<SupernodeRepository>().gateways;

void _onInitState(Action action, Context<MiningSimulatorState> ctx) async {
  await _lastMining(ctx);
  await _minersOwned(ctx);
  await _balance(ctx);
}

Future<void> _lastMining(Context<MiningSimulatorState> ctx) async {
  final dao = _buildDhxDao(ctx);
  final res = await dao.lastMining();
  ctx.dispatch(MiningSimulatorActionCreator.lastMining(
      double.parse(res.dhxAmount), double.parse(res.miningPower)));
}

Future<void> _minersOwned(Context<MiningSimulatorState> ctx) async {
  final dao = _buildGatewaysDao(ctx);
  Map data = {
    "organizationID": ctx.context.read<SupernodeCubit>().state.orgId,
    "offset": 0,
    "limit": 1,
  };
  final res = await dao.list(data);
  int total = int.parse(res['totalCount']);
  ctx.dispatch(MiningSimulatorActionCreator.minersTotal(total));
}

Future<void> _balance(Context<MiningSimulatorState> ctx) async {
  WalletDao dao = _buildWalletDao(ctx);
  Map data = {
    'userId': ctx.context.read<SupernodeCubit>().state.session.userId,
    'orgId': ctx.context.read<SupernodeCubit>().state.orgId,
    'currency': ''
  };

  var res = await dao.balance(data);
  double balance = Tools.convertDouble(res['balance']);

  ctx.dispatch(MiningSimulatorActionCreator.mxcTotal(balance));
}
