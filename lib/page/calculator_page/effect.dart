import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/daos/coingecko_dao.dart';
import 'package:supernodeapp/common/daos/demo/wallet_dao.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/calculator_page/action.dart';
import 'state.dart';

Effect<CalculatorState> buildEffect() {
  return combineEffects(<Object, Effect<CalculatorState>>{
    Lifecycle.initState: _initState,
    CalculatorAction.list: _list,
  });
}

WalletDao _buildWalletDao(Context<CalculatorState> ctx) {
  return GlobalStore.state.settings.isDemo ? DemoWalletDao() : WalletDao();
}

Future<void> _list(Action action, Context<CalculatorState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('calculator_list_page');
  ctx.dispatch(CalculatorActionCreator.setSelectedCurrencies(
      StorageManager.selectedCurrencies()));
}

Future<void> _initState(Action action, Context<CalculatorState> ctx) async {
  await _refreshMxcPrice(ctx);
  await _refreshRates(ctx);
}

Future<void> _refreshMxcPrice(Context<CalculatorState> ctx) async {
  final walletDao = _buildWalletDao(ctx);

  final settingsData = GlobalStore.store.getState().settings;
  final userId = settingsData.userId;
  final orgId = settingsData.selectedOrganizationId;
  Map data = {
    'userId': userId,
    'orgId': orgId,
    'currency': '',
    'mxcPrice': '1'
  };
  final response = await walletDao.convertUSD(data);
  final mxcPrice = response['mxcPrice'];
  ctx.dispatch(CalculatorActionCreator.setMxcPrice(mxcPrice));
}

Future<void> _refreshRates(Context<CalculatorState> ctx) async {
  final dao = CoingeckoDao();
  final rates = await dao.exchangeRates();
  ctx.dispatch(CalculatorActionCreator.setRates(rates));
}
