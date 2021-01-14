import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/legacy/device_component/component.dart';
import 'package:supernodeapp/page/home_page/legacy/gateway_component/component.dart';
import 'package:supernodeapp/page/home_page/legacy/mapbox_gl_component/component.dart';
import 'package:supernodeapp/page/home_page/legacy/user_component/component.dart';
import 'package:supernodeapp/page/home_page/legacy/wallet_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePage extends Page<HomeState, Map<String, dynamic>> {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<HomeState>(
              adapter: null,
              slots: <String, Dependent<HomeState>>{
                'user': UserConnector() + UserComponent(),
                'gateway': GatewayConnector() + GatewayComponent(),
                'device': DeviceConnector() + DeviceComponent(),
                'wallet': WalletConnector() + WalletComponent(),
                'mapbox': MapboxGlConnector() + MapboxGlComponent(),
              }),
          middleware: <Middleware<HomeState>>[],
        );
}
