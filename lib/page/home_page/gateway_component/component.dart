import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/gateway_component/gateway_profile_component/component.dart';

import 'effect.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GatewayComponent extends Component<GatewayState> {
  GatewayComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GatewayState>(
            slots: <String, Dependent<GatewayState>>{
              'profile': GatewayProfileConnector() + GatewayProfileComponent()
            },
          ),
        );
}
