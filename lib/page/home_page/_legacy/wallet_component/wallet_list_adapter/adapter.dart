import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'reducer.dart';
import 'wallet_item_component/component.dart';

class WalletListAdapter extends SourceFlowAdapter<WalletState> {
  WalletListAdapter()
      : super(
          pool: <String, Component<Object>>{'item': WalletItemComponent()},
          reducer: buildReducer(),
        );
}
