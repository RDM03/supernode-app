import 'package:fish_redux/fish_redux.dart';

enum WalletItemAction { isExpand }

class WalletItemActionCreator {
  static Action isExpand(String id) {
    return Action(WalletItemAction.isExpand,payload: id);
  }
}
