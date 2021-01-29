import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/demo/stake_dao.dart';
import 'package:supernodeapp/common/daos/demo/topup_dao.dart';
import 'package:supernodeapp/common/daos/demo/withdraw_dao.dart';
import 'package:supernodeapp/common/daos/stake_dao.dart';
import 'package:supernodeapp/common/daos/topup_dao.dart';
import 'package:supernodeapp/common/daos/withdraw_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'action.dart';
import 'state.dart';

Effect<WalletState> buildEffect() {
  return combineEffects(<Object, Effect<WalletState>>{
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
    WalletAction.onTab: _onTab,
    WalletAction.onFilter: _onFilter,
    WalletAction.onHistoryBtc: _onHistoryBtc,
    WalletAction.onStake: _onStake,
    WalletAction.onUnstake: _onUnstake,
    WalletAction.onStakeDetails: _onStakeDetails,
  });
}

StakeDao _buildStakeDao(Context<WalletState> ctx) {
  return ctx.state.isDemo ? DemoStakeDao() : StakeDao();
}

WithdrawDao _buildWithdrawDao(Context<WalletState> ctx) {
  return ctx.state.isDemo ? DemoWithdrawDao() : WithdrawDao();
}

TopupDao _buildTopupDao(Context<WalletState> ctx) {
  return ctx.state.isDemo ? DemoTopupDao() : TopupDao();
}

void _initState(Action action, Context<WalletState> ctx) {
  if (!ctx.state.isFirstRequest) return;

  ctx.dispatch(WalletActionCreator.onFilter('SEARCH DEFUALT'));
  if (ctx.state.displayTokens.contains(Token.btc))
    ctx.dispatch(WalletActionCreator.onFilterBtc());
}

void _dispose(Action action, Context<WalletState> ctx) {
  // ctx.dispatch(WalletActionCreator.tab(0));
}

void _onTab(Action action, Context<WalletState> ctx) {
  int index = action.payload;
  ctx.dispatch(WalletActionCreator.tab(index));

  if (ctx.state.itemCount == 0) {
    //list not initialised
    String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
    if (orgId.isEmpty) return;
    if (ctx.state.selectedToken == Token.supernodeDhx) return;

    Map data = {
      'orgId': orgId,
      'offset': 0,
      'limit': 999,
      'from': ctx.state.isSetDate1 || ctx.state.isSetDate2
          ? DateTime.parse(ctx.state.firstTime).toUtc().toIso8601String()
          : DateTime(2000).toUtc().toIso8601String(),
      'till': ctx.state.isSetDate1 || ctx.state.isSetDate2
          ? DateTime.parse(ctx.state.secondTime).toUtc().toIso8601String()
          : DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String(),
    };

    _search(ctx, 'SEARCH DEFUALT', data);
  }
}

void _onFilter(Action action, Context<WalletState> ctx) async {
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  String type = action.payload;

  if (orgId.isEmpty) return;

  Map data = {
    'orgId': orgId,
    'offset': 0,
    'limit': 999,
    'from': type == 'SEARCH' && (ctx.state.isSetDate1 || ctx.state.isSetDate2)
        ? DateTime.parse(ctx.state.firstTime).toUtc().toIso8601String()
        : DateTime(2000).toUtc().toIso8601String(),
    'till': type == 'SEARCH' && (ctx.state.isSetDate1 || ctx.state.isSetDate2)
        ? DateTime.parse(ctx.state.secondTime).toUtc().toIso8601String()
        : DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String(),
    'currency': '',
  };

  _withdrawFee(ctx);

  switch (type) {
    case 'DEPOSIT':
      if (!type.contains('DEFAULT') && !type.contains('DATETIME')) {
        ctx.dispatch(WalletActionCreator.updateSelectedButton(0));
      }
      TopupDao dao = _buildTopupDao(ctx);
      final list = await _getHistory(ctx, dao, data, type, ['topupHistory']);
      ctx.dispatch(WalletActionCreator.updateWalletList(type, list));
      break;
    case 'WITHDRAW':
      if (!type.contains('DEFAULT') && !type.contains('DATETIME')) {
        ctx.dispatch(WalletActionCreator.updateSelectedButton(1));
      }
      WithdrawDao dao = _buildWithdrawDao(ctx);
      final list = await _getHistory(ctx, dao, data, type, ['withdrawHistory']);
      ctx.dispatch(WalletActionCreator.updateWalletList(type, list));
      break;
    case 'STAKE':
      _search(ctx, type, data, index: 0);
      break;
    case 'UNSTAKE':
      _search(ctx, type, data, index: 1);
      break;
    case 'STAKEUNSTAKE':
      _search(ctx, type, data, index: 2);
      break;
    default:
      _search(ctx, type, data, index: 2);
  }
}

void _onHistoryBtc(Action action, Context<WalletState> ctx) async {
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  if (orgId.isEmpty) return;

  Map data = {
    'orgId': orgId,
    'offset': 0,
    'limit': 999,
    'from': DateTime(2000).toUtc().toIso8601String(),
    'till': DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String(),
    'currency': 'BTC',
  };

  WithdrawDao dao = _buildWithdrawDao(ctx);
  try {
    var res = await dao.history(data);
    mLog('btc history', res);

    final list = [];
    if ((res as Map).containsKey('withdrawHistory')) {
      list.addAll(res['withdrawHistory'] as List);
    }

    ctx.dispatch(WalletActionCreator.updateBtcList(list));
  } catch (err) {
    tip(ctx.context,'btc history: $err');
  }
}

