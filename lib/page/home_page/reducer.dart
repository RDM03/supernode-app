import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/local_storage_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'action.dart';
import 'state.dart';
import 'user_component/state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      HomeAction.loading: _loading,
      HomeAction.loadingMap: _loadingMap,
      HomeAction.tabIndex: _tabIndex,
      HomeAction.profile: _profile,
      HomeAction.balance: _balance,
      HomeAction.addDHX: _addDHX,
      HomeAction.dataDHX: _dataDHX,
      HomeAction.stakedAmount: _stakedAmount,
      HomeAction.gateways: _gateways,
      HomeAction.miningIncome: _miningIncome,
      HomeAction.gatewaysLocations: _gatewaysLocations,
      HomeAction.devices: _devices,
      HomeAction.updateUsernameEmail: _updateUsernameEmail,
      HomeAction.convertUSD: _convertUSD,
      HomeAction.totalRevenue: _totalRevenue,
      HomeAction.isUpdate: _isUpdate,
      HomeAction.reloginCount: _reloginCount,
      HomeAction.geojsonList: _geojsonList,
    },
  );
}

HomeState _geojsonList(HomeState state, Action action) {

  final HomeState newState = state.clone();
  return newState
    ..geojsonList = action.payload;
}


HomeState _reloginCount(HomeState state, Action action) {

  final HomeState newState = state.clone();
  return newState
    ..reloginCount = action.payload + 1;
}

HomeState _isUpdate(HomeState state, Action action) {

  final HomeState newState = state.clone();
  return newState
    ..isUpdate = false;
}

HomeState _loading(HomeState state, Action action) {
  bool toogle = action.payload;

  final HomeState newState = state.clone();
  return newState..loading = toogle;
}

HomeState _loadingMap(HomeState state, Action action) {
  final HomeState newState = state.clone();
  Map res = action.payload;

  if (res['type'] == 'add') {
    return newState..loadingMap.add(res['data']);
  }else{
    return newState..loadingMap.remove(res['data']);
  }
}

HomeState _tabIndex(HomeState state, Action action) {
  int index = action.payload;

  Dao.dio.lock();
  Future.delayed(Duration(seconds: 3),(){
    Dao.dio.unlock();
  });

  final HomeState newState = state.clone();
  if (Sys.mainMenus[index] == 'Wallet') {
    newState.expandedView = false;
  }
  return newState..tabIndex = index;
}

HomeState _profile(HomeState state, Action action) {
  Map data = action.payload;
  UserState user = data['user'];
  List<OrganizationsState> organizations = data['organizations'];
  String wechatExternalUsername = data['wechatExternalUsername'];

  final HomeState newState = state.clone();
  return newState
    ..userId = user.id
    ..username = user.username
    ..email = user.email
    ..isAdmin = user.isAdmin
    ..isActive = user.isActive
    ..organizations = organizations
    ..wechatExternalUsername = wechatExternalUsername;
}

HomeState _balance(HomeState state, Action action) {
  double data = action.payload;

  final HomeState newState = state.clone();
  return newState..balance = data;
}

HomeState _addDHX(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.displayTokens = [...newState.displayTokens, Token.supernodeDhx];
  return newState;
}

HomeState _dataDHX(HomeState state, Action action) {
  Map data = action.payload;

  final HomeState newState = state.clone();
  if (data.containsKey(LocalStorageDao.balanceDHXKey))
    newState.balanceDHX = data[LocalStorageDao.balanceDHXKey];
  if (data.containsKey(LocalStorageDao.lockedAmountKey))
    newState.lockedAmount = data[LocalStorageDao.lockedAmountKey];
  if (data.containsKey(LocalStorageDao.totalRevenueDHXKey))
    newState.totalRevenueDHX = data[LocalStorageDao.totalRevenueDHXKey];
  if (data.containsKey(LocalStorageDao.mPowerKey))
    newState.mPower = data[LocalStorageDao.mPowerKey];
  if (data.containsKey(LocalStorageDao.miningPowerKey))
    newState.miningPower = data[LocalStorageDao.miningPowerKey];
  if (data.containsKey('list'))
    newState.stakeDHXList = data['list'];
  return newState;
}

HomeState _stakedAmount(HomeState state, Action action) {
  double data = action.payload;

  final HomeState newState = state.clone();
  return newState..stakedAmount = data;
}

HomeState _gateways(HomeState state, Action action) {
  Map data = action.payload;
  int total = data['total'];
  // int value = data['value'];
  List list = data['list'];

  final HomeState newState = state.clone();
  return newState
    ..gatewaysTotal = total
    ..gatewaysList = list;
}

HomeState _miningIncome(HomeState state, Action action) {
  double value = action.payload;

  final HomeState newState = state.clone();
  return newState..gatewaysRevenue = value;
}

HomeState _gatewaysLocations(HomeState state, Action action) {
  List data = action.payload;

  final HomeState newState = state.clone();
  return newState..gatewaysLocations = data;
}

HomeState _devices(HomeState state, Action action) {
  Map data = action.payload;
  int total = data['total'];
  double value = data['value'];

  final HomeState newState = state.clone();
  return newState
    ..devicesTotal = total
    ..devicesRevenue = value;
}

HomeState _updateUsernameEmail(HomeState state, Action action) {
  Map data = action.payload;

  final HomeState newState = state.clone();
  return newState
    ..username = data['username']
    ..email = data['email'];
}

HomeState _convertUSD(HomeState state, Action action) {
  Map data = action.payload;

  final HomeState newState = state.clone();

  if (data['type'] == 'gateway') {
    return newState..gatewaysUSDRevenue = Tools.convertDouble(data['value']);
  }

  if (data['type'] == 'device') {
    return newState..devicesUSDRevenue = Tools.convertDouble(data['value']);
  }

  return state;
}

HomeState _totalRevenue(HomeState state, Action action) {
  double data = action.payload;

  final HomeState newState = state.clone();
  return newState
    ..totalRevenue = data;
}