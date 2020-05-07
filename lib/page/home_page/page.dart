import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/device_component/component.dart';
import 'package:supernodeapp/page/home_page/gateway_component/component.dart';
import 'package:supernodeapp/page/home_page/user_component/component.dart';
import 'package:supernodeapp/page/home_page/wallet_component/component.dart';

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
                }),
            middleware: <Middleware<HomeState>>[
            ],);

}
