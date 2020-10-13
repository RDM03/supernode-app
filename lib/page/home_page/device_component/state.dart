import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/device_component/device_list_adapter/device_item_component/state.dart';
import 'package:supernodeapp/page/home_page/wallet_component/wallet_list_adapter/wallet_item_component/view.dart';

class DeviceState extends MutableSource implements Cloneable<DeviceState> {
  int deviceSortType = 0;

  List get list => isDemo ? demoList : realList;
  set list(val) => isDemo ? demoList = val : realList = val;
  List demoList;
  List realList;

  DeviceState() {
  }

  @override
  Object getItemData(int index) => list[index];

  @override
  String getItemType(int index) => 'item';

  @override
  int get itemCount => list?.length ?? 0;

  @override
  void setItemData(int index, Object data) => list[index] = data;

  bool isDemo;

  @override
  DeviceState clone() {
    return DeviceState()
      ..deviceSortType = deviceSortType
      ..demoList = demoList
      ..realList = realList
      ..isDemo = isDemo;
  }

  void addDevice(String sn) {
    list.add(DeviceItemState(() => isDemo));
  }
}

DeviceState initState(Map<String, dynamic> args) {
  return DeviceState();
}
