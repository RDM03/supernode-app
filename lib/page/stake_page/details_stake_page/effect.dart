import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/stake_page/details_stake_page/action.dart';
import 'state.dart';

Effect<DetailsStakeState> buildEffect() {
  return combineEffects(<Object, Effect<DetailsStakeState>>{
    Lifecycle.initState: _refreshOtpStatus,
    DetailsStakeAction.refreshOtpStatus: _refreshOtpStatus,
    DetailsStakeAction.unstake: _onUnstake,
    DetailsStakeAction.unstakeProcess: _process,
  });
}

void _onUnstake(Action action, Context<DetailsStakeState> ctx) async {
  final authenticated = await Biometrics.authenticateAsync(ctx.context);
  if (!authenticated) return;

  ctx.dispatch(DetailsStakeActionCreator.unstakeProcess());
}

Future<void> _unstake(Context<DetailsStakeState> ctx, String otpCode) async {
  var curState = ctx.state;
  final loading = await Loading.show(ctx.context);

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  StakeDao dao = StakeDao();
  Map data = {
    "orgId": orgId,
    "stakeId": curState.stake.id,
    "otp_code": otpCode,
  };

  try {
    final res = await dao.unstake(data);
    if (res.containsKey('status')) {
      await Navigator.pushNamed(ctx.context, 'confirm_page', arguments: {
        'title': FlutterI18n.translate(ctx.context, 'unstake'),
        'content': res['status']
      });
      Navigator.of(ctx.context).pop(true);
      Navigator.of(ctx.context).pop(true);
    } else {
      tip(ctx.context, res);
    }
  } catch (err) {
    loading.hide();
    tip(ctx.context, 'StakeDao unstake: $err');
  }
}

Future<void> _raise2Fa(Context<DetailsStakeState> ctx) async {
  if (ctx.state.otpEnabled) {
    final String otpCode =
        await Navigator.of(ctx.context).pushNamed<dynamic>('get_2fa_page');
    if (otpCode == null) return;
    ctx.dispatch(DetailsStakeActionCreator.unstakeProcess(otpCode));
  } else {
    await Navigator.pushNamed(ctx.context, 'set_2fa_page',
        arguments: {'isEnabled': GlobalStore.state?.settings?.is2FAEnabled});
    ctx.dispatch(DetailsStakeActionCreator.refreshOtpStatus());
  }
}

void _refreshOtpStatus(Action action, Context<DetailsStakeState> ctx) async {
  UserDao dao = UserDao();

  dao.getTOTPStatus().then((res) {
    mLog('totp', res);

    if (res.enabled != null) {
      ctx.dispatch(DetailsStakeActionCreator.setOtpEnabled(res.enabled));
    }
  }).catchError((err) {
    tip(ctx.context, '$err');
  });
}

void _process(Action action, Context<DetailsStakeState> ctx) async {
  final String code = action.payload;

  if (code == null) {
    await _raise2Fa(ctx);
    return;
  }

  await _unstake(ctx, code);
}
