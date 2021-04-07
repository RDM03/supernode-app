import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GatewayProfilePage
    extends Page<GatewayProfileState, Map<String, dynamic>> {
  GatewayProfilePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GatewayProfileState>(
              adapter: null, slots: <String, Dependent<GatewayProfileState>>{}),
        );
}
