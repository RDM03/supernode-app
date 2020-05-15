import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'wallet_list_adapter/adapter.dart';

class WalletComponent extends Component<WalletState> {
  WalletComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<WalletState>(
                adapter: NoneConn<WalletState>() + WalletListAdapter(),
                slots: <String, Dependent<WalletState>>{
                }),);

}
