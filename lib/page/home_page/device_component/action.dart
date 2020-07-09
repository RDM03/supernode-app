import 'package:fish_redux/fish_redux.dart';

enum DeviceAction { onQrScan, changeDeviceSortType }

class DeviceActionCreator {
  static Action onQrScan() {
    return const Action(DeviceAction.onQrScan);
  }

  static Action changeDeviceSortType(int deviceType) {
    return Action(DeviceAction.changeDeviceSortType, payload: deviceType);
  }
}
