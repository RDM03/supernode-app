import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:supernodeapp/common/daos/demo/gateways_dao.dart';
import 'package:supernodeapp/common/daos/demo/stake_dao.dart';
import 'package:supernodeapp/common/daos/demo/user_dao.dart';
import 'package:supernodeapp/common/daos/demo/wallet_dao.dart';
import 'package:supernodeapp/common/daos/gateways_location_dao.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/local_storage_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/mapbox_gl_component/component.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

import 'action.dart';
import 'gateway_component/gateway_list_adapter/gateway_item_component/state.dart';
import 'state.dart';
import 'user_component/state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _initState,
    Lifecycle.build: _build,
    HomeAction.onOperate: _onOperate,
    HomeAction.onSettings: _onSettings,
    HomeAction.onProfile: _onProfile,
    HomeAction.onGateways: _onGateways,
    HomeAction.relogin: _relogin,
    HomeAction.mapbox: _mapbox,
  });
}

UserDao _buildUserDao(Context<HomeState> ctx) {
  return ctx.state.isDemo ? DemoUserDao() : UserDao();
}

WalletDao _buildWalletDao(Context<HomeState> ctx) {
  return ctx.state.isDemo ? DemoWalletDao() : WalletDao();
}

GatewaysDao _buildGatewaysDao(Context<HomeState> ctx) {
  return ctx.state.isDemo ? DemoGatewaysDao() : GatewaysDao();
}

StakeDao _buildStakeDao(Context<HomeState> ctx) {
  return ctx.state.isDemo ? DemoStakeDao() : StakeDao();
}

void _relogin(Action action, Context<HomeState> ctx) async {
  Map data = {
    'username': StorageManager.sharedPreferences.getString(Config.USERNAME_KEY),
    'password': StorageManager.sharedPreferences.getString(Config.PASSWORD_KEY)
  };

  int reloginCount = ctx.state.reloginCount;
  try {
    if (reloginCount > 3) {
      ctx.dispatch(HomeActionCreator.reloginCount(0));
      throw Exception(['error: login more than three times.']);
    }

    ctx.dispatch(HomeActionCreator.reloginCount(reloginCount++));

    Map data = {
      'username':
          StorageManager.sharedPreferences.getString(Config.USERNAME_KEY),
      'password':
          StorageManager.sharedPreferences.getString(Config.PASSWORD_KEY)
    };

    String apiRoot =
        StorageManager.sharedPreferences.getString(Config.API_ROOT);
    Dao.baseUrl = apiRoot;

    UserDao dao = _buildUserDao(ctx);
    showLoading(ctx.context);
    var res = await dao.login(data);
    mLog('login', res);
    hideLoading(ctx.context);

    SettingsState settingsData = GlobalStore.store.getState().settings;

    if (settingsData == null) {
      settingsData = SettingsState().clone();
    }

    Dao.token = res['jwt'];
    settingsData.token = res['jwt'];
    settingsData.username = data['username'];
    settingsData.isDemo = res['isDemo'] ?? false;
    _profile(ctx);
  } catch (e) {
    hideLoading(ctx.context);

    ctx.dispatch(HomeActionCreator.loading(false));

    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = '';
    settingsData.selectedOrganizationId = '';
    settingsData.organizations = [];
    SettingsDao.updateLocal(settingsData);

    Navigator.of(ctx.context).pushReplacementNamed('login_page');
    // tip(ctx.context, '$err');
  }
}

void _initState(Action action, Context<HomeState> ctx) async {
  await _gatewaysLocationsFromLocal(ctx);
  _updateUserDataFromLocal(ctx);
  await _profile(ctx);
  await _gatewaysLocationsFromRemote(ctx);
}

