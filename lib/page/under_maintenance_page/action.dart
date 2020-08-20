import 'package:fish_redux/fish_redux.dart';

enum UnderMaintenanceAction { setLoading, refresh }

class UnderMaintenanceActionCreator {
  static Action setLoading(bool val) {
    return Action(UnderMaintenanceAction.setLoading, payload: val);
  }

  static Action refresh() {
    return Action(UnderMaintenanceAction.refresh);
  }
}
