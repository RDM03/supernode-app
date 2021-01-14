import 'package:decimal/decimal.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:supernodeapp/common/daos/demo/dhx_dao.dart';
import 'package:supernodeapp/common/daos/demo/gateways_dao.dart';
import 'package:supernodeapp/common/daos/demo/stake_dao.dart';
import 'package:supernodeapp/common/daos/demo/user_dao.dart';
import 'package:supernodeapp/common/daos/demo/wallet_dao.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';
import 'package:supernodeapp/common/daos/gateways_location_dao.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/local_storage_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/repositories/storage_repository.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/legacy/wallet_component/action.dart';
import 'package:supernodeapp/page/home_page/legacy/wallet_component/wallet_list_adapter/wallet_item_component/state.dart';
import 'package:supernodeapp/page/login_page/bloc/view.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'package:supernodeapp/route.dart';

import 'action.dart';
import 'gateway_component/item_state.dart';
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
    HomeAction.onAddDHX: _onAddDHX,
    HomeAction.onDataDHX: _onDataDHX,
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

DhxDao _buildDhxDao(Context<HomeState> ctx) {
  return ctx.state.isDemo ? DemoDhxDao() : DhxDao();
}

void _relogin(Action action, Context<HomeState> ctx) async {
  int reloginCount = ctx.state.reloginCount;
  Loading loading;
  try {
    if (reloginCount > 3) {
      ctx.dispatch(HomeActionCreator.reloginCount(0));
      throw Exception(['error: login more than three times.']);
    }

    ctx.dispatch(HomeActionCreator.reloginCount(reloginCount));

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
    loading = await Loading.show(ctx.context);
    var res = await dao.login(data);
    mLog('login', res);
    loading.hide();

    SettingsState settingsData = GlobalStore.store.getState().settings;

    if (settingsData == null) {
      settingsData = SettingsState().clone();
    }

    Dao.token = res['jwt'];
    settingsData.token = res['jwt'];
    settingsData.username = data['username'];
    settingsData.isDemo = res['isDemo'] ?? false;
    _profile(ctx);
    ctx.dispatch(HomeActionCreator.onDataDHX());
  } catch (err) {
    loading?.hide();

    ctx.dispatch(HomeActionCreator.loading(false));

    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = '';
    settingsData.selectedOrganizationId = '';
    settingsData.organizations = [];
    SettingsDao.updateLocal(settingsData);

    Navigator.pushReplacement(ctx.context, route((c) => LoginPage()));
    tip(ctx.context, '$err');
  }
}

void _initState(Action action, Context<HomeState> ctx) async {
  _checkNodeStatus();
  _loadUserData(ctx);

  await _gatewaysLocationsFromLocal(ctx);
  await _profile(ctx);
}

void _checkNodeStatus() async {
  await checkMaintenance();
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
  SettingsState settingsData = GlobalStore.store.getState().settings;

  if (settingsData.userId.isNotEmpty &&
      settingsData.selectedOrganizationId.isNotEmpty) {
    _requestUserFinance(
        ctx, settingsData.userId, settingsData.selectedOrganizationId);
  }
}

void _onGateways(Action action, Context<HomeState> ctx) async {
  SettingsState settingsData = GlobalStore.store.getState().settings;
  var orgId = settingsData.selectedOrganizationId;
  if (orgId == null || orgId.isEmpty)
    orgId = settingsData.organizations.first.organizationID;

  ctx.dispatch(HomeActionCreator.loadingMap('gatewaysTotal', type: 'delete'));

  await _miningIncome(ctx, ctx.state.userId, orgId);
  await _gateways(ctx, orgId);
}

