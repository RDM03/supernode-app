import 'package:fish_redux/fish_redux.dart';

enum DeviceAction { onQrScan, qrScan, changeDeviceSortType, onOpen }

class DeviceActionCreator {
  static Action onQrScan() {
    return const Action(DeviceAction.onQrScan);
  }

  static Action qrScan(String sn) {
    return Action(DeviceAction.qrScan, payload: sn);
  }

  static Action changeDeviceSortType(int deviceType) {
    return Action(DeviceAction.changeDeviceSortType, payload: deviceType);
  }

  static Action onOpen() {
    return const Action(DeviceAction.onOpen);
  }
}
