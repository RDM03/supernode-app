import 'package:fish_redux/fish_redux.dart';

enum WithdrawAction { onQrScan, address, onEnterSecurityWithdrawContinue, onSubmit, fee, balance, status }

class WithdrawActionCreator {
  static Action status(bool toogle) {
    return Action(WithdrawAction.status,payload: toogle);
  }

  static Action fee(double fee) {
    return Action(WithdrawAction.fee,payload: fee);
  }

  static Action balance(double balance) {
    return Action(WithdrawAction.balance,payload: balance);
  }

  static Action onQrScan() {
    return const Action(WithdrawAction.onQrScan);
  }

  static Action address(String data) {
    return Action(WithdrawAction.address,payload: data);
  }

  static Action onEnterSecurityWithdrawContinue() {
    return Action(WithdrawAction.onEnterSecurityWithdrawContinue);
  }

  static Action onSubmit() {
    return const Action(WithdrawAction.onSubmit);
  }
}
