import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/stake_dao.dart';
import 'package:supernodeapp/common/daos/topup_dao.dart';
import 'package:supernodeapp/common/daos/withdraw_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<WalletState> buildEffect() {
  return combineEffects(<Object, Effect<WalletState>>{
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
    WalletAction.onTab: _onTab,
    WalletAction.onFilter: _onFilter,
  });
}

void _initState(Action action, Context<WalletState> ctx) {
   if(!ctx.state.isFirstRequest) return;
   
  final TickerProvider tickerProvider = ctx.stfState as TickerProvider;

  TabController tabController = TabController(length: 2, vsync: tickerProvider);
  
  tabController.addListener(() { 
    ctx.dispatch(WalletActionCreator.tab(tabController.index));
  });

  ctx.dispatch(WalletActionCreator.tabController(tabController));
  
  Future.delayed(Duration(seconds: 3),(){
    ctx.dispatch(WalletActionCreator.tab(0));
    ctx.dispatch(WalletActionCreator.onFilter('SEARCH DEFUALT'));
  });
}

void _dispose(Action action, Context<WalletState> ctx) {
  // ctx.dispatch(WalletActionCreator.tab(0));
}

void _onTab(Action action, Context<WalletState> ctx) {
  int index = action.payload;
  ctx.dispatch(WalletActionCreator.tab(index));
  ctx.state.tabController.animateTo(index);

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  if(orgId.isEmpty) return;

  Map data = {
    'orgId': orgId,
    'offset': 0,
    'limit': 999,
    'from': DateTime(2000).toUtc().toIso8601String(),
    'till': DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String(),
  };

  _search(ctx,'SEARCH DEFUALT',data);
}

void _onFilter(Action action, Context<WalletState> ctx) {
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  String type = action.payload;

  if(orgId.isEmpty) return;

  Map data = {
    'orgId': orgId,
    'offset': 0,
    'limit': 999,
    'from': DateTime(2000).toUtc().toIso8601String(),
    'till': DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String(),
    'currency': '',
  };

  _withdrawFee(ctx);

  switch (type) {
    case 'DEPOSIT':
      _deposit(ctx,type,data);
      break;
    case 'WITHDRAW':
      _withdraw(ctx,type,data);
      break;
    case 'STAKE':
      _search(ctx,type,data,index: 0);
      break;
    case 'UNSTAKE':
      _search(ctx,type,data,index: 1);
      break;
    case 'STAKEUNSTAKE':
      _search(ctx,type,data,index: 2);
      break;
    default:
      _search(ctx,type,data,index: 2);
  }
}

void _search(Context<WalletState> ctx,String type,Map data,{int index = -1}){
  if(type == 'STAKE' || type == 'UNSTAKE'){
    ctx.dispatch(WalletActionCreator.updateSelectedButton(index));

    StakeDao dao = StakeDao();
    _requestHistory(ctx,dao,data,type,'stakingHist');
    return; 
  }

  if(ctx.state.tabIndex == 1){
    StakeDao dao = StakeDao();
    _requestHistory(ctx,dao,data,type,'stakingHist');
    return;
  }

  // WalletDao dao = WalletDao();
  // _requestHistory(ctx,dao,data,type,'txHistory'); 
  if(type == 'SEARCH DEFUALT'){
    _deposit(ctx,'DEPOSIT DEFAULT',data);
    _withdraw(ctx,'WITHDRAW DEFAULT',data);
  }

  if(type == 'SEARCH'){
    _deposit(ctx,'DEPOSIT DATETIME',data);
    _withdraw(ctx,'WITHDRAW DATETIME',data);
  }
}

void _withdrawFee(Context<WalletState> ctx){
  WithdrawDao dao = WithdrawDao();
  dao.fee().then((res){
    mLog('WithdrawDao fee',res);

    if((res as Map).containsKey('withdrawFee')){
      ctx.dispatch(WalletActionCreator.withdrawFee(Tools.convertDouble(res['withdrawFee'])));
    }
  }).catchError((err){
    // tip(ctx.context,'WithdrawDao fee: $err');
  });
}

void _withdraw(Context<WalletState> ctx,String type,Map data){
  if(!type.contains('DEFAULT') && !type.contains('DATETIME')) {
    ctx.dispatch(WalletActionCreator.updateSelectedButton(1));
  }
  data['moneyAbbr']="ETH_MXC";
  WithdrawDao dao = WithdrawDao();
  _requestHistory(ctx,dao,data,type,'withdrawHistory');  

}

void _deposit(Context<WalletState> ctx,String type,Map data){
  if(!type.contains('DEFAULT') && !type.contains('DATETIME')) ctx.dispatch(WalletActionCreator.updateSelectedButton(0));

  TopupDao dao = TopupDao();
  _requestHistory(ctx,dao,data,type,'topupHistory');  
}

Future<void> _requestHistory(Context<WalletState> ctx,dao,Map data,String type, String keyType) async {
  ctx.dispatch(WalletActionCreator.loadingHistory(true));
  
  try{
    var res = await dao.history(data);
    mLog('$type history',res);
    
    if((res as Map).containsKey(keyType)){

      List list = res[keyType] as List;

      ctx.dispatch(WalletActionCreator.updateList(type, list));
    }

    ctx.dispatch(WalletActionCreator.loadingHistory(false));
  }catch(err){
    ctx.dispatch(WalletActionCreator.loadingHistory(false));
    // tip(ctx.context,'$type history: $err');
  }

}