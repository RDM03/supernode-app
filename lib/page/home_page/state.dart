import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/mapbox_gl_component/state.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'package:supernodeapp/page/settings_page/state.dart';

import 'device_component/state.dart';
import 'gateway_component/item_state.dart';
import 'gateway_component/state.dart';
import 'user_component/state.dart';
import 'wallet_component/state.dart';
import 'wallet_component/wallet_list_adapter/wallet_item_component/state.dart';

class HomeState implements Cloneable<HomeState> {
  //home
  int reloginCount = 0;
  int tabIndex = 0;
  bool isUpdate = true;
  bool loading = true;
  Set loadingMap = {};

  //profile
  String userId = '';
  String username = '';
  String email = '';
  bool isAdmin = false;
  bool isActive = false;

  String superNode = '';

  List<OrganizationsState> organizations = [];
  String selectedOrganizationId = '';

  //external
  String wechatExternalUsername = '';
  String shopifyExternalUsername = '';

  //wallet
  bool expandedView = false;
  List<Token> displayTokens = [Token.mxc];
  Token selectedToken;
  bool isFirstRequest = true;
  bool loadingHistory = true;
  double balance = 0;
  double balanceDHX = 0;
  double balanceBTC = 0;
  double totalRevenue = 0;
  double lockedAmount = 0;
  double totalRevenueDHX = 0;
  double mPower = 0;
  double miningPower = 0;
  Map<Token, int> walletActiveTabToken = {Token.mxc: 0, Token.supernodeDhx: 0};
  bool isSetDate1 = false;
  bool isSetDate2 = false;
  int selectedIndexBtn1 = -1;
  int selectedIndexBtn2 = -1;
  List<WalletItemState> walletList = [];
  List<StakeItemState> stakeList = [];
  List<StakeDHXItemState> stakeDHXList = [];
  List<WalletItemState> transactions = [];
  List<WalletItemState> btcList = [];
  double withdrawFee = 0;
  String firstTime = TimeDao.getDatetime(new DateTime.now(), type: 'date');
  String secondTime = TimeDao.getDatetime(new DateTime.now(), type: 'date');
  Map lastSearchData;
  String lastSearchType;

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
  List geojsonList = [];

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
      ..reloginCount = reloginCount
      ..isUpdate = isUpdate
      ..tabIndex = tabIndex
      ..loading = loading
      ..loadingMap = loadingMap
      ..loadingHistory = loadingHistory
      ..userId = userId
      ..username = username
      ..email = email
      ..isAdmin = isAdmin
      ..isActive = isActive
      ..organizations = organizations ?? []
      ..selectedOrganizationId = selectedOrganizationId
      ..wechatExternalUsername = wechatExternalUsername
      ..shopifyExternalUsername = shopifyExternalUsername
      ..superNode = superNode
      ..balance = balance
      ..balanceDHX = balanceDHX
      ..balanceBTC = balanceBTC
      ..totalRevenue = totalRevenue
      ..lockedAmount = lockedAmount
      ..totalRevenueDHX = totalRevenueDHX
      ..mPower = mPower
      ..miningPower  = miningPower
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
      ..geojsonList = geojsonList
      ..walletActiveTabToken = walletActiveTabToken
      ..walletList = walletList ?? []
      ..stakeList = stakeList ?? []
      ..stakeDHXList = stakeDHXList ?? []
      ..transactions = transactions ?? []
      ..btcList = btcList ?? []
      ..withdrawFee = withdrawFee
      ..firstTime = firstTime
      ..secondTime = secondTime
      ..isSetDate1 = isSetDate1
      ..isSetDate2 = isSetDate2
      ..selectedIndexBtn1 = selectedIndexBtn1
      ..selectedIndexBtn2 = selectedIndexBtn2
      ..expandedView = expandedView
      ..displayTokens = displayTokens
      ..selectedToken = selectedToken
      ..isFirstRequest = isFirstRequest
      ..isDemo = isDemo
      ..profile = profile
      ..mapCtlProfile = mapCtlProfile
      ..miningRevenve = miningRevenve
      ..gatewayFrame = gatewayFrame
      ..deviceSortType = deviceSortType
      ..lastSearchData = lastSearchData
      ..lastSearchType = lastSearchType;
  }
}

