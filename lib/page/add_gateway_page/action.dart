import 'package:fish_redux/fish_redux.dart';

enum AddGatewayAction { onQrScan, serialNumber, onAdd, onProfile }

class AddGatewayActionCreator {
  static Action onQrScan() {
    return const Action(AddGatewayAction.onQrScan);
  }

  static Action serialNumber(String data) {
    return Action(AddGatewayAction.serialNumber,payload: data);
  }

  static Action onAdd() {
    return const Action(AddGatewayAction.onAdd);
  }

  static Action onProfile() {
    return const Action(AddGatewayAction.onProfile);
  }
}
