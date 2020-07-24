import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'gateway_item_component/component.dart';
import 'reducer.dart';


class GatewayListAdapter extends SourceFlowAdapter<GatewayState> {
  GatewayListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'item': GatewayItemComponent()
          },
          reducer: buildReducer(),
        );
}