void _updateUserDataFromLocal(Context<HomeState> ctx){
  Map data = LocalStorageDao.loadUserData('user_'+ctx.state.username);
  if(data['balance'] != null){
    ctx.dispatch(HomeActionCreator.balance(data['balance']));
  }

  if(data['miningIncome'] != null){
    ctx.dispatch(HomeActionCreator.miningIncome(data['miningIncome']));
  }

  if(data['stakedAmount'] != null){
    ctx.dispatch(HomeActionCreator.stakedAmount(data['stakedAmount']));
  }

  if(data['gatewaysTotal'] != null){
    ctx.dispatch(HomeActionCreator.gateways(data['gatewaysTotal'], 0, null));
  }

  if(data['gatewayUSD'] != null){
    ctx.dispatch(HomeActionCreator.convertUSD('gateway', data['gatewayUSD']));
  }

  if(data['totalRevenue'] != null){
    ctx.dispatch(HomeActionCreator.totalRevenue(data['totalRevenue']));
  }

}

void _build(Action action, Context<HomeState> ctx) {
  if (ctx.state.isUpdate) {
    ctx.dispatch(HomeActionCreator.isUpdate());
    _checkForUpdate(ctx);
  }
}

Future<void> _checkForUpdate(Context<HomeState> ctx) {
  var _ctx = ctx.context;

  updateDialog(_ctx);
}

void _onProfile(Action action, Context<HomeState> ctx) {
  Future.delayed(Duration(seconds: 2), () async {
    _profile(ctx);
  });
}

void _onGateways(Action action, Context<HomeState> ctx) async {
  SettingsState settingsData = GlobalStore.store.getState().settings;
  var orgId = settingsData.selectedOrgId;
  if (orgId == null || orgId.isEmpty)
    orgId = settingsData.organizations.first.organizationID;
  await _miningIncome(ctx, ctx.state.userId, orgId);
  await _gateways(ctx);
}

Future<void> _profile(Context<HomeState> ctx) async {
  ctx.dispatch(HomeActionCreator.loading(true));
  Dao.ctx = ctx;

  try {
    UserDao dao = _buildUserDao(ctx);
    var res = await dao.profile();

    mLog('profile', res);
    UserState userData = UserState.fromMap(res['user'], type: 'remote');

    List<OrganizationsState> organizationsData = [];
    for (int index = 0; index < res['organizations'].length; index++) {
      organizationsData
          .add(OrganizationsState.fromMap(res['organizations'][index]));
    }

    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = userData.id;
    settingsData.organizations = organizationsData;
    settingsData.isDemo = userData.isDemo;
    if (settingsData.selectedOrganizationId.isEmpty) {
      settingsData.selectedOrganizationId =
          organizationsData.first.organizationID;
    }

    SettingsDao.updateLocal(settingsData);
    ctx.dispatch(HomeActionCreator.profile(userData, organizationsData));

    String orgId = settingsData.selectedOrganizationId;

    // Gain user's finance situation
    await _balance(ctx, userData, orgId);
    await _miningIncome(ctx, userData.id, orgId);
    await _stakeAmount(ctx, orgId);
    await _stakingRevenue(ctx, orgId);

    // Request gateways' amount and location
    await _gateways(ctx);

    // await _devices(ctx,userData,orgId);
  } catch (e) {
    ctx.dispatch(HomeActionCreator.loading(false));
    ctx.dispatch(HomeActionCreator.onReLogin());
  }
}

Future<void> _balance(
    Context<HomeState> ctx, UserState userData, String orgId) async {
  if (orgId.isEmpty) return;

  try {
    WalletDao dao = _buildWalletDao(ctx);
    Map data = {'userId': userData.id, 'orgId': orgId, 'currency': ''};

    var res = await dao.balance(data);
    mLog('balance', res);
    double balance = Tools.convertDouble(res['balance']);

    ctx.dispatch(HomeActionCreator.balance(balance));

    //save to the local
    LocalStorageDao.saveUserData('user_'+ctx.state.username, 'balance', balance);
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    // tip(ctx.context, 'WalletDao balance: $err');
  }
}

