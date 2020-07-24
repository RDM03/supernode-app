import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/gateway_component/gateway_list_adapter/gateway_item_component/state.dart';

enum GatewayAction { onAdd, onProfile, profile }

class GatewayActionCreator {
  static Action onAdd() {
    return const Action(GatewayAction.onAdd);
  }

  static Action onProfile(GatewayItemState data) {
    return Action(GatewayAction.onProfile, payload: data);
  }

  static Action profile(GatewayItemState data) {
    return Action(GatewayAction.profile, payload: data);
  }
}
