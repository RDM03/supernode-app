import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EnterNonOTPSecurityCodeComponent
    extends Component<EnterNonOTPSecurityCodeState> {
  EnterNonOTPSecurityCodeComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<EnterNonOTPSecurityCodeState>(
              adapter: null,
              slots: <String, Dependent<EnterNonOTPSecurityCodeState>>{}),
        );
}
