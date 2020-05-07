import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GatewayItemComponent extends Component<GatewayItemState> {
  GatewayItemComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GatewayItemState>(
                adapter: null,
                slots: <String, Dependent<GatewayItemState>>{
                }),);

}
