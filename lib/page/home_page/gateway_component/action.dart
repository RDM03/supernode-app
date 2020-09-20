import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/gateway_component/item_state.dart';

enum GatewayAction { onAdd, onProfile, profile, onLoadPage, addGateways }

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

  static Action onLoadPage(int page,
      [Completer<List<GatewayItemState>> completer]) {
    return Action(GatewayAction.onLoadPage, payload: {
      'page': page,
      'completer': completer,
    });
  }

  static Action addGateways(List<GatewayItemState> addList) {
    return Action(GatewayAction.addGateways, payload: addList);
  }
}
