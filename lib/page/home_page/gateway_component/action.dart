import 'package:fish_redux/fish_redux.dart';

enum GatewayAction { onAdd }

class GatewayActionCreator {
  static Action onAdd() {
    return const Action(GatewayAction.onAdd);
  }
}
