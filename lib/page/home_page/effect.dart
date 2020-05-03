import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_map/flutter_map.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';

import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';
import 'gateway_component/gateway_list_adapter/gateway_item_component/state.dart';
import 'state.dart';
import 'user_component/state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _initState,
    HomeAction.onOperate: _onOperate,
    HomeAction.onSettings: _onSettings,
    HomeAction.onProfile: _onProfile,
  });
}

void _initState(Action action, Context<HomeState> ctx) {  
  _profile(ctx);
}

void _onProfile(Action action, Context<HomeState> ctx) {
  _profile(ctx);
}

void _profile(Context<HomeState> ctx){
  // showLoading(ctx.context);

  UserDao dao = UserDao();
  
  dao.profile().then((res) async{
    log('profile',res);
    // hideLoading(ctx.context);

    UserState userData = UserState.fromMap(res['user'],type: 'remote');

    List<OrganizationsState> organizationsData = [];
    for(int index = 0;index < res['organizations'].length;index++){
      organizationsData.add(OrganizationsState.fromMap(res['organizations'][index]));
    }

    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = userData.id;
    settingsData.organizations = organizationsData;
    if(settingsData.selectedOrganizationId.isEmpty){
      settingsData.selectedOrganizationId = organizationsData.first.organizationID;
    }

    SettingsDao.updateLocal(settingsData);

    ctx.dispatch(HomeActionCreator.profile(userData,organizationsData));

    _gateways(ctx);
    _gatewaysLocations(ctx);
    // _devices(ctx,userData,settingsData.selectedOrganizationId);
    _balance(ctx,userData,settingsData.selectedOrganizationId);
    _stakeAmount(ctx,settingsData.selectedOrganizationId);

  }).catchError((err){
    ctx.dispatch(HomeActionCreator.loading(false));
    
    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = '';
    settingsData.selectedOrganizationId = '';
    settingsData.organizations = [];

    SettingsDao.updateLocal(settingsData);

    Navigator.of(ctx.context).pushReplacementNamed('login_page');
    
    // tip(ctx.context,' $err');
  });
}

void _balance(Context<HomeState> ctx,UserState userData,String orgId){
  if(orgId.isEmpty) return;

  WalletDao dao = WalletDao();

  Map data = {
    'userId': userData.id,
    'orgId': orgId
  };

  dao.balance(data).then((res) {
    log('balance',res);
    double balance = Tools.convertDouble(res['balance']);
    ctx.dispatch(HomeActionCreator.balance(balance));
  }).catchError((err){
    tip(ctx.context,'WalletDao balance: $err');
  });

  // dao.miningIncome(data).then((res) async{
  //   log('WalletDao miningInfo',res);
  //   int value = 0;
  //   if((res as Map).containsKey('miningIncome')){
  //     value = Tools.convertDouble(res['miningIncome']);
  //   }

  //   ctx.dispatch(HomeActionCreator.miningIncome(value));

  //   // if(value == 0) return;

  //   Map priceData = {
  //     'userId': userData.id,
  //     'orgId': orgId,
  //     'mxc_price': value.toString()
  //   };

  //   var gatewaysUSDValue = await _convertUSD(ctx,priceData);
  //   ctx.dispatch(HomeActionCreator.convertUSD('gateway', gatewaysUSDValue));

  // }).catchError((err){
  //   tip(ctx.context,'WalletDao miningInfo: $err');
  // });
}

void _stakeAmount(Context<HomeState> ctx,String orgId){
  if(orgId.isEmpty) return;

  StakeDao dao = StakeDao();

  dao.amount(orgId).then((res) async{
    log('StakeDao amount',res);
    double amount = 0;
    if(res.containsKey('actStake') && res['actStake'] != null){
      amount = Tools.convertDouble(res['actStake']['Amount']);
    }

    ctx.dispatch(HomeActionCreator.stakedAmount(amount));
    ctx.dispatch(HomeActionCreator.loading(false));
  }).catchError((err){
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context,'StakeDao amount: $err');
  });
}

