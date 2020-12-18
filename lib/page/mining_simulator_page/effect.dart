import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/daos/demo/dhx_demo.dart';
import 'package:supernodeapp/common/daos/demo/gateways_dao.dart';
import 'package:supernodeapp/common/daos/demo/wallet_dao.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

import 'action.dart';
import 'state.dart';

Effect<MiningSimulatorState> buildEffect() {
  return combineEffects(<Object, Effect<MiningSimulatorState>>{
    Lifecycle.initState: _onInitState,
  });
}

WalletDao _buildWalletDao(Context<MiningSimulatorState> ctx) {
  return ctx.state.isDemo ? DemoWalletDao() : WalletDao();
}

DhxDao _buildDhxDao(Context<MiningSimulatorState> ctx) {
  return ctx.state.isDemo ? DemoDhxDao() : DhxDao();
}

GatewaysDao _buildGatewaysDao(Context<MiningSimulatorState> ctx) =>
    ctx.state.isDemo ? DemoGatewaysDao() : GatewaysDao();

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
  SettingsState settingsData = GlobalStore.store.getState().settings;
  Map data = {
    "organizationID": settingsData.selectedOrganizationId,
    "offset": 0,
    "limit": 1,
  };
  final res = await dao.list(data);
  int total = int.parse(res['totalCount']);
  ctx.dispatch(MiningSimulatorActionCreator.minersTotal(total));
}

Future<void> _balance(Context<MiningSimulatorState> ctx) async {
  SettingsState settingsData = GlobalStore.store.getState().settings;
  WalletDao dao = _buildWalletDao(ctx);
  Map data = {
    'userId': settingsData.userId,
    'orgId': settingsData.selectedOrganizationId,
    'currency': ''
  };

  var res = await dao.balance(data);
  double balance = Tools.convertDouble(res['balance']);

  ctx.dispatch(MiningSimulatorActionCreator.mxcTotal(balance));
}
