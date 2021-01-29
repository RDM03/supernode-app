import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/user_component/state.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

enum HomeAction {
  relogin,
  loading,
  loadingMap,
  tabIndex,
  onProfile,
  profile,
  balance,
  onAddDHX,
  addDHX,
  dataDHX,
  onAddBTC,
  addBTC,
  dataBTC,
  mapbox,
  geojsonList,
  stakedAmount,
  gateways,
  onGateways,
  devices,
  gatewaysLocations,
  onOperate,
  onSettings,
  updateUsernameEmail,
  miningIncome,
  convertUSD,
  location,
  totalRevenue,
  isUpdate,
  reloginCount
}

class HomeActionCreator {
  static Action reloginCount(int num) {
    return Action(HomeAction.reloginCount,payload: num);
  }

  static Action isUpdate() {
    return const Action(HomeAction.isUpdate);
  }
  
  static Action onReLogin() {
    return const Action(HomeAction.relogin);
  }

  static Action loading(bool toogle) {
    return Action(HomeAction.loading, payload: toogle);
  }

  /// data - label for data being loaded, for example: ['balance', 'balanceDHX', 'lockedAmount', 'miningPower', 'stakedAmount', 'totalRevenue']
  /// type = 'add' - loading finished for data,
  /// type = 'other than add' - loading started for data
  static Action loadingMap(String data,{String type = 'add'}) {
    return Action(HomeAction.loadingMap, payload: {'data': data, 'type': type});
  }

  static Action onProfile() {
    return const Action(HomeAction.onProfile);
  }

  static Action profile(UserState user, String wechatExternalUsername, String shopifyExternalUsername, List<OrganizationsState> organizations) {
    return Action(HomeAction.profile, payload: {'user': user, 'wechatExternalUsername': wechatExternalUsername, 'shopifyExternalUsername': shopifyExternalUsername, 'organizations': organizations});
  }

  static Action updateUsernameEmail(Map data) {
    return Action(HomeAction.updateUsernameEmail, payload: data);
  }

  static Action balance(double balance) {
    return Action(HomeAction.balance, payload: balance);
  }

  static Action onAddDHX(bool saveLocally_LoadData) {
    return Action(HomeAction.onAddDHX, payload: saveLocally_LoadData);
  }

  static Action addDHX() {
    return Action(HomeAction.addDHX);
  }

  static Action dataDHX(Map data) {
    return Action(HomeAction.dataDHX, payload: data);
  }

  static Action onAddBTC(bool saveLocally_LoadData) {
    return Action(HomeAction.onAddBTC, payload: saveLocally_LoadData);
  }

  static Action addBTC() {
    return Action(HomeAction.addBTC);
  }

  static Action dataBTC(Map data) {
    return Action(HomeAction.dataBTC, payload: data);
  }

  static Action mapbox(){
    return const Action(HomeAction.mapbox);
  }

  static Action geojsonList(List data){
    return Action(HomeAction.geojsonList,payload: data);
  }

  static Action stakedAmount(double data) {
    return Action(HomeAction.stakedAmount, payload: data);
  }

  static Action miningIncome(double value) {
    return Action(HomeAction.miningIncome, payload: value);
  }

  static Action gateways(int total, double value, List list) {
    return Action(HomeAction.gateways, payload: {'total': total, 'value': value, 'list': list});
  }

  static Action onGateways() {
    return const Action(HomeAction.onGateways);
  }

  static Action gatewaysLocations(List data) {
    return Action(HomeAction.gatewaysLocations, payload: data);
  }

  static Action devices(int total, double value) {
    return Action(HomeAction.devices, payload: {'total': total, 'value': value});
  }

  static Action tabIndex(int index) {
    return Action(HomeAction.tabIndex, payload: index);
  }

  static Action onOperate(String act, {String tokenName: 'MXC'}) {
    return Action(HomeAction.onOperate, payload: {'act': act, 'tokenName': tokenName});
  }

  static Action onSettings() {
    return const Action(HomeAction.onSettings);
  }

  static Action convertUSD(String type, value) {
    return Action(HomeAction.convertUSD, payload: {'type': type, 'value': value});
  }

  static Action totalRevenue(double data){
    return Action(HomeAction.totalRevenue, payload: data);
  }
}
