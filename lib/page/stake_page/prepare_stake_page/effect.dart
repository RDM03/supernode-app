import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/tools.dart';

import 'action.dart';
import 'state.dart';

Effect<PrepareStakeState> buildEffect() {
  return combineEffects(<Object, Effect<PrepareStakeState>>{
    PrepareStakeAction.onConfirm: _onConfirm,
    PrepareStakeAction.process: _process,
  });
}

StakeDao _buildStakeDao(Context<PrepareStakeState> ctx) {
  return ctx.context.read<SupernodeRepository>().stake;
}

WalletDao _buildWalletDao(Context<PrepareStakeState> ctx) {
  return ctx.context.read<SupernodeRepository>().wallet;
}

void _resultPage(Context<PrepareStakeState> ctx, String type, dynamic res) {
  if (res.containsKey('status')) {
    Navigator.pushNamed(ctx.context, 'confirm_page',
        arguments: {'title': type, 'content': res['status']});

    ctx.dispatch(PrepareStakeActionCreator.resSuccess(
        res['status'].contains('successful')));
  } else {
    tip(res);
  }
}

Future<void> _stake(Context<PrepareStakeState> ctx) async {
  var curState = ctx.state;
  final loading = Loading.show(ctx.context);

  String orgId = ctx.context.read<SupernodeCubit>().state.orgId;
  String amount = curState.amountCtl.text;

  StakeDao dao = _buildStakeDao(ctx);
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
    tip('StakeDao stake: $err');
  });
}

void _onConfirm(Action action, Context<PrepareStakeState> ctx) async {
  final formValid = ctx.state.formKey.currentState.validate();
  if (!formValid) return;

  final curDate = DateTime.now();
  final endDate = ctx.state.endDate;

  final val = await Navigator.of(ctx.context)
      .pushNamed('confirm_stake_page', arguments: {
    'endDate': endDate,
    'amount': ctx.state.amountCtl.text,
  });

  _balance(ctx);

  if (val ?? false) {
    ctx.dispatch(PrepareStakeActionCreator.process());
  }
}

void _process(Action action, Context<PrepareStakeState> ctx) async {
  await _stake(ctx);
}

Future<void> _balance(Context<PrepareStakeState> ctx) async {
  final settingsData = ctx.context.read<SupernodeCubit>().state;

  try {
    WalletDao dao = _buildWalletDao(ctx);
    Map data = {
      'userId': settingsData.session.userId,
      'orgId': settingsData.orgId,
      'currency': ''
    };

    var res = await dao.balance(data);
    mLog('balance', res);
    double balance = Tools.convertDouble(res['balance']);

    ctx.dispatch(PrepareStakeActionCreator.balance(balance));
  } catch (err) {}
}
