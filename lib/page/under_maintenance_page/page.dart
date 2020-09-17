import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class UnderMaintenancePage
    extends Page<UnderMaintenanceState, Map<String, dynamic>> {
  UnderMaintenancePage()
      : super(
          initState: (_) => UnderMaintenanceState(false),
          view: buildView,
          reducer: buildReducer(),
          effect: buildEffect(),
        );
}
