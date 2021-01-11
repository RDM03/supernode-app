import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WalletItemComponent extends Component<GeneralItemState> {
  WalletItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<WalletItemState>(
              adapter: null, slots: <String, Dependent<WalletItemState>>{}),
        );
}
