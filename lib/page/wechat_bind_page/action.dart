import 'package:fish_redux/fish_redux.dart';

enum WechatBindAction { isObscureText, onBind }

class WechatBindActionCreator {
  static Action isObscureText() {
    return const Action(WechatBindAction.isObscureText);
  }

  static Action onBind() {
    return const Action(WechatBindAction.onBind);
  }
}