Future<void> _miningIncome(
    Context<HomeState> ctx, String userId, String orgId) async {
  try {
    WalletDao dao = _buildWalletDao(ctx);
    Map data = {'userId': userId, 'orgId': orgId, 'currency': ''};

    var res = await dao.miningIncome(data);

    mLog('WalletDao miningInfo', res);
    double value = 0;

    if ((res as Map).containsKey('miningIncome')) {
      value = Tools.convertDouble(res['miningIncome']);
    }

    ctx.dispatch(HomeActionCreator.miningIncome(value));
    //save to the local
    LocalStorageDao.saveUserData('user_'+ctx.state.username, 'miningIncome', value);

    Map priceData = {
      'userId': userId,
      'orgId': orgId,
      'currency': '',
      'mxcPrice': '${value == 0.0 ? value.toInt() : value}'
    };
    await _convertUSD(ctx, priceData, 'gateway');
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    // tip(ctx.context, 'WalletDao miningInfo: $err');
  }
}

Future<void> _stakeAmount(Context<HomeState> ctx, String orgId) async {
  assert(orgId.isNotEmpty);

  try {
    StakeDao dao = _buildStakeDao(ctx);

    var res = await dao.amount(orgId);
    mLog('StakeDao amount', res);
    double amount = 0;
    if (res.containsKey('actStake') && res['actStake'] != null) {
      amount = Tools.convertDouble(res['actStake']['amount']);
    }

    ctx.dispatch(HomeActionCreator.stakedAmount(amount));
    //save to the local
    LocalStorageDao.saveUserData('user_'+ctx.state.username, 'stakedAmount', amount);
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    // tip(ctx.context, 'StakeDao amount: $err');
  }
}

Future<void> _gateways(Context<HomeState> ctx) async {
  try {
    GatewaysDao dao = _buildGatewaysDao(ctx);
    String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
    Map data = {"organizationID": orgId, "offset": 0, "limit": 999};

    var res = await dao.list(data);
    mLog('GatewaysDao list', res);

    // [0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}
    // 用于匹配版本号 允许范围 0.0.0 -> 99.99.99
    var reg = RegExp(r"[0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}");

    int total = int.parse(res['totalCount']);
    // int allValues = 0;
    List<GatewayItemState> list = [];

    List tempList = res['result'] as List;

    if (tempList.length > 0) {
      for (int index = 0; index < tempList.length; index++) {
        RegExp modelReg = new RegExp(r'(?<=(Gateway Model: )).+(?=[\n])');
        RegExpMatch modelRegRes =
            modelReg.firstMatch(tempList[index]['description']);
        if (modelRegRes != null) {
          tempList[index]['model'] = modelRegRes.group(0);
        }

        RegExp versionReg = new RegExp(r'(?<=(Gateway OsVersion: )).+');
        RegExpMatch versionRegRes =
            versionReg.firstMatch(tempList[index]['description']);
        if (versionRegRes != null) {
          tempList[index]['osversion'] = versionRegRes.group(0);
        }

        // allValues += tempList[index]['location']['accuracy'];
        Iterable<Match> matches =
            reg.allMatches(tempList[index]['description']);
        String description = '';
        for (Match m in matches) {
          description = m.group(0);
        }

        tempList[index]['description'] = description;

        list.add(GatewayItemState.fromMap(tempList[index]));
      }
    }

    ctx.dispatch(HomeActionCreator.gateways(total, 0, list));

    //save to the local
    LocalStorageDao.saveUserData('user_'+ctx.state.username, 'gatewaysTotal', total);
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    // tip(ctx.context, 'GatewaysDao list: $err');
  }
}

Future<void> _gatewaysLocationsFromLocal(Context<HomeState> ctx) async {
  Map<String, List<SuperNodeBean>> superNodes = GlobalStore.state.superModel.superNodesByCountry;
  GatewaysLocationDao gatewayLocationDao = GatewaysLocationDao();
  List geojsonList = [];

  //local data
  geojsonList = await gatewayLocationDao.listFromLocal();
  ctx.dispatch(HomeActionCreator.geojsonList(geojsonList));
}

