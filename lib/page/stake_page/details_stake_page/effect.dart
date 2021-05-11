import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/log.dart';
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

StakeDao _buildStakeDao(Context<DetailsStakeState> ctx) {
  return ctx.context.read<SupernodeRepository>().stake;
}

UserDao _buildUserDao(Context<DetailsStakeState> ctx) {
  return ctx.context.read<SupernodeRepository>().user;
}

void _onUnstake(Action action, Context<DetailsStakeState> ctx) async {
  final authenticated = await Biometrics.authenticateAsync(ctx.context);
  if (!authenticated) return;

  ctx.dispatch(DetailsStakeActionCreator.unstakeProcess());
}

Future<void> _unstake(Context<DetailsStakeState> ctx, String otpCode) async {
  var curState = ctx.state;
  final loading = Loading.show(ctx.context);

  final orgId = ctx.context.read<SupernodeCubit>().state.orgId;

  StakeDao dao = _buildStakeDao(ctx);
  Map data = {
    "orgId": orgId,
    "stakeId": curState.stake.id,
    "otp_code": otpCode,
  };

  try {
    final res = await dao.unstake(data);
    loading.hide();
    if (res.containsKey('status')) {
      await Navigator.pushNamed(ctx.context, 'confirm_page', arguments: {
        'title': FlutterI18n.translate(ctx.context, 'unstake'),
        'content': res['status']
      });
      Navigator.of(ctx.context).pop(true);
    } else {
      tip(res);
    }
  } catch (err) {
    loading.hide();
    tip('StakeDao unstake: $err');
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
        arguments: {'isEnabled': null});
    ctx.dispatch(DetailsStakeActionCreator.refreshOtpStatus());
  }
}

void _refreshOtpStatus(Action action, Context<DetailsStakeState> ctx) async {
  UserDao dao = _buildUserDao(ctx);

  Map data = {};

  dao.getTOTPStatus().then((res) {
    mLog('totp', res);
    ctx.dispatch(DetailsStakeActionCreator.setOtpEnabled(res.enabled));
  }).catchError((err) {
    tip('$err');
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
