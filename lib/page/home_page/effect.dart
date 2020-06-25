import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/local_storage_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/wallet_component/wallet_list_adapter/wallet_item_component/state.dart';
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
    HomeAction.onGateways: _onGateways,
    HomeAction.relogin: _relogin,
    HomeAction.mapbox: _mapbox,
  });
}

void _relogin(Action action, Context<HomeState> ctx) {
  Map data = {'username': StorageManager.sharedPreferences.getString(Config.USERNAME_KEY), 'password': StorageManager.sharedPreferences.getString(Config.PASSWORD_KEY)};

  String apiRoot = StorageManager.sharedPreferences.getString(Config.API_ROOT);
  Dao.baseUrl = apiRoot;

  UserDao dao = UserDao();
  showLoading(ctx.context);
  dao.login(data).then((res) {
    mLog('login', res);
    hideLoading(ctx.context);

    SettingsState settingsData = GlobalStore.store.getState().settings;

    if (settingsData == null) {
      settingsData = SettingsState().clone();
    }

    Dao.token = res['jwt'];
    settingsData.token = res['jwt'];
    settingsData.username = data['username'];
    _profile(ctx);
  }).catchError((err) {
    hideLoading(ctx.context);
    ctx.dispatch(HomeActionCreator.loading(false));
    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = '';
    settingsData.selectedOrganizationId = '';
    settingsData.organizations = [];
    SettingsDao.updateLocal(settingsData);
    Navigator.of(ctx.context).pushReplacementNamed('login_page');
    tip(ctx.context, '$err');
  });
}

void _initState(Action action, Context<HomeState> ctx) {
  _profile(ctx);
}

void _onProfile(Action action, Context<HomeState> ctx) {
  _profile(ctx);
}

void _onGateways(Action action, Context<HomeState> ctx) {
  _gateways(ctx);
}

void _profile(Context<HomeState> ctx) {
  ctx.dispatch(HomeActionCreator.loading(true));
  UserDao dao = UserDao();

  dao.profile().listen((res) async {
    mLog('profile', res);
    UserState userData = UserState.fromMap(res['user'], type: 'remote');

    List<OrganizationsState> organizationsData = [];
    for (int index = 0; index < res['organizations'].length; index++) {
      organizationsData.add(OrganizationsState.fromMap(res['organizations'][index]));
    }

    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = userData.id;
    settingsData.organizations = organizationsData;
    if (settingsData.selectedOrganizationId.isEmpty) {
      settingsData.selectedOrganizationId = organizationsData.first.organizationID;
    }

    SettingsDao.updateLocal(settingsData);
    ctx.dispatch(HomeActionCreator.profile(userData, organizationsData));

    String orgId = settingsData.selectedOrganizationId;

    //Gain user's finance situation
    _balance(ctx, userData, orgId);
    _miningIncome(ctx, userData, orgId);
    _stakeAmount(ctx, orgId);
    _stakingRevenue(ctx, orgId);

    //Request gateways' amount and location
    _gateways(ctx);
    _gatewaysLocations(ctx);

    // _devices(ctx,userData,orgId);
  }).onError((err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    ctx.dispatch(HomeActionCreator.onReLogin());
  });
}

void _balance(Context<HomeState> ctx, UserState userData, String orgId) {
  if (orgId.isEmpty) return;

  WalletDao dao = WalletDao();

  Map data = {'userId': userData.id, 'orgId': orgId};

  dao.balance(data).listen((res) {
    mLog('balance', res);
    double balance = Tools.convertDouble(res['balance']);
    LocalStorageDao.saveUserData('user_${userData.id}', {'balance': balance});
    ctx.dispatch(HomeActionCreator.balance(balance));
  }).onError((err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context, 'WalletDao balance: $err');
  });
}

void _miningIncome(Context<HomeState> ctx, UserState userData, String orgId) {
  WalletDao dao = WalletDao();

  Map data = {'userId': userData.id, 'orgId': orgId};

  dao.miningIncome(data).listen((res) {
    mLog('WalletDao miningInfo', res);
    double value = 0;
    if ((res as Map).containsKey('miningIncome')) {
      value = Tools.convertDouble(res['miningIncome']);
    }

    ctx.dispatch(HomeActionCreator.miningIncome(value));

    Map priceData = {'userId': userData.id, 'orgId': orgId, 'mxcPrice': '${value == 0.0 ? value.toInt() : value}'};

    _convertUSD(ctx, priceData, 'gateway');
  }).onError((err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context, 'WalletDao miningInfo: $err');
  });
}

void _stakeAmount(Context<HomeState> ctx, String orgId) {
  if (orgId.isEmpty) return;

  StakeDao dao = StakeDao();

  dao.amount(orgId).listen((res) {
    mLog('StakeDao amount', res);
    double amount = 0;
    if (res.containsKey('actStake') && res['actStake'] != null) {
      amount = Tools.convertDouble(res['actStake']['Amount']);
    }

    ctx.dispatch(HomeActionCreator.stakedAmount(amount));
  }).onError((err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context, 'StakeDao amount: $err');
  });
}

