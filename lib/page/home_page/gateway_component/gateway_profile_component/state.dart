import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/page/home_page/gateway_component/gateway_list_adapter/gateway_item_component/state.dart';

class GatewayProfileState implements Cloneable<GatewayProfileState> {

  GatewayItemState profile;
  MapViewController mapCtl;
  List miningRevenve;
  List gatewayFrame;
  bool isDemo;

  @override
  GatewayProfileState clone() {
    return GatewayProfileState()
      ..profile = profile
      ..mapCtl = mapCtl
      ..miningRevenve = miningRevenve
      ..gatewayFrame = gatewayFrame
      ..isDemo = isDemo;
  }
}

GatewayProfileState initState(Map<String, dynamic> args) {
  return GatewayProfileState();
}
