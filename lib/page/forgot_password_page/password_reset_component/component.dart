import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PasswordResetComponent extends Component<PasswordResetState> {
  PasswordResetComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PasswordResetState>(
                adapter: null,
                slots: <String, Dependent<PasswordResetState>>{
                }),);

}