Future<void> _profile(Context<HomeState> ctx) async {
  Dao.ctx = ctx;
  SettingsState settingsData = GlobalStore.store.getState().settings;

  if (settingsData.userId.isNotEmpty &&
      settingsData.selectedOrganizationId.isNotEmpty) {
    await _requestUserFinance(
        ctx, settingsData.userId, settingsData.selectedOrganizationId);
  }

  try {
    UserDao dao = _buildUserDao(ctx);
    SettingsState settingsData = GlobalStore.store.getState().settings;

    var res = await dao.profile();

    mLog('profile', res);
    UserState userData = UserState.fromMap(res['user'], type: 'remote');

    List<OrganizationsState> organizationsData = [];
    for (int index = 0; index < res['organizations'].length; index++) {
      organizationsData
          .add(OrganizationsState.fromMap(res['organizations'][index]));
    }

    if (settingsData.userId.isEmpty ||
        settingsData.selectedOrganizationId.isEmpty) {
      await _requestUserFinance(
          ctx, userData.id, organizationsData.first.organizationID);
    }

    settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = userData.id;
    settingsData.organizations = organizationsData;
    settingsData.isDemo = userData.isDemo;
    if (settingsData.selectedOrganizationId.isEmpty) {
      settingsData.selectedOrganizationId =
          organizationsData.first.organizationID;
    }

    SettingsDao.updateLocal(settingsData);
    ctx.dispatch(HomeActionCreator.profile(userData, organizationsData));
  } catch (e) {
    ctx.dispatch(HomeActionCreator.onReLogin());
  }
}

Future<void> _requestUserFinance(
    Context<HomeState> ctx, String userId, String orgId) async {
  await _balance(ctx, userId, orgId);
  await _stakeAmount(ctx, userId, orgId);
  await _stakingRevenue(ctx, userId, orgId);

  await _miningIncome(ctx, userId, orgId);

  // Request gateways' amount and location
  await _gateways(ctx, orgId);

  // await _devices(ctx,userData,orgId);
}

void _loadUserData(Context<HomeState> ctx) {
  var data = LocalStorageDao.loadUserData('user_${ctx.state.username}');
  data ??= {};

  if (data['balance'] != null)
    ctx.dispatch(HomeActionCreator.balance(data['balance']));

  if (data[LocalStorageDao.walletDHX] != null &&
      data[LocalStorageDao.walletDHX]) {
    //load values from previous session
    Map dataDHX = {};
    if (data[LocalStorageDao.balanceDHXKey] != null)
      dataDHX[LocalStorageDao.balanceDHXKey] =
          data[LocalStorageDao.balanceDHXKey];
    if (data[LocalStorageDao.lockedAmountKey] != null)
      dataDHX[LocalStorageDao.lockedAmountKey] =
          data[LocalStorageDao.lockedAmountKey];
    if (data[LocalStorageDao.totalRevenueDHXKey] != null)
      dataDHX[LocalStorageDao.totalRevenueDHXKey] =
          data[LocalStorageDao.totalRevenueDHXKey];
    if (data[LocalStorageDao.mPowerKey] != null)
      dataDHX[LocalStorageDao.mPowerKey] = data[LocalStorageDao.mPowerKey];
    if (data[LocalStorageDao.miningPowerKey] != null)
      dataDHX[LocalStorageDao.miningPowerKey] =
          data[LocalStorageDao.miningPowerKey];
    if (dataDHX.isNotEmpty) ctx.dispatch(HomeActionCreator.dataDHX(dataDHX));

    //add DHX to wallet
    ctx.dispatch(HomeActionCreator.onAddDHX(false));
  }

  if (data['miningIncome'] != null)
    ctx.dispatch(HomeActionCreator.miningIncome(data['miningIncome']));
  if (data['stakedAmount'] != null)
    ctx.dispatch(HomeActionCreator.stakedAmount(data['stakedAmount']));
  if (data['totalRevenue'] != null)
    ctx.dispatch(HomeActionCreator.totalRevenue(data['totalRevenue']));
  if (data['gatewaysTotal'] != null)
    ctx.dispatch(HomeActionCreator.gateways(data['gatewaysTotal'], 0, null));
  if (data['usd_gateway'] != null)
    ctx.dispatch(HomeActionCreator.convertUSD('gateway', data['usd_gateway']));

  print(data);
}

