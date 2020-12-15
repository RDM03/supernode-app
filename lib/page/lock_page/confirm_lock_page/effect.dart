import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/demo/dhx_dao.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';
import 'state.dart';

Effect<ConfirmLockState> buildEffect() {
  return combineEffects(<Object, Effect<ConfirmLockState>>{
    ConfirmLockAction.onConfirm: _onConfirm,
  });
}

DhxDao _buildDhxDao(Context<ConfirmLockState> ctx) =>
    ctx.state.isDemo ? DemoDhxDao() : DhxDao();

void _onConfirm(Action action, Context<ConfirmLockState> ctx) async {
  final council = ctx.state.council;
  final dao = _buildDhxDao(ctx);
  String stakeId;
  try {
    if (council.id != null) {
      final res = await dao.createCouncil(
        amount: ctx.state.amount,
        boost: ctx.state.boostRate.toString(),
        lockMonths: ctx.state.months.toString(),
        name: council.name,
        organizationId: council.chairOrgId,
      );
      stakeId = res.stakeId;
      ctx.dispatch(ConfirmLockActionCreator.setCouncil(
          ctx.state.council.copyWith(id: res.councilId)));
    } else {
      SettingsState settingsData = GlobalStore.store.getState().settings;

      final res = await dao.createStake(
        amount: ctx.state.amount,
        boost: ctx.state.boostRate.toString(),
        councilId: council.id,
        lockMonths: ctx.state.months.toString(),
        organizationId: settingsData.selectedOrganizationId,
      );
      stakeId = res;
    }

    if (stakeId != null) {
      Navigator.of(ctx.context).pushNamed('result_lock_page',
          arguments: {'isDemo': true, 'stakeId': stakeId});
    }
  } on DaoException catch (e) {
    tip(ctx.context, FlutterI18n.translate(ctx.context, e.message),
        duration: 5);
    print(e);
  }
}