void _gateways(Context<HomeState> ctx){
  GatewaysDao dao = GatewaysDao();

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  Map data = {
    "organizationID": orgId,
    "offset": 0,
    "limit": 999
  };

  dao.list(data).then((res) async{
    log('GatewaysDao list',res);
    
    int total = int.parse(res['totalCount']);
    // int allValues = 0;
    List<GatewayItemState> list = [];

    List tempList = res['result'] as List;

    if(tempList.length > 0){
      for(int index = 0;index < tempList.length;index ++){
        // allValues += tempList[index]['location']['accuracy'];
        list.add(
          GatewayItemState.fromMap(tempList[index])
        );
      }
    }

    ctx.dispatch(HomeActionCreator.gateways(total,0,list));

  }).catchError((err){
    tip(ctx.context,'GatewaysDao list: $err');
  });
}

void _gatewaysLocations(Context<HomeState> ctx){
  GatewaysDao dao = GatewaysDao();

  dao.locations().then((res) async{
    log('GatewaysDao locations',res);
    
    if(res['result'].length > 0){
      List<Marker> locations =[];
      for(int index = 0;index < res['result'].length;index ++){
        var location = res['result'][index]['location'];
        var marker = Marker(
          point: Tools.convertLatLng(location),
          builder: (ctx) =>
            Image.asset(AppImages.gateways),
        );

        locations.add(marker);
      }
      ctx.dispatch(HomeActionCreator.gatewaysLocations(locations));
    }

  }).catchError((err){
    tip(ctx.context,'GatewaysDao locations: $err');
  });
}

void _devices(Context<HomeState> ctx,UserState userData,String orgId){
  DevicesDao dao = DevicesDao();

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  Map data = {
    "organizationID": orgId,
    "offset": 0,
    "limit": 999
  };

  dao.list(data).then((res) async{
    log('DevicesDao list',res);
    
    int total = int.parse(res['totalCount']);
    double allValues = 0;

    ctx.dispatch(HomeActionCreator.devices(total,allValues));

    Map priceData = {
      'userId': userData.id,
      'orgId': orgId,
      'mxc_price': allValues.toString()
    };

    var devicesUSDValue = await _convertUSD(ctx,priceData);
    ctx.dispatch(HomeActionCreator.convertUSD('device', devicesUSDValue));

  }).catchError((err){
    tip(ctx.context,'DevicesDao list: $err');
  });
}

void _onOperate(Action action, Context<HomeState> ctx) {
  String act = action.payload;
  String page = '${act}_page';
  double balance = ctx.state.balance;
  List<OrganizationsState> organizations = ctx.state.organizations;

  if(act == 'unstake'){
    page = 'stake_page';
  }

  Navigator.pushNamed(ctx.context,page,arguments: {'balance': balance,'organizations':organizations,'type': act}).then((res){
    if(page == 'stake_page' && res){
      _profile(ctx);
    }
  });
}

void _onSettings(Action action, Context<HomeState> ctx) {
  var curState = ctx.state;
  
  Map user = {
    'userId': curState.userId,
    'username': curState.username,
    'email': curState.email,
    'isAdmin': curState.isAdmin
  };

  List<OrganizationsState> organizations = ctx.state.organizations;

  Navigator.pushNamed(ctx.context,'settings_page',arguments: {'user': user,'organizations':organizations}).then((res){
    if(res != null){
      ctx.dispatch(HomeActionCreator.updateUsername(res));
    }

    _profile(ctx);
  });
}

Future<dynamic> _convertUSD(Context<HomeState> ctx,Map data){
  WalletDao dao = WalletDao();

  dao.convertUSD(data).then((res) async{
    log('WalletDao convertUSD',res);
    
    return res;

  }).catchError((err){
    tip(ctx.context,'WalletDao convertUSD: $err');
  });
}