Future<void> _balance(
    Context<HomeState> ctx, String userId, String orgId) async {
  if (orgId.isEmpty) return;

  try {
    ctx.dispatch(HomeActionCreator.loadingMap('balance', type: 'remove'));
    WalletDao dao = _buildWalletDao(ctx);
    Map data = {'userId': userId, 'orgId': orgId, 'currency': ''};

    var res = await dao.balance(data);
    mLog('balance', res);
    double balance = Tools.convertDouble(res['balance']);
    LocalStorageDao.saveUserData(
        'user_${ctx.state.username}', {'balance': balance});

    ctx.dispatch(HomeActionCreator.balance(balance));
    ctx.dispatch(HomeActionCreator.loadingMap('balance'));
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loadingMap('balance'));
    tip(ctx.context, 'WalletDao balance: $err');
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
    LocalStorageDao.saveUserData(
        'user_${ctx.state.username}', {'miningIncome': value});

    ctx.dispatch(HomeActionCreator.miningIncome(value));

    Map priceData = {
      'userId': userId,
      'orgId': orgId,
      'currency': '',
      'mxcPrice': '${value == 0.0 ? value.toInt() : value}'
    };
    await _convertUSD(ctx, userId, priceData, 'gateway');
  } catch (err) {
    tip(ctx.context, 'WalletDao miningInfo: $err');
  }
}

Future<void> _stakeAmount(
    Context<HomeState> ctx, String userId, String orgId) async {
  assert(orgId.isNotEmpty);

  try {
    ctx.dispatch(HomeActionCreator.loadingMap('stakedAmount', type: 'remove'));
    StakeDao dao = _buildStakeDao(ctx);

    final res = await dao.activestakes({
      "orgId": orgId,
    });

    mLog('StakeDao amount', res);
    double amount = 0;
    if (res.containsKey('actStake') && res['actStake'] != null) {
      final list = res['actStake'] as List;
      var sum = Decimal.zero;
      for (final stake in list) {
        final stakeAmount = Decimal.parse(stake['amount']);
        sum += stakeAmount;
      }
      amount = sum.toDouble();
    }
    LocalStorageDao.saveUserData(
        'user_${ctx.state.username}', {'stakedAmount': amount});

    ctx.dispatch(HomeActionCreator.stakedAmount(amount));
    ctx.dispatch(HomeActionCreator.loadingMap('stakedAmount'));
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loadingMap('stakedAmount'));
    tip(ctx.context, 'StakeDao amount: $err');
  }
}

Future<void> _gateways(Context<HomeState> ctx, String orgId) async {
  try {
    ctx.dispatch(HomeActionCreator.loading(true));
    GatewaysDao dao = _buildGatewaysDao(ctx);

    Map data = {"organizationID": orgId, "offset": 0, "limit": 10};

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

    LocalStorageDao.saveUserData(
        'user_${ctx.state.username}', {'gatewaysTotal': total});
    ctx.dispatch(HomeActionCreator.gateways(total, 0, list));
    ctx.dispatch(HomeActionCreator.loadingMap('gatewaysTotal'));
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loadingMap('gatewaysTotal'));
    tip(ctx.context, 'GatewaysDao list: $err');
  }
}

Future<void> _gatewaysLocationsFromLocal(Context<HomeState> ctx) async {
  Map<String, List<Supernode>> superNodes =
      GlobalStore.state.superModel.superNodesByCountry;
  GatewaysLocationDao gatewayLocationDao = GatewaysLocationDao();
  List geojsonList = [];

  //local data
  geojsonList = await gatewayLocationDao.listFromLocal();
  Map localGeojsonMap = LocalStorageDao.loadUserData('geojson');
  localGeojsonMap ??= {};

  if (localGeojsonMap['data'] != null && localGeojsonMap['data'].length > 0) {
    geojsonList.addAll(localGeojsonMap['data']);
  }

  ctx.dispatch(HomeActionCreator.geojsonList(geojsonList));
}

