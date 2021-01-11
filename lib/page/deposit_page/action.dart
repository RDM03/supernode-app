import 'package:fish_redux/fish_redux.dart';

enum DepositAction { address, copy }

class DepositActionCreator {
  static Action copy() {
    return const Action(DepositAction.copy);
  }

  static Action address(String data) {
    return Action(DepositAction.address, payload: data);
  }
}
