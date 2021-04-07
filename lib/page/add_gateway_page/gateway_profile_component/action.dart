import 'package:fish_redux/fish_redux.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

enum GatewayProfileAction {
  initState,
  onNetworkServerPicker,
  onGatewayProfilePicker,
  selectIdType,
  updateItem,
  onSetLocation,
  update,
  onNetworkServerList,
  networkServerList,
  gatewayProfileList,
  networkServerId,
  gatewayProfileId,
  discoveryEnabled,
  addLocation,
  addMapController,
}

class GatewayProfileActionCreator {
  static Action initState() {
    return const Action(GatewayProfileAction.initState);
  }

  static Action onNetworkServerPicker() {
    return const Action(GatewayProfileAction.onNetworkServerPicker);
  }

  static Action onGatewayProfilePicker() {
    return const Action(GatewayProfileAction.onGatewayProfilePicker);
  }

  static Action networkServerId(String id, String value) {
    return Action(GatewayProfileAction.networkServerId,
        payload: {'id': id, 'value': value});
  }

  static Action gatewayProfileId(String id, String value) {
    return Action(GatewayProfileAction.gatewayProfileId,
        payload: {'id': id, 'value': value});
  }

  static Action selectIdType() {
    return const Action(GatewayProfileAction.selectIdType);
  }

  // static Action updateItem(GatewayItemState data) {
  //   return Action(GatewayProfileAction.updateItem, payload: data);
  // }

  static Action update() {
    return const Action(GatewayProfileAction.update);
  }

  static Action onNetworkServerList() {
    return const Action(GatewayProfileAction.onNetworkServerList);
  }

  static Action networkServerList(List data) {
    return Action(GatewayProfileAction.networkServerList, payload: data);
  }

  static Action gatewayProfileList(List data) {
    return Action(GatewayProfileAction.gatewayProfileList, payload: data);
  }

  static Action discoveryEnabled() {
    return const Action(GatewayProfileAction.discoveryEnabled);
  }

  static Action addLocation({LatLng location, String type = 'user'}) {
    return Action(GatewayProfileAction.addLocation,
        payload: {'location': location, 'type': type});
  }

  static Action addMapController(MapboxMapController ctl) {
    return Action(GatewayProfileAction.addLocation, payload: ctl);
  }
}
