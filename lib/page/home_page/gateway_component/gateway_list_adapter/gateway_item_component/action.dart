import 'package:fish_redux/fish_redux.dart';

enum GatewayItemAction { onProfile }

class GatewayItemActionCreator {
  static Action onProfile() {
    return const Action(GatewayItemAction.onProfile);
  }
}
