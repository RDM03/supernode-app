import 'package:fish_redux/fish_redux.dart';

enum GatewayProfileAction { miningInfo, gatewayFrame }

class GatewayProfileActionCreator {
  static Action miningInfo(List data) {
    return Action(GatewayProfileAction.miningInfo, payload: data);
  }

  static Action gatewayFrame(List data) {
    return Action(GatewayProfileAction.gatewayFrame, payload: data);
  }
}
