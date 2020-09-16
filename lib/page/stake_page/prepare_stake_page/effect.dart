import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/demo/stake_dao.dart';
import 'package:supernodeapp/common/daos/stake_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<PrepareStakeState> buildEffect() {
  return combineEffects(<Object, Effect<PrepareStakeState>>{
    PrepareStakeAction.onConfirm: _onConfirm,
    PrepareStakeAction.process: _process,
  });
}

StakeDao _buildStakeDao(Context<PrepareStakeState> ctx) {
  return ctx.state.isDemo ? DemoStakeDao() : StakeDao();
}

void _resultPage(Context<PrepareStakeState> ctx, String type, dynamic res) {
  if (res.containsKey('status')) {
    Navigator.pushNamed(ctx.context, 'confirm_page',
        arguments: {'title': type, 'content': res['status']});

    ctx.dispatch(PrepareStakeActionCreator.resSuccess(
        res['status'].contains('successful')));
  } else {
    tip(ctx.context, res);
  }
}

Future<void> _stake(Context<PrepareStakeState> ctx) async {
  var curState = ctx.state;
  final loading = await Loading.show(ctx.context);

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
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
    tip(ctx.context, 'StakeDao stake: $err');
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

  if (val ?? false) {
    ctx.dispatch(PrepareStakeActionCreator.process());
  }
}

void _process(Action action, Context<PrepareStakeState> ctx) async {
  await _stake(ctx);
}
