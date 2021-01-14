import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum WalletListAction { action }

class WalletListActionCreator {
  static Action onAction() {
    return const Action(WalletListAction.action);
  }
}
