import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

import 'device_component/state.dart';
import 'gateway_component/gateway_list_adapter/gateway_item_component/state.dart';
import 'gateway_component/state.dart';
import 'user_component/state.dart';
import 'wallet_component/state.dart';
import 'wallet_component/wallet_list_adapter/wallet_item_component/state.dart';

class HomeState implements Cloneable<HomeState> {
  //home
  bool isUpdate = true;
  int tabIndex = 0;
  bool loading = true;

  //profile
  String userId = '';
  String username = '';
  String email = '';
  bool isAdmin = false;
  bool isActive = false;

  String superNode = '';

  List<OrganizationsState> organizations = [];
  String selectedOrganizationId = '';

  //wallet
  bool isFirstRequest = true;
  bool loadingHistory = true;
  TabController tabController;
  double balance = 0;
  double totalRevenue = 0;
  int walletTabIndex = 0;
  double tabHeight = 100;
  bool isSetDate1 = false;
  bool isSetDate2 = false;
  int selectedIndexBtn1 = -1;
  int selectedIndexBtn2 = -1;
  List<WalletItemState> walletList = [];
  double withdrawFee = 0;
  String firstTime = TimeDao.getDatetime(new DateTime.now(), type: 'date');
  String secondTime = TimeDao.getDatetime(new DateTime.now(), type: 'date');

  //stake
  double stakedAmount = 0;

  //gateways
  int gatewaysTotal = 0;
  double gatewaysRevenue = 0;
  double gatewaysUSDRevenue = 0;
  List<MapMarker> gatewaysLocations = [];
  GatewayItemState profile;
  MapViewController mapCtlProfile = MapViewController();
  List miningRevenve = [];
  List gatewayFrame = [];

  //map
  MapViewController mapCtl = MapViewController();
  List<GatewayItemState> gatewaysList = [];

  //devices
  int devicesTotal = 0;
  double devicesRevenue = 0;
  double devicesUSDRevenue = 0;
  
  //demo
  bool isDemo;

  int deviceSortType = 0;

  //profile
  // bool isSelectIdType = true;

  @override
  HomeState clone() {
    return HomeState()
      ..isUpdate = isUpdate
      ..tabController = tabController
      ..tabIndex = tabIndex
      ..loading = loading
      ..loadingHistory = loadingHistory
      ..userId = userId
      ..username = username
      ..email = email
      ..isAdmin = isAdmin
      ..isActive = isActive
      ..organizations = organizations ?? []
      ..selectedOrganizationId = selectedOrganizationId
      ..superNode = superNode
      ..balance = balance
      ..totalRevenue = totalRevenue
      ..stakedAmount = stakedAmount
      ..stakedAmount = stakedAmount
      ..gatewaysTotal = gatewaysTotal
      ..gatewaysRevenue = gatewaysRevenue
      ..gatewaysUSDRevenue = gatewaysUSDRevenue
      ..devicesTotal = devicesTotal
      ..devicesRevenue = devicesRevenue
      ..devicesUSDRevenue = devicesUSDRevenue
      ..gatewaysLocations = gatewaysLocations
      ..mapCtl = mapCtl
      ..gatewaysList = gatewaysList
      ..tabHeight = tabHeight
      ..walletTabIndex = walletTabIndex
      ..walletList = walletList ?? []
      ..withdrawFee = withdrawFee
      ..firstTime = firstTime
      ..secondTime = secondTime
      ..isSetDate1 = isSetDate1
      ..isSetDate2 = isSetDate2
      ..selectedIndexBtn1 = selectedIndexBtn1
      ..selectedIndexBtn2 = selectedIndexBtn2
      ..isFirstRequest = isFirstRequest
      ..isDemo = isDemo
      ..profile = profile
      ..mapCtlProfile = mapCtlProfile
      ..miningRevenve = miningRevenve
      ..gatewayFrame = gatewayFrame
      ..deviceSortType = deviceSortType;
  }
}

HomeState initState(Map<String, dynamic> args) {
  args ??= {};
  final bool isDemo = StorageManager.sharedPreferences.getBool(Config.DEMO_MODE) ?? false;

  SettingsState settingsData = GlobalStore.store.getState().settings;

  return HomeState()
    ..username = settingsData.username
    ..isDemo = isDemo;
}

