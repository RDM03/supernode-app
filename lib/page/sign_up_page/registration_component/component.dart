import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RegistrationComponent extends Component<RegistrationState> {
  RegistrationComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RegistrationState>(
              adapter: null, slots: <String, Dependent<RegistrationState>>{}),
        );
}
