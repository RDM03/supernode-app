import 'package:fish_redux/fish_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'gateway_list_adapter/gateway_item_component/state.dart';

class GatewayState extends MutableSource implements Cloneable<GatewayState> {
  
  //gateways
  int gatewaysTotal = 0;
  double gatewaysRevenue = 0;
  double gatewaysUSDRevenue = 0;

  List<OrganizationsState> organizations = [];
  LatLng location;

  List list = [];

  @override
  Object getItemData(int index) => list[index];

  @override
  String getItemType(int index) => 'item';

  @override
  int get itemCount => list?.length ?? 0;

  @override
  void setItemData(int index, Object data) => list[index] = data;

  @override
  GatewayState clone() {
    return GatewayState()
      ..gatewaysTotal = gatewaysTotal
      ..gatewaysRevenue = gatewaysRevenue
      ..gatewaysUSDRevenue = gatewaysUSDRevenue
      ..organizations = organizations ?? []
      ..location = location
      ..list = list ?? [];
  }
}

GatewayState initState(Map<String, dynamic> args) {
  return GatewayState();
}

class GatewayItemConnector extends ConnOp<GatewayState, GatewayItemState>{

  @override
  GatewayItemState get(GatewayState state){
    return GatewayItemState();
  }

  @override
  void set(GatewayState state, GatewayItemState subState) {

  }
}