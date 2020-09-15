import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DetailsStakePage extends Page<DetailsStakeState, Map<String, dynamic>> {
  DetailsStakePage()
      : super(
          initState: initState,
          view: buildView,
          effect: buildEffect(),
          reducer: buildReducer(),
        );
}
