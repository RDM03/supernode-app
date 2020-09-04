import 'package:fish_redux/fish_redux.dart';

enum WithdrawAction {
  onQrScan,
  address,
  isEnabled,
  onEnterSecurityWithdrawContinue,
  onGotoSet2FA,
  onSubmit,
  fee,
  balance,
  status,
  onAddressBook,
}

class WithdrawActionCreator {
  static Action status(bool toogle) {
    return Action(WithdrawAction.status, payload: toogle);
  }

  static Action isEnabled(bool data) {
    return Action(WithdrawAction.isEnabled, payload: data);
  }

  static Action fee(double fee) {
    return Action(WithdrawAction.fee, payload: fee);
  }

  static Action balance(double balance) {
    return Action(WithdrawAction.balance, payload: balance);
  }

  static Action onQrScan() {
    return const Action(WithdrawAction.onQrScan);
  }

  static Action address(String data) {
    return Action(WithdrawAction.address, payload: data);
  }

  static Action onEnterSecurityWithdrawContinue() {
    return Action(WithdrawAction.onEnterSecurityWithdrawContinue);
  }

  static Action onGotoSet2FA() {
    return Action(WithdrawAction.onGotoSet2FA);
  }

  static Action onAddressBook() {
    return Action(WithdrawAction.onAddressBook);
  }

  static Action onSubmit() {
    return const Action(WithdrawAction.onSubmit);
  }
}
