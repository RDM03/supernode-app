import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GatewayProfileComponent extends Component<GatewayProfileState> {
  GatewayProfileComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GatewayProfileState>(
                adapter: null,
                slots: <String, Dependent<GatewayProfileState>>{
                }),);

}
