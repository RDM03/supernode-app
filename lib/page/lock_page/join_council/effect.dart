import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/page/lock_page/join_council/action.dart';
import 'package:supernodeapp/page/lock_page/join_council/view.dart';
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
    ctx.context.read<SupernodeRepository>().dhx;

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
    final become =
        await showBecomeCouncilChairDialog(ctx.state.scaffoldKey?.currentState);
    if (become)
      moveNext(
        ctx,
        Council(
          name: ctx.context.read<SupernodeCubit>().state.session.username,
          chairOrgId: ctx.context.read<SupernodeCubit>().state.orgId,
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
  final res = await Navigator.of(ctx.context)
      .pushNamed('confirm_lock_page', arguments: {
    'amount': ctx.state.amount,
    'boostRate': ctx.state.boostRate,
    'months': ctx.state.months,
    'minersOwned': ctx.state.minersOwned,
    'council': council,
    'isDemo': ctx.state.isDemo,
    'avgDailyDhxRevenue': ctx.state.avgDailyDhxRevenue,
  });
  if (res == true)
    Navigator.of(ctx.context).pop(true);
  else {
    ctx.dispatch(JoinCouncilActionCreator.process());
  }
}
