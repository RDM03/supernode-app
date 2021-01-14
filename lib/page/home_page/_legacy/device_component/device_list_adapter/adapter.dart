import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/legacy/device_component/device_list_adapter/device_item_component/component.dart';
import 'package:supernodeapp/page/home_page/legacy/device_component/state.dart';

import '../state.dart';
import 'reducer.dart';

class DeviceListAdapter extends SourceFlowAdapter<DeviceState> {
  DeviceListAdapter()
      : super(
          pool: <String, Component<Object>>{'item': DeviceItemComponent()},
          reducer: buildReducer(),
        );
}
