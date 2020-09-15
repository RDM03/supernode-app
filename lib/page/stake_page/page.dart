import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StakePage extends Page<StakeState, Map<String, dynamic>> {
  StakePage()
      : super(
          initState: initState,
          view: buildView,
          reducer: buildReducer(),
          effect: buildEffect(),
        );
}
