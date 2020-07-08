import 'package:fish_redux/fish_redux.dart';

class NotificationOutState implements Cloneable<NotificationOutState> {
  int locationsAction = 0;

  @override
  NotificationOutState clone() {
    return NotificationOutState()..locationsAction = locationsAction;
  }
}

NotificationOutState initState(Map<String, dynamic> args) {
  return NotificationOutState();
}
