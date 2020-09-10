import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ListUnstakePage extends Page<ListUnstakeState, Map<String, dynamic>> {
  ListUnstakePage()
      : super(
          initState: initState,
          view: buildView,
          reducer: buildReducer(),
          effect: buildEffect(),
        );
}
