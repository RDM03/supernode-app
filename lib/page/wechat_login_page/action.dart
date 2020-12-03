import 'package:fish_redux/fish_redux.dart';

enum WechatLoginAction { onAlreadyHaveAccount, onCreateAccount }

class WechatLoginActionCreator {
  static Action onAlreadyHaveAccount() {
    return const Action(WechatLoginAction.onAlreadyHaveAccount);
  }

  static Action onCreateAccount() {
    return const Action(WechatLoginAction.onCreateAccount);
  }
}