void _onOperate(Action action, Context<HomeState> ctx) {
  String act = action.payload;
  String page = '${act}_page';
  double balance = ctx.state.balance;
  bool isDemo = ctx.state.isDemo;
  double stakedAmount = ctx.state.stakedAmount;
  List<OrganizationsState> organizations = ctx.state.organizations;

  if (act == 'unstake') {
    page = 'list_unstake_page';
  }

  Navigator.pushNamed(ctx.context, page, arguments: {
    'balance': balance,
    'organizations': organizations,
    'type': act,
    'stakedAmount': stakedAmount,
    'isDemo': isDemo,
  }).then((res) {
    res ??= false;
    if ((page == 'stake_page' || page == 'withdraw_page') && res) {
      _profile(ctx);
    }
  });
}

void _mapbox(Action action, Context<HomeState> ctx) async {
  showMaterialModalBottomSheet(
    context: ctx.context,
    enableDrag: false,
    builder: (context, scrollController) => ctx.buildComponent('mapbox'),
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
    ctx.dispatch(HomeActionCreator.onDataDHX());
  });
}

Future<void> _convertUSD(
    Context<HomeState> ctx, String userId, Map data, String type) async {
  try {
    WalletDao dao = _buildWalletDao(ctx);

    var res = await dao.convertUSD(data);
    mLog('WalletDao convertUSD', res);

    if ((res as Map).containsKey('mxcPrice')) {
      double value = double.parse(res['mxcPrice']);
      LocalStorageDao.saveUserData(
          'user_${ctx.state.username}', {'usd_$type': value});
      ctx.dispatch(HomeActionCreator.convertUSD(type, value));
      ctx.dispatch(HomeActionCreator.loadingMap('gatewaysUSD'));
    }
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loadingMap('gatewaysUSD'));
    tip(ctx.context, 'WalletDao convertUSD: $err');
  }
}

Future<void> _stakingRevenue(
    Context<HomeState> ctx, String userId, String orgId) async {
  try {
    ctx.dispatch(HomeActionCreator.loadingMap('totalRevenue', type: 'remove'));
    StakeDao dao = _buildStakeDao(ctx);
    Map data = {
      'orgId': orgId,
      'till': DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String()
    };

    var res = await dao.revenue(data);

    mLog('StakeDao revenue', res);
    final amount = Tools.convertDouble(res['amount']);
    LocalStorageDao.saveUserData(
        'user_${ctx.state.username}', {'totalRevenue': amount});
    ctx.dispatch(HomeActionCreator.totalRevenue(amount));
    ctx.dispatch(HomeActionCreator.loadingMap('totalRevenue'));
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loadingMap('totalRevenue'));
    tip(ctx.context, 'StakeDao history: $err');
  }
}

void _onAddDHX(Action action, Context<HomeState> ctx) {
  bool saveLocally = action.payload;
  if (!ctx.state.displayTokens.contains(Token.DHX)) {
    ctx.dispatch(HomeActionCreator.addDHX());
    ctx.dispatch(HomeActionCreator.onDataDHX(addingDHX: true));
  }
  if (saveLocally) {
    SettingsState settingsData = GlobalStore.store.getState().settings;
    if (settingsData.username.isNotEmpty) {
      LocalStorageDao.saveUserData(
          'user_${settingsData.username}', {LocalStorageDao.walletDHX: true});
    }
  }
}

void _onDataDHX(Action action, Context<HomeState> ctx) async {
  bool addingDHX = action.payload;
  if (addingDHX || ctx.state.displayTokens.contains(Token.DHX)) {
    _requestUserDHXBalance(ctx);
    _requestLockedAmount_TotalRevenue(ctx);
    _requestLastMining(ctx);
  }
}

