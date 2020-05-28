import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EnterSecurityCodeComponent extends Component<EnterSecurityCodeState> {
  EnterSecurityCodeComponent()
      : super(
    effect: buildEffect(),
    reducer: buildReducer(),
    view: buildView,
    dependencies: Dependencies<EnterSecurityCodeState>(
        adapter: null,
        slots: <String, Dependent<EnterSecurityCodeState>>{
        }),);

}

