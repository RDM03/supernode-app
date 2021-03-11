import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/log.dart';

import 'action.dart';
import 'state.dart';

Effect<DepositState> buildEffect() {
  return combineEffects(<Object, Effect<DepositState>>{
    Lifecycle.initState: _initState,
    DepositAction.copy: _copy,
  });
}

_buildTopupDao(Context<DepositState> ctx) {
  return ctx.context.read<SupernodeRepository>().topup;
}

void _initState(Action action, Context<DepositState> ctx) async {
  String orgId = ctx.context.read<SupernodeCubit>().state.orgId;
  if (orgId == null || orgId.isEmpty) {
    orgId = ctx.state.orgId;
  }

  Future.delayed(Duration(seconds: 3), () async {
    try {
      TopupDao dao = _buildTopupDao(ctx);
      Map data = {
        "orgId": orgId,
        "currency": '',
      };

      TopupAccount res = await dao.account(data);
      mLog('account', res);

      if ((res as Map).containsKey('activeAccount')) {
        ctx.dispatch(DepositActionCreator.address(res.activeAccount));
      }
    } catch (err) {
      tip(ctx.context, 'TopupDao account: $err');
    }
  });
}

void _copy(Action action, Context<DepositState> ctx) {
  var curState = ctx.state;

  Clipboard.setData(ClipboardData(text: curState.address));

  tip(ctx.context, FlutterI18n.translate(ctx.context, 'has_copied'),
      success: true);
}