void _requestUserDHXBalance(Context<HomeState> ctx) async {
  const String balanceDHXlabel = LocalStorageDao.balanceDHXKey;
  SettingsState settingsData = GlobalStore.store.getState().settings;
  if (settingsData.userId.isNotEmpty &&
      settingsData.selectedOrganizationId.isNotEmpty) {
    ctx.dispatch(HomeActionCreator.loadingMap(balanceDHXlabel, type: "remove"));

    String userId = settingsData.userId;
    String orgId = settingsData.selectedOrganizationId;
    try {
      WalletDao dao = _buildWalletDao(ctx);
      Map data = {'userId': userId, 'orgId': orgId, 'currency': 'DHX'};

      var res = await dao.balance(data);
      double balanceDHX = Tools.convertDouble(res['balance']);
      mLog('DHX balance', '$res');
      Map dataDHX = {balanceDHXlabel: balanceDHX};
      if (settingsData.username.isNotEmpty) {
        LocalStorageDao.saveUserData('user_${settingsData.username}', dataDHX);
      }

      ctx.dispatch(HomeActionCreator.dataDHX(dataDHX));
      ctx.dispatch(HomeActionCreator.loadingMap(balanceDHXlabel));
    } catch (err) {
      ctx.dispatch(HomeActionCreator.loadingMap(balanceDHXlabel));
      tip(ctx.context, 'WalletDao balance: $err');
    }
  }
}

void _requestLockedAmount_TotalRevenue(Context<HomeState> ctx) async {
  const String lockedAmountLabel = LocalStorageDao.lockedAmountKey;
  SettingsState settingsData = GlobalStore.store.getState().settings;
  if (settingsData.selectedOrganizationId.isNotEmpty) {
    ctx.dispatch(
        HomeActionCreator.loadingMap(lockedAmountLabel, type: "remove"));

    String orgId = settingsData.selectedOrganizationId;
    try {
      DhxDao dao = _buildDhxDao(ctx);

      List<StakeDHX> res = await dao.listStakes(organizationId: orgId);
      mLog('dhxStakesList', '$res');
      double lockedAmount = 0.0;
      double totalRevenueDHX = 0.0;
      double mPower = 0.0;
      final List<StakeDHXItemState> list = [];
      for (StakeDHX stake in res) {
        mPower += Tools.convertDouble(stake.amount) *
            (1 + Tools.convertDouble(stake.boost));
        lockedAmount += Tools.convertDouble(stake.amount);
        totalRevenueDHX += Tools.convertDouble(stake.dhxMined);
        list.add(StakeDHXItemState(StakeDHXItemEntity.fromStake(stake)));
      }
      if (list.length > 0) list[list.length - 1].isLast = true;

      Map dataDHX = {
        lockedAmountLabel: lockedAmount,
        LocalStorageDao.totalRevenueDHXKey: totalRevenueDHX,
        LocalStorageDao.mPowerKey: mPower
      };
      if (settingsData.username.isNotEmpty) {
        LocalStorageDao.saveUserData('user_${settingsData.username}', dataDHX);
      }
      dataDHX['list'] = list;

      ctx.dispatch(HomeActionCreator.dataDHX(dataDHX));
      ctx.dispatch(HomeActionCreator.loadingMap(lockedAmountLabel));
    } catch (err) {
      ctx.dispatch(HomeActionCreator.loadingMap(lockedAmountLabel));
      tip(ctx.context, 'DhxDao dhxStakesList: $err');
    }
  }
}

void _requestLastMining(Context<HomeState> ctx) async {
  const String miningPowerLabel = LocalStorageDao.miningPowerKey;
  ctx.dispatch(HomeActionCreator.loadingMap(miningPowerLabel, type: "remove"));

  try {
    DhxDao dao = _buildDhxDao(ctx);
    var res = await dao.lastMining();
    mLog('lastMining', '${res.miningPower}');
    double miningPower = Tools.convertDouble(res.miningPower);

    SettingsState settingsData = GlobalStore.store.getState().settings;
    Map dataDHX = {miningPowerLabel: miningPower};
    if (settingsData.username.isNotEmpty) {
      LocalStorageDao.saveUserData('user_${settingsData.username}', dataDHX);
    }

    ctx.dispatch(HomeActionCreator.dataDHX(dataDHX));
    ctx.dispatch(HomeActionCreator.loadingMap(miningPowerLabel));
  } catch (err) {
    ctx.dispatch(HomeActionCreator.loadingMap(miningPowerLabel));
    tip(ctx.context, 'DhxDao lastMining: $err');
  }
}
