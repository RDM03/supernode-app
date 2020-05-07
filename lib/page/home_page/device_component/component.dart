import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DeviceComponent extends Component<DeviceState> {
  DeviceComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DeviceState>(
                adapter: null,
                slots: <String, Dependent<DeviceState>>{
                }),);

}
