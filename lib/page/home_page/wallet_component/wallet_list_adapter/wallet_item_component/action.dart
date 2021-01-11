import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/wallet_component/wallet_list_adapter/wallet_item_component/state.dart';

enum WalletItemAction { isExpand }

class WalletItemActionCreator {
  static Action isExpand(GeneralItemState id) {
    return Action(WalletItemAction.isExpand, payload: id);
  }
}