void _gateways(Context<HomeState> ctx) {
  GatewaysDao dao = GatewaysDao();

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  Map data = {"organizationID": orgId, "offset": 0, "limit": 999};

  dao.list(data).listen((res) {
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
        // allValues += tempList[index]['location']['accuracy'];
        Iterable<Match> matches = reg.allMatches(tempList[index]['description']);
        String description = '';
        for (Match m in matches) {
          description = m.group(0);
        }

        tempList[index]['description'] = description;
        list.add(GatewayItemState.fromMap(tempList[index]));
      }
    }

    ctx.dispatch(HomeActionCreator.gateways(total, 0, list));
  }).onError((err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context, 'GatewaysDao list: $err');
  });
}

void _gatewaysLocations(Context<HomeState> ctx) {
  GatewaysDao dao = GatewaysDao();

  dao.locations().listen((res) async {
    mLog('GatewaysDao locations', res);

    if (res['result'].length > 0) {
      List<MapMarker> locations = [];
      for (int index = 0; index < res['result'].length; index++) {
        var location = res['result'][index]['location'];
        var marker = MapMarker(
          point: Tools.convertLatLng(location),
          image: AppImages.gateways,
        );
        locations.add(marker);
      }
      ctx.dispatch(HomeActionCreator.gatewaysLocations(locations));
      ctx.state.mapCtl.addSymbols(locations);
    }
  }).onError((err) {
    tip(ctx.context, 'GatewaysDao locations: $err');
  });
}

void _devices(Context<HomeState> ctx, UserState userData, String orgId) {
  DevicesDao dao = DevicesDao();

  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  Map data = {"organizationID": orgId, "offset": 0, "limit": 999};

  dao.list(data).then((res) async {
    mLog('DevicesDao list', res);

    int total = int.parse(res['totalCount']);
    double allValues = 0;

    ctx.dispatch(HomeActionCreator.devices(total, allValues));

    Map priceData = {'userId': userData.id, 'orgId': orgId, 'mxcPrice': '${allValues == 0.0 ? allValues.toInt() : allValues}'};

    var devicesUSDValue = _convertUSD(ctx, priceData, 'device');
//     ctx.dispatch(HomeActionCreator.convertUSD('device', devicesUSDValue));
  }).catchError((err) {
    tip(ctx.context, 'DevicesDao list: $err');
  });
}

void _onOperate(Action action, Context<HomeState> ctx) {
  String act = action.payload;
  String page = '${act}_page';
  double balance = ctx.state.balance;
  List<OrganizationsState> organizations = ctx.state.organizations;

  if (act == 'unstake') {
    page = 'stake_page';
  }

  Navigator.pushNamed(ctx.context, page, arguments: {'balance': balance, 'organizations': organizations, 'type': act}).then((res) {
    if ((page == 'stake_page' || page == 'withdraw_page') && res) {
      _profile(ctx);
    }
  });
}

void _mapbox(Action action, Context<HomeState> ctx) {
  Navigator.pushNamed(
    ctx.context,
    'mapbox_page',
    arguments: {
      'markers': ctx.state.mapCtl.markers,
    },
  );
}

void _onSettings(Action action, Context<HomeState> ctx) {
  var curState = ctx.state;

  Map user = {'userId': curState.userId, 'username': curState.username, 'email': curState.email, 'isAdmin': curState.isAdmin};

  List<OrganizationsState> organizations = ctx.state.organizations;

  Navigator.pushNamed(ctx.context, 'settings_page', arguments: {'user': user, 'organizations': organizations}).then((res) {
    if (res != null) {
      ctx.dispatch(HomeActionCreator.updateUsername(res));
    }

    _profile(ctx);
  });
}

void _convertUSD(Context<HomeState> ctx, Map data, String type) {
  WalletDao dao = WalletDao();

  dao.convertUSD(data).listen((res) async {
    mLog('WalletDao convertUSD', res);

    if ((res as Map).containsKey('mxcPrice')) {
      double value = double.parse(res['mxcPrice']);
      ctx.dispatch(HomeActionCreator.convertUSD(type, value));
    }
  }).onError((err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context, 'WalletDao convertUSD: $err');
  });
}

void _stakingRevenue(Context<HomeState> ctx, String orgId) {
  StakeDao dao = StakeDao();

  Map data = {'orgId': orgId, 'offset': 0, 'limit': 999};

  dao.history(data).listen((res) async {
    mLog('StakeDao history', res);
    double totleRevenue = 0;

    if ((res as Map).containsKey('stakingHist') && res['stakingHist'].length > 0) {
      List items = res['stakingHist'] as List;
      items.forEach((item) {
        WalletItemState obj = WalletItemState.fromMap(item);
        totleRevenue += obj.revenue;
      });

      ctx.dispatch(HomeActionCreator.totalRevenue(totleRevenue));
      ctx.dispatch(HomeActionCreator.loading(false));
    }
  }).onError((err) {
    ctx.dispatch(HomeActionCreator.loading(false));
    tip(ctx.context, 'StakeDao history: $err');
  });
}