class UserConnector extends ConnOp<HomeState, UserState> {
  @override
  UserState get(HomeState state) {
    return UserState()
      ..loading = state.loading
      ..id = state.userId
      ..username = state.username
      ..isAdmin = state.isAdmin
      ..isActive = state.isActive
      ..organizations = state.organizations
      ..selectedSuperNode = state.superNode
      ..balance = state.balance
      ..stakedAmount = state.stakedAmount
      ..totalRevenue = state.totalRevenue
      ..gatewaysTotal = state.gatewaysTotal
      ..gatewaysRevenue = state.gatewaysRevenue
      ..gatewaysUSDRevenue = state.gatewaysUSDRevenue
      ..devicesTotal = state.devicesTotal
      ..devicesRevenue = state.devicesRevenue
      ..devicesUSDRevenue = state.devicesUSDRevenue
      ..mapViewController = state.mapCtl
      ..gatewaysLocations = state.gatewaysLocations
      ..isDemo = state.isDemo;
  }

  @override
  void set(HomeState state, UserState subState) {
    state..mapCtl = subState.mapViewController;
  }
}

class GatewayConnector extends ConnOp<HomeState, GatewayState> {
  @override
  GatewayState get(HomeState state) {
    return GatewayState()
      ..loading = state.loading
      ..gatewaysTotal = state.gatewaysTotal
      ..gatewaysRevenue = state.gatewaysRevenue
      ..gatewaysUSDRevenue = state.gatewaysUSDRevenue
      ..organizations = state.organizations
      ..list = state.gatewaysList
      ..isDemo = state.isDemo
      ..profile = state.profile
      ..mapCtl = state.mapCtlProfile
      ..miningRevenve = state.miningRevenve
      ..gatewayFrame = state.gatewayFrame;
  }

  @override
  void set(HomeState state, GatewayState subState) {
    state
      ..profile = subState.profile
      ..mapCtlProfile = subState.mapCtl
      ..miningRevenve = subState.miningRevenve
      ..gatewayFrame = subState.gatewayFrame;
  }
}

class DeviceConnector extends ConnOp<HomeState, DeviceState> {
  @override
  DeviceState get(HomeState state) {
    return DeviceState()
      ..deviceSortType = state.deviceSortType
      ..isDemo = state.isDemo;
  }

  @override
  void set(HomeState state, DeviceState subState) {
    state.deviceSortType = subState.deviceSortType;
  }
}

class WalletConnector extends ConnOp<HomeState, WalletState> {
  @override
  WalletState get(HomeState state) {
    return WalletState()
      ..isFirstRequest = state.isFirstRequest
      ..loading = state.loading
      ..loadingHistory = state.loadingHistory
      ..tabController = state.tabController
      ..balance = state.balance
      ..totalRevenue = state.totalRevenue
      ..organizations = state.organizations
      ..stakedAmount = state.stakedAmount
      ..isSetDate1 = state.isSetDate1
      ..isSetDate2 = state.isSetDate2
      ..selectedIndexBtn1 = state.selectedIndexBtn1
      ..selectedIndexBtn2 = state.selectedIndexBtn2
      ..tabIndex = state.walletTabIndex
      ..tabHeight = state.tabHeight
      ..list = state.walletList
      ..withdrawFee = state.withdrawFee
      ..firstTime = state.firstTime
      ..secondTime = state.secondTime
      ..isDemo = state.isDemo;
  }

  @override
  void set(HomeState state, WalletState subState) {
    state
      ..isFirstRequest = subState.isFirstRequest
      ..loadingHistory = subState.loadingHistory
      ..tabController = subState.tabController
      ..totalRevenue = subState.totalRevenue
      ..isSetDate1 = subState.isSetDate1
      ..isSetDate2 = subState.isSetDate2
      ..selectedIndexBtn1 = subState.selectedIndexBtn1
      ..selectedIndexBtn2 = subState.selectedIndexBtn2
      ..walletTabIndex = subState.tabIndex
      ..tabHeight = subState.tabHeight
      ..walletList = subState.list
      ..withdrawFee = subState.withdrawFee
      ..firstTime = subState.firstTime
      ..secondTime = subState.secondTime;
  }
}
