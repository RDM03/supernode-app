import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<WalletItemState> buildEffect() {
  return combineEffects(<Object, Effect<WalletItemState>>{
    // WalletItemAction.action: _onAction,
  });
}

void _onAction(Action action, Context<WalletItemState> ctx) {
}
