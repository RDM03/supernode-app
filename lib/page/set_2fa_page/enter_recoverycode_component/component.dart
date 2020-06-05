import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EnterRecoveryCodeComponent extends Component<EnterRecoveryCodeState> {
  EnterRecoveryCodeComponent()
      : super(
    effect: buildEffect(),
    reducer: buildReducer(),
    view: buildView,
    dependencies: Dependencies<EnterRecoveryCodeState>(
        adapter: null,
        slots: <String, Dependent<EnterRecoveryCodeState>>{
        }),);

}

