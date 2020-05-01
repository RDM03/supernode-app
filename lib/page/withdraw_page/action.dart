import 'package:fish_redux/fish_redux.dart';

enum WithdrawAction { onQrScan, address, onSubmit }

class WithdrawActionCreator {
  static Action onQrScan() {
    return const Action(WithdrawAction.onQrScan);
  }

  static Action address(String data) {
    return Action(WithdrawAction.address,payload: data);
  }

  static Action onSubmit() {
    return const Action(WithdrawAction.onSubmit);
  }
}