HomeState initState(Map<String, dynamic> args) {
  args ??= {};
  final bool isDemo =
      StorageManager.sharedPreferences.getBool(Config.DEMO_MODE) ?? false;

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
      ..loadingMap = state.loadingMap
      ..id = state.userId
      ..username = state.username
      ..isAdmin = state.isAdmin
      ..isActive = state.isActive
      ..organizations = state.organizations
      ..selectedSuperNode = state.superNode
      ..balance = state.balance
      ..stakedAmount = state.stakedAmount
      ..totalRevenue = state.totalRevenue
      ..lockedAmount = state.lockedAmount
      ..gatewaysTotal = state.gatewaysTotal
      ..gatewaysRevenue = state.gatewaysRevenue
      ..gatewaysUSDRevenue = state.gatewaysUSDRevenue
      ..devicesTotal = state.devicesTotal
      ..devicesRevenue = state.devicesRevenue
      ..devicesUSDRevenue = state.devicesUSDRevenue
      ..mapViewController = state.mapCtl
      ..gatewaysLocations = state.gatewaysLocations
      ..geojsonList = state.geojsonList
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
      ..loadingMap = state.loadingMap
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
      ..gatewayFrame = subState.gatewayFrame
      ..gatewaysList = subState.list;
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
      ..expandedView = state.expandedView
      ..displayTokens = state.displayTokens
      ..selectedToken = state.selectedToken
      ..isFirstRequest = state.isFirstRequest
      ..loading = state.loading
      ..loadingMap = state.loadingMap
      ..loadingHistory = state.loadingHistory
      ..balance = state.balance
      ..balanceDHX = state.balanceDHX
      ..balanceBTC = state.balanceBTC
      ..totalRevenue = state.totalRevenue
      ..lockedAmount = state.lockedAmount
      ..totalRevenueDHX = state.totalRevenueDHX
      ..gatewaysTotal = state.gatewaysTotal
      ..mPower = state.mPower
      ..miningPower = state.miningPower
      ..organizations = state.organizations
      ..stakedAmount = state.stakedAmount
      ..isSetDate1 = state.isSetDate1
      ..isSetDate2 = state.isSetDate2
      ..selectedIndexBtn1 = state.selectedIndexBtn1
      ..selectedIndexBtn2 = state.selectedIndexBtn2
      ..activeTabToken = state.walletActiveTabToken
      ..walletList = state.walletList
      ..stakeList = state.stakeList
      ..stakeDHXList = state.stakeDHXList
      ..transactions = state.transactions
      ..btcList = state.btcList
      ..withdrawFee = state.withdrawFee
      ..firstTime = state.firstTime
      ..secondTime = state.secondTime
      ..isDemo = state.isDemo
      ..lastSearchData = state.lastSearchData
      ..lastSearchType = state.lastSearchType;
  }

  @override
  void set(HomeState state, WalletState subState) {
    state
      ..expandedView = subState.expandedView
      ..displayTokens = subState.displayTokens
      ..selectedToken = subState.selectedToken
      ..isFirstRequest = subState.isFirstRequest
      ..loadingHistory = subState.loadingHistory
      ..totalRevenue = subState.totalRevenue
      ..isSetDate1 = subState.isSetDate1
      ..isSetDate2 = subState.isSetDate2
      ..selectedIndexBtn1 = subState.selectedIndexBtn1
      ..selectedIndexBtn2 = subState.selectedIndexBtn2
      ..walletActiveTabToken = subState.activeTabToken
      ..walletList = subState.walletList
      ..stakeList = subState.stakeList
      ..transactions = subState.transactions
      ..btcList = subState.btcList
      ..withdrawFee = subState.withdrawFee
      ..firstTime = subState.firstTime
      ..secondTime = subState.secondTime
      ..lastSearchData = subState.lastSearchData
      ..lastSearchType = subState.lastSearchType;
  }
}

class MapboxGlConnector extends ConnOp<HomeState, MapboxGlState> {
  @override
  MapboxGlState get(HomeState state) {
    return MapboxGlState()
      ..geojsonList = state.geojsonList;
  }

  @override
  void set(HomeState state, MapboxGlState subState) {
    
  }
}
