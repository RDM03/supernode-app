import 'package:fish_redux/fish_redux.dart';

class DeviceItemState implements Cloneable<DeviceItemState> {
  bool Function() isDemo;

  DeviceItemState(this.isDemo);

  @override
  DeviceItemState clone() {
    return DeviceItemState(isDemo);
  }
}
