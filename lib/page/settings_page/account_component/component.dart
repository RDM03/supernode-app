import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class AccountComponent extends Component<AccountState> {
  AccountComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<AccountState>(
              adapter: null, slots: <String, Dependent<AccountState>>{}),
        );
}
