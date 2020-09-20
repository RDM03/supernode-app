import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/page/home_page/gateway_component/gateway_profile_component/state.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'item_state.dart';

class GatewayState extends MutableSource implements Cloneable<GatewayState> {
  //gateways
  bool loading = true;
  Set loadingMap = {};
  int gatewaysTotal = 0;
  double gatewaysRevenue = 0;
  double gatewaysUSDRevenue = 0;

  List<OrganizationsState> organizations = [];
  LatLng location;

  //profile
  GatewayItemState profile;
  MapViewController mapCtl;
  List miningRevenve;
  List gatewayFrame;

  List<GatewayItemState> list = [];

  @override
  Object getItemData(int index) => list[index];

  @override
  String getItemType(int index) => 'item';

  @override
  int get itemCount => list?.length ?? 0;

  @override
  void setItemData(int index, Object data) => list[index] = data;

  bool isDemo;

  @override
  GatewayState clone() {
    return GatewayState()
      ..profile = profile
      ..mapCtl = mapCtl
      ..miningRevenve = miningRevenve
      ..gatewayFrame = gatewayFrame
      ..loading = loading
      ..loadingMap = loadingMap
      ..gatewaysTotal = gatewaysTotal
      ..gatewaysRevenue = gatewaysRevenue
      ..gatewaysUSDRevenue = gatewaysUSDRevenue
      ..organizations = organizations ?? []
      ..location = location
      ..list = list ?? []
      ..isDemo = isDemo;
  }
}

GatewayState initState(Map<String, dynamic> args) {
  return GatewayState();
}

class GatewayItemConnector extends ConnOp<GatewayState, GatewayItemState> {
  @override
  GatewayItemState get(GatewayState state) {
    return GatewayItemState();
  }

  @override
  void set(GatewayState state, GatewayItemState subState) {}
}

class GatewayProfileConnector
    extends ConnOp<GatewayState, GatewayProfileState> {
  @override
  GatewayProfileState get(GatewayState state) {
    return GatewayProfileState()
      ..profile = state.profile ?? GatewayItemState().clone()
      ..mapCtl = state.mapCtl
      ..miningRevenve = state.miningRevenve
      ..gatewayFrame = state.gatewayFrame
      ..isDemo = state.isDemo;
  }

  @override
  void set(GatewayState state, GatewayProfileState subState) {
    state
      ..mapCtl = subState.mapCtl
      ..miningRevenve = subState.miningRevenve
      ..gatewayFrame = subState.gatewayFrame;
  }
}
