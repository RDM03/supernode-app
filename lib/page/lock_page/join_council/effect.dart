import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/daos/dhx_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/lock_page/join_council/action.dart';
import 'package:supernodeapp/page/lock_page/join_council/view.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'state.dart';

Effect<JoinCouncilState> buildEffect() {
  return combineEffects(<Object, Effect<JoinCouncilState>>{
    Lifecycle.initState: _onInitState,
    JoinCouncilAction.process: _onInitState,
    JoinCouncilAction.becomeCouncilChair: _onBecomeCouncilChair,
    JoinCouncilAction.onConfirm: _onConfirm,
  });
}

DhxDao _buildDhxDao(Context<JoinCouncilState> ctx) =>
    ctx.state.isDemo ? DhxDao() : DhxDao();

void _onInitState(Action action, Context<JoinCouncilState> ctx) {
  _listCouncils(ctx);
}

Future<void> _listCouncils(Context<JoinCouncilState> ctx) async {
  DhxDao dao = _buildDhxDao(ctx);
  var res = await dao.listCouncils();
  ctx.dispatch(JoinCouncilActionCreator.councils(res));
  if (councilChairMeets(ctx.state)) {
    ctx.dispatch(JoinCouncilActionCreator.becomeCouncilChair());
  } else {
    if (res.isEmpty) showNoCouncilsDialog(ctx.state.scaffoldKey?.currentState);
  }
  print(res);
}

bool councilChairMeets(JoinCouncilState state) {
  final doubleAmount = double.parse(state.amount);
  final months = state.months;
  final minersCount = state.minersOwned;
  return !(doubleAmount < 5000000 || months < 12 || minersCount < 5);
}

void _onBecomeCouncilChair(Action action, Context<JoinCouncilState> ctx) async {
  if (!councilChairMeets(ctx.state)) {
    showDoesntMeetRequirmentsDialog(ctx.state.scaffoldKey?.currentState);
  } else {
    SettingsState settingsData = GlobalStore.store.getState().settings;

    final become =
        await showBecomeCouncilChairDialog(ctx.state.scaffoldKey?.currentState);
    if (become)
      moveNext(
        ctx,
        Council(
          name: settingsData.username,
          chairOrgId: settingsData.selectedOrganizationId,
        ),
      );
  }
}

void _onConfirm(Action action, Context<JoinCouncilState> ctx) async {
  moveNext(
    ctx,
    action.payload,
  );
}

Future<void> moveNext(Context<JoinCouncilState> ctx, Council council) async {
  await Navigator.of(ctx.context).pushNamed('confirm_lock_page', arguments: {
    'amount': ctx.state.amount,
    'boostRate': ctx.state.boostRate,
    'months': ctx.state.months,
    'minersOwned': ctx.state.minersOwned,
    'council': council,
  });
  ctx.dispatch(JoinCouncilActionCreator.process());
}
