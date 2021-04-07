import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';

class GatewayProfileState implements Cloneable<GatewayProfileState> {
  GatewayItem profile;
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
  final profile = args['item'];
  final isDemo = args['isDemo'];
  return GatewayProfileState()
    ..profile = profile
    ..mapCtl = MapViewController()
    ..isDemo = isDemo;
}