Future<void> _gatewaysLocationsFromRemote(Context<HomeState> ctx) async {
  Map<String, List<SuperNodeBean>> superNodes = GlobalStore.state.superModel.superNodesByCountry;
  GatewaysLocationDao gatewayLocationDao = GatewaysLocationDao();
  List geojsonList = ctx.state.geojsonList;

  //remote data
  Dao dao = Dao();
  List superNodesKeys = superNodes.keys.toList();

 for(int i = 0;i < superNodesKeys.length;i++){
    String key = superNodesKeys[i];
    if(key.toLowerCase() == 'test'){
      ctx.dispatch(HomeActionCreator.geojsonList(geojsonList));
      continue;
    }

    List nodes = superNodes[key];
    for(int j = 0;j < nodes.length;j++){
      if(nodes[j].region.toLowerCase() != 'test'){
        print(nodes[j].url + GatewaysApi.locations);
        var res = await dao.get(
          url: nodes[j].url + GatewaysApi.locations
        );

        //the link of ausn.matchx.io returns null
        if(res != null && res['result'] != null && res['result'].length > 0){
          List geojsonRes = gatewayLocationDao.geojsonList(res['result']);
          geojsonList.addAll(geojsonRes);
        }

      }
    }
  }
}

void _onOperate(Action action, Context<HomeState> ctx) {
  String act = action.payload;
  String page = '${act}_page';
  double balance = ctx.state.balance;
  bool isDemo = ctx.state.isDemo;
  double stakedAmount = ctx.state.stakedAmount;
  List<OrganizationsState> organizations = ctx.state.organizations;

  if (act == 'unstake') {
    page = 'stake_page';
  }

  Navigator.pushNamed(ctx.context, page, arguments: {
    'balance': balance,
    'organizations': organizations,
    'type': act,
    'stakedAmount': stakedAmount,
    'isDemo': isDemo
  }).then((res) {
    if ((page == 'stake_page' || page == 'withdraw_page') && res) {
      _profile(ctx);
    }
  });
}

void _mapbox(Action action, Context<HomeState> ctx) {
  Navigator.push(
    ctx.context,
    MaterialPageRoute(
      maintainState: false,
      fullscreenDialog: false,
      builder: (context) {
        return ctx.buildComponent('mapbox');
      }),
  );
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

  Navigator.pushNamed(
    ctx.context,
    'settings_page',
    arguments: {
      'user': user,
      'organizations': organizations,
      'isDemo': curState.isDemo,
    },
  ).then((res) {
    if (res != null) {
      ctx.dispatch(HomeActionCreator.updateUsername(res));
    }

    _profile(ctx);
  });
}

Future<void> _convertUSD(Context<HomeState> ctx, Map data, String type) async {
  try {
    WalletDao dao = _buildWalletDao(ctx);

    var res = await dao.convertUSD(data);
    mLog('WalletDao convertUSD', res);

    if ((res as Map).containsKey('mxcPrice')) {
      double value = double.parse(res['mxcPrice']);
      ctx.dispatch(HomeActionCreator.convertUSD(type, value));

      //save to the local
      LocalStorageDao.saveUserData('user_'+ctx.state.username, '${type}USD', value);
    }
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    // tip(ctx.context, 'WalletDao convertUSD: $err');
  }
}

Future<void> _stakingRevenue(Context<HomeState> ctx, String orgId) async {
  try {
    StakeDao dao = _buildStakeDao(ctx);
    Map data = {
      'orgId': orgId,
      'till': DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String()
    };

    var res = await dao.revenue(data);

    mLog('StakeDao revenue', res);
    final amount = Tools.convertDouble(res['amount']);
    ctx.dispatch(HomeActionCreator.totalRevenue(amount));
    ctx.dispatch(HomeActionCreator.loading(false));

    //save to the local
    LocalStorageDao.saveUserData('user_'+ctx.state.username, 'totalRevenue', amount);
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    // tip(ctx.context, 'StakeDao history: $err');
  }
}
