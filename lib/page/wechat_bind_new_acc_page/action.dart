import 'package:fish_redux/fish_redux.dart';

enum WechatBindNewAccAction { onBindNewAcc, isCheckTerms, isCheckSend }

class WechatBindNewAccActionCreator {
  static Action onBindNewAcc() {
    return const Action(WechatBindNewAccAction.onBindNewAcc);
  }

  static Action isCheckTerms() {
    return const Action(WechatBindNewAccAction.isCheckTerms);
  }

  static Action isCheckSend() {
    return const Action(WechatBindNewAccAction.isCheckSend);
  }
}