void _search(Context<WalletState> ctx, String type, Map data,
    {int index = -1}) async {
  ctx.dispatch(WalletActionCreator.saveLastSearch(data, type));
  if (type == 'STAKE' || type == 'UNSTAKE') {
    ctx.dispatch(WalletActionCreator.updateSelectedButton(index));

    StakeDao dao = _buildStakeDao(ctx);
    final list = await _getHistory(ctx, dao, data, type, ['stakingHist']);
    ctx.dispatch(WalletActionCreator.updateStakeList(type, list));
    return;
  }

  if (ctx.state.activeTabToken[ctx.state.selectedToken] == 1) {
    StakeDao dao = _buildStakeDao(ctx);
    final list = await _getHistory(ctx, dao, data, type, ['stakingHist']);
    ctx.dispatch(WalletActionCreator.updateStakeList(type, list));
    return;
  }

  // WalletDao dao = WalletDao();
  // _requestHistory(ctx,dao,data,type,'txHistory');
  if (type == 'SEARCH DEFUALT') {
    final list = [
      ...await _getHistory(ctx, _buildTopupDao(ctx), data, type,
          ['topupHistory', 'withdrawHistory']),
      ...await _getHistory(ctx, _buildWithdrawDao(ctx), data, type,
          ['topupHistory', 'withdrawHistory']),
    ];
    ctx.dispatch(WalletActionCreator.updateWalletList(type, list));
  }

  if (type == 'SEARCH') {
    final list = [
      ...await _getHistory(ctx, _buildTopupDao(ctx), data, type,
          ['topupHistory', 'withdrawHistory']),
      ...await _getHistory(ctx, _buildWithdrawDao(ctx), data, type,
          ['topupHistory', 'withdrawHistory']),
    ];
    ctx.dispatch(WalletActionCreator.updateWalletList(type, list));
  }
}

void _withdrawFee(Context<WalletState> ctx) {
  WithdrawDao dao = _buildWithdrawDao(ctx);
  dao.fee().then((res) {
    mLog('WithdrawDao fee', res);

    if ((res as Map).containsKey('withdrawFee')) {
      ctx.dispatch(WalletActionCreator.withdrawFee(
          Tools.convertDouble(res['withdrawFee'])));
    }
  }).catchError((err) {
    // tip(ctx.context,'WithdrawDao fee: $err');
  });
}

void _staking(Context<WalletState> ctx, String type, Map data) {
  ctx.dispatch(WalletActionCreator.updateSelectedButton(0));

  StakeDao dao = _buildStakeDao(ctx);

  dao.activestakes(data).then((res) {
    mLog('StakeDao activestakes', res);

    if ((res as Map).containsKey('actStake')) {
      // && (res['actStake'] as List).isNotEmpty){
      List list = [res['actStake']];
      ctx.dispatch(WalletActionCreator.updateStakeList(type, list));
    }
  }).catchError((err) {
    // tip(ctx.context,'StakeDao activestakes: $err');
  });
}

Future<List> _getHistory(Context<WalletState> ctx, dao, Map data, String type,
    List<String> keyTypes) async {
  ctx.dispatch(WalletActionCreator.loadingHistory(true));

  try {
    var res = await dao.history(data);
    mLog('$type history', res);

    final list = [];
    for (final keyType in keyTypes) {
      if ((res as Map).containsKey(keyType)) {
        list.addAll(res[keyType] as List);
      }
    }
    // _buildWithdrawDao(ctx)
    // ctx.dispatch(WalletActionCreator.updateList(type, list));

    ctx.dispatch(WalletActionCreator.loadingHistory(false));
    return list;
  } catch (err) {
    ctx.dispatch(WalletActionCreator.loadingHistory(false));
    return [];
    // tip(ctx.context,'$type history: $err');
  }
}

Map _getGeneralParams(Context<WalletState> ctx) {
  double balance = ctx.state.balance;
  bool isDemo = ctx.state.isDemo;
  double stakedAmount = ctx.state.stakedAmount;
  List<OrganizationsState> organizations = ctx.state.organizations;
  return <String, dynamic>{
    'organizations': organizations,
    'stakedAmount': stakedAmount,
    'isDemo': isDemo,
    'balance': balance,
  };
}

void _onStake(Action action, Context<WalletState> ctx) async {
  final res = await Navigator.of(ctx.context)
      .pushNamed('stake_page', arguments: _getGeneralParams(ctx));
  if (res ?? false) {
    _search(ctx, ctx.state.lastSearchType, ctx.state.lastSearchData);
    ctx.dispatch(HomeActionCreator.onProfile());
  }
}

void _onUnstake(Action action, Context<WalletState> ctx) async {
  final res = await Navigator.of(ctx.context)
      .pushNamed('list_unstake_page', arguments: _getGeneralParams(ctx));
  if (res ?? false) {
    _search(ctx, ctx.state.lastSearchType, ctx.state.lastSearchData);
    ctx.dispatch(HomeActionCreator.onProfile());
  }
}

void _onStakeDetails(Action action, Context<WalletState> ctx) async {
  final res = await Navigator.of(ctx.context)
      .pushNamed('details_stake_page', arguments: {
    'stake': action.payload,
    'isDemo': ctx.state.isDemo,
  });
  if (res ?? false) {
    _search(ctx, ctx.state.lastSearchType, ctx.state.lastSearchData);
    ctx.dispatch(HomeActionCreator.onProfile());
  }
}