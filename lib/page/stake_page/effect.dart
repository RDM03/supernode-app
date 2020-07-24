import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/stake_dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<StakeState> buildEffect() {
  return combineEffects(<Object, Effect<StakeState>>{
    StakeAction.onConfirm: _onConfirm,
    StakeAction.refreshOtpStatus: _refreshOtpStatus,
    StakeAction.process: _process,
    Lifecycle.initState: _refreshOtpStatus,
  });
}

void _resultPage(Context<StakeState> ctx, String type, dynamic res) {
  if (res.containsKey('status')) {
    Navigator.pushNamed(ctx.context, 'confirm_page', arguments: {'title': type, 'content': res['status']});

    ctx.dispatch(StakeActionCreator.resSuccess(res['status'].contains('successful')));
  } else {
    tip(ctx.context, res);
  }
}

Future<void> _stake(Context<StakeState> ctx) async {
  var curState = ctx.state;
  showLoading(ctx.context);

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  double amount = double.parse(curState.amountCtl.text);

  StakeDao dao = StakeDao();
  Map data = {"orgId": orgId, "amount": amount};

  await dao.stake(data).then((res) async {
    hideLoading(ctx.context);
    mLog(curState.type, res);
    _resultPage(ctx, 'stake', res);
  }).catchError((err) {
    hideLoading(ctx.context);
    tip(ctx.context, 'StakeDao stake: $err');
  });
}

Future<void> _unstake(Context<StakeState> ctx, String otpCode) async {
  var curState = ctx.state;
  showLoading(ctx.context);

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  double amount = double.parse(curState.amountCtl.text);

  StakeDao dao = StakeDao();
  Map data = {
    "orgId": orgId,
    "amount": amount,
    "otp_code": otpCode,
  };

  await dao.unstake(data).then((res) async {
    hideLoading(ctx.context);
    mLog(curState.type, res);
    _resultPage(ctx, 'unstake', res);
  }).catchError((err) {
    hideLoading(ctx.context);
    tip(ctx.context, 'StakeDao unstake: $err');
  });
}

Future<void> _raise2Fa(Context<StakeState> ctx) async {
  if (ctx.state.otpEnabled) {
    final String otpCode = await Navigator.of(ctx.context).pushNamed<dynamic>('get_2fa_page');
    if (otpCode == null) return;
    ctx.dispatch(StakeActionCreator.process(otpCode));
  } else {
    await Navigator.pushNamed(ctx.context, 'set_2fa_page', arguments: {'isEnabled': false});
    ctx.dispatch(StakeActionCreator.refreshOtpStatus());
  }
}

void _refreshOtpStatus(Action action, Context<StakeState> ctx) async {
  UserDao dao = UserDao();

  Map data = {};

  dao.getTOTPStatus(data).then((res) {
    mLog('totp', res);

    if ((res as Map).containsKey('enabled')) {
      ctx.dispatch(StakeActionCreator.setOtpEnabled(res['enabled']));
    }
  }).catchError((err) {
    tip(ctx.context, '$err');
  });
}

void _onConfirm(Action action, Context<StakeState> ctx) async {
  final formValid = ctx.state.formKey.currentState.validate();
  if (!formValid) return;

  final authenticated = await Biometrics.authenticateAsync(ctx.context);
  if (!authenticated) return;

  ctx.dispatch(StakeActionCreator.process());
}

void _process(Action action, Context<StakeState> ctx) async {
  if (ctx.state.type == 'stake') {
    await _stake(ctx);
  } else {
    final String code = action.payload;

    if (code == null) {
      await _raise2Fa(ctx);
      return;
    }

    await _unstake(ctx, code);
  }
}
