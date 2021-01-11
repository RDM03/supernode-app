import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

enum AddGatewayAction {
  onQrScan,
  serialNumber,
  onAdd,
  onProfile,
  setNumberTextColor
}

class AddGatewayActionCreator {
  static Action onQrScan() {
    return const Action(AddGatewayAction.onQrScan);
  }

  static Action serialNumber(String data) {
    return Action(AddGatewayAction.serialNumber, payload: data);
  }

  static Action onAdd() {
    return const Action(AddGatewayAction.onAdd);
  }

  static Action onProfile() {
    return const Action(AddGatewayAction.onProfile);
  }

  static Action setNumberTextColor(Color color) {
    return Action(AddGatewayAction.setNumberTextColor, payload: color);
  }
}
