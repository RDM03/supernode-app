import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/dhx.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/tools.dart';

import 'action.dart';
import 'state.dart';

Effect<PrepareLockState> buildEffect() {
  return combineEffects(<Object, Effect<PrepareLockState>>{
    Lifecycle.initState: _onInitState,
    PrepareLockAction.onConfirm: _onConfirm,
    PrepareLockAction.process: _process,
  });
}

WalletDao _buildWalletDao(Context<PrepareLockState> ctx) =>
    ctx.context.read<SupernodeRepository>().wallet;

GatewaysDao _buildGatewaysDao(Context<PrepareLockState> ctx) =>
    ctx.context.read<SupernodeRepository>().gateways;

DhxDao _buildDhxDao(Context<PrepareLockState> ctx) =>
    ctx.context.read<SupernodeRepository>().dhx;

void _onInitState(Action action, Context<PrepareLockState> ctx) async {
  await _minersOwned(ctx);
  await _balance(ctx);
  await _lastMining(ctx);
}

void _resultPage(Context<PrepareLockState> ctx, String type, dynamic res) {
  if (res.containsKey('status')) {
    Navigator.pushNamed(ctx.context, 'confirm_page',
        arguments: {'title': type, 'content': res['status']});

    ctx.dispatch(PrepareLockActionCreator.resSuccess(
        res['status'].contains('successful')));
  } else {
    tip(ctx.context, res);
  }
}

Future<void> _stake(Context<PrepareLockState> ctx) async {
  var curState = ctx.state;
  final loading = Loading.show(ctx.context);

  String orgId = ctx.context.read<SupernodeCubit>().state.orgId;
  String amount = curState.amountCtl.text;

  final dao = null;
  Map data = {
    "orgId": orgId,
    "amount": amount,
    if (ctx.state.months != null) "boost": ctx.state.boostRate.toString(),
    if (ctx.state.months != null) "lockPeriods": ctx.state.months.toString(),
  };

  await dao.stake(data).then((res) async {
    loading.hide();
    mLog('stake', res);
    _resultPage(ctx, 'stake', res);
  }).catchError((err) {
    loading.hide();
    tip(ctx.context, 'LockDao stake: $err');
  });
}

void _onConfirm(Action action, Context<PrepareLockState> ctx) async {
  final formValid = ctx.state.formKey.currentState.validate();
  final estimateDhx = calculateDhxDaily(
    dhxBonded: ctx.state.lastMiningDhx,
    minersCount: ctx.state.minersOwned,
    months: ctx.state.months,
    mxcLocked: double.tryParse(ctx.state.amountCtl.text),
    yesterdayMining: ctx.state.lastMiningMPower,
  );
  if (!formValid) return;
  if (estimateDhx == null) return;

  final res = await Navigator.of(ctx.context)
      .pushNamed('join_council_page', arguments: {
    'amount': ctx.state.amountCtl.text,
    'boostRate': ctx.state.boostRate,
    'months': ctx.state.months,
    'minersOwned': ctx.state.minersOwned,
    'isDemo': ctx.state.isDemo,
    'avgDailyDhxRevenue': estimateDhx,
  });

  _balance(ctx);

  if (res == true)
    Navigator.of(ctx.context).pop(true);
  else {
    ctx.dispatch(PrepareLockActionCreator.process());
  }
}

void _process(Action action, Context<PrepareLockState> ctx) async {
  await _stake(ctx);
}

Future<void> _minersOwned(Context<PrepareLockState> ctx) async {
  final dao = _buildGatewaysDao(ctx);
  Map data = {
    "organizationID": ctx.context.read<SupernodeCubit>().state.orgId,
    "offset": 0,
    "limit": 1,
  };
  final res = await dao.list(data);
  int total = int.parse(res['totalCount']);
  ctx.dispatch(PrepareLockActionCreator.minersOwned(total));
}

Future<void> _balance(Context<PrepareLockState> ctx) async {
  WalletDao dao = _buildWalletDao(ctx);
  Map data = {
    'userId': ctx.context.read<SupernodeCubit>().state.session.userId,
    'orgId': ctx.context.read<SupernodeCubit>().state.orgId,
    'currency': ''
  };

  var res = await dao.balance(data);
  double balance = Tools.convertDouble(res['balance']);

  ctx.dispatch(PrepareLockActionCreator.balance(balance));
}

Future<void> _lastMining(Context<PrepareLockState> ctx) async {
  final dao = _buildDhxDao(ctx);
  final res = await dao.lastMining();
  ctx.dispatch(PrepareLockActionCreator.lastMining(
      double.parse(res.dhxAmount), double.parse(res.miningPower)));
}
