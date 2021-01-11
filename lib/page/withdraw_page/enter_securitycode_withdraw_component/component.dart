import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EnterSecurityCodeWithdrawComponent
    extends Component<EnterSecurityCodeWithdrawState> {
  EnterSecurityCodeWithdrawComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<EnterSecurityCodeWithdrawState>(
              adapter: null,
              slots: <String, Dependent<EnterSecurityCodeWithdrawState>>{}),
        );
}
