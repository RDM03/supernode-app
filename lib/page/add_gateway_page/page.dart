import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/add_gateway_page/gateway_profile_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AddGatewayPage extends Page<AddGatewayState, Map<String, dynamic>> {
  AddGatewayPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AddGatewayState>(
              adapter: null,
              slots: <String, Dependent<AddGatewayState>>{
                'profile': GatewayProfileConnector() + GatewayProfileComponent()
              }),
          middleware: <Middleware<AddGatewayState>>[],
        );
}